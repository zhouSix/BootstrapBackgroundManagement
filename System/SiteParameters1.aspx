<%@ Page Title="" Language="C#" MasterPageFile="~/System/MasterPage.master" AutoEventWireup="true"
    CodeFile="SiteParameters1.aspx.cs" Inherits="System_SiteParameters1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            $('.summernote').summernote({
                height: 300,
                tabsize: 1,
                lang: 'zh-CN'
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default2.aspx">
                    首页</a></h3>
        </li>
        <li><b>系统管理</b> </li>
        <li class="active">网站参数</li>
    </ul>
    <hr style="padding: 0px; margin: 0px 0px 10px 0px;" />
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
                    <button type="button" class="btn btn-primary" onclick="SaveWebInfo()">
                        确认保存</button>
                </div>
            </div>
            </form>
        </div>
    </div>
    <script src="../js/newalert.js" type="text/javascript"></script>
    <script type="text/javascript">
        //页面加载时，加载页面数据
        jQuery(function ($) {
            loadSiteParamInfo();
        });

        //获取页面数据并进行展示
        function loadSiteParamInfo() {
            var model = new Object();
            //网站参数信息
            model.action = "loadSiteParamInfo";
            //将网站参数信息转换成json数据
            var siteParam = JSON.stringify(model);
            //加载网站参数信息
            $.ajax({
                type: "post",
                //                async: false,
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": siteParam },
                dataType: "json",
                success: function (data) {
                    if (data.WebName != "") {
                        $("#txtTitle").val(data.WebName);
                        $("#txtKey").val(data.WebKey);
                        $("#txtDescript").val(data.WebDescribe);
                        $('#txtRightInfo').summernote('code', data.WebCopyRight);
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

        //
        function SaveWebInfo() {
            var obj = new Object();
            obj.action = "saveSiteParamInfo";
            obj.WebName = $("#txtTitle").val();
            obj.WebKey = $("#txtKey").val();
            obj.WebDescribe = $("#txtDescript").val();
            obj.WebCopyRight = $('#txtRightInfo').summernote('code');

            //将网站参数信息转换成json数据
            var webObj = JSON.stringify(obj);
            //提交网站参数，进行保存
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": webObj },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("操作成功", "保存成功!", "success");
                    } else {
                        alertDialog(data.ErrorMsg, "error");
                        pageAlert("操作失败", data.ErrorMsg, "error");
                    }
                    //重新加载数据
                    loadSiteParamInfo();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //重新加载数据
                    loadSiteParamInfo();
                    //                    alert(XMLHttpRequest.status);
                    //                    alert(XMLHttpRequest.readyState);
                    //                    alert(textStatus);
                }
            });

        }
    </script>
</asp:Content>
