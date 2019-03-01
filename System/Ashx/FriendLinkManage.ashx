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
        }
    }

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


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}