using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;

/// <summary>
///BasePage 的摘要说明
/// </summary>
public class BasePage : System.Web.UI.Page
{
    public BasePage()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    protected override void OnPreInit(EventArgs e)
    {
        base.OnPreInit(e);
        if (Request.Cookies["AdminGB"] == null)
        {
            Response.Redirect("/System/Login.aspx");
            Response.End();
        }
        else if (Request.Cookies["AdminGB"]["username"] == null && Request.Cookies["AdminGB"]["username"].ToString() == "") 
        {
            Response.Redirect("/System/Login.aspx");
            Response.End();
        }
    }

    public string userName
    {
        get { return Request.Cookies["AdminGB"]["username"].ToString(); }
    }

}