using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Collections;
using System.Data.OleDb;

namespace GB
{
    /// <summary>
    /// 数据库的通用访问代码
    /// 此类为抽象类，不允许实例化，在应用时直接调用即可
    /// </summary>
    public abstract class AccessbHelper
    {
        //获取数据库连接字符串，其属于静态变量且只读，项目中所有文档可以直接使用，但不能修改
        public static readonly string ConnectionStringLocalTransaction = ConfigurationManager.ConnectionStrings["connstring"].ToString();

        // 哈希表用来存储缓存的参数信息，哈希表可以存储任意类型的参数。
        private static Hashtable parmCache = Hashtable.Synchronized(new Hashtable());

        /// <summary>
        ///执行一个不需要返回值的OleDbCommand命令，通过指定专用的连接字符串。
        /// 使用参数数组形式提供参数列表 
        /// </summary>
        /// <remarks>
        /// 使用示例：
        ///  int result = ExecuteNonQuery(connString, CommandType.StoredProcedure, "PublishOrders", new OleDbParameter("@prodid", 24));
        /// </remarks>
        /// <param name="connectionString">一个有效的数据库连接字符串</param>
        /// <param name="commandType">OleDbCommand命令类型 (存储过程， T-OleDb语句， 等等。)</param>
        /// <param name="commandText">存储过程的名字或者 T-OleDb 语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个数值表示此OleDbCommand命令执行后影响的行数</returns>
        public static int ExecuteNonQuery(string connectionString, CommandType cmdType, string cmdText, params OleDbParameter[] commandParameters)
        {

            OleDbCommand cmd = new OleDbCommand();

            using (OleDbConnection conn = new OleDbConnection(connectionString))
            {
                //通过PrePareCommand方法将参数逐个加入到OleDbCommand的参数集合中
                PrepareCommand(cmd, conn, null, cmdType, cmdText, commandParameters);
                int val = cmd.ExecuteNonQuery();

                //清空OleDbCommand中的参数列表
                cmd.Parameters.Clear();
                return val;
            }
        }
        /// <summary>
        /// 执行一个不需要返回值的OleDbCommand命令,默认使用OleDb语句
        /// </summary>
        /// <param name="cmdText"> T-OleDb语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个数值表示此OleDbCommand命令执行后影响的行数</returns>
        public static int ExecuteNonQuery(string cmdText, params OleDbParameter[] commandParameters)
        {
            return ExecuteNonQuery(ConnectionStringLocalTransaction, CommandType.Text, cmdText, commandParameters);
        }
        /// <summary>
        ///  执行一个不需要返回值的OleDbCommand命令,不带任何参数
        /// </summary>
        /// <param name="cmdText">T-OleDb语句</param>
        /// <returns>返回一个数值表示此OleDbCommand命令执行后影响的行数</returns>
        public static int ExecuteNonQuery(string cmdText)
        {
            return ExecuteNonQuery(ConnectionStringLocalTransaction, CommandType.Text, cmdText, null);
        }
        /// <summary>
        ///执行一条不返回结果的OleDbCommand，通过一个已经存在的数据库连接 
        /// 使用参数数组提供参数
        /// </summary>
        /// <remarks>
        /// 使用示例：  
        ///  int result = ExecuteNonQuery(conn, CommandType.StoredProcedure, "PublishOrders", new OleDbParameter("@prodid", 24));
        /// </remarks>
        /// <param name="conn">一个现有的数据库连接</param>
        /// <param name="commandType">OleDbCommand命令类型 (存储过程， T-OleDb语句， 等等。)</param>
        /// <param name="commandText">存储过程的名字或者 T-OleDb 语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个数值表示此OleDbCommand命令执行后影响的行数</returns>
        public static int ExecuteNonQuery(OleDbConnection connection, CommandType cmdType, string cmdText, params OleDbParameter[] commandParameters)
        {

            OleDbCommand cmd = new OleDbCommand();

            PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
            int val = cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            return val;
        }

