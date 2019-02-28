<%@ WebHandler Language="C#" Class="SystemManage" %>

using System;
using System.Web;
using LitJson;
using System.Text;
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
            case "loadSiteParamInfo":    //网站参数加载
                LoadSiteParamInfo(context);
                break;
            case "saveSiteParamInfo":    //保存网站参数页面的数据
                SaveSiteParamInfo(context, jsonData);
                break;
            case "addTopCnl":           //新增顶级频道
                AddTopChannel(context, jsonData);
                break;
            case "addCate":            //新增子频道
                AddCategory(context, jsonData);
                break;
            case "searchModleById":    //通过id查询频道信息
                SearchModleById(context, jsonData);
                break;
            case "updateCate":        //修改频道
                UpdateCategory(context, jsonData);
                break;
            case "delCate":           //删除频道
                DeleteCategory(context, jsonData);
                break;
            case "backToUpChannel":    //频道列表返回上一级列表
                BackToUpChannel(context, jsonData);
                break;
            case "AddManager":      //新增管理员
                AddManager(context, jsonData);
                break;
            case "updateManagerPwd":    //修改管理员密码
                UpdateManagerPwd(context, jsonData);
                break;
            case "deleteManage":        //删除管理员
                DeleteManage(context, jsonData);
                break;
            case "searchDropMenuList":  //查询下拉框内容
                SearchDropMenuList(context, jsonData);
                break;
            case "getTableIdBySortName":    //根据分类名称查询分类id
                GetTableIdBySortName(context, jsonData);
                break;
            case "searchCateDropMenuList":  //查询新增界面下拉框内容
                SearchCateDropMenuList(context, jsonData);
                break;
            case "searchUpdateCateDropMenuList":
                SearchUpdateCateDropMenuList(context, jsonData);
                break;
            case "addIndexSetInfo":        //新增首页设置
                AddIndexSetInfo(context, jsonData);
                break;
            case "searchIndexSetInfo":     //按照id查询首页设置详情
                SearchIndexSetInfo(context, jsonData);
                break;
            case "updateIndexSetInfo":     //修改首页设置
                UpdateIndexSetInfo(context, jsonData);
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

    #region 根据父级id获取这个频道的父级id
    /// <summary>
    /// 根据父级id获取这个频道的父级id
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void BackToUpChannel(HttpContext context, JsonData jsonData)
    {
        //获取页面传递父级id
        string id = jsonData["Cid"].ToString();
        //返回信息对象话
        Error error = new Error();
        string strSql = "";

        try
        {
            //查询父级id
            strSql = "select big_id from news_class where id =" + id;
            string bigId = GB.AccessbHelper.ExecuteScalar(strSql).ToString();
            //返回的为空值则查询失败，否则查询成功
            if (!string.IsNullOrEmpty(bigId))
            {
                string cname = "";
                if (!bigId.Equals("0"))
                {
                    strSql = "select sort_name from news_class where id =" + bigId;
                    cname = GB.AccessbHelper.ExecuteScalar(strSql).ToString();
                }
                //查询成功，返回查询的父级id
                error.ErrorCode = "0";
                error.ErrorMsg = bigId + ":" + cname;
            }
            else
            {
                //查询失败，返回失败提示
                error.ErrorCode = "1";
                error.ErrorMsg = "查询失败！";
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

    #region 新增管理员
    /// <summary>
    /// 新增管理员
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void AddManager(HttpContext context, JsonData jsonData)
    {
        //获取新增管理员的用户名和密码 
        string userName = jsonData["userName"].ToString();
        string userPwd = jsonData["pwd"].ToString();
        //密码加密
        userPwd = GB.Encrypt.jiami(userPwd);

        Error error = new Error();
        int result = 0;
        string strSql = "";

        try
        {
            strSql = "insert into ergyertye346(swtfhuiesyt,dfhrdtqw5,usertype,truename) values(@swtfhuiesyt,@dfhrdtqw5,@usertype,@truename)";
            OleDbParameter[] param = new OleDbParameter[4];
            param[0] = new OleDbParameter("@swtfhuiesyt", userName);
            param[1] = new OleDbParameter("@dfhrdtqw5", userPwd);
            param[2] = new OleDbParameter("@usertype", "manger");
            param[3] = new OleDbParameter("@truename", userName);
            result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);
            if (result > 0)
            {
                //用户新增成功
                error.ErrorCode = "0";
            }
            else
            {
                //数据库添加失败
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
        //对象转为json，返回页面
        context.Response.Write(JsonMapper.ToJson(error));

    } 
    #endregion

    #region 修改管理员密码
    /// <summary>
    /// 修改管理员密码
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void UpdateManagerPwd(HttpContext context, JsonData jsonData)
    {
        //获取要修改用户的id和密码 
        string id = jsonData["id"].ToString();
        string userPwd = jsonData["userPwd"].ToString();
        //密码加密
        userPwd = GB.Encrypt.jiami(userPwd);

        Error error = new Error();
        int result = 0;
        string strSql = "";

        try
        {
            strSql = "update ergyertye346 set dfhrdtqw5=@dfhrdtqw5 where id=@id";
            OleDbParameter[] param = new OleDbParameter[2];
            param[0] = new OleDbParameter("@dfhrdtqw5", userPwd);
            param[1] = new OleDbParameter("@id", id);
            result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);
            if (result > 0)
            {
                //用户密码修改成功
                error.ErrorCode = "0";
            }
            else
            {
                //密码修改失败
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

    #region 删除管理员
    /// <summary>
    /// 删除管理员
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void DeleteManage(HttpContext context, JsonData jsonData)
    {
        //获取要删除用户的id
        string id = jsonData["id"].ToString();

        Error error = new Error();
        int result = 0;
        string strSql = "";

        try
        {
            strSql = " Delete from ergyertye346 where id="+id;
            result = GB.AccessbHelper.ExecuteNonQuery(strSql);
            if (result > 0)
            {
                //用户密码修改成功
                error.ErrorCode = "0";
            }
            else
            {
                //密码修改失败
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

    #region 查询下拉框内容
    /// <summary>
    /// 查询下拉框内容
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void SearchDropMenuList(HttpContext context, JsonData jsonData)
    {
        //获取查询列表的父级id
        string cid = jsonData["cid"].ToString();
        Error error = new Error();
        string strSql = "";
        try
        {
            strSql = "select * from news_class where big_id=0 and istop=0 order by id ";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    DataRow[] dr = dt.Select("sort_name like '%首页%'");
                    if (dr.Length == 0)
                        sb.Append("<li><a onclick='shows1($(this).text())' href='#'>网站首页</a> </li>");
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<li><a onclick='shows1($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                    }
                    //查询成功，返回html值
                    error.ErrorCode = "0";
                    error.ErrorMsg = sb.ToString();
                }
                else
                {
                    //sql查询失败，查询到的值为空值
                    error.ErrorCode = "1";
                    error.ErrorMsg = "没有查询数据！";
                }
            }
            else
            {
                //sql查询失败，查询到的值为空值
                error.ErrorCode = "1";
                error.ErrorMsg = "没有查询数据！";
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

    #region 根据分类名称查询分类id
    /// <summary>
    /// 根据分类名称查询分类id
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void GetTableIdBySortName(HttpContext context, JsonData jsonData)
    {
        //获取页面传进来的分类名称
        string class_name = jsonData["sortname"].ToString();
        Error error = new Error();
        string strSql = "";

        try
        {
            //根据分类名称查询分类id和分类路径
            strSql = "select * from news_class where sort_name='" + class_name + "'";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            //根据查询到的表格数据，判断是否查询到分类信息；否则没有查到分类信息
            if (dt.Rows.Count > 0)
            {
                string cid = dt.Rows[0]["id"].ToString();
                error.ErrorCode = "0";
                error.ErrorMsg = cid;
            }
            else
            {
                error.ErrorCode = "0";
                error.ErrorMsg = "未查询分类信息！";
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

    #region 查询新增界面下拉框内容
    /// <summary>
    /// 查询新增界面下拉框内容
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void SearchCateDropMenuList(HttpContext context, JsonData jsonData)
    {
    //获取查询列表的父级id
        string cid = jsonData["cid"].ToString();
        Error error = new Error();
        string strSql = "";
        try
        {
            strSql = "select * from news_class where big_id=0 and istop=0 order by id ";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    DataRow[] dr = dt.Select("sort_name like '%首页%'");
                    sb.Append("<li><a onclick='showCates($(this).text())' href='#'>请选择类别</a> </li>");
                    if (dr.Length == 0)
                        sb.Append("<li><a onclick='showCates($(this).text())' href='#'>网站首页</a> </li>");
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<li><a onclick='showCates($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                    }
                    //查询成功，返回html值
                    error.ErrorCode = "0";
                    error.ErrorMsg = sb.ToString();
                }
                else
                {
                    //sql查询失败，查询到的值为空值
                    error.ErrorCode = "1";
                    error.ErrorMsg = "没有查询数据！";
                }
            }
            else
            {
                //sql查询失败，查询到的值为空值
                error.ErrorCode = "1";
                error.ErrorMsg = "没有查询数据！";
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

    private void SearchUpdateCateDropMenuList(HttpContext context, JsonData jsonData)
    {
        //获取查询列表的父级id
        string cid = jsonData["cid"].ToString();
        Error error = new Error();
        string strSql = "";
        try
        {
            strSql = "select * from news_class where big_id=0 and istop=0 order by id ";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    DataRow[] dr = dt.Select("sort_name like '%首页%'");
                    sb.Append("<li><a onclick='show_update_cates($(this).text())' href='#'>请选择类别</a> </li>");
                    if (dr.Length == 0)
                        sb.Append("<li><a onclick='show_update_cates($(this).text())' href='#'>网站首页</a> </li>");
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<li><a onclick='show_update_cates($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                    }
                    //查询成功，返回html值
                    error.ErrorCode = "0";
                    error.ErrorMsg = sb.ToString();
                }
                else
                {
                    //sql查询失败，查询到的值为空值
                    error.ErrorCode = "1";
                    error.ErrorMsg = "没有查询数据！";
                }
            }
            else
            {
                //sql查询失败，查询到的值为空值
                error.ErrorCode = "1";
                error.ErrorMsg = "没有查询数据！";
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

    #region 新增首页设置
    /// <summary>
    /// 新增首页设置
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void AddIndexSetInfo(HttpContext context, JsonData jsonData)
    {
        //获取页面设置的参数
        string sortid = jsonData["sortid"].ToString();
        string title = jsonData["title"].ToString();
        string pagekeyw = jsonData["pagekeyw"].ToString();
        string pagedesc = jsonData["pagedesc"].ToString();
        string class_name = jsonData["class_name"].ToString();
        string picpath = jsonData["picpath"].ToString();
        string abs = jsonData["abstract"].ToString();
        string info = jsonData["info"].ToString();

        string classid, newspath = "";
        
        Error error = new Error();
        int result = 0;
        string strSql = "";
        try
        {
            //根据分类名称查询分类id和分类路径
            strSql = "select * from news_class where sort_name='" + class_name + "'";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            //根据查询到的表格数据，判断是否查询到分类信息；否则没有查到分类信息
            if (dt.Rows.Count > 0)
            {
                //获取分类id和分类路径
                classid = dt.Rows[0]["id"].ToString();
                newspath = dt.Rows[0]["path"].ToString();
                
                //插入数据
                strSql = "insert into news(title,class_id,info,news_path,newsstate,ispic,picpath,infofrom,pagekeyw,pagedesc,abstract,sortid,isindex,isjp,ists,weburl,titlesize,indexsort) values(@title,@class_id,@info,@news_path,@newsstate,@ispic,@picpath,@infofrom,@pagekeyw,@pagedesc,@abstract,@sortid,@isindex,@isjp,@ists,@weburl,@titlesize,@indexsort)";
                OleDbParameter[] param = new OleDbParameter[18];
                param[0] = new OleDbParameter("@title", title);
                param[1] = new OleDbParameter("@class_id", classid);
                param[2] = new OleDbParameter("@info", info);
                param[3] = new OleDbParameter("@news_path", newspath);
                param[4] = new OleDbParameter("@newsstate", "1");
                param[5] = new OleDbParameter("@ispic", "0");
                param[6] = new OleDbParameter("@picpath", picpath);
                param[7] = new OleDbParameter("@infofrom", "本站");
                param[8] = new OleDbParameter("@pagekeyw", pagekeyw);
                param[9] = new OleDbParameter("@pagedesc", pagedesc);
                param[10] = new OleDbParameter("@abstract", abs);
                param[11] = new OleDbParameter("@sortid", sortid);
                param[12] = new OleDbParameter("@isindex", "1");
                param[13] = new OleDbParameter("@isjp", "0");
                param[14] = new OleDbParameter("@ists", "0");
                param[15] = new OleDbParameter("@weburl", "");
                param[16] = new OleDbParameter("@titlesize", "14");
                param[17] = new OleDbParameter("@indexsort", sortid);
                result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);
                if (result > 0)
                {
                    //插入成功
                    error.ErrorCode = "0";
                    error.ErrorMsg = "数据插入成功！";
                }
                else
                {   
                    //插入失败
                    error.ErrorCode = "1";
                    error.ErrorMsg = "数据插入失败！";
                }
            }
            else 
            {
                //sql异常，异常原因
                error.ErrorCode = "1";
                error.ErrorMsg = "未查到分类信息！";
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

    #region 根据id查询首页设置详情内容
    /// <summary>
    /// 根据id查询首页设置详情内容
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void SearchIndexSetInfo(HttpContext context, JsonData jsonData)
    {
        //获取查询详情内容id
        string id = jsonData["id"].ToString();

        ParamInfo pInfo = new ParamInfo();
        
        string strSql = "";
        try
        {
            //查询sql语句
            strSql = " select top 1 id,sortid,title,pagekeyw,pagedesc,class_id,picpath,Abstract,info from news where id= "+id;
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            //判断查询的数据是否为空值，不为空值，查询其分类名称
            if (dt.Rows.Count > 0) 
            {
                //sql语句，根据分类id查询分类名称
                strSql = "select sort_name from news_class where id="+dt.Rows[0]["class_id"].ToString();
                string sort_name = GB.AccessbHelper.ExecuteScalar(strSql).ToString();

                pInfo.Id = dt.Rows[0]["id"].ToString();
                pInfo.Sortid = dt.Rows[0]["sortid"].ToString();
                pInfo.Title = dt.Rows[0]["title"].ToString();
                pInfo.Pagekeyw = dt.Rows[0]["pagekeyw"].ToString();
                pInfo.Pagedesc = dt.Rows[0]["pagedesc"].ToString();
                pInfo.Class_id = dt.Rows[0]["class_id"].ToString();
                pInfo.Class_name = sort_name;
                pInfo.Picpath = dt.Rows[0]["picpath"].ToString();
                pInfo.Introduction = dt.Rows[0]["Abstract"].ToString();
                pInfo.Info = dt.Rows[0]["info"].ToString();
            }
            //对象转为json
            string result = JsonMapper.ToJson(pInfo);
            context.Response.Write(result);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    } 
    #endregion

    private void UpdateIndexSetInfo(HttpContext context, JsonData jsonData) 
    {
        //获取页面传进来的参数
        ParamInfo pInfo = new ParamInfo();
        pInfo.Id = jsonData["id"].ToString();
        pInfo.Sortid = jsonData["sortid"].ToString();
        pInfo.Title = jsonData["title"].ToString();
        pInfo.Pagekeyw = jsonData["pagekeyw"].ToString();
        pInfo.Pagedesc = jsonData["pagedesc"].ToString();
        pInfo.Class_name = jsonData["class_name"].ToString();
        pInfo.Picpath = jsonData["picpath"].ToString();
        pInfo.Introduction = jsonData["abstract"].ToString();
        pInfo.Info = jsonData["info"].ToString();

        Error error = new Error();
        int result = 0;
        string strSql = "";
        string newspath = "";

        try
        {
         //根据分类名称查询分类id和分类路径
            strSql = "select * from news_class where sort_name='" + pInfo.Class_name + "'";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            //根据查询到的表格数据，判断是否查询到分类信息；否则没有查到分类信息
            if (dt.Rows.Count > 0)
            {
                //获取分类id和分类路径
                pInfo.Class_id = dt.Rows[0]["id"].ToString();
                newspath = dt.Rows[0]["path"].ToString();

                //修改数据sql
                strSql = "update news set title=@title,class_id=@class_id,info=@info,news_path=@news_path,newsstate=@newsstate,ispic=@ispic,picpath=@picpath,infofrom=@infofrom,pagekeyw=@pagekeyw,pagedesc=@pagedesc,abstract=@abstract,sortid=@sortid,isindex=@isindex,isjp=@isjp,ists=@ists,weburl=@weburl,titlesize=@titlesize,indexsort=@indexsort where id=@id";
                OleDbParameter[] param = new OleDbParameter[18];
                param[0] = new OleDbParameter("@title", pInfo.Title);
                param[1] = new OleDbParameter("@class_id", pInfo.Class_id);
                param[2] = new OleDbParameter("@info", pInfo.Info);
                param[3] = new OleDbParameter("@news_path", newspath);
                param[4] = new OleDbParameter("@newsstate", "1");
                param[5] = new OleDbParameter("@ispic", "0");
                param[6] = new OleDbParameter("@picpath", pInfo.Picpath);
                param[7] = new OleDbParameter("@infofrom", "本站");
                param[8] = new OleDbParameter("@pagekeyw", pInfo.Pagekeyw);
                param[9] = new OleDbParameter("@pagedesc", pInfo.Pagedesc);
                param[10] = new OleDbParameter("@abstract", pInfo.Introduction);
                param[11] = new OleDbParameter("@sortid", pInfo.Sortid);
                param[12] = new OleDbParameter("@isindex", "1");
                param[13] = new OleDbParameter("@isjp", "0");
                param[14] = new OleDbParameter("@ists", "0");
                param[15] = new OleDbParameter("@weburl", "");
                param[16] = new OleDbParameter("@titlesize", "14");
                param[17] = new OleDbParameter("@indexsort", pInfo.Sortid);
                result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);
                if (result > 0)
                {
                    //插入成功
                    error.ErrorCode = "0";
                    error.ErrorMsg = "数据插入成功！";
                }
                else
                {
                    //插入失败
                    error.ErrorCode = "1";
                    error.ErrorMsg = "数据插入失败！";
                }
            }
            else
            {
                //sql异常，异常原因
                error.ErrorCode = "1";
                error.ErrorMsg = "未查到分类信息！";
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
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}

/// <summary>
/// 内容参数类
/// </summary>
[Serializable]
public class ParamInfo 
{
    /// <summary>
    /// id
    /// </summary>
    private string id;

    public string Id
    {
        get { return id; }
        set { id = value; }
    }

    /// <summary>
    /// 优先级别
    /// </summary>
    private string sortid;

    public string Sortid
    {
        get { return sortid; }
        set { sortid = value; }
    }
    
    /// <summary>
    /// 信息标题
    /// </summary>
    private string title;

    public string Title
    {
        get { return title; }
        set { title = value; }
    }
    
    /// <summary>
    /// 关键字
    /// </summary>
    private string pagekeyw;

    public string Pagekeyw
    {
        get { return pagekeyw; }
        set { pagekeyw = value; }
    }
    
    /// <summary>
    /// 描述
    /// </summary>
    private string pagedesc;

    public string Pagedesc
    {
        get { return pagedesc; }
        set { pagedesc = value; }
    }
    
    /// <summary>
    /// 所属栏目id
    /// </summary>
    private string class_id;

    public string Class_id
    {
        get { return class_id; }
        set { class_id = value; }
    }
    
    /// <summary>
    /// 所属栏目描述
    /// </summary>
    private string class_name;

    public string Class_name
    {
        get { return class_name; }
        set { class_name = value; }
    }
    
    /// <summary>
    /// 略缩图地址
    /// </summary>
    private string picpath;

    public string Picpath
    {
        get { return picpath; }
        set { picpath = value; }
    }
    
    /// <summary>
    /// 信息摘要
    /// </summary>
    private string introduction;

    public string Introduction
    {
        get { return introduction; }
        set { introduction = value; }
    }
    
    /// <summary>
    /// 信息内容
    /// </summary>
    private string info;

    public string Info
    {
        get { return info; }
        set { info = value; }
    }
    
    
}