<%@ Page Title="" Language="C#" MasterPageFile="~/System/MasterPage.master" AutoEventWireup="true"
    CodeFile="SysManage_List1.aspx.cs" Inherits="System_SysManage_List1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%-- fileinput的js引入  上传文件或图片插件--%>
    <link href="bootstrap-fileinput-master/css/fileinput.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap-fileinput-master/themes/explorer-fas/theme.min.css" rel="stylesheet"
        type="text/css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
        crossorigin="anonymous">
    <script src="bootstrap-fileinput-master/js/fileinput.min.js" type="text/javascript"></script>
    <script src="bootstrap-fileinput-master/themes/fas/theme.min.js" type="text/javascript"></script>
    <script src="bootstrap-fileinput-master/themes/explorer-fas/theme.min.js" type="text/javascript"></script>
    <script src="bootstrap-fileinput-master/js/locales/zh.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('.summernote').summernote({
                height: 150,
                tabsize: 1,
                lang: 'zh-CN'
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;" id="hd_title">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default1.aspx">
                    首页</a></h3>
        </li>
        <%--<li><b>系统管理</b></li>
        <li><b>首页页面设置</b> </li>
        <li class="active">首页设置列表信息</li>--%>
    </ul>
    <div class="row" style="margin-left: 5px;">
        <div class="col-sm-12">
            <div class="alert alert-warning alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="glyphicon glyphicon-warning-sign"></i>设置提示（注意：！）
            </div>
            <div class="col-md-3" style="font-size: 16; line-height: 36px;">
                <div class="col-md-3">
                    请选择：</div>
                <div class="col-md-9">
                    <div class="dropdown">
                        <button type="button" class="btn btn-default dropdown-toggle" id="dropdownMenu1"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="width: 150px;">
                            <span id="dropdownMenu2">请选择类别</span> <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="drp_menu_list">
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-3" style="font-size: 16; line-height: 36px;">
                <div class="col-md-3">
                    关键字：</div>
                <div class="col-md-9">
                    <div class="input-group">
                        <input type="text" class="form-control">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button">
                                查询
                            </button>
                        </span>
                    </div>
                </div>
            </div>
            <div class="col-md-12" style="background-color: #dedef8; box-shadow: inset 1px -1px 1px #ddd, inset -1px 1px 1px #ddd;
                font-size: 16; line-height: 45px; margin-top: 10px;" id="dv_table_title">
                列表
            </div>
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" onclick="Add_Info()">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
                <button id="btn_edit" type="button" class="btn btn-default" onclick="Update_Info()">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                </button>
                <button id="btn_delete" type="button" class="btn btn-default" onclick="Delete_Info()">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                </button>
            </div>
            <table id="table" class="table table-bordered">
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var parentId = "";
        //页面加载时获取url传进来的参数，绑定类别下拉菜单，绑定表格数据
        $(function () {
            parentId = getQueryString("Cid");
            BindDrpListMenuHtml(parentId);
            initTable();
        });

        //绑定页面类别下拉菜单
        function BindDrpListMenuHtml(parentId) {
            //获取要传递的参数
            var model = new Object();
            model.action = "searchDrpMenuListHtml";
            model.cid = parentId;
            //将信息转换成json数据
            var dataInfo = JSON.stringify(model);

            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": dataInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        $("#drp_menu_list").html(data.ErrorMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                }
            });
        }

        //获取url中传递的参数
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]);
            return null;
        } 
    </script>
</asp:Content>
