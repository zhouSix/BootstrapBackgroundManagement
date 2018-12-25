using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
namespace GB{
    public class BindDLL
    {
        public BindDLL()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        public static void BindCateGoryList(DropDownList ddl, string sql)
        {

            //DataSet ds = new DataSet();
            //ds = GB.SqlHelper.ExecuteDataSet(sql);
            DataTable dt = new DataTable();
            dt = GB.AccessbHelper.ExecuteDataSet(sql).Tables[0];
            CreateLevelDropDown(ddl, dt);
        }
        public static void BindCateGoryList(DropDownList ddl, string sql, int big_id)
        {

            //DataSet ds = new DataSet();
            //ds = GB.SqlHelper.ExecuteDataSet(sql);
            DataTable dt = new DataTable();
            dt = GB.AccessbHelper.ExecuteDataSet(sql).Tables[0];
            CreateLevelDropDown(ddl, dt, big_id);
        }

        private static void CreateLevelDropDown(DropDownList ddlst, DataTable dt)
        {
            ArrayList allItems = new ArrayList();
            DataRow[] rows = dt.Select("[big_id]=" + 0);
            foreach (DataRow row in rows)
                CreateLevelDropDownAssistant(dt, ref   allItems, row, string.Empty);

            ListItem[] items = new ListItem[allItems.Count];
            allItems.CopyTo(items);
            ddlst.Items.AddRange(items);
        }
        private static void CreateLevelDropDown(DropDownList ddlst, DataTable dt,int big_id)
        {
            ArrayList allItems = new ArrayList();
            DataRow[] rows = dt.Select("[big_id]=" + big_id);
            if (rows.Length > 1)
            {
                foreach (DataRow row in rows)
                    CreateLevelDropDownAssistant(dt, ref   allItems, row, string.Empty);
            }
            else
            {
                DataRow[] rows2 = dt.Select("[id]=" + big_id);
                foreach (DataRow row in rows2)
                    CreateLevelDropDownAssistant(dt, ref   allItems, row, string.Empty);
            }
            

            ListItem[] items = new ListItem[allItems.Count];
            allItems.CopyTo(items);
            ddlst.Items.AddRange(items);
        }
        private static void CreateLevelDropDownAssistant(DataTable dt, ref   ArrayList items, DataRow parentRow, string curHeader)
        {
            ListItem newItem = new ListItem(curHeader + parentRow["sort_name"].ToString(), parentRow["id"].ToString());
            items.Add(newItem);
            parentRow.Delete();

            DataRow[] rows = dt.Select("[big_id]='" + newItem.Value + "'");
            for (int i = 0; i < rows.Length - 1; i++)
                CreateLevelDropDownAssistant(dt, ref   items, rows[i], curHeader.Replace("┣", "┃").Replace("┗", "┣") + "┣");

            if (rows.Length > 0)
                CreateLevelDropDownAssistant(dt, ref   items, rows[rows.Length - 1], curHeader.Replace("┣", "┃").Replace("┗", "┣") + "┗");
        } 

    }

}
/// <summary>
/// BindDLL 的摘要说明
/// </summary>

