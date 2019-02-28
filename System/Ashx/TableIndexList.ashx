<%@ WebHandler Language="C#" Class="TableIndexList" %>

using System;
using System.Web;
using System.Data;
using LitJson;

public class TableIndexList : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
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

    #region 查询首页设置列表信息
    /// <summary>
    /// 查询首页设置列表信息
    /// </summary>
    /// <param name="context"></param>
    private void GetIndexListJson(HttpContext context)
    {
        string orders = context.Request["order"].ToString();
        string cid = context.Request["cid"].ToString();
        if (!cid.Equals("-1"))
        {
            int offset = Convert.ToInt32(context.Request["offset"].ToString());
            int limit = Convert.ToInt32(context.Request["limit"].ToString());
            string strSql = "select id,title,class_id,iif(class_id=0,'首页',(select sort_name from news_class where id=class_id)) as sort_name,dateandtime,sortid from news where class_id=" + cid + " order by id asc";
            DataTable dtZong = GB.AccessbHelper.ExecuteDataTable(strSql);
            DataTable dtPage = TableHelper.GetPagedTable(dtZong, offset + 1, limit);
            string resultJson = JsonHelper.GetJsonByPageDataTable(dtZong, dtPage, "total", "rows");
            context.Response.Write(resultJson);
        }
        else
        {
            string strSql = "select id,title,class_id,iif(class_id=0,'首页',(select sort_name from news_class where id=class_id)) as sort_name,dateandtime,sortid from news where class_id=-1 order by id asc";
            DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql);
            string resultJson = JsonHelper.GetJsonByDataTable(dt, "total", "rows");
            //对象转为json，返回页面
            context.Response.Write(resultJson);
        }
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