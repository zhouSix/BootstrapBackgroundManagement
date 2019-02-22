<%@ WebHandler Language="C#" Class="TableIndexList" %>

using System;
using System.Web;
using System.Data;

public class TableIndexList : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = context.Request["action"].ToString();
        switch (action)
        {
            case "GetIndexListJson":
                GetIndexListJson(context);
                break;
            default:
                break;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="context"></param>
    private void GetIndexListJson(HttpContext context) 
    {
        string orders = context.Request["order"].ToString();
        int offset = Convert.ToInt32(context.Request["offset"].ToString());
        int limit = Convert.ToInt32(context.Request["limit"].ToString());
        string strSql = "select id,title,class_id,iif(class_id=0,'首页',(select sort_name from news_class where id=class_id)) as sort_name,dateandtime,sortid from news where class_id=0 order by id asc";
        DataTable dtZong = GB.AccessbHelper.ExecuteDataTable(strSql);
        DataTable dtPage = TableHelper.GetPagedTable(dtZong, offset + 1, limit);
        string resultJson = JsonHelper.GetJsonByPageDataTable(dtZong, dtPage, "total", "rows");
        context.Response.Write(resultJson);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}