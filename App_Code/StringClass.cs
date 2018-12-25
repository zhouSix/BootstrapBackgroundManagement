using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace GB
{
    /// <summary>
    /// �ַ���������
    /// </summary>
   public class StringClass
    {
        #region ��ȡ�ַ���

        /// <summary>
        /// ��ȡ�ַ���
        /// </summary>
        /// <param name="inputstr">������ַ���</param>
        /// <param name="length">����</param>
        public static string cutString(string inputstr, int length)
        {
            if (inputstr.Length < length)
            {
                return inputstr;
            }
            else
            {
                return inputstr.Substring(0, length) + "...";
            }
        }
		public static string cutString(string inputstr, int length, string end)
        {
            if (inputstr.Length < length)
            {
                return inputstr;
            }
            else
            {
                return inputstr.Substring(0, length) + end;
            }
        }
        #endregion ��ȡ�ַ���
        #region ��ȡ��HTML��ǵ��ַ��� 
        /// <summary>
        /// ���ֽڳ��Ƚ�ȡ�ַ���(֧�ֽ�ȡ��HTML������ʽ���ַ���) 
        /// </summary>
        /// <param name="param">��Ҫ��ȡ���ַ�������</param>
        /// <param name="length">��ȡ���ֽڳ���</param>
        /// <param name="end">�ַ���ĩβ���ϵ��ַ���</param>
        /// <returns>���ؽ�ȡ����ַ���</returns>
        public string StringHTML(string param, int length, string end)
        {
            string Pattern = null;
            //param = GB.StringClass.cutHtmlString(param, param.Length);
            MatchCollection m = null;
            StringBuilder result = new StringBuilder();
            int n = 0;
            char temp;
            bool isCode = false; //�ǲ���HTML����
            bool isHTML = false; //�ǲ���HTML�����ַ�,��&nbsp;
            char[] pchar = param.ToCharArray();
            for (int i = 0; i < pchar.Length; i++)
            {
                temp = pchar[i];
                if (temp == '<')
                {
                    isCode = true;
                }
                else if (temp == '&')
                {
                    isHTML = true;
                }
                else if (temp == '>' && isCode)
                {
                    n = n - 1;
                    isCode = false;
                }
                else if (temp == ';' && isHTML)
                {
                    isHTML = false;
                }
                if (!isCode && !isHTML)
                {
                    n = n + 1;
                    //UNICODE���ַ�ռ�����ֽ�
                    if (System.Text.Encoding.Default.GetBytes(temp + "").Length > 1)
                    {
                        n = n + 1;
                    }
                }
                result.Append(temp);
                if (n >= length)
                    break;
            }
            result.Append(end);
            //ȡ����ȡ�ַ����е�HTML���
            string temp_result = Regex.Replace(result.ToString(), "(>)[^<>]*(<?)", "$1$2", RegexOptions.IgnoreCase);
            //ȥ������Ҫ���ر�ǵ�HTML���
            temp_result = Regex.Replace(temp_result, @"</?(area|base|basefont|body|br|col|colgroup|dd|dt|frame|head|hr|html|img|input|isindex|li|link|meta|option|p|param|tbody|td|tfoot|th|thead|tr)[^<>]*/?>"
                , "", RegexOptions.IgnoreCase);
            //ȥ���ɶԵ�HTML���
            temp_result = Regex.Replace(temp_result, @"<([a-zA-Z]+)[^<>]*>(.*?)</\1>", "", RegexOptions.IgnoreCase);
            //��������ʽȡ�����
            Pattern = ("<([a-zA-Z]+)[^<>]*>");
            m = Regex.Matches(temp_result, Pattern);
            ArrayList endHTML = new ArrayList();
            foreach (Match mt in m)
                endHTML.Add(mt.Result("$1"));
            //��ȫ���ɶԵ�HTML���
            for (int i = endHTML.Count - 1; i >= 0; i--)
            {
                result.Append("</");
                result.Append(endHTML[i]);
                result.Append(">");
            }
            return result.ToString();
        }

























        #endregion ��ȡ��HTML��ǵ��ַ���
        #region �����ݿ��еĳ�����תΪ������

        /// <summary>
        /// �����ݿ��еĳ�����תΪ������
        /// </summary>
        /// <param name="timestr">�����ʱ���ַ���</param>
        public static string cutShortTime(string timestr)
        {
            DateTime dates = Convert.ToDateTime(timestr);

            return dates.ToString("yyyy-MM-dd");
        }
        #endregion �����ݿ��еĳ�����תΪ������
        #region �ؼ��ֱ�ɫ

        /// <summary>
        /// �ؼ��ֱ�ɫ
        /// </summary>
        /// <param name="oText">Դ����</param>
        /// <param name="oKeyWords">�ؼ���</param>
        /// <returns>�滻�������</returns>
        public static string ChangeText(object oText, object oKeyWords)
        {
            Regex reg = new Regex(oKeyWords.ToString());
            return reg.Replace(oText.ToString(), "<span style='color:#FF0000;'>" + oKeyWords.ToString() + "</span>");
        }
        #endregion �ؼ��ֱ�ɫ
        #region ����Σ�յ������ַ���
        /// <summary>
        /// ����Σ�յ������ַ���
        /// </summary>
        /// <param name="input">������ַ���</param>
        public static string ReplaceStr(String input)
        {
            StringBuilder sb = new StringBuilder(input);
            sb.Replace("<", "&lt;", 0, sb.Length);
            sb.Replace(">", "&gt;", 0, sb.Length);
            sb.Replace("\'", "\"", 0, sb.Length);
            sb.Replace("&", "&amp;", 0, sb.Length);
            return sb.ToString();
        }
        #endregion ����Σ�յ������ַ���
        #region ����ַ��Ϸ���
        /// <summary>
        /// ����ַ��Ϸ���
        /// </summary>
        /// <param name="Input">�������ַ���</param>
        /// <returns></returns>
        public static bool CheckInjection(string Input)
        {
            bool b = true;
            if (Input != null)
            {
                if (Input.IndexOfAny(new char[] { '%', '&', '*', '+', '<', '>', ';', '\"', '|', '?', '/', ',', '\'' }) >= 0)
                {
                    b = false;
                }
            }
            else
            {
                b = false;
            }
            return b;
        }
        public static bool validateString(string Input)
        {
            bool b = true;
            if (Input.IndexOfAny(new char[] { '%', '&', '*', '+', '<', '>', ';', '\"', '|', '?', '/', ',', '\'' }) >= 0)
            {
                b = false;
            }
            return b;
        }
        #endregion ����ַ��Ϸ���
        #region HtmlToTxt
       public static string HtmlToTxt(string strHtml)
       {
           string[] aryReg ={
            @"<script[^>]*?>.*?</script>",
            @"<(\/\s*)?!?((\w+:)?\w+)(\w+(\s*=?\s*(([""'])(\\[""'tbnr]|[^\7])*?\7|\w+)|.{0})|\s)*?(\/\s*)?>",
            @"([\r\n])[\s]+",
            @"&(quot|#34);",
            @"&(amp|#38);",
            @"&(lt|#60);",
            @"&(gt|#62);", 
            @"&(nbsp|#160);", 
            @"&(iexcl|#161);",
            @"&(cent|#162);",
            @"&(pound|#163);",
            @"&(copy|#169);",
            @"&#(\d+);",
            @"-->",
            @"<!--.*\n"
            };

           string newReg = aryReg[0];
           string strOutput = strHtml;
           for (int i = 0; i < aryReg.Length; i++)
           {
               Regex regex = new Regex(aryReg[i], RegexOptions.IgnoreCase);
               strOutput = regex.Replace(strOutput, string.Empty);
           }

           strOutput.Replace("<", "");
           strOutput.Replace(">", "");
           strOutput.Replace("\r\n", "");


           return strOutput;
       }
        #endregion HtmlToTxt
       #region �ַ����ַ�������ֵĴ���
       /// <summary>
        /// �ַ����ַ�������ֵĴ���
        /// </summary>
        /// <param name="c">�ַ�</param>
        /// <param name="s">�ַ���</param>
        /// <returns>���ִ���</returns>
        public static int NumberInString(char c, string s)
        {
            int count=0;
            for (int i = 0; i < s.Length; i++)
            {
                if (c.Equals(s[i]))
                {
                    count++;
                }
            }
            return count;
        }
       #endregion �ַ����ַ�������ֵĴ���
       public static string GetViaIP()
       {
           string viaIp = null;
           try
           {
               System.Web.HttpRequest request = System.Web.HttpContext.Current.Request;
               if (request.ServerVariables["HTTP_VIA"] != null)
               {
                   viaIp = request.UserHostAddress;
               }
           }
           catch (Exception e)
           {
               throw e;
           }
           return viaIp;
       }
        /// <summary>
        /// �ļ���С����
        /// </summary>
        /// <param name="c">�ַ�</param>
        /// <param name="s">�ַ���</param>
        /// <returns>���ִ���</returns>
        public static string getFileSize(long size)
        {
            string strsize;
            if (size / (1024 * 1024) > 1)
            {
                strsize = Convert.ToString(size / (1024 * 1024)) + "M";
            }
            else
            {
                if (size / 1024 > 1)
                {
                    strsize = Convert.ToString(size / 1024) + "K";
                }
                else
                {
                    strsize = size.ToString() + "B";
                }
            }
            return strsize;
        }
        #region ���������ת���ַ��������ķ���
        /// <summary>
        /// ���������ת���ַ��������ķ���
        /// </summary>
        /// <param name="obj">�������</param>
        /// <returns>�ַ�������</returns>
        public static string GetString(object obj)
        {
            return (obj == DBNull.Value || obj == null) ? System.DateTime.Now.ToString(): obj.ToString();
        }
        #endregion
        public static DateTime GetDateTime(object obj)
        {
            DateTime result;
            DateTime.TryParse(GetString(obj), out result);
            return result;
        }
       /// <summary>
       /// ɾ��html���
       /// </summary>
       /// <param name="Htmlstring"></param>
       /// <returns></returns>
        public static string NoHtml(string Htmlstring)
        {
            if (Htmlstring == null)
            {
                return "";
            }
            else
            {
                //ɾ���ű�
                Htmlstring = Regex.Replace(Htmlstring, @"<script[^>]*?>.*?</script>", "", RegexOptions.IgnoreCase);
                //ɾ��HTML
                Htmlstring = Regex.Replace(Htmlstring, @"<(.[^>]*)>", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"([\r\n])[\s]+", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"-->", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"<!--.*", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(quot|#34);", "\"", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(amp|#38);", "&", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(lt|#60);", "<", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(gt|#62);", ">", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(nbsp|#160);", " ", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(iexcl|#161);", "\xa1", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(cent|#162);", "\xa2", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(pound|#163);", "\xa3", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&(copy|#169);", "\xa9", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, @"&#(\d+);", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "xp_cmdshell", "", RegexOptions.IgnoreCase);

                //ɾ�������ݿ���صĴ�
                Htmlstring = Regex.Replace(Htmlstring, "select", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "insert", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "delete from", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "count''", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "drop table", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "truncate", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "asc", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "mid", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "char", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "xp_cmdshell", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "exec master", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "net localgroup administrators", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "and", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "net user", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "or", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "net", "", RegexOptions.IgnoreCase);
                //Htmlstring = Regex.Replace(Htmlstring, "*", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "-", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "delete", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "drop", "", RegexOptions.IgnoreCase);
                Htmlstring = Regex.Replace(Htmlstring, "script", "", RegexOptions.IgnoreCase);

                //������ַ�
                Htmlstring = Htmlstring.Replace("<", "");
                Htmlstring = Htmlstring.Replace(">", "");
                Htmlstring = Htmlstring.Replace("*", "");
                Htmlstring = Htmlstring.Replace("-", "");
                Htmlstring = Htmlstring.Replace("?", "");
                Htmlstring = Htmlstring.Replace("'", "''");
                Htmlstring = Htmlstring.Replace(",", "");
                Htmlstring = Htmlstring.Replace("/", "");
                Htmlstring = Htmlstring.Replace(";", "");
                Htmlstring = Htmlstring.Replace("*/", "");
                Htmlstring = Htmlstring.Replace("\r\n", "");
                Htmlstring = HttpContext.Current.Server.HtmlEncode(Htmlstring).Trim();

                return Htmlstring;
            }
        }
       
    }
}
