<%@ WebHandler Language="C#" Class="SystemFriendLink" %>

using System;
using System.Web;
using System.Data;

public class SystemFriendLink : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = context.Request["action"].ToString();
        switch (action)
        {
            case "GetFriendLinkList":       //查询友情链接列表信息
                GetFriendLinkList(context);
                break;
            default:
                break;
        }
    }

    #region 查询友情链接列表信息
    /// <summary>
    /// 查询友情链接列表信息
    /// </summary>
    /// <param name="context"></param>
    private void GetFriendLinkList(HttpContext context)
    {
        string orders = context.Request["order"].ToString();
        int offset = Convert.ToInt32(context.Request["offset"].ToString());
        int limit = Convert.ToInt32(context.Request["limit"].ToString());
        string strSql = "select id,title,infofrom from Links";
        DataTable dtZong = GB.AccessbHelper.ExecuteDataTable(strSql);
        DataTable dtPage = TableHelper.GetPagedTable(dtZong, offset + 1, limit);
        string resultJson = JsonHelper.GetJsonByPageDataTable(dtZong, dtPage, "total", "rows");
        context.Response.Write(resultJson);
    } 
    #endregion
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}