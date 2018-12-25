using System;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;
using System.Web;
using System.Web.Security;

namespace GB
{
    /// <summary>
    /// ���ü�����
    /// </summary>
    public class Encrypt
    {
        #region Kdc

        private static string KEY_64 = "JasmineT";
        private static string IV_64 = "JasmineT";

        #region Encode

        /// <summary>
        /// Kdc����
        /// </summary>
        /// <param name="data">����ǰ�ַ�</param>
        /// <returns>���ܺ��ַ�</returns>
        public static string Encode(string data)
        {
            byte[] byKey = System.Text.ASCIIEncoding.ASCII.GetBytes(KEY_64);
            byte[] byIV = System.Text.ASCIIEncoding.ASCII.GetBytes(IV_64);

            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            int i = cryptoProvider.KeySize;
            MemoryStream ms = new MemoryStream();
            CryptoStream cst = new CryptoStream(ms, cryptoProvider.CreateEncryptor(byKey, byIV), CryptoStreamMode.Write);

            StreamWriter sw = new StreamWriter(cst);
            sw.Write(data);
            sw.Flush();
            cst.FlushFinalBlock();
            sw.Flush();
            return Convert.ToBase64String(ms.GetBuffer(), 0, (int)ms.Length);
        }
        #endregion Encode

        #region Decode

        /// <summary>
        /// Kdc����
        /// </summary>
        /// <param name="data">����ǰ�ַ�</param>
        /// <returns>���ܺ��ַ�</returns>
        public static string Decode(string data)
        {
            byte[] byKey = System.Text.ASCIIEncoding.ASCII.GetBytes(KEY_64);
            byte[] byIV = System.Text.ASCIIEncoding.ASCII.GetBytes(IV_64);

            byte[] byEnc;
            try
            {
                byEnc = Convert.FromBase64String(data);
            }
            catch
            {
                return null;
            }

            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            MemoryStream ms = new MemoryStream(byEnc);
            CryptoStream cst = new CryptoStream(ms, cryptoProvider.CreateDecryptor(byKey, byIV), CryptoStreamMode.Read);
            StreamReader sr = new StreamReader(cst);
            return sr.ReadToEnd();
        }
        #endregion Decode

        #endregion Kdc

        #region Sha1

        /// <summary>
        /// Sha1����
        /// </summary>
        /// <param name="strText">����ǰ�ַ�</param>
        /// <returns>���ܺ��ַ�</returns>
        public static string Sha1(string strText)
        {
            return FormsAuthentication.HashPasswordForStoringInConfigFile(strText.Trim(), "sha1");
        }
        #endregion Sha1

        #region Md5

        /// <summary>
        /// Md5����
        /// </summary>
        /// <param name="strText">����ǰ�ַ�</param>
        /// <returns>���ܺ��ַ�</returns>
        public static string Md5(string strText)
        {
            return FormsAuthentication.HashPasswordForStoringInConfigFile(strText.Trim(), "md5");
        }

        public static string Md5(string strText, bool Is16)
        {
            return FormsAuthentication.HashPasswordForStoringInConfigFile(strText.Trim(), "md5").Substring(8, 16);
        }
        #endregion Md5
        public static string jiami(string strText)
        {
            return Md5(Sha1(strText));
        }
    }
}