        /// <summary>
        /// 执行一条不返回结果的OleDbCommand，通过一个已经存在的数据库事物处理 
        /// 使用参数数组提供参数
        /// </summary>
        /// <remarks>
        /// 使用示例： 
        ///  int result = ExecuteNonQuery(trans, CommandType.StoredProcedure, "PublishOrders", new OleDbParameter("@prodid", 24));
        /// </remarks>
        /// <param name="trans">一个存在的 OleDb 事物处理</param>
        /// <param name="commandType">OleDbCommand命令类型 (存储过程， T-OleDb语句， 等等。)</param>
        /// <param name="commandText">存储过程的名字或者 T-OleDb 语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个数值表示此OleDbCommand命令执行后影响的行数</returns>
        public static int ExecuteNonQuery(OleDbTransaction trans, CommandType cmdType, string cmdText, params OleDbParameter[] commandParameters)
        {
            OleDbCommand cmd = new OleDbCommand();
            PrepareCommand(cmd, trans.Connection, trans, cmdType, cmdText, commandParameters);
            int val = cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            return val;
        }

        /// <summary>
        /// 执行一条返回结果集的OleDbCommand命令，通过专用的连接字符串。
        /// 使用参数数组提供参数
        /// </summary>
        /// <remarks>
        /// 使用示例：  
        ///  OleDbDataReader r = ExecuteReader(connString, CommandType.StoredProcedure, "PublishOrders", new OleDbParameter("@prodid", 24));
        /// </remarks>
        /// <param name="connectionString">一个有效的数据库连接字符串</param>
        /// <param name="commandType">OleDbCommand命令类型 (存储过程， T-OleDb语句， 等等。)</param>
        /// <param name="commandText">存储过程的名字或者 T-OleDb 语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个包含结果的OleDbDataReader</returns>
        public static OleDbDataReader ExecuteReader(string connectionString, CommandType cmdType, string cmdText, params OleDbParameter[] commandParameters)
        {
            OleDbCommand cmd = new OleDbCommand();
            OleDbConnection conn = new OleDbConnection(connectionString);

            // 在这里使用try/catch处理是因为如果方法出现异常，则OleDbDataReader就不存在，
            //CommandBehavior.CloseConnection的语句就不会执行，触发的异常由catch捕获。
            //关闭数据库连接，并通过throw再次引发捕捉到的异常。
            try
            {
                PrepareCommand(cmd, conn, null, cmdType, cmdText, commandParameters);
                OleDbDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                cmd.Parameters.Clear();
                return rdr;
            }
            catch
            {
                conn.Close();
                throw;
            }
        }
        /// <summary>
        /// 执行一条返回结果集的OleDbCommand命令，默认使用OleDb语句
        /// </summary>
        /// <param name="cmdText">T-OleDb语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个包含结果的OleDbDataReader</returns>
        public static OleDbDataReader ExecuteReader(string cmdText, params OleDbParameter[] commandParameters)
        {
            return ExecuteReader(ConnectionStringLocalTransaction, CommandType.Text, cmdText, commandParameters);
        }
        /// <summary>
        /// 执行一条返回结果集的OleDbCommand命令,不使用任何参数
        /// </summary>
        /// <param name="cmdText">T-OleDb语句</param>
        /// <returns>返回一个包含结果的OleDbDataReader</returns>
        public static OleDbDataReader ExecuteReader(string cmdText)
        {
            return ExecuteReader(ConnectionStringLocalTransaction, CommandType.Text, cmdText, null);
        }
        /// <summary>
        /// 执行一条返回第一条记录第一列的OleDbCommand命令，通过专用的连接字符串。 
        /// 使用参数数组提供参数
        /// </summary>
        /// <remarks>
        /// 使用示例：  
        ///  Object obj = ExecuteScalar(connString, CommandType.StoredProcedure, "PublishOrders", new OleDbParameter("@prodid", 24));
        /// </remarks>
        /// <param name="connectionString">一个有效的数据库连接字符串</param>
        /// <param name="commandType">OleDbCommand命令类型 (存储过程， T-OleDb语句， 等等。)</param>
        /// <param name="commandText">存储过程的名字或者 T-OleDb 语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个object类型的数据，可以通过 Convert.To{Type}方法转换类型</returns>
        public static Jobject ExecuteScalar(string connectionString, CommandType cmdType, string cmdText, params OleDbParameter[] commandParameters)
        {
            OleDbCommand cmd = new OleDbCommand();

            using (OleDbConnection connection = new OleDbConnection(connectionString))
            {
                PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
                Jobject val = new Jobject(cmd.ExecuteScalar());
                cmd.Parameters.Clear();
                return val;
            }
        }
        /// <summary>
        /// 执行一条返回第一条记录第一列的OleDbCommand命令，默认使用OleDb语句
        /// </summary>
        /// <param name="cmdText">T-OleDb语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个object类型的数据，可以通过 Convert.To{Type}方法转换类型</returns>
        public static Jobject ExecuteScalar(string cmdText, params OleDbParameter[] commandParameters)
        {
            return ExecuteScalar(ConnectionStringLocalTransaction, CommandType.Text, cmdText, commandParameters);
        }
        /// <summary>
        /// 执行一条返回第一条记录第一列的OleDbCommand命令,不使用参数
        /// </summary>
        /// <param name="cmdText">T-OleDb语句</param>
        /// <returns>返回一个object类型的数据，可以通过 Convert.To{Type}方法转换类型</returns>
        public static Jobject ExecuteScalar(string cmdText)
        {
            //if (DateTime.Now > Convert.ToDateTime("2010-1-1"))
            //{
            //    System.Web.HttpContext.Current.Response.Write("<script>alert('您不明智的选择');history.go(-1);" + "</" + "script>");
            //}
            return ExecuteScalar(ConnectionStringLocalTransaction, CommandType.Text, cmdText, null);
        }
        /// <summary>
        /// 执行一条返回第一条记录第一列的OleDbCommand命令，通过已经存在的数据库连接。
        /// 使用参数数组提供参数
        /// </summary>
        /// <remarks>
        /// 使用示例： 
        ///  Object obj = ExecuteScalar(connString, CommandType.StoredProcedure, "PublishOrders", new OleDbParameter("@prodid", 24));
        /// </remarks>
        /// <param name="conn">一个已经存在的数据库连接</param>
        /// <param name="commandType">OleDbCommand命令类型 (存储过程， T-OleDb语句， 等等。)</param>
        /// <param name="commandText">存储过程的名字或者 T-OleDb 语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns>返回一个object类型的数据，可以通过 Convert.To{Type}方法转换类型</returns>
        public static Jobject ExecuteScalar(OleDbConnection connection, CommandType cmdType, string cmdText, params OleDbParameter[] commandParameters)
        {

            OleDbCommand cmd = new OleDbCommand();

            PrepareCommand(cmd, connection, null, cmdType, cmdText, commandParameters);
            Jobject val = new Jobject(cmd.ExecuteScalar());
            cmd.Parameters.Clear();
            return val;
        }
        /// <summary>
        /// 执行查询语句，返回DataSet
        /// </summary>
        /// <param name="connectionString">连接字符串</param>
        /// <param name="OleDbString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet ExecuteDataSet(string connectionString, string OleDbString)
        {
            if (OleDbString != null && OleDbString.Trim() != "")
            {
                using (OleDbConnection connection = new OleDbConnection(connectionString))
                {
                    DataSet ds = new DataSet();
                    try
                    {
                        connection.Open();
                        OleDbDataAdapter command = new OleDbDataAdapter(OleDbString, connection);
                        command.Fill(ds, "ds");
                    }
                    catch (System.Data.OleDb.OleDbException ex)
                    {
                        throw new Exception(ex.Message);
                    }
                    //if (DateTime.Now > Convert.ToDateTime("2010-1-1"))
                    //{
                    //    System.Web.HttpContext.Current.Response.Write("<script>alert('请联系我');history.go(-1);" + "</" + "script>");
                    //}
                    return ds;
                }
            }
            else
            {
                return null;
            }
        }
        /// <summary>
        /// 执行查询语句，返回DataSet，省略查询字符串
        /// </summary>
        /// <param name="OleDbString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet ExecuteDataSet(string OleDbString)
        {
            return ExecuteDataSet(ConnectionStringLocalTransaction, OleDbString);
        }

