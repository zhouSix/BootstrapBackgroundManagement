using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace GB
{
    /// <summary>
    /// 字符串操作类
    /// </summary>
   public class StringClass
    {
        #region 截取字符串

        /// <summary>
        /// 截取字符串
        /// </summary>
        /// <param name="inputstr">输入的字符串</param>
        /// <param name="length">长度</param>
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
        #endregion 截取字符串
        #region 截取带HTML标记的字符串 
        /// <summary>
        /// 按字节长度截取字符串(支持截取带HTML代码样式的字符串) 
        /// </summary>
        /// <param name="param">将要截取的字符串参数</param>
        /// <param name="length">截取的字节长度</param>
        /// <param name="end">字符串末尾补上的字符串</param>
        /// <returns>返回截取后的字符串</returns>
        public string StringHTML(string param, int length, string end)
        {
            string Pattern = null;
            //param = GB.StringClass.cutHtmlString(param, param.Length);
            MatchCollection m = null;
            StringBuilder result = new StringBuilder();
            int n = 0;
            char temp;
            bool isCode = false; //是不是HTML代码
            bool isHTML = false; //是不是HTML特殊字符,如&nbsp;
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
                    //UNICODE码字符占两个字节
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
            //取出截取字符串中的HTML标记
            string temp_result = Regex.Replace(result.ToString(), "(>)[^<>]*(<?)", "$1$2", RegexOptions.IgnoreCase);
            //去掉不需要结素标记的HTML标记
            temp_result = Regex.Replace(temp_result, @"</?(area|base|basefont|body|br|col|colgroup|dd|dt|frame|head|hr|html|img|input|isindex|li|link|meta|option|p|param|tbody|td|tfoot|th|thead|tr)[^<>]*/?>"
                , "", RegexOptions.IgnoreCase);
            //去掉成对的HTML标记
            temp_result = Regex.Replace(temp_result, @"<([a-zA-Z]+)[^<>]*>(.*?)</\1>", "", RegexOptions.IgnoreCase);
            //用正则表达式取出标记
            Pattern = ("<([a-zA-Z]+)[^<>]*>");
            m = Regex.Matches(temp_result, Pattern);
            ArrayList endHTML = new ArrayList();
            foreach (Match mt in m)
                endHTML.Add(mt.Result("$1"));
            //补全不成对的HTML标记
            for (int i = endHTML.Count - 1; i >= 0; i--)
            {
                result.Append("</");
                result.Append(endHTML[i]);
                result.Append(">");
            }
            return result.ToString();
        }

























        #endregion 截取带HTML标记的字符串
        #region 把数据库中的长日期转为短日期

        /// <summary>
        /// 把数据库中的长日期转为短日期
        /// </summary>
        /// <param name="timestr">输入的时间字符串</param>
        public static string cutShortTime(string timestr)
        {
            DateTime dates = Convert.ToDateTime(timestr);

            return dates.ToString("yyyy-MM-dd");
        }
        #endregion 把数据库中的长日期转为短日期
        #region 关键字变色

        /// <summary>
        /// 关键字变色
        /// </summary>
        /// <param name="oText">源内容</param>
        /// <param name="oKeyWords">关键字</param>
        /// <returns>替换后的内容</returns>
        public static string ChangeText(object oText, object oKeyWords)
        {
            Regex reg = new Regex(oKeyWords.ToString());
            return reg.Replace(oText.ToString(), "<span style='color:#FF0000;'>" + oKeyWords.ToString() + "</span>");
        }
        #endregion 关键字变色
        #region 过滤危险的输入字符串
        /// <summary>
        /// 过滤危险的输入字符串
        /// </summary>
        /// <param name="input">输入的字符串</param>
        public static string ReplaceStr(String input)
        {
            StringBuilder sb = new StringBuilder(input);
            sb.Replace("<", "&lt;", 0, sb.Length);
            sb.Replace(">", "&gt;", 0, sb.Length);
            sb.Replace("\'", "\"", 0, sb.Length);
            sb.Replace("&", "&amp;", 0, sb.Length);
            return sb.ToString();
        }
        #endregion 过滤危险的输入字符串
        #region 检查字符合法性
        /// <summary>
        /// 检查字符合法性
        /// </summary>
        /// <param name="Input">被检查的字符串</param>
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
        #endregion 检查字符合法性
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
       #region 字符在字符串里出现的次数
       /// <summary>
        /// 字符在字符串里出现的次数
        /// </summary>
        /// <param name="c">字符</param>
        /// <param name="s">字符串</param>
        /// <returns>出现次数</returns>
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
       #endregion 字符在字符串里出现的次数
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
        /// 文件大小换算
        /// </summary>
        /// <param name="c">字符</param>
        /// <param name="s">字符串</param>
        /// <returns>出现次数</returns>
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
        #region 将对象变量转成字符串变量的方法
        /// <summary>
        /// 将对象变量转成字符串变量的方法
        /// </summary>
        /// <param name="obj">对象变量</param>
        /// <returns>字符串变量</returns>
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
       /// 删除html标记
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
                //删除脚本
                Htmlstring = Regex.Replace(Htmlstring, @"<script[^>]*?>.*?</script>", "", RegexOptions.IgnoreCase);
                //删除HTML
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

                //删除与数据库相关的词
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

                //特殊的字符
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
