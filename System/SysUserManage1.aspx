<%@ Page Title="" Language="C#" MasterPageFile="~/System/MasterPage.master" AutoEventWireup="true"
    CodeFile="SysUserManage1.aspx.cs" Inherits="System_SysUserManage1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .modal-body table tr td
        {
            line-height: 35px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default1.aspx">
                    首页</a></h3>
        </li>
        <li><b>系统管理</b> </li>
        <li class="active">用户管理</li>
    </ul>
    <hr style="padding: 0px; margin: 0px 0px 10px 0px;" />
    <div class="row" style="margin-left: 5px;">
        <div class="col-sm-12">
            <div class="alert alert-warning alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="glyphicon glyphicon-warning-sign"></i>管理员操作提示（注意：请慎重添加或删除用户信息，设置的密钥要容易记忆！）
            </div>
            <div class="col-md-12" style="background-color: #dedef8; box-shadow: inset 1px -1px 1px #ddd, inset -1px 1px 1px #ddd;
                font-size: 16; line-height: 45px;">
                用户列表
                <button type="button" class="btn btn-default" style="margin-left: 60px" data-toggle="modal"
                    data-target="#myAddUser">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加用户
                </button>
            </div>
            <table id="table" class="table table-bordered">
            </table>
        </div>
    </div>
    <!-- 模态框（Modal）- 添加用户(myAddTopUser) -->
    <div class="modal fade" id="myAddUser" tabindex="-1" role="dialog" aria-labelledby="myAddUser"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        新增管理员
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td>
                                    用户名称：
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtUserName" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    密 码：
                                </td>
                                <td>
                                    <input type="password" class="form-control" id="txtPwd" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    确认密码：
                                </td>
                                <td>
                                    <input type="password" class="form-control" id="txtPwdConfirm" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div id="prompt" class="alert alert-danger alert-dismissable">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                            &times;
                        </button>
                        错误！请进行一些更改。
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        关闭
                    </button>
                    <button type="button" class="btn btn-primary" onclick="addUser()">
                        添加
                    </button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            initTable();
        });

        //初始化表格数据
        function initTable() {
            $('#table').bootstrapTable({
                url: "/BootstrapBackgroundManagement/System/Ashx/TableUserList.ashx?action=GetUserListJson",
                //请求方法
                method: 'get',
                //是否显示行间隔色
                striped: true,
                //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）     
                cache: false,
                //是否显示分页（*）  
                pagination: true,
                //是否启用排序  
                sortable: false,
                //排序方式 
                sortOrder: "asc",
                //初始化加载第一页，默认第一页
                //我设置了这一项，但是貌似没起作用，而且我这默认是0,- -
                pageNumber: 1,                       //初始化加载第一页，默认第一页
                //每页的记录行数（*）   
                pageSize: 10,
                //可供选择的每页的行数（*）    
                pageList: [10, 20, 30, 40, 50],
                //分页方式：client客户端分页，server服务端分页（*）
                sidePagination: "server",
                //是否显示搜索
                search: false,
                //Enable the strict search.    
                strictSearch: true,
                //Indicate which field is an identity field.
                idField: "id",
                columns: [{
                    field: 'id',
                    title: '编号',
                    align: 'center'
                }, {
                    field: 'swtfhuiesyt',
                    title: '用户名',
                    align: 'center'
                }, {
                    field: 'dateandtime',
                    title: '创建日期',
                    align: 'center',
                }, {
                    field: 'id',
                    title: '编辑',
                    align: 'center',
                    formatter: function (value, row, index) {
                        //通过formatter可以自定义列显示的内容
                        //value：当前field的值，即id
                        //row：当前行的数据
                        var a = '<a href="/BootstrapBackgroundManagement/System/SysManage/Sys_Channel_Update.aspx"  data-toggle="modal" data-target="#myUpdateSameLevelCnl" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-pencil"></span>编辑</a>';
                        return a;
                    }
                }, {
                    field: 'id',
                    title: '删除',
                    align: 'center',
                    formatter: function (value, row, index) {
                        //通过formatter可以自定义列显示的内容
                        //value：当前field的值，即id
                        //row：当前行的数据
                        var a = '<a href="javescript:void(0);" data-toggle="modal" data-target="#myDeleteCnl" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-remove"></span>删除</a>';
                        return a;
                    }
                }],
                pagination: true
            });
        }

        //新增用户，关闭对话框之前移除数据
        $("#myAddUser").on("hidden.bs.modal", function () {
            $("#txtUserName").val("");
            $("#txtPwd").val("");
            $("#txtPwdConfirm").val("");
        });
    </script>
</asp:Content>
