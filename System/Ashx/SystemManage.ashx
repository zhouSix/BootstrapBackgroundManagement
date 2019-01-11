<%@ WebHandler Language="C#" Class="SystemManage" %>

using System;
using System.Web;
using LitJson;
using System.Configuration;
using System.Data.OleDb;
using System.Data;
using System.Collections.Generic;

public class SystemManage : IHttpHandler
{
    protected const int webParamId = 4;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/json";
        //获取页面传进来的json参数数据
        string model = context.Request.Params["data"];
        //将字符串转成json
        JsonData jsonData = JsonMapper.ToObject(model);
        string webAction = jsonData["action"].ToString();
        //判断使用的方法是否是登录
        switch (webAction)
        {
            //加载网站参数页面
            case "loadSiteParamInfo":
                LoadSiteParamInfo(context);
                break;
            case "saveSiteParamInfo":
                SaveSiteParamInfo(context, jsonData);
                break;
            case "addTopCnl":
                AddTopChannel(context, jsonData);
                break;
            case "addCate":
                AddCategory(context, jsonData);
                break;
            case "searchModleById":
                SearchModleById(context, jsonData);
                break;
            case "updateCate":
                UpdateCategory(context, jsonData);
                break;
            case "delCate":
                DeleteCategory(context, jsonData);
                break;
        }
    }

    #region 网站参数加载
    /// <summary>
    /// 网站参数加载
    /// </summary>
    /// <param name="context"></param>
    protected void LoadSiteParamInfo(HttpContext context)
    {
        try
        {
            WebParamInfo webParam = new WebParamInfo();
            //取出web.config中配置的网站参数信息
            webParam.WebName = ConfigurationManager.AppSettings["webname"].ToString();
            webParam.WebKey = ConfigurationManager.AppSettings["webkeywords"].ToString();
            webParam.WebDescribe = ConfigurationManager.AppSettings["webdescription"].ToString();

            //查询数据库中存不存在用户网站版权信息，存在取值，不存在为空值
            DataTable dt = GB.AccessbHelper.ExecuteDataTable("select info from PageInfo where id=" + webParamId);
            if (dt.Rows.Count > 0)
                webParam.WebCopyRight = dt.Rows[0][0].ToString();
            //对象转为json
            string result = JsonMapper.ToJson(webParam);
            context.Response.Write(result);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    #endregion


    #region 保存网站参数页面的数据
    /// <summary>
    /// 保存网站参数页面的数据
    /// </summary>
    /// <param name="context"></param>
    private void SaveSiteParamInfo(HttpContext context, JsonData jsonData)
    {
        WebParamInfo webParam = new WebParamInfo();
        //获取页面传进来的参数
        webParam.WebName = jsonData["WebName"].ToString();
        webParam.WebKey = jsonData["WebKey"].ToString();
        webParam.WebDescribe = jsonData["WebDescribe"].ToString();
        webParam.WebCopyRight = jsonData["WebCopyRight"].ToString();

        Error error = new Error();
        int result = 0;
        //网站版权信息保存到数据库中
        try
        {
            string strSql = "update PageInfo set info=@info where ID=" + webParamId;
            OleDbParameter[] param = new OleDbParameter[1];
            param[0] = new OleDbParameter("@info", webParam.WebCopyRight);
            result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);
        }
        catch (Exception ex)
        {
            //sql异常，异常原因
            error.ErrorCode = "1";
            error.ErrorMsg = ex.Message;
        }
        if (result > 0)
        {
            //sql更新成功，更新web.config中配置的网站参数信息
            ConfigHelper config = new ConfigHelper();
            config.SetAppSetting("webname", webParam.WebName);
            config.SetAppSetting("webkeywords", webParam.WebKey);
            config.SetAppSetting("webdescription", webParam.WebDescribe);
            config.Save();

            error.ErrorCode = "0";
        }
        else
        {
            //数据库没有修改成功
            error.ErrorCode = "1";
            error.ErrorMsg = "保存失败！";
        }

        //对象转为json
        context.Response.Write(JsonMapper.ToJson(error));
    }
    #endregion


    #region 新增顶级频道
    /// <summary>
    /// 新增顶级频道
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    protected void AddTopChannel(HttpContext context, JsonData jsonData)
    {
        News_Class nc = new News_Class();
        //获取页面传进来的参数
        nc.sort_name = jsonData["sortName"].ToString();
        nc.big_id = Convert.ToInt32(jsonData["bigId"].ToString());
        nc.orders = Convert.ToInt32(jsonData["orders"].ToString());
        nc.pagetitle = jsonData["pageTitle"].ToString();
        nc.pagekeyw = jsonData["pageKey"].ToString();
        nc.pagedesc = jsonData["pageDesc"].ToString();

        Error error = new Error();
        int result = 0;
        string strSql = "";
        try
        {
            strSql = "insert into news_class(sort_name,big_id,orders,pagetitle,pagekeyw,pagedesc) values(@sort_name,@big_id,@orders,@pagetitle,@pagekeyw,@pagedesc)";
            OleDbParameter[] param = new OleDbParameter[6];
            param[0] = new OleDbParameter("@sort_name", nc.sort_name);
            param[1] = new OleDbParameter("@big_id", nc.big_id);
            param[2] = new OleDbParameter("@orders", nc.orders);
            param[3] = new OleDbParameter("@pagetitle", nc.pagetitle);
            param[4] = new OleDbParameter("@pagekeyw", nc.pagekeyw);
            param[5] = new OleDbParameter("@pagedesc", nc.pagedesc);
            result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);

            if (result > 0)
            {
                result = 0;
                //sql更新成功，设置news_class中的path
                strSql = "select max(id) from news_class";
                string topId = GB.AccessbHelper.ExecuteScalar(strSql).ToString();
                string topPath = ",0," + topId.Trim() + ",";
                strSql = "update news_class set path=@path where ID=" + topId.Trim();
                OleDbParameter[] otherParam = new OleDbParameter[1];
                otherParam[0] = new OleDbParameter("@path", topPath);
                result = GB.AccessbHelper.ExecuteNonQuery(strSql, otherParam);
                if (result > 0)
                {
                    error.ErrorCode = "0";
                }
                else
                {
                    //数据库没有修改成功
                    error.ErrorCode = "1";
                    error.ErrorMsg = "数据保存成功，字段path未修改完成！";
                }
            }
            else
            {
                //数据库没有修改成功
                error.ErrorCode = "1";
                error.ErrorMsg = "保存失败！";
            }
        }
        catch (Exception ex)
        {
            //sql异常，异常原因
            error.ErrorCode = "1";
            error.ErrorMsg = ex.Message;
        }
        //对象转为json
        context.Response.Write(JsonMapper.ToJson(error));
    }
    #endregion

    #region 新增分类
    /// <summary>
    /// 新增分类
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    protected void AddCategory(HttpContext context, JsonData jsonData)
    {
        News_Class nc = new News_Class();
        //获取页面传进来的参数
        nc.sort_name = jsonData["sortName"].ToString();
        nc.big_id = Convert.ToInt32(jsonData["bigId"].ToString());
        nc.orders = Convert.ToInt32(jsonData["orders"].ToString());
        nc.pagetitle = jsonData["pageTitle"].ToString();
        nc.pagekeyw = jsonData["pageKey"].ToString();
        nc.pagedesc = jsonData["pageDesc"].ToString();

        Error error = new Error();
        int result = 0;
        string strSql = "";
        try
        {
            strSql = "insert into news_class(sort_name,big_id,orders,pagetitle,pagekeyw,pagedesc) values(@sort_name,@big_id,@orders,@pagetitle,@pagekeyw,@pagedesc)";
            OleDbParameter[] param = new OleDbParameter[6];
            param[0] = new OleDbParameter("@sort_name", nc.sort_name);
            param[1] = new OleDbParameter("@big_id", nc.big_id);
            param[2] = new OleDbParameter("@orders", nc.orders);
            param[3] = new OleDbParameter("@pagetitle", nc.pagetitle);
            param[4] = new OleDbParameter("@pagekeyw", nc.pagekeyw);
            param[5] = new OleDbParameter("@pagedesc", nc.pagedesc);
            result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);

            if (result > 0)
            {
                result = 0;
                //sql更新成功，设置news_class中的path
                strSql = "select max(id) from news_class";
                string topId = GB.AccessbHelper.ExecuteScalar(strSql).ToString();
                string topPath;
                if (nc.big_id == 0)
                    topPath = ",0," + topId.Trim() + ",";
                else
                    topPath = ",0," + nc.big_id + "," + topId.Trim() + ",";
                strSql = "update news_class set path=@path where ID=" + topId.Trim();
                OleDbParameter[] otherParam = new OleDbParameter[1];
                otherParam[0] = new OleDbParameter("@path", topPath);
                result = GB.AccessbHelper.ExecuteNonQuery(strSql, otherParam);
                if (result > 0)
                {
                    error.ErrorCode = "0";
                }
                else
                {
                    //数据库没有修改成功
                    error.ErrorCode = "1";
                    error.ErrorMsg = "数据保存成功，字段path未修改完成！";
                }
            }
            else
            {
                //数据库没有修改成功
                error.ErrorCode = "1";
                error.ErrorMsg = "保存失败！";
            }
        }
        catch (Exception ex)
        {
            //sql异常，异常原因
            error.ErrorCode = "1";
            error.ErrorMsg = ex.Message;
        }
        //对象转为json
        context.Response.Write(JsonMapper.ToJson(error));
    }
    #endregion

    #region 查询分类信息
    /// <summary>
    /// 查询分类信息
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    protected void SearchModleById(HttpContext context, JsonData jsonData)
    {
        //获取页面传进来的参数
        string id = jsonData["id"].ToString();
        //返回实体对象实例化
        News_Class nc = new News_Class();
        try
        {
            //查询sql语句
            string strSql = "select top 1 id,sort_name,big_id,path,orders,pagetitle,pagekeyw,pagedesc from news_class where id=" + id;
            //执行sql
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            DataRow dr = dt.Rows[0];
            //将查到的表格数据转换成对象
            nc.id = Convert.ToInt32(dr["id"].ToString());
            nc.sort_name = dr["sort_name"].ToString();
            nc.big_id = Convert.ToInt32(dr["big_id"].ToString());
            nc.path = dr["path"].ToString();
            nc.orders = Convert.ToInt32(dr["orders"].ToString());
            nc.pagetitle = dr["pagetitle"].ToString();
            nc.pagekeyw = dr["pagekeyw"].ToString();
            nc.pagedesc = dr["pagedesc"].ToString();
            //判断父级id的值，为零，父级名称为：0顶级分类；否则为big_id + 父级名称 
            if (nc.big_id == 0)
                nc.big_name = "0顶级分类";
            else
            {
                strSql = "select top 1 sort_name from news_class where id=" + nc.big_id;
                string sName = GB.AccessbHelper.ExecuteScalar(strSql).ToString();
                if (!string.IsNullOrEmpty(sName))
                    nc.big_name = nc.big_id + sName;
            }
            //对象转为json
            string result = JsonMapper.ToJson(nc);
            context.Response.Write(result);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    }
    #endregion

    #region 修改分类
    /// <summary>
    /// 修改分类
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    protected void UpdateCategory(HttpContext context, JsonData jsonData)
    {
        News_Class nc = new News_Class();
        //获取页面传进来的参数
        nc.id = Convert.ToInt32(jsonData["id"].ToString());
        nc.sort_name = jsonData["sortName"].ToString();
        nc.big_id = Convert.ToInt32(jsonData["bigId"].ToString());
        nc.orders = Convert.ToInt32(jsonData["orders"].ToString());
        nc.pagetitle = jsonData["pageTitle"].ToString();
        nc.pagekeyw = jsonData["pageKey"].ToString();
        nc.pagedesc = jsonData["pageDesc"].ToString();

        //返回信息对象话
        Error error = new Error();
        //参数
        int result = 0;
        string strSql = "";

        try
        {
            //修改的sql语句，父级分类不变，path不变
            strSql = " update news_class set sort_name=@sortName,orders=@orders,pagetitle=@pagetitle,pagekeyw=@pagekeyw,pagedesc=@pagedesc where id=@id";
            OleDbParameter[] param = new OleDbParameter[6];
            param[0] = new OleDbParameter("@sortName", nc.sort_name);
            param[1] = new OleDbParameter("@orders", nc.orders);
            param[2] = new OleDbParameter("@pagetitle", nc.pagetitle);
            param[3] = new OleDbParameter("@pagekeyw", nc.pagekeyw);
            param[4] = new OleDbParameter("@pagedesc", nc.pagedesc);
            param[5] = new OleDbParameter("@id", nc.id);
            result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);
            if (result > 0)
            {
                //数据库修改成功
                error.ErrorCode = "0";
            }
            else
            {
                //数据库没有修改成功
                error.ErrorCode = "1";
                error.ErrorMsg = "修改失败！";
            }
        }
        catch (Exception ex)
        {
            //sql异常，异常原因
            error.ErrorCode = "1";
            error.ErrorMsg = ex.Message;
        }
        //对象转为json，返回页面
        context.Response.Write(JsonMapper.ToJson(error));
    }
    #endregion

    #region 删除分类
    /// <summary>
    /// 删除分类
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    protected void DeleteCategory(HttpContext context, JsonData jsonData)
    {
        //获取页面传递尽量要删除的id
        string id = jsonData["id"].ToString();
        //变量
        //返回信息对象话
        Error error = new Error();
        string strSql = "";
        int result = 0;
        try
        {
            //查询要删除分类的path路径
            strSql = "select path from news_class where id =" + id;
            string dele_path = GB.AccessbHelper.ExecuteScalar(strSql).ToString();

            //删除此类以及此类的子类在news表中的全部内容
            strSql = "delete from news where news_path like'%" + dele_path + "%' ";
            result = GB.AccessbHelper.ExecuteNonQuery(strSql);


            //删除此类以及此类的子类
            strSql = "delete from news_class where path like'%" + dele_path + "%'";
            result = GB.AccessbHelper.ExecuteNonQuery(strSql);
            if (result > 0)
            {
                //数据删除成功！
                error.ErrorCode = "0";
            }
            else
            {
                //数据库删除失败！-（删除news_class表中id为"id"的类以及"id"的子类）
                error.ErrorCode = "1";
                error.ErrorMsg = "删除失败！";
            }
        }
        catch (Exception ex)
        {
            //sql异常，异常原因
            error.ErrorCode = "1";
            error.ErrorMsg = ex.Message;
        }
        //对象转为json，返回页面
        context.Response.Write(JsonMapper.ToJson(error));
    }
    #endregion

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}