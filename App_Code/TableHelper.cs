using System;
using System.Collections.Generic;
using System.Web;
using System.Data;

/// <summary>
///TableHelper 的摘要说明
/// </summary>
public class TableHelper
{
	public TableHelper()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    /// <summary>
    /// DataTable分页处理
    /// </summary>
    /// <param name="dt">dt数据</param>
    /// <param name="PageIndex">表示第几页</param>
    /// <param name="PageSize">表示每页的记录数</param>
    /// <returns>DataTable</returns>
    public static DataTable GetPagedTable(DataTable dt, int PageIndex, int PageSize)
    {
        if (PageIndex == 0)
            return dt;//0页代表每页数据，直接返回

        DataTable newdt = dt.Copy();
        newdt.Clear();//copy dt的框架

        int rowbegin = PageIndex - 1;
        int rowend = PageIndex + PageSize;

        if (rowbegin >= dt.Rows.Count)
            return newdt;//源数据记录数小于等于要显示的记录，直接返回dt

        if (rowend > dt.Rows.Count)
            rowend = dt.Rows.Count;
        for (int i = rowbegin; i <= rowend - 1; i++)
        {
            DataRow newdr = newdt.NewRow();
            DataRow dr = dt.Rows[i];
            foreach (DataColumn column in dt.Columns)
            {
                newdr[column.ColumnName] = dr[column.ColumnName];
            }
            newdt.Rows.Add(newdr);
        }
        return newdt;
    }
}