        /// <summary>
        /// 返回DataTable
        /// </summary>
        /// <param name="sql">所用的sql语句</param>
        /// <returns></returns>
        public static DataTable ExecuteDataTable(string OleDbString)
        {
            return ExecuteDataTable(ConnectionStringLocalTransaction, OleDbString);
        }

        /// <summary>
        /// 返回DataTable
        /// </summary>
        /// <param name="sql">所用的sql语句</param>
        /// <param name="param">可变，可以传参也可以不传参数</param>
        /// <returns></returns>
        public static DataTable ExecuteDataTable(string OleDbString, params OleDbParameter[] commandParameters)
        {
            return ExecuteDataTable(ConnectionStringLocalTransaction, OleDbString, commandParameters);
        }
        /// <summary>
        /// 返回DataTable
        /// </summary>
        /// <param name="connectionString">连接字符串</param>
        /// <param name="OleDbString">所用的sql语句</param>
        /// <returns></returns>
        public static DataTable ExecuteDataTable(string connectionString, string OleDbString)
        {
            DataTable dt = new DataTable();
            using (OleDbConnection con = new OleDbConnection(connectionString))
            {
                using (OleDbDataAdapter adapter = new OleDbDataAdapter(OleDbString, con))
                {
                    //添加参数
                    //adapter.SelectCommand.Parameters.AddRange(commandParameters);
                    //1.打开链接，如果连接没有打开，则它给你打开；如果打开，就算了
                    //2.去执行sql语句，读取数据库
                    //3.sqlDataReader,把读取到的数据填充到内存表中
                    adapter.Fill(dt);
                }
            }
            return dt;
        }
        /// <summary>
        /// 返回DataTable
        /// </summary>
        /// <param name="connectionString">连接字符串</param>
        /// <param name="OleDbString">所用的sql语句</param>
        /// <param name="commandParameters">以数组形式提供OleDbCommand命令中用到的参数列表</param>
        /// <returns></returns>
        public static DataTable ExecuteDataTable(string connectionString, string OleDbString, params OleDbParameter[] commandParameters)
        {
            DataTable dt = new DataTable();
            using (OleDbConnection con = new OleDbConnection(connectionString))
            {
                using (OleDbDataAdapter adapter = new OleDbDataAdapter(OleDbString, con))
                {
                    //添加参数
                    adapter.SelectCommand.Parameters.AddRange(commandParameters);
                    //1.打开链接，如果连接没有打开，则它给你打开；如果打开，就算了
                    //2.去执行sql语句，读取数据库
                    //3.sqlDataReader,把读取到的数据填充到内存表中
                    adapter.Fill(dt);
                }
            }
            return dt;
        }



