using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class System_MasterPage : System.Web.UI.MasterPage, System.Web.SessionState.IRequiresSessionState
{
    public string userName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["AdminGB"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            if (Request.Cookies["AdminGB"]["username"] != null && Request.Cookies["AdminGB"]["username"].ToString() != "")
            {
                ;
                userName = Request.Cookies["AdminGB"]["username"].ToString();
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}
