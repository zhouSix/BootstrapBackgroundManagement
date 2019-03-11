<%@ WebHandler Language="C#" Class="PageTableList" %>

using System;
using System.Web;
using System.Data;
using LitJson;

public class PageTableList : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = context.Request["action"].ToString();
        switch (action)
        {
            case "GetPageListJson":         //查询页面表格数据
                GetPageListJson(context);
                break;
            default:
                break;
        }
    }

    #region 查询页面表格数据
    /// <summary>
    /// 查询页面表格数据
    /// </summary>
    /// <param name="context"></param>
    private void GetPageListJson(HttpContext context)
    {
        string orders = context.Request["order"].ToString();
        string cid = context.Request["cid"].ToString();
        int offset = Convert.ToInt32(context.Request["offset"].ToString());
        int limit = Convert.ToInt32(context.Request["limit"].ToString());
        string strSql = "select id,title,class_id,iif(class_id=0,'首页',(select sort_name from news_class where id=class_id)) as sort_name,dateandtime,sortid,isindex from news where class_id=" + cid + " order by isindex desc, id " + orders; ;
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