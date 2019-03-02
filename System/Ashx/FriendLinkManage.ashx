<%@ WebHandler Language="C#" Class="FriendLinkManage" %>

using System;
using System.Web;
using LitJson;
using System.Data;
using System.Data.OleDb;

public class FriendLinkManage : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/json";
        //获取页面传进来的json参数数据
        string model = context.Request.Params["data"];
        //将字符串转成json
        JsonData jsonData = JsonMapper.ToObject(model);
        string action = jsonData["action"].ToString();
        //判断页面使用什么方法
        switch (action)
        {
            case "addFriendLink":       //新增友情链接
                AddFriendLinkInfo(context, jsonData);
                break;
            case "searchFriendLinkInfo":    //查询友情链接信息
                SearchFriendLinkInfo(context, jsonData);
                break;
            case "updateFriendLink":    //修改友情链接
                UpdateFriendLink(context, jsonData);
                break;
            case "deleteFriendLink":    //删除友情链接
                DeleteFriendLink(context, jsonData);
                break;
        }
    }

    #region 新增友情链接
    /// <summary>
    /// 新增友情链接
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void AddFriendLinkInfo(HttpContext context, JsonData jsonData)
    {
        //获取页面传进来的参数
        string title = jsonData["title"].ToString();
        string link = jsonData["link"].ToString();
        //返回结果字符串
        Error error = new Error();
        int result = 0;
        string strSql = "";
        try
        {
            strSql = "insert into Links(title,infofrom)values(@title,@infofrom)";
            OleDbParameter[] param = new OleDbParameter[2];
            param[0] = new OleDbParameter("@title", title);
            param[1] = new OleDbParameter("@infofrom", link);
            result = GB.AccessbHelper.ExecuteNonQuery(strSql, param);

            if (result > 0)
            {
                error.ErrorCode = "0";
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

    #region 查询友情链接信息
    /// <summary>
    /// 查询友情链接信息
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void SearchFriendLinkInfo(HttpContext context, JsonData jsonData)
    {
        //获取页面传进来的参数
        string id = jsonData["id"].ToString();

        FriendLink link = new FriendLink();
        try
        {
            //根据id，查询友情链接内容
            string strSql = "select top 1 id,title,infofrom from Links where id=" + id;
            //执行sql
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            DataRow dr = dt.Rows[0];
            //将查到的表格数据转换成对象
            link.Id = dr["id"].ToString();
            link.Title = dr["title"].ToString();
            link.Infofrom = dr["infofrom"].ToString();
            //对象转为json
            string result = JsonMapper.ToJson(link);
            context.Response.Write(result);
        }
        catch (Exception ex)
        {
            throw new Exception(ex.Message);
        }
    } 
    #endregion

    #region 修改友情链接
    /// <summary>
    /// 修改友情链接
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void UpdateFriendLink(HttpContext context, JsonData jsonData)
    {
        //获取页面传进来的参数
        string id = jsonData["id"].ToString();
        string title = jsonData["title"].ToString();
        string link = jsonData["link"].ToString();

        //返回信息对象话
        Error error = new Error();
        //参数
        int result = 0;
        string strSql = "";

        try
        {
            strSql = "update Links set title=@title,infofrom=@infofrom where id=@id";
            OleDbParameter[] param = new OleDbParameter[3];
            param[0] = new OleDbParameter("@title", title);
            param[1] = new OleDbParameter("@infofrom", link);
            param[2] = new OleDbParameter("@id", id);
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

    #region 删除友情链接
    /// <summary>
    /// 删除友情链接
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void DeleteFriendLink(HttpContext context, JsonData jsonData)
    {
        //获取页面传进来的要删除的友情链接id
        string ids = jsonData["id"].ToString();
        //设置返回值
        Error error = new Error();
        int result = 0;
        string strSql = "";
        try
        {
            strSql = "Delete from Links where id in(" + ids + ")";
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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}

public class FriendLink 
{
    private string id;

    public string Id
    {
        get { return id; }
        set { id = value; }
    }

    private string title;

    public string Title
    {
        get { return title; }
        set { title = value; }
    }

    private string infofrom;

    public string Infofrom
    {
        get { return infofrom; }
        set { infofrom = value; }
    }
}