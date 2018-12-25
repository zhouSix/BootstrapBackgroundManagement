using System;
using System.Collections.Generic;
using System.Text;

namespace GB
{
    /// <summary>
    /// 常用的JavaScript代码封装
    /// </summary>
    public class JavaScript
    {
        #region GetJavaScript

        /// <summary>
        /// 弹出提示框
        /// </summary>
        /// <param name="text">提示文字</param>
        /// <returns></returns>
        public static void GetJavaScript(string text)
        {
            System.Web.HttpContext.Current.Response.Write("<script>alert('" + text + "');" + "</" + "script>");
        }

        /// <summary>
        /// 弹出提示框并转到新页
        /// </summary>
        /// <param name="text">提示问题</param>
        /// <param name="page">新页</param>
        /// <returns></returns>
        public static void GetJavaScript(string text, string page)
        {
            System.Web.HttpContext.Current.Response.Write("<script>alert('" + text + "');location.href='" + page + "';" + "</" + "script>");
        }
        #endregion GetJavaScript

        #region GetJavaScriptBack

        /// <summary>
        /// 返回起始页
        /// </summary>
        /// <returns></returns>
        public static void GetJavaScriptBack()
        {
            System.Web.HttpContext.Current.Response.Write("<script>history.go(-1);" + "</" + "script>");
        }
        #endregion GetJavaScriptBack

        #region GetJavaScriptMainBack

        /// <summary>
        /// 跳转到新页
        /// </summary>
        /// <param name="page"></param>
        /// <returns></returns>
        public static void GetJavaScriptMainBack(string page)
        {
            System.Web.HttpContext.Current.Response.Write("<script>location.href='" + page + "';" + "</" + "script>");
        }
        #endregion GetJavaScriptMainBack

        #region GetJavaScriptOpenNewWin

        /// <summary>
        /// 在新窗口打开页面
        /// </summary>
        /// <param name="page">页面</param>
        /// <param name="pageName">窗口名称</param>
        /// <returns></returns>
        public static void GetJavaScriptOpenNewWin(string page, string pageName)
        {
            System.Web.HttpContext.Current.Response.Write("<script>window.open('" + page + "', '" + pageName + "');" + "</" + "script>");
        }
        #endregion GetJavaScriptOpenNewWin

        #region GetJavaScriptTextAndClose

        /// <summary>
        /// 弹出提示框并关闭窗口
        /// </summary>
        /// <param name="text">提示文字</param>
        /// <returns></returns>
        public static void GetJavaScriptTextAndClose(string text)
        {
            System.Web.HttpContext.Current.Response.Write("<script>alert('" + text + "');window.close();" + "</" + "script>");
        }
        #endregion GetJavaScriptTextAndClose

        #region GetJavaScriptClose

        /// <summary>
        /// 关闭窗口
        /// </summary>
        /// <returns></returns>
        public static void GetJavaScriptClose()
        {
            System.Web.HttpContext.Current.Response.Write("<script>window.close();" + "</" + "script>");
        }
        #endregion GetJavaScriptClose
    }
}
