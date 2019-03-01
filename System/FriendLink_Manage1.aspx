<%@ Page Title="" Language="C#" MasterPageFile="~/System/MasterPage.master" AutoEventWireup="true"
    CodeFile="FriendLink_Manage1.aspx.cs" Inherits="System_FriendLink_Manage1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default1.aspx">
                    首页</a>
            </h3>
        </li>
        <li><b>友情连接</b></li>
        <li class="active">友情连接列表信息</li>
    </ul>
    <div class="row" style="margin-left: 5px;">
        <div class="col-sm-12">
            <div class="alert alert-warning alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="glyphicon glyphicon-warning-sign"></i>友情连接提示（注意：！）
            </div>
            <div class="col-md-3" style="font-size: 16; line-height: 36px;">
                <div class="col-md-4">
                    链接标题：</div>
                <div class="col-md-8">
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
                友情链接列表
            </div>
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" data-target="#myAddFriendLinkInfo">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
                <button id="btn_edit" type="button" class="btn btn-default" onclick="Update_Link()">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                </button>
                <button id="btn_delete" type="button" class="btn btn-default" onclick="Delete_Link()">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
                </button>
            </div>
            <table id="table" class="table table-bordered">
            </table>
        </div>
    </div>
    <!-- 模态框（Modal）- 新增信息(myFriendLinkInfo) -->
    <div class="modal fade" id="myAddFriendLinkInfo" tabindex="-1" role="dialog" aria-labelledby="myAddFriendLinkInfo"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        新增链接
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td style="width: 180px;">
                                    链接标题：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtTitle" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    链接地址：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtLink" style="width: 400px;" placeholder="http://" />
                                    </div>
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
                    <button type="button" class="btn btn-primary" onclick="AddFriendLink()">
                        添加
                    </button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        //绑定表格数据
        $(function () {
            initTable();
        });

        //友情链接表格
        function initTable() {
            $('#table').bootstrapTable({
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemFriendLink.ashx?action=GetFriendLinkList",
                //请求方法
                method: 'get',
                toolbar: '#toolbar',                //工具按钮用哪个容器
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
                sidePagination: "server",
                //是否显示搜索
                search: false,      //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大  
                strictSearch: true, //Indicate which field is an identity field.
                showColumns: true,                  //是否显示所有的列
                showRefresh: true,                  //是否显示刷新按钮
                minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                showToggle: true,                    //是否显示详细视图和列表视图的切换按钮
                cardView: false,                    //是否显示详细视图
                detailView: false,                   //是否显示父子表
                idField: "id",
                columns: [{
                    checkbox: true
                }, {
                    field: 'id',
                    title: '编号',
                    align: 'center'
                }, {
                    field: 'title',
                    title: '链接标题',
                    align: 'center'
                }
                , {
                    field: 'infofrom',
                    title: '链接地址',
                    align: 'center'
                }, {
                    field: 'id',
                    title: '编辑',
                    align: 'center',
                    formatter: function (value, row, index) {
                        //通过formatter可以自定义列显示的内容
                        //value：当前field的值，即id
                        //row：当前行的数据
                        var a = '<a href="javescript:void(0);"  data-toggle="modal" data-target="#myUpdateIndexInfo" data-id="' + value + '" data-catename="' + row["title"] + '" ><span class="glyphicon glyphicon-pencil"></span>编辑</a>';
                        return a;
                    }
                }, {
                    field: 'id',
                    title: '删除',
                    align: 'center',
                    formatter: function (value, row, index) {
                        var a = '<a href="javescript:void(0);" data-toggle="modal" data-target="#myDeleteIndexInfo" data-id="' + value + '" data-catename="' + row["title"] + '" ><span class="glyphicon glyphicon-remove"></span>删除</a>';
                        return a;
                    }
                }],
                pagination: true
            });
        }

        //新增友情链接,弹窗前隐藏错误提示
        $('#myAddFriendLinkInfo').on('show.bs.modal', function (event) {
            $("#prompt").hide();
        });

        //新增友情链接，关闭对话框之前移除数据
        $('#myAddFriendLinkInfo').on('show.bs.modal', function (event) {
            $("#txtTitle").val("");
            $("#txtLink").val("");
        });

        //错误提示
        function PromptText(text) {
            var $b = $('#prompt').find('button');
            $('#prompt').html($b);
            $b.after(text);
        }

        //新增信息
        function AddFriendLink() {
            //必填文本判断
            if ($("#txtTitle").val() == "") {
                $("#txtTitle").parent(".input-group").addClass("has-error");
                $("#prompt").show();
                PromptText("链接标题不能为空！");
                return;
            } else {
                $("#txtTitle").parent(".input-group").removeClass("has-error");
                $("#prompt").hide();
            }
            if ($("#txtLink").val() == "") {
                $("#txtLink").parent(".input-group").addClass("has-error");
                $("#prompt").show();
                PromptText("链接地址不能为空！");
                return;
            } else {
                $("#txtLink").parent(".input-group").removeClass("has-error");
                $("#prompt").hide();
            }
            //新增类对象，添加内容
            var model = new Object();
            model.action = "addFriendLink";
            model.title = $("#txtTitle").val();
            model.link = $("#txtLink").val();
            //将链接信息转换成json数据
            var dataInfo = JSON.stringify(model);
            //提交链接信息，进行保存
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/FriendLinkManage.ashx",
                data: { "data": dataInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("添加成功", "保存成功!", "success");
                    } else {
                        pageAlert("添加失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myAddFriendLinkInfo').modal('hide');
                    //刷新数据
                    refreshTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("添加失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myAddFriendLinkInfo').modal('hide');
                    //刷新数据
                    refreshTable();
                }
            });
        }

        //刷新事件
        function refreshTable() {
            $('#table').bootstrapTable('refresh');
        }
    </script>
</asp:Content>
