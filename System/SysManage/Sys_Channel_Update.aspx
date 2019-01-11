<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sys_Channel_Update.aspx.cs" Inherits="System_SysManage_Sys_Channel_Update" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
            &times;
        </button>
        <h4 class="modal-title">
            修改频道
        </h4>
    </div>
    <div class="modal-body">
        <table class="table table-striped table-bordered">
            <tbody>
                <tr>
                    <td class="col-sm-3">
                        所属父类别：
                    </td>
                    <td class="col-sm-9">
                        <label id="lblupPIdName"></label>
                        <input type="hidden" id="hidupbid" name="hidupbid" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                        优先级别：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtuplvlOrders" placeholder="100(必须是数字)" />
                    </td>
                </tr>
                <tr>
                    <td>
                        类别名称：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtuplvlSortName" placeholder="名称(必填)" />
                        <input type="hidden" id="hiduplvlId" name="hiduplvlId" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                        页面标题：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtuplvlPageTitle" placeholder="页面标题" />
                    </td>
                </tr>
                <tr>
                    <td>
                        页面关健字：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtuplvlPageKey" placeholder="页面关健字" />
                    </td>
                </tr>
                <tr>
                    <td>
                        页面描述：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtuplvlPageDesc" placeholder="页面描述" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">
            关闭
        </button>
        <button type="button" class="btn btn-primary" onclick="UpdateCategory()">
            修改分类
        </button>
    </div>
</body>
</html>
