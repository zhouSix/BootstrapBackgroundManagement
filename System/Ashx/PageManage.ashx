<%@ WebHandler Language="C#" Class="PageManage" %>

using System;
using System.Web;
using LitJson;
using System.Data;
using System.Text;

public class PageManage : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
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
        }
    }

    /// <summary>
    /// 查询页面下拉框内容
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    private void SearchDropMenuList(HttpContext context, JsonData jsonData) 
    {
        //获取查询列表的父级id
        string cid = jsonData["cid"].ToString();
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}