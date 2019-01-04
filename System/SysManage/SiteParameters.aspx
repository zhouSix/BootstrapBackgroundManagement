<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SiteParameters.aspx.cs" Inherits="System_SysManage_SiteParameters" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>网站参数</title>
    <script type="text/javascript">
        $(function () {
            $('.summernote').summernote({
                height: 300,
                tabsize: 1,
                lang: 'zh-CN'
            });
        });
    </script>
</head>
<body>
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default2.aspx">
                    首页</a></h3>
        </li>
        <li><b>系统管理</b> </li>
        <li class="active">网站参数</li>
    </ul>
    <div class="row" style="margin-left: 5px;">
        <div class="col-sm-12">
            <div class="alert alert-warning alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="glyphicon glyphicon-warning-sign"></i>系统基本设置（注意：如果你不是专业人员请勿改动，只有开放文件的读写权限才能修改）
            </div>
            <form class="form-horizontal" role="form" action="">
            <div class="form-group">
                <label class="col-sm-2 control-label">
                    网站标题：</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="txtTitle" placeholder="网站标题">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">
                    网站关键字：</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="txtKey" placeholder="网站关键字">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">
                    网站描述：</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="txtDescript" placeholder="网站描述">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">
                    系统版权信息：</label>
                <div class="col-sm-9">
                    <div class="summernote" id="txtRightInfo">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <button type="submit" class="btn btn-default">
                        确认保存</button>
                </div>
            </div>
            </form>
        </div>
    </div>
    <script src="../js/newalert.js" type="text/javascript"></script>
    <script type="text/javascript">
        jQuery(function ($) {

            //服务器信息
            var action = "LoadWebParamInfo";
            //加载首页服务器信息
            $.ajax({
                type: "post",
                url: "/newsbackManage/system/WebSystem/SystemManage.ashx",
                data: { "action": action },
                dataType: "json",
                success: function (data) {
                    if (data.WebName != "") {
                        $("#webTitle").val(data.WebName);
                        $("#webKeyword").val(data.WebKey);
                        $("#webDescribe").val(data.WebDescribe);
                        $("#editor1").html(data.WebCopyRight);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //                    alert(XMLHttpRequest.status);
                    //                    alert(XMLHttpRequest.readyState);
                    //                    alert(textStatus);
                }
            });

        });

        var action = "SaveWebParamInfo"
        function SaveWebInfo() {
            var obj = new Object();
            obj.action = action;
            obj.WebName = $("#webTitle").val();
            obj.WebKey = $("#webKeyword").val();
            obj.WebDescribe = $("#webDescribe").val();
            obj.WebCopyRight = $("#editor1").html();

            //将网站参数信息转换成json数据
            var webObj = JSON.stringify(obj);
            //提交网站参数，进行保存
            $.ajax({
                type: "post",
                url: "/newsbackManage/system/WebSystem/SystemManage.ashx",
                data: { "webInfo": webObj },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        alertDialog("修改成功!", "ok");
                    } else {
                        alertDialog(data.ErrorMsg, "error");
                        pageAlert("操作失败", data.ErrorMsg, "error");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //                    alert(XMLHttpRequest.status);
                    //                    alert(XMLHttpRequest.readyState);
                    //                    alert(textStatus);
                }
            });

        }
    </script>
</body>
</html>
