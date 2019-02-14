<%@ Page Title="" Language="C#" MasterPageFile="~/System/MasterPage.master" AutoEventWireup="true"
    CodeFile="SysChannelList1.aspx.cs" Inherits="System_SysChannelList1" %>

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
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default2.aspx">
                    首页</a></h3>
        </li>
        <li><b>系统管理</b> </li>
        <li class="active">频道管理</li>
    </ul>
    <hr style="padding: 0px; margin: 0px 0px 10px 0px;" />
    <div class="row" style="margin-left: 5px;">
        <div class="col-sm-12">
            <div class="alert alert-warning alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                    &times;
                </button>
                <i class="glyphicon glyphicon-warning-sign"></i>频道操作提示（注意：如果要删除分类请慎重考虑！因为删除分类的话，会删除此分类下的子类以及该分类和子类在页面中显示的全部内容！）
            </div>
            <div class="col-md-12" style="background-color: #dedef8; box-shadow: inset 1px -1px 1px #ddd, inset -1px 1px 1px #ddd;
                font-size: 16; line-height: 45px;">
                频道管理
                <button type="button" class="btn btn-default" style="margin-left: 60px" data-toggle="modal"
                    data-target="#myAddTopCnl" data-id="0" data-catename="顶级分类">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增顶级频道
                </button>
            </div>
            <table id="table" class="table table-bordered">
            </table>
        </div>
    </div>
    <!-- 模态框（Modal）- 新增顶级频道(myAddTopCnl) -->
    <div class="modal fade" id="myAddTopCnl" tabindex="-1" role="dialog" aria-labelledby="myAddTopCnl"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        新增顶级频道
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
                                    <label id="lblParentIdName">
                                    </label>
                                    <input type="hidden" id="hidbigid" name="hidbigid" value="" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    优先级别：
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtOrders" placeholder="100(必须是数字)" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    类别名称：
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtSortName" placeholder="名称(必填)" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    页面标题：
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtPageTitle" placeholder="页面标题" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    页面关健字：
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtPageKey" placeholder="页面关健字" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    页面描述：
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtPageDesc" placeholder="页面描述" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        关闭
                    </button>
                    <button type="button" class="btn btn-primary" onclick="addTopCnl()">
                        添加分类
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 模态框（Modal）- 新增同级频道/新增子频道(myAddSameLevelCnl) -->
    <div class="modal fade" id="myAddSameLevelCnl" tabindex="-1" role="dialog" aria-labelledby="myAddSameLevelCnl"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
        </div>
    </div>
    <!-- 模态框（Modal）- 修改(myUpdateSameLevelCnl) -->
    <div class="modal fade" id="myUpdateSameLevelCnl" tabindex="-1" role="dialog" aria-labelledby="myUpdateSameLevelCnl"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
        </div>
    </div>
    <!-- 模态框   信息删除确认-->
    <div class="modal fade" id="myDeleteCnl" tabindex="-1" role="dialog" aria-labelledby="myDeleteCnl"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title">
                        提示</h4>
                </div>
                <div class="modal-body">
                    <!-- 隐藏需要删除的id -->
                    <input type="hidden" id="deleteCnlId" name="deleteCnlId" value="" />
                    <p>
                        您确认要删除该条信息吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消</button>
                    <button type="button" class="btn btn-primary" id="deleteHaulBtn" onclick="DelCategory()">
                        确认</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- 模态框（Modal）- 管理子频道(myManageChildCnl) -->
    <%--<div class="modal fade" id="myManageChildCnl" tabindex="-1" role="dialog" aria-labelledby="myManageChildCnl"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
        </div>
    </div>--%>
    <!-- 模态框（Modal）- 管理子频道 - 新增同级频道(myManageChildCnl) -->
    <%--<div class="modal fade" id="myAddChildZSameCnl" style="z-index:1050;" role="dialog" aria-labelledby="myAddChildZSameCnl"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
        </div>
    </div>--%>
    <!--静态框   信息删除确认 end-->
    <script type="text/javascript">

        $(function () {
            initTable();
            SetModalsCenter("myAddTopCnl");
        });

        //判断字符串是否为数字
        function checkNum(value) {
            var reg = /^[0-9]+.?[0-9]*$/; //判断字符串是否为数字 ，判断正整数用/^[1-9]+[0-9]*]*$/
            if (!reg.test(value))
                return false;
            else
                return true;
        }

        //初始化表格数据
        function initTable() {
            $('#table').bootstrapTable({
                url: "/BootstrapBackgroundManagement/System/Ashx/TableChannelList.ashx?action=GetChannelListJson",
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
                //这个接口需要处理bootstrap table传递的固定参数,并返回特定格式的json数据  

                //默认值为 'limit',传给服务端的参数为：limit, offset, search, sort, order Else
                //queryParamsType:'',   
                ////查询参数,每次调用是会带上这个参数，可自定义                         
                //                queryParams: queryParams : function(params) {
                //                    var subcompany = $('#subcompany option:selected').val();
                //                    var name = $('#name').val();
                //                    return {
                //                          pageNumber: params.offset+1,
                //                          pageSize: params.limit,
                //                          companyId:subcompany,
                //                          name:name
                //                        };
                //                },
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
                    title: 'ID',
                    align: 'center'
                }, {
                    field: 'sort_name',
                    title: '分类名称',
                    align: 'center'
                }, {
                    field: 'big_id',
                    title: '新增同级频道',
                    align: 'center',
                    formatter: function (value, row, index) {
                        //通过formatter可以自定义列显示的内容
                        //value：当前field的值，即id
                        //row：当前行的数据
                        var a = '<a href="/BootstrapBackgroundManagement/System/SysManage/Sys_Channel_Add.aspx" data-toggle="modal" data-target="#myAddSameLevelCnl" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-plus"></span>新增同级频道</a>';
                        return a;
                    }
                }, {
                    field: 'id',
                    title: '管理子频道',
                    align: 'center',
                    formatter: function (value, row, index) {
                        //通过formatter可以自定义列显示的内容
                        //value：当前field的值，即id
                        //row：当前行的数据
                        //                        var a = '<a href="/BootstrapBackgroundManagement/System/SysManage/Sys_Child_Channel_Manage.aspx" data-toggle="modal" data-target="#myManageChildCnl" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-list"></span>管理子频道</a>';
                        //                        return a;
                        var a = '<a href="/BootstrapBackgroundManagement/System/SysManage/Sys_Child_Channel_Manage.aspx?Cid=' + value + '&cname=' + row["sort_name"] + '" ><span class="glyphicon glyphicon-list"></span>管理子频道</a>';
                        return a;
                    }
                }, {
                    field: 'id',
                    title: '新增子频道',
                    align: 'center',
                    formatter: function (value, row, index) {
                        //通过formatter可以自定义列显示的内容
                        //value：当前field的值，即id
                        //row：当前行的数据
                        var a = '<a href="/BootstrapBackgroundManagement/System/SysManage/Sys_Channel_Add.aspx" data-toggle="modal" data-target="#myAddSameLevelCnl" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-plus"></span>新增子频道</a>';
                        return a;
                    }
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

        //新增顶级频道(myAddTopCnl)
        function addTopCnl() {
            var model = new Object();
            var dfOrders = "100";
            if ($("#txtSortName").val() == "") {
                $("#txtSortName").parent("td").addClass("has-error");
                return;
            }
            if ($("#txtOrders").val() != "") {
                if (checkNum($("#txtOrders").val()))
                    dfOrders = $("#txtOrders").val();
                else {
                    $("#txtOrders").parent("td").addClass("has-error");
                    return;
                }
            }

            //获取页面数据
            model.action = "addTopCnl";
            model.orders = dfOrders;
            model.bigId = $("#hidbigid").val();
            model.sortName = $("#txtSortName").val();
            model.pageTitle = $("#txtPageTitle").val();
            model.pageKey = $("#txtPageKey").val();
            model.pageDesc = $("#txtPageDesc").val();

            //将信息转换成json数据
            var cnlInfo = JSON.stringify(model);
            //提交网站参数，进行保存
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": cnlInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("操作成功", "保存成功!", "success");
                    } else {
                        alertDialog(data.ErrorMsg, "error");
                        pageAlert("操作失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myAddTopCnl').modal('hide');
                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    refreshTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myAddTopCnl').modal('hide');
                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    refreshTable();
                    //                    alert(XMLHttpRequest.status);
                    //                    alert(XMLHttpRequest.readyState);
                    //                    alert(textStatus);
                }
            });
        }

        //新增顶级频道 设置id显示以及弹窗所属的父级类别
        $('#myAddTopCnl').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var bigId = button.data('id'); //获取要操作的ID
            if (bigId == 0) {
                $('#lblParentIdName').text("0顶级分类");
                $('#hidbigid').val(bigId);
            } else {
                //把要修改的分类名称显示出来
                $('#lblParentIdName').text(button.data('catename'));
                $('#hidbigid').val(bigId);
            }
        });

        //新增同级频道 设置id显示以及弹窗所属的父级类别
        $('#myAddSameLevelCnl').on('shown.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var bigId = button.data('id'); //获取要操作的ID
            var catename = button.data('catename');
            if (bigId == 0) {
                $('#lblPIdName').text("0顶级分类");
                $('#hidbid').val(bigId);
                $('#mdlTitle').text("新增同级频道");
            } else {
                //把要修改的分类名称显示出来
                $('#lblPIdName').text(bigId + catename);
                $('#hidbid').val(bigId);
                $('#mdlTitle').text("新增子频道");
            }
        });

        //修改频道，根据设置的id,查询整个频道信息并显示出来
        $('#myUpdateSameLevelCnl').on('shown.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var id = button.data('id'); //获取要操作的ID
            //获取要传递的参数
            var model = new Object();
            model.action = "searchModleById";
            model.id = id;
            //将信息转换成json数据
            var cateInfo = JSON.stringify(model);

            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": cateInfo },
                dataType: "json",
                success: function (data) {
                    if (data.sort_name != "") {
                        //把要修改的分类名称显示出来
                        $('#lblupPIdName').text(data.big_name);
                        $('#hidupbid').val(data.big_id);
                        $('#hiduplvlId').val(data.id);
                        $("#txtuplvlOrders").val(data.orders)
                        $("#txtuplvlSortName").val(data.sort_name);
                        $("#txtuplvlPageTitle").val(data.pagetitle);
                        $("#txtuplvlPageKey").val(data.pagekeyw);
                        $("#txtuplvlPageDesc").val(data.pagedesc);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myUpdateSameLevelCnl').modal('hide');
                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    refreshTable();
                }
            });
        });

        //删除频道 设置要删除的隐藏id
        $('#myDeleteCnl').on('shown.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var id = button.data('id'); //获取要操作的ID
            $('#deleteCnlId').val(id);
        });

        //管理子频道，设置要显示的子频道列表
        //        $('#myManageChildCnl').on('shown.bs.modal', function (event) {
        //            var button = $(event.relatedTarget);
        //            var bigId = button.data('id'); //获取要操作的ID
        //            var catename = button.data('catename');
        //            $('#mdlTitle').text("“" + catename + "”子频道管理");
        //            initChildTable(bigId,bigName);
        //        });

        //        function initChildTable(bigId, bigName) {
        //            $('#childTable').bootstrapTable({
        //                url: "/BootstrapBackgroundManagement/System/Ashx/TableChannelList.ashx?action=GetChildChannelListJson&bigId="+bigId,
        //                //请求方法
        //                method: 'get',
        //                //是否显示行间隔色
        //                striped: true,
        //                //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）     
        //                cache: false,
        //                //是否显示分页（*）  
        //                pagination: false,
        //                //是否启用排序  
        //                sortable: false,
        //                //排序方式 
        //                sortOrder: "asc",
        //                //初始化加载第一页，默认第一页
        //                //我设置了这一项，但是貌似没起作用，而且我这默认是0,- -
        //                pageNumber: 1,                       //初始化加载第一页，默认第一页
        //                //每页的记录行数（*）   
        //                pageSize: 10,
        //                //可供选择的每页的行数（*）    
        //                pageList: [10, 20, 30, 40, 50],
        //                //这个接口需要处理bootstrap table传递的固定参数,并返回特定格式的json数据  
        //                //分页方式：client客户端分页，server服务端分页（*）
        //                sidePagination: "server",
        //                //是否显示搜索
        //                search: false,
        //                //Enable the strict search.    
        //                strictSearch: true,
        //                //Indicate which field is an identity field.
        //                idField: "id",
        //                columns: [{
        //                    field: 'id',
        //                    title: 'ID',
        //                    align: 'center'
        //                }, {
        //                    field: 'sort_name',
        //                    title: '分类名称',
        //                    align: 'center'
        //                }, {
        //                    field: 'big_id',
        //                    title: '新增同级频道',
        //                    align: 'center',
        //                    formatter: function (value, row, index) {
        //                        //通过formatter可以自定义列显示的内容
        //                        //value：当前field的值，即id
        //                        //row：当前行的数据
        //                        var a = '<a href="javascript:void(0);" data-toggle="modal" data-target="#myAddChildZSameCnl" data-id="' + bigId + '" data-catename="' + bigName + '" ><span class="glyphicon glyphicon-plus"></span>新增同级频道</a>';
        //                        return a;
        //                    }
        //                }, {
        //                    field: 'id',
        //                    title: '编辑',
        //                    align: 'center',
        //                    formatter: function (value, row, index) {
        //                        //通过formatter可以自定义列显示的内容
        //                        //value：当前field的值，即id
        //                        //row：当前行的数据
        //                        var a = '<a href="/BootstrapBackgroundManagement/System/SysManage/Sys_Channel_Update.aspx"  data-toggle="modal" data-target="#myUpdateSameLevelCnl" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-pencil"></span>编辑</a>';
        //                        return a;
        //                    }
        //                }, {
        //                    field: 'id',
        //                    title: '删除',
        //                    align: 'center',
        //                    formatter: function (value, row, index) {
        //                        //通过formatter可以自定义列显示的内容
        //                        //value：当前field的值，即id
        //                        //row：当前行的数据
        //                        var a = '<a href="javescript:void(0);" data-toggle="modal" data-target="#myDeleteCnl" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-remove"></span>删除</a>';
        //                        return a;
        //                    }
        //                }],
        //                pagination: true
        //            });
        //         }


        //新增频道
        function AddCategory() {
            var model = new Object();
            var dfOrders = "100";
            if ($("#txtlvlSortName").val() == "") {
                $("#txtlvlSortName").parent("td").addClass("has-error");
                return;
            }
            if ($("#txtlvlOrders").val() != "") {
                if (checkNum($("#txtlvlOrders").val()))
                    dfOrders = $("#txtlvlOrders").val();
                else {
                    $("#txtlvlOrders").parent("td").addClass("has-error");
                    return;
                }
            }
            //获取页面数据
            model.action = "addCate";
            model.id = $("#hidlvlId").val();
            model.orders = dfOrders;
            model.bigId = $("#hidbid").val();
            model.sortName = $("#txtlvlSortName").val();
            model.pageTitle = $("#txtlvlPageTitle").val();
            model.pageKey = $("#txtlvlPageKey").val();
            model.pageDesc = $("#txtlvlPageDesc").val();

            //将信息转换成json数据
            var cateInfo = JSON.stringify(model);
            //提交网站参数，进行保存

            //提交网站参数，进行保存
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": cateInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("操作成功", "保存成功!", "success");
                    } else {
                        alertDialog(data.ErrorMsg, "error");
                        pageAlert("操作失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myAddSameLevelCnl').modal('hide');
                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    refreshTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myAddSameLevelCnl').modal('hide');
                    refreshTable();
                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    //                    alert(XMLHttpRequest.status);
                    //                    alert(XMLHttpRequest.readyState);
                    //                    alert(textStatus);
                }
            });

        }

        //修改频道
        function UpdateCategory() {
            var model = new Object();
            var dfOrders = "100";
            if ($("#txtuplvlSortName").val() == "") {
                $("#txtuplvlSortName").parent("td").addClass("has-error");
                return;
            }
            if ($("#txtuplvlOrders").val() != "") {
                if (checkNum($("#txtuplvlOrders").val()))
                    dfOrders = $("#txtuplvlOrders").val();
                else {
                    $("#txtuplvlOrders").parent("td").addClass("has-error");
                    return;
                }
            }
            //获取页面数据
            model.action = "updateCate";
            model.id = $("#hiduplvlId").val();
            model.orders = dfOrders;
            model.bigId = $("#hidupbid").val();
            model.sortName = $("#txtuplvlSortName").val();
            model.pageTitle = $("#txtuplvlPageTitle").val();
            model.pageKey = $("#txtuplvlPageKey").val();
            model.pageDesc = $("#txtuplvlPageDesc").val();

            //将信息转换成json数据
            var cateInfo = JSON.stringify(model);
            //提交网站参数，进行保存
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": cateInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("操作成功", "修改成功!", "success");
                    } else {
                        alertDialog(data.ErrorMsg, "error");
                        pageAlert("操作失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myUpdateSameLevelCnl').modal('hide');
                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    refreshTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myUpdateSameLevelCnl').modal('hide');
                    refreshTable();
                    //                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    //                    alert(XMLHttpRequest.status);
                    //                    alert(XMLHttpRequest.readyState);
                    //                    alert(textStatus);
                }
            });
        }

        //删除频道
        function DelCategory() {
            var model = new Object();
            //获取要删除的id
            model.id = $('#deleteCnlId').val();
            model.action = "delCate";
            //将信息转换成json数据
            var cateInfo = JSON.stringify(model);
            //提交网站参数，进行删除
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": cateInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("操作成功", "删除成功!", "success");
                    } else {
                        alertDialog(data.ErrorMsg, "error");
                        pageAlert("操作失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myDeleteCnl').modal('hide');
                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    refreshTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myDeleteCnl').modal('hide');
                    refreshTable();
                    //                    //重新加载表格数据
                    //                    $("#table").bootstrapTable('destroy');
                    //                    initTable();
                    //                    alert(XMLHttpRequest.status);
                    //                    alert(XMLHttpRequest.readyState);
                    //                    alert(textStatus);
                }
            });
        }

        //新增同级频道/新增子频道，关闭对话框之前移除数据
        $("#myAddSameLevelCnl").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
        });

        //修改频道信息，关闭对话框之前移除数据
        $("#myUpdateSameLevelCnl").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
        });

        //        //管理子频道信息，关闭对话框之前移除数据
        //        $("#myManageChildCnl").on("hidden.bs.modal", function () {
        //            $(this).removeData("bs.modal");
        //        });

        //刷新事件
        function refreshTable() {
            $('#table').bootstrapTable('refresh');
        }

    </script>
</asp:Content>
