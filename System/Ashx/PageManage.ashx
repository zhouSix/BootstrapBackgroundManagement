<%@ WebHandler Language="C#" Class="PageManage" %>

using System;
using System.Web;
using LitJson;
using System.Data;
using System.Data.OleDb;
using System.Text;

public class PageManage : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/json";
        //获取页面传进来的json参数数据
        string model = context.Request.Params["data"];
        //将字符串转成json
        JsonData jsonData = JsonMapper.ToObject(model);
        string action = jsonData["action"].ToString();
        //判断使用的方法是否是登录
        switch (action)
        {
            case "searchDrpMenuListHtml":  //查询页面下拉框内容
                SearchDrpMenuListHtml(context, jsonData);
                break;
            case "search_Add_DrpMenuListHtml":  //绑定新增界面分类信息的下拉框
                Search_Add_DrpMenuListHtml(context, jsonData);  
                break;
            case "getParantNameByPid":     //根据父级id来查询父级名称
                GetParantNameByPid(context, jsonData);
                break;
            case "search_Update_DrpMenuListHtml":       //绑定修改界面分类信息的下拉框
                Search_Update_DrpMenuListHtml(context, jsonData);  
                break;
            case "add_Page_Msg_Info":       //新增信息
                Add_Page_Msg_Info(context, jsonData);
                break;
            case "update_Page_Msg_Info":    //修改信息
                Update_Page_Msg_Info(context, jsonData);
                break;
                
        }
    }

    #region 查询页面下拉框内容
    /// <summary>
    /// 查询页面下拉框内容
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void SearchDrpMenuListHtml(HttpContext context, JsonData jsonData)
    {
        //获取查询列表的父级id
        string cid = jsonData["cid"].ToString();
        //输出链接字符串
        StringBuilder sb = new StringBuilder();
        Error error = new Error();
        string strSql = "";
        try
        {
            strSql = "select * from news_class where big_id=" + cid + " and istop=0 order by id ";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            //如果子级没有查询到数据，返回父级分类
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
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
                    //返回父级分类
                    strSql = "select * from news_class where id=" + cid;
                    dt = GB.AccessbHelper.ExecuteDataTable(strSql);
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<li><a onclick='shows1($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                    }
                    error.ErrorCode = "0";
                    error.ErrorMsg = sb.ToString();
                }
            }
            else
            {
                //返回父级分类
                strSql = "select * from news_class where id=" + cid;
                dt = GB.AccessbHelper.ExecuteDataTable(strSql);
                foreach (DataRow row in dt.Rows)
                {
                    sb.Append("<li><a onclick='shows1($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                }
                error.ErrorCode = "0";
                error.ErrorMsg = sb.ToString();
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

    #region 绑定新增界面分类信息的下拉框
    /// <summary>
    /// 绑定新增界面分类信息的下拉框
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void Search_Add_DrpMenuListHtml(HttpContext context, JsonData jsonData)
    {
        //获取查询列表的父级id
        string cid = jsonData["cid"].ToString();
        //输出链接字符串
        StringBuilder sb = new StringBuilder();
        Error error = new Error();
        string strSql = "";
        try
        {
            strSql = "select * from news_class where big_id=" + cid + " and istop=0 order by id ";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            //如果子级没有查询到数据，返回父级分类
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<li><a onclick='shows_Add($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                    }
                    //查询成功，返回html值
                    error.ErrorCode = "0";
                    error.ErrorMsg = sb.ToString();
                }
                else
                {
                    //返回父级分类
                    strSql = "select * from news_class where id=" + cid;
                    dt = GB.AccessbHelper.ExecuteDataTable(strSql);
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<li><a onclick='shows_Add($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                    }
                    error.ErrorCode = "0";
                    error.ErrorMsg = sb.ToString();
                }
            }
            else
            {
                //返回父级分类
                strSql = "select * from news_class where id=" + cid;
                dt = GB.AccessbHelper.ExecuteDataTable(strSql);
                foreach (DataRow row in dt.Rows)
                {
                    sb.Append("<li><a onclick='shows_Add($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                }
                error.ErrorCode = "0";
                error.ErrorMsg = sb.ToString();
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

    #region 根据父级id来查询父级名称
    /// <summary>
    /// 根据父级id来查询父级名称
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void GetParantNameByPid(HttpContext context, JsonData jsonData)
    {
        //获取查询列表的父级id
        string pid = jsonData["pid"].ToString();
        //输出的结果
        string result = "";
        Error error = new Error();
        //sql语句字符串
        string strSql = "";
        try
        {
            strSql = " select sort_name from news_class where id=" + pid;
            result = GB.AccessbHelper.ExecuteScalar(strSql).ToString();
            error.ErrorCode = "0";
            error.ErrorMsg = result;
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

    #region 绑定修改界面分类信息的下拉框
    /// <summary>
    /// 绑定修改界面分类信息的下拉框
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void Search_Update_DrpMenuListHtml(HttpContext context, JsonData jsonData)
    {
        //获取查询列表的父级id
        string cid = jsonData["cid"].ToString();
        //输出链接字符串
        StringBuilder sb = new StringBuilder();
        Error error = new Error();
        string strSql = "";
        try
        {
            strSql = "select * from news_class where big_id=" + cid + " and istop=0 order by id ";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            //如果子级没有查询到数据，返回父级分类
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<li><a onclick='shows_Update($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                    }
                    //查询成功，返回html值
                    error.ErrorCode = "0";
                    error.ErrorMsg = sb.ToString();
                }
                else
                {
                    //返回父级分类
                    strSql = "select * from news_class where id=" + cid;
                    dt = GB.AccessbHelper.ExecuteDataTable(strSql);
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<li><a onclick='shows_Update($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                    }
                    error.ErrorCode = "0";
                    error.ErrorMsg = sb.ToString();
                }
            }
            else
            {
                //返回父级分类
                strSql = "select * from news_class where id=" + cid;
                dt = GB.AccessbHelper.ExecuteDataTable(strSql);
                foreach (DataRow row in dt.Rows)
                {
                    sb.Append("<li><a onclick='shows_Update($(this).text())' href='#'>" + row["sort_name"] + "</a> </li>");
                }
                error.ErrorCode = "0";
                error.ErrorMsg = sb.ToString();
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

    #region 新增信息
    /// <summary>
    /// 新增信息
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void Add_Page_Msg_Info(HttpContext context, JsonData jsonData)
    {
        //获取页面传进来的参数
        string sortid = jsonData["sortid"].ToString();
        string title = jsonData["title"].ToString();
        string pagekeyw = jsonData["pagekeyw"].ToString();
        string pagedesc = jsonData["pagedesc"].ToString();
        string class_name = jsonData["class_name"].ToString();
        string picpath = jsonData["picpath"].ToString();
        string abs = jsonData["abstract"].ToString();
        string info = jsonData["info"].ToString();
        string clicks = jsonData["click"].ToString();
        string isIndex = jsonData["isindex"].ToString();
        string classid, newspath = "";

        //返回结果
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
                strSql = "insert into news(title,class_id,info,news_path,newsstate,ispic,picpath,infofrom,pagekeyw,pagedesc,abstract,sortid,click,isindex,isjp,ists,weburl,titlesize,indexsort,) values(@title,@class_id,@info,@news_path,@newsstate,@ispic,@picpath,@infofrom,@pagekeyw,@pagedesc,@abstract,@sortid,@click,@isindex,@isjp,@ists,@weburl,@titlesize,@indexsort)";
                OleDbParameter[] param = new OleDbParameter[19];
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
                param[12] = new OleDbParameter("@click", clicks);
                param[13] = new OleDbParameter("@isindex", "1");
                param[14] = new OleDbParameter("@isjp", "0");
                param[15] = new OleDbParameter("@ists", "0");
                param[16] = new OleDbParameter("@weburl", "");
                param[17] = new OleDbParameter("@titlesize", "14");
                param[18] = new OleDbParameter("@indexsort", sortid);
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

    #region 修改信息
    /// <summary>
    /// 修改信息
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void Update_Page_Msg_Info(HttpContext context, JsonData jsonData)
    {
        
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