<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sys_Channel_Add.aspx.cs"
    Inherits="System_SysManage_Sys_Channel_Add" %>

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
        <h4 class="modal-title" id="mdlTitle">
            新增同级频道
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
                        <label id="lblPIdName"></label>
                        <input type="hidden" id="hidbid" name="hidbid" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                        优先级别：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtlvlOrders" placeholder="100(必须是数字)" />
                    </td>
                </tr>
                <tr>
                    <td>
                        类别名称：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtlvlSortName" placeholder="名称(必填)" />
                    </td>
                </tr>
                <tr>
                    <td>
                        页面标题：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtlvlPageTitle" placeholder="页面标题" />
                    </td>
                </tr>
                <tr>
                    <td>
                        页面关健字：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtlvlPageKey" placeholder="页面关健字" />
                    </td>
                </tr>
                <tr>
                    <td>
                        页面描述：
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txtlvlPageDesc" placeholder="页面描述" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">
            关闭
        </button>
        <button type="button" name="btnlvlSave" class="btn btn-primary" onclick="AddCategory()">
            添加分类
        </button>
    </div>
</body>
</html>