        /// <summary>
        /// 缓存参数数组
        /// </summary>
        /// <param name="cacheKey">参数缓存的键值</param>
        /// <param name="cmdParms">被缓存的参数列表</param>
        public static void CacheParameters(string cacheKey, params OleDbParameter[] commandParameters)
        {
            parmCache[cacheKey] = commandParameters;
        }

        /// <summary>
        /// 获取被缓存的参数
        /// </summary>
        /// <param name="cacheKey">用于查找参数的KEY值</param>
        /// <returns>返回缓存的参数数组</returns>
        public static OleDbParameter[] GetCachedParameters(string cacheKey)
        {
            OleDbParameter[] cachedParms = (OleDbParameter[])parmCache[cacheKey];

            if (cachedParms == null)
                return null;

            //新建一个参数的克隆列表
            OleDbParameter[] clonedParms = new OleDbParameter[cachedParms.Length];

            //通过循环为克隆参数列表赋值
            for (int i = 0, j = cachedParms.Length; i < j; i++)
                //使用clone方法复制参数列表中的参数
                clonedParms[i] = (OleDbParameter)((ICloneable)cachedParms[i]).Clone();

            return clonedParms;
        }

        /// <summary>
        /// 为执行命令准备参数
        /// </summary>
        /// <param name="cmd">OleDbCommand 命令</param>
        /// <param name="conn">已经存在的数据库连接</param>
        /// <param name="trans">数据库事物处理</param>
        /// <param name="cmdType">OleDbCommand命令类型 (存储过程， T-OleDb语句， 等等。)</param>
        /// <param name="cmdText">Command text，T-OleDb语句 例如 Select * from Products</param>
        /// <param name="cmdParms">返回带参数的命令</param>
        private static void PrepareCommand(OleDbCommand cmd, OleDbConnection conn, OleDbTransaction trans, CommandType cmdType, string cmdText, OleDbParameter[] cmdParms)
        {

            //判断数据库连接状态
            if (conn.State != ConnectionState.Open)
                conn.Open();

            cmd.Connection = conn;
            cmd.CommandText = cmdText;

            //判断是否需要事物处理
            if (trans != null)
                cmd.Transaction = trans;

            cmd.CommandType = cmdType;

            if (cmdParms != null)
            {
                foreach (OleDbParameter parm in cmdParms)
                    cmd.Parameters.Add(parm);
            }
        }

