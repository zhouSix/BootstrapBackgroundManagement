<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ControlPanel.aspx.cs" Inherits="System_ControlPanel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>控制台</title>
    <%--jquery的js引入--%>
    <%--<script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>--%>
    <%--font-awesome的css引入 字体样式和图标--%>
    <%--<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />--%>
    <%--bootstrap的js和css引入--%>
    <%--<link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />--%>
    <%--<script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>--%>
    <%-- holder的js引入  图片占位符插件--%>
    <%--<script src="js/holder.js" type="text/javascript"></script>--%>
</head>
<body>
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="Default2.aspx">首页</a></h3>
        </li>
        <li class="active">控制台</li>
    </ul>
    <hr style="padding: 0px; margin: 0px 0px 10px 0px;" />
    <div class="row" style="margin-left: 5px;">
        <div class="col-sm-12">
            <div class="alert alert-success alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="glyphicon glyphicon-ok"></i>欢迎使用 <strong>亿普格后台管理系统 。 </strong>
            </div>
            <table class="table table-striped table-bordered">
                <caption>
                    <h4>
                        <i class="glyphicon glyphicon-cog"></i>服务器信息</h4>
                </caption>
                <thead>
                    <tr>
                        <th class="col-sm-6">
                            名称
                        </th>
                        <th class="col-sm-6">
                            信息
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            服务器名称：
                        </td>
                        <td>
                            <b id="serName" class="green">&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            服务器IP：
                        </td>
                        <td>
                            <b id="serIp" class="green">&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            NET框架版本：
                        </td>
                        <td>
                            <b id="serFrame" class="green">&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            操作系统：
                        </td>
                        <td>
                            <b id="serSystem" class="green">&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            IIS环境：
                        </td>
                        <td>
                            <b id="serEnvir" class="green">&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            服务器端口：
                        </td>
                        <td>
                            <b id="serPort" class="green">&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            虚拟目录绝对路径：
                        </td>
                        <td>
                            <b id="serPath" class="green">&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            HTTPS支持：
                        </td>
                        <td>
                            <b id="serHttp" class="green">&nbsp;</b>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            seesion总数：
                        </td>
                        <td>
                            <b id="serSessionCount" class="green">&nbsp;</b>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <script src="js/newalert.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //服务器信息
            var model = new Object();
            model.action = "serviceInfo";
            var serInfo = JSON.stringify(model);
            //加载首页服务器信息
            $.ajax({
                type: "post",
                url: "Ashx/Default.ashx",
                data: { "data": serInfo },
                dataType: "json",
                success: function (data) {
                    if (data.serName != "") {
                        $("#serName").html(data.SerName);
                        $("#serIp").html(data.SerIp);
                        $("#serFrame").html(data.SerFrame);
                        $("#serSystem").html(data.SerSystem);
                        $("#serEnvir").html(data.SerEnvir);
                        $("#serPort").html(data.SerPort);
                        $("#serPath").html(data.SerPath);
                        $("#serHttp").html(data.SerHttp);
                        $("#serSessionCount").html(data.SerSessionCount);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("加载失败", "网络超时，请重试！", "error");
                    //                    alert(XMLHttpRequest.status);
                    //                    alert(XMLHttpRequest.readyState);
                    //                    alert(textStatus);
                }
            });
        });
    </script>
</body>
</html>
