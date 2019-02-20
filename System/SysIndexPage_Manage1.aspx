<%@ Page Title="" Language="C#" MasterPageFile="~/System/MasterPage.master" AutoEventWireup="true"
    CodeFile="SysIndexPage_Manage1.aspx.cs" Inherits="System_SysIndexPage_Manage1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default1.aspx">
                    首页</a></h3>
        </li>
        <li><b>首页页面设置</b> </li>
        <li class="active">首页设置列表信息</li>
    </ul>
    <%--<hr style="padding: 0px; margin: 0px 0px 10px 0px;" />--%>
    <div class="row" style="margin-left: 5px;">
        <div class="col-sm-12">
            <div class="alert alert-warning alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="glyphicon glyphicon-warning-sign"></i>首页设置提示（注意：！）
            </div>
            <div class="col-md-3" style="font-size: 16; line-height: 36px;">
                <div class="col-md-3">
                    请选择：</div>
                <div class="col-md-9">
                    <div class="dropdown">
                        <button type="button" class="btn btn-default dropdown-toggle" id="dropdownMenu1"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="width:150px;">
                            <span id="dropdownMenu2">请选择类别</span> <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                            <li><a onclick="shows1($(this).text())" href="#">Java</a> </li>
                            <li><a onclick="shows1($(this).text())" href="#">数据挖掘</a> </li>
                            <li><a onclick="shows1($(this).text())" href="#">数据通信/网络</a> </li>
                            <li><a onclick="shows1($(this).text())" href="#">分离的链接</a> </li>
                        </ul>
                    </div>
                    <%-- <select class="form-control">
                        <option>请选择类别</option>
                        <option>1</option>
                        <option>2</option>
                        <option>3</option>
                        <option>4</option>
                    </select>--%>
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
                font-size: 16; line-height: 45px; margin-top: 10px;">
                首页设置列表
                <button type="button" class="btn btn-default" style="margin-left: 60px" data-toggle="modal"
                    data-target="#myAddUser">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加信息
                </button>
            </div>
            <table id="table" class="table table-bordered">
            </table>
        </div>
    </div>
    <script type="text/javascript">
        function shows1(a) {
            $('#dropdownMenu2').text(a)
        }
    </script>
</asp:Content>
