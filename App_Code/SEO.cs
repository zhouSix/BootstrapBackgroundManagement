using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
namespace GB
{
    /// <summary>
    /// SEO 的摘要说明
    /// </summary>
    public class SEO
    {
        public SEO()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
        public void SEO_HEAD(string title, string keyword, string description, Page page)
        {
            page.Title = title;
            HtmlMeta metaKeyWords = new HtmlMeta();
            HtmlMeta metaDescription = new HtmlMeta();
            metaKeyWords.Name = "Keywords";
            metaKeyWords.Content = keyword;
            metaDescription.Name = "description";
            metaDescription.Content = description;

            page.Header.Controls.Add(metaKeyWords);
            page.Header.Controls.Add(metaDescription);
        }
    }
}