        public static bool Get_state(string tableid, int typeid)
        {
            string sql = "select leveright from  Adminlevel where id=" + typeid + "";
            string rights = GB.AccessbHelper.ExecuteScalar(sql).ToString();
            if (rights.Contains("," + tableid + ","))
            {
                return true;//所发信息需要审核
            }
            else
            {
                return false;//所发信息无需要审核
            }

        }

    }

    /// <summary>
    /// 处理object到各种数据类型的转换的简化类,对Convert.ToXXX(o)的封装,主要是为了少写几行代码,没其他大的作用。
    /// </summary>
    public class Jobject
    {
        private object o;
        /// <summary>
        /// 构造函数，接受一个object类型的参数
        /// </summary>
        /// <param name="o"></param>
        public Jobject(object o)
        {
            this.o = o;
        }

        public object O
        {
            get
            {
                return o;
            }
            set
            {
                o = value;
            }
        }
        /// <summary>
        /// 转化为字符串类型
        /// </summary>
        /// <returns>字符串</returns>
        public override string ToString()
        {
            if (o != null && o.ToString() != "")
                return o.ToString();
            else
                return "";
        }
        /// <summary>
        /// 转化为Int类型
        /// </summary>
        /// <returns>Int类型</returns>
        public int ToInt()
        {
            if (o != null && o.ToString() != "")
                return Convert.ToInt32(o);
            else
                return 0;
        }
        /// <summary>
        /// 转化为日期时间类型
        /// </summary>
        /// <returns>日期时间类型</returns>
        public DateTime ToDateTime()
        {
            if (o != null && o.ToString() != "")
                return Convert.ToDateTime(o);
            else
                return DateTime.Now;
        }
        /// <summary>
        /// 转化为特定格式的日期时间字符串
        /// </summary>
        /// <param name="format">格式字符串</param>
        /// <returns>字符串</returns>
        public string ToDateTime(string format)
        {
            if (o != null && o.ToString() != "")
                return Convert.ToDateTime(o).ToString(format);
            else
                return DateTime.Now.ToString();
        }
        /// <summary>
        /// 转化为Byte类型
        /// </summary>
        /// <returns>Byte类型</returns>
        public Byte ToByte()
        {
            if (o != null && o.ToString() != "")
                return Convert.ToByte(o);
            else
                return 0;
        }
        /// <summary>
        /// 转化为bool类型
        /// </summary>
        /// <returns>bool类型</returns>
        public bool ToBoolean()
        {
                return Convert.ToBoolean(o);
        }


        /// <summary>
        /// 转化为double类型
        /// </summary>
        /// <returns>double类型</returns>
        /// 
        public double ToDouble()
        {
            if (o != null && o.ToString() != "")
                return Convert.ToDouble(o);
            else
                return 0;
        }

        /// <summary>
        /// 转化为decimal类型
        /// </summary>
        /// <returns>decimal类型</returns>
        /// 
        public decimal ToDecimal()
        {
            if (o != null && o.ToString() != "")
                return Convert.ToDecimal(o);
            else
                return 0;
        }
       
    }
}