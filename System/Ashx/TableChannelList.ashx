<%@ WebHandler Language="C#" Class="TableChannelList" %>

using System;
using System.Web;
using System.Data;


public class TableChannelList : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = context.Request["action"].ToString();
        switch (action) 
        {
            case "GetChannelListJson":
                GetChannelListJson(context);
                break;
            case "GetChildChannelListJson":
                string bigId = context.Request["bigId"].ToString();
                GetChildChannelListJson(context,bigId);
                break;
            default:
                break;
        }
    }

    /// <summary>
    /// 获取频道列表分页数据
    /// </summary>
    /// <param name="context"></param>
    protected void GetChannelListJson(HttpContext context) 
    {
        string orders = context.Request["order"].ToString();
        int offset =Convert.ToInt32(context.Request["offset"].ToString());
        int limit = Convert.ToInt32(context.Request["limit"].ToString());
        string strSql = "select id,sort_name,big_id from news_class where big_id=0 and istop=0 order by orders asc,id asc";
        DataTable dtZong = GB.AccessbHelper.ExecuteDataTable(strSql);
        DataTable dtPage = TableHelper.GetPagedTable(dtZong, offset+1, limit);
        string resultJson = JsonHelper.GetJsonByPageDataTable(dtZong, dtPage, "total", "rows");
        context.Response.Write(resultJson);
    }

    /// <summary>
    /// 获取字频道列表数据
    /// </summary>
    /// <param name="context"></param>
    /// <param name="bigId"></param>
    protected void GetChildChannelListJson(HttpContext context,string bigId) 
    {
        string strSql = "select id,sort_name,big_id from news_class where big_id="+bigId+" and istop=0 order by orders asc,id asc";
        DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
        string resultJson = JsonHelper.GetJsonByDataTable(dt, "total", "rows");
        context.Response.Write(resultJson);
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}