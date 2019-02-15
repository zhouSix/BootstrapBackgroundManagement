<%@ WebHandler Language="C#" Class="TableUserList" %>

using System;
using System.Web;
using System.Data;

public class TableUserList : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = context.Request["action"].ToString();
        switch (action)
        {
            case "GetUserListJson":
                GetUserListJson(context);
                break;
            default:
                break;
        }
    }

    #region 获取用户列表分页信息
    /// <summary>
    /// 获取用户列表分页信息
    /// </summary>
    /// <param name="context"></param>
    private void GetUserListJson(HttpContext context)
    {
        string orders = context.Request["order"].ToString();
        int offset = Convert.ToInt32(context.Request["offset"].ToString());
        int limit = Convert.ToInt32(context.Request["limit"].ToString());
        string strSql = "select id,swtfhuiesyt,dateandtime from ergyertye346 order by id asc";
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