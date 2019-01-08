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
            default:
                break;
        }
    }

    /// <summary>
    /// 获取频道列表数据
    /// </summary>
    /// <param name="context"></param>
    protected void GetChannelListJson(HttpContext context) 
    {
        string strSql = "select id,sort_name from news_class where big_id=0 and istop=0 order by orders asc,id asc";
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