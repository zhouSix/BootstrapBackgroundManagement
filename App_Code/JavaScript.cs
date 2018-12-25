using System;
using System.Collections.Generic;
using System.Text;

namespace GB
{
    /// <summary>
    /// ���õ�JavaScript�����װ
    /// </summary>
    public class JavaScript
    {
        #region GetJavaScript

        /// <summary>
        /// ������ʾ��
        /// </summary>
        /// <param name="text">��ʾ����</param>
        /// <returns></returns>
        public static void GetJavaScript(string text)
        {
            System.Web.HttpContext.Current.Response.Write("<script>alert('" + text + "');" + "</" + "script>");
        }

        /// <summary>
        /// ������ʾ��ת����ҳ
        /// </summary>
        /// <param name="text">��ʾ����</param>
        /// <param name="page">��ҳ</param>
        /// <returns></returns>
        public static void GetJavaScript(string text, string page)
        {
            System.Web.HttpContext.Current.Response.Write("<script>alert('" + text + "');location.href='" + page + "';" + "</" + "script>");
        }
        #endregion GetJavaScript

        #region GetJavaScriptBack

        /// <summary>
        /// ������ʼҳ
        /// </summary>
        /// <returns></returns>
        public static void GetJavaScriptBack()
        {
            System.Web.HttpContext.Current.Response.Write("<script>history.go(-1);" + "</" + "script>");
        }
        #endregion GetJavaScriptBack

        #region GetJavaScriptMainBack

        /// <summary>
        /// ��ת����ҳ
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
        /// ���´��ڴ�ҳ��
        /// </summary>
        /// <param name="page">ҳ��</param>
        /// <param name="pageName">��������</param>
        /// <returns></returns>
        public static void GetJavaScriptOpenNewWin(string page, string pageName)
        {
            System.Web.HttpContext.Current.Response.Write("<script>window.open('" + page + "', '" + pageName + "');" + "</" + "script>");
        }
        #endregion GetJavaScriptOpenNewWin

        #region GetJavaScriptTextAndClose

        /// <summary>
        /// ������ʾ�򲢹رմ���
        /// </summary>
        /// <param name="text">��ʾ����</param>
        /// <returns></returns>
        public static void GetJavaScriptTextAndClose(string text)
        {
            System.Web.HttpContext.Current.Response.Write("<script>alert('" + text + "');window.close();" + "</" + "script>");
        }
        #endregion GetJavaScriptTextAndClose

        #region GetJavaScriptClose

        /// <summary>
        /// �رմ���
        /// </summary>
        /// <returns></returns>
        public static void GetJavaScriptClose()
        {
            System.Web.HttpContext.Current.Response.Write("<script>window.close();" + "</" + "script>");
        }
        #endregion GetJavaScriptClose
    }
}
