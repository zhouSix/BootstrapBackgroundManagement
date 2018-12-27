<%@ WebHandler Language="C#" Class="Default" %>

using System;
using System.Web;
using System.Data.OleDb;
using LitJson;


public class Default : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/json";
        //获取页面传进来的json参数数据
        string model = context.Request.Params["data"];
        //将字符串转成json
        JsonData jsonData = JsonMapper.ToObject(model);
        string webAction = jsonData["action"].ToString();
        //判断使用的方法是否是登录
        switch (webAction) 
        {
            case "loginIn":
                GetLoginResult(context, jsonData);
                break;
            case "logout":
                Logout(context);
                break;
        }
    }

    #region 登录功能
    /// <summary>
    /// 登录功能
    /// </summary>
    /// <param name="context"></param>
    /// <param name="jsonData"></param>
    protected void GetLoginResult(HttpContext context, JsonData jsonData)
    {
        string result;
        //生产cookie
        HttpCookie MyCookie = new HttpCookie("AdminGB");
        DateTime now = DateTime.Now;

        Error err = new Error();
        string vCode = jsonData["validatecode"].ToString();
        string code = context.Session["Code"].ToString();
        //判断验证码和生成的验证码是否相同，不区分大小写
        if (!vCode.Equals(code, StringComparison.OrdinalIgnoreCase))
        {
            err.ErrorCode = "3";
            err.ErrorMsg = "验证码错误，请输入正确的验证码！";
            result = JsonMapper.ToJson(err);
            context.Response.Write(result);
            return;
        }
        string userName = jsonData["username"].ToString();
        string userPwd = jsonData["pwd"].ToString();
        //密码加密
        userPwd = GB.Encrypt.jiami(userPwd);
        string strSql = "select * from  ergyertye346 where swtfhuiesyt=@swtfhuiesyt and dfhrdtqw5= @dfhrdtqw5";
        OleDbParameter[] param = new OleDbParameter[2];
        param[0] = new OleDbParameter("@swtfhuiesyt", userName);
        param[1] = new OleDbParameter("@dfhrdtqw5", userPwd);
        //根据用户名和加密的密码获取用户信息
        System.Data.DataTable dt = GB.AccessbHelper.ExecuteDataTable(strSql, param);
        if (dt.Rows.Count < 1)
        {
            err.ErrorCode = "2";
            err.ErrorMsg = "账号或密码不正确，请重新输入！";
            result = JsonMapper.ToJson(err);
            context.Response.Write(result);
            return;
        }
        MyCookie.Values.Add("username", userName);
        MyCookie.Values.Add("IsAuthorized", "true");
        //设置cookie有效期为30分钟
        TimeSpan ts = new TimeSpan(0, 0, 30, 0);

        MyCookie.Expires = now.Add(ts);

        context.Response.AppendCookie(MyCookie);
        err.ErrorCode = "0";
        //生产json数据，输出
        result = JsonMapper.ToJson(err);
        context.Response.Write(result);
    } 
    #endregion


    #region 退出用户登陆
    /// <summary>
    /// 退出用户登陆
    /// </summary>
    /// <param name="context"></param>
    protected void Logout(HttpContext context)
    {
        Error err = new Error();
        HttpCookie cookie = null;
        if (context.Request.Cookies["AdminGB"] != null)
        {
            cookie = context.Request.Cookies["AdminGB"];
            cookie.Expires = DateTime.Now.AddDays(-1);
            context.Response.Cookies.Add(cookie);
        }
        err.ErrorCode = "0";
        string result = JsonMapper.ToJson(err);
        context.Response.Write(result);
    }
    #endregion
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}