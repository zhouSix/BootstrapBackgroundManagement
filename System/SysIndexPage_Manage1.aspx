<%@ Page Title="" Language="C#" MasterPageFile="~/System/MasterPage.master" AutoEventWireup="true"
    CodeFile="SysIndexPage_Manage1.aspx.cs" Inherits="System_SysIndexPage_Manage1" %>

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
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default1.aspx">
                    首页</a></h3>
        </li>
        <li><b>系统管理</b></li>
        <li><b>首页页面设置</b> </li>
        <li class="active">首页设置列表信息</li>
    </ul>
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
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="width: 150px;">
                            <span id="dropdownMenu2">请选择类别</span> <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1" id="ddmUlHtml">
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
                font-size: 16; line-height: 45px; margin-top: 10px;">
                首页设置列表
            </div>
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" data-target="#myAddIndexInfo">
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
    <!-- 模态框（Modal）- 新增信息(myAddIndexInfo) -->
    <div class="modal fade" id="myAddIndexInfo" tabindex="-1" role="dialog" aria-labelledby="myAddIndexInfo"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        新增信息
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td style="width: 180px;">
                                    优先级别：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtSortId" placeholder="100" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    信息标题：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtTitle" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    SEO关键字：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtPagekeyw" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    SEO描述：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtPagedesc" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    所属栏目：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <div class="dropdown">
                                            <button type="button" class="btn btn-default dropdown-toggle" id="drpdCate" data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="true" style="width: 150px;">
                                                <span id="spnDrpdCate">请选择类别</span> <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="drpdCate" id="drpdUlCate">
                                            </ul>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    缩略图地址：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtpicpath" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    上传缩略图：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <div class="file-loading">
                                            <input id="img_file" type="file" multiple class="file" data-overwrite-initial="false"
                                                data-min-file-count="1" data-theme="fas">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    信息摘要：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtAbstract" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    信息内容（PC）：<br />
                                    按回车键是增加段落<br />
                                    按Shift + Enter 是换行
                                </td>
                                <td>
                                    <div class="input-group">
                                        <div class="summernote" id="txtInfo">
                                        </div>
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
                    <button type="button" class="btn btn-primary" onclick="AddIndexInfo()">
                        添加
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 模态框（Modal）- 修改信息(myUpdateIndexInfo) -->
    <div class="modal fade" id="myUpdateIndexInfo" tabindex="-1" role="dialog" aria-labelledby="myUpdateIndexInfo"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        修改信息
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td style="width: 180px;">
                                    优先级别：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txt_update_sortid" placeholder="100" />
                                        <input type="hidden" id="hid_update_id" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    信息标题：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txt_update_title" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    SEO关键字：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txt_update_pagekeyw" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    SEO描述：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txt_update_pagedesc" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    所属栏目：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <div class="dropdown">
                                            <button type="button" class="btn btn-default dropdown-toggle" id="drp_update_menu"
                                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="width: 150px;">
                                                <span id="spn_update_drpmenu">请选择类别</span> <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu" aria-labelledby="drop_update_menu" id="ul_update_drpmenu">
                                            </ul>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    缩略图地址：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txt_update_picpath" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    上传缩略图：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <div class="file-loading">
                                            <input id="img_file_update" type="file" multiple class="file" data-overwrite-initial="false"
                                                data-min-file-count="1" data-theme="fas">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    信息摘要：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txt_update_abstract" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    信息内容（PC）：<br />
                                    按回车键是增加段落<br />
                                    按Shift + Enter 是换行
                                </td>
                                <td>
                                    <div class="input-group">
                                        <div class="summernote" id="txt_update_info">
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div id="update_prompt" class="alert alert-danger alert-dismissable">
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
                    <button type="button" class="btn btn-primary" onclick="UpdateIndexInfo()">
                        保存
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 模态框   信息删除确认-->
    <div class="modal fade" id="myDeleteIndexInfo" tabindex="-1" role="dialog" aria-labelledby="myDeleteIndexInfo"
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
                    <input type="hidden" id="deleteInfoId" />
                    <p>
                        您确认要删除该条信息吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消</button>
                    <button type="button" class="btn btn-primary" id="deleteHaulBtn" onclick="DeleteIndexInfo()">
                        确认</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <script type="text/javascript">
        //选择类别下拉框数据选择
        function shows1(a) {
            $('#dropdownMenu2').text(a)
        }
        //新增界面所属栏目下拉框数据选择
        function showCates(a) {
            $('#spnDrpdCate').text(a)
        }
        //修改界面所属栏目下拉框数据选择
        function show_update_cates(a) {
            $('#spn_update_drpmenu').text(a)
        }

        var parentId = "";

        //页面加载时获取url传进来的参数，绑定类别下拉菜单，绑定表格数据
        $(function () {
            parentId = getQueryString("Cid");

            BindDdmHtml(parentId);

            initTable("-1");
        });

        //绑定类别下拉菜单
        function BindDdmHtml(parentId) {
            //获取要传递的参数
            var model = new Object();
            model.action = "searchDropMenuList";
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
                        $("#ddmUlHtml").html(data.ErrorMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                }
            });
        }

        //绑定新增界面栏目下拉菜单
        function BindCateDrpHtml(parentId) {
            //获取要传递的参数
            var model = new Object();
            model.action = "searchCateDropMenuList";
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
                        $("#drpdUlCate").html(data.ErrorMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                }
            });
        }

        function Bind_Update_CateDrpHtml(parentId) {
            //获取要传递的参数
            var model = new Object();
            model.action = "searchUpdateCateDropMenuList";
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
                        $("#ul_update_drpmenu").html(data.ErrorMsg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                }
            });
        }


        //类别下拉菜单选择时变更表格数据
        $("#dropdownMenu2").bind('DOMNodeInserted', function (e) {
            refreshTable();
        });

        //刷新表格信息
        function refreshTable() {
            var menuName = $('#dropdownMenu2').text();
            //获取要传递的参数
            var model = new Object();
            model.action = "getTableIdBySortName";
            model.sortname = menuName;
            //将信息转换成json数据
            var dataInfo = JSON.stringify(model);
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": dataInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        var cid = data.ErrorMsg;
                        if ($('#dropdownMenu2').text().indexOf("首页") != -1) {
                            $("#table").bootstrapTable('refresh', { 'url': "/BootstrapBackgroundManagement/System/Ashx/TableIndexList.ashx?action=GetIndexListJson&cid=" + cid });
                        }
                        else {
                            $("#table").bootstrapTable('refresh', { 'url': "/BootstrapBackgroundManagement/System/Ashx/TableIndexList.ashx?action=GetIndexListJson&cid=-1" });
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                }
            });

            //            if ($('#dropdownMenu2').text().indexOf("首页") != -1) {
            //                $("#table").bootstrapTable('refresh', { 'url': "/BootstrapBackgroundManagement/System/Ashx/TableIndexList.ashx?action=GetIndexListJson&cid=0" });
            //            }
            //            else {
            //                $("#table").bootstrapTable('refresh', { 'url': "/BootstrapBackgroundManagement/System/Ashx/TableIndexList.ashx?action=GetIndexListJson&cid=-1" });
            //            }
        }

        //初始化表格数据
        function initTable(Cid) {
            $('#table').bootstrapTable({
                url: "/BootstrapBackgroundManagement/System/Ashx/TableIndexList.ashx?action=GetIndexListJson&cid=" + Cid,
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
                //queryParams: oTableInit.queryParams, //传递参数（*）
                sidePagination: "server",
                //是否显示搜索
                search: false,      //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大  
                strictSearch: true, //Indicate which field is an identity field.
                showColumns: true,                  //是否显示所有的列
                showRefresh: true,                  //是否显示刷新按钮
                minimumCountColumns: 2,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                //height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
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
                    title: '文章标题',
                    align: 'center'
                }
                //                , {
                //                    field: 'class_id',
                //                    title: '所属类别id',
                //                    align: 'center'
                //                }
                , {
                    field: 'sort_name',
                    title: '所属类别',
                    align: 'center'
                }, {
                    field: 'dateandtime',
                    title: '发布时间',
                    align: 'center'
                }, {
                    field: 'sortid',
                    title: '优先级别',
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

        //新增用户,弹窗前隐藏错误提示
        $('#myAddIndexInfo').on('show.bs.modal', function (event) {
            $("#prompt").hide();
            BindCateDrpHtml(parentId);
        });

        //修改用户,弹窗前隐藏错误提示
        $('#myUpdateIndexInfo').on('show.bs.modal', function (event) {
            $("#update_prompt").hide();
            //判断隐藏input是否被赋值，没有赋值则是表格内编辑点击操作
            if ($("#hid_update_id").val() == "") {
                var button = $(event.relatedTarget);
                //获取要操作的ID
                var id = button.data('id');
                //将获取的id,绑定到隐藏的input值中 
                $("#hid_update_id").val(id);
            }
            Bind_Update_CateDrpHtml(parentId);

            //获取要传递的参数
            var model = new Object();
            model.action = "searchIndexSetInfo";
            model.id = $("#hid_update_id").val();
            //将信息转换成json数据
            var dataInfo = JSON.stringify(model);

            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": dataInfo },
                dataType: "json",
                success: function (data) {
                    if (data.Title != "") {
                        //把要修改的分类名称显示出来
                        $("#txt_update_sortid").val(data.Sortid);
                        $("#txt_update_title").val(data.Title);
                        $("#txt_update_pagekeyw").val(data.Pagekeyw);
                        $("#txt_update_pagedesc").val(data.Pagedesc);
                        $('#spn_update_drpmenu').text(data.Class_name);
                        $("#txt_update_picpath").val(data.Picpath);
                        $("#txt_update_abstract").val(data.Introduction);
                        $('#txt_update_info').summernote('code', data.Info);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myUpdateIndexInfo').modal('hide');
                    refreshTable();
                }
            });
        });

        $('#myDeleteIndexInfo').on('show.bs.modal', function (event) {
            //判断隐藏input是否被赋值，没有赋值则是表格内编辑点击操作
            if ($("#deleteInfoId").val() == "") {
                var button = $(event.relatedTarget);
                var id = button.data('id'); //获取要操作的ID
                $('#deleteInfoId').val(id);
            }
        });

        //修改按钮点击事件（表格上的按钮）
        function Update_Info() {
            //取表格的选中行数据
            var arrselections = $("#table").bootstrapTable('getSelections');
            //判断表格中选中行只能选一行
            if (arrselections.length <= 0) {
                pageAlert("操作失败", "请选择有效数据!", "error");
                return;
            }
            else if(arrselections.length > 1)
            {
                pageAlert("操作失败", "请选择一条有效数据!", "error");
                return;
            }
            //获取选中行的id，并赋值给隐藏的input
            var updateId = arrselections[0]["id"].toString();
            $("#hid_update_id").val(updateId);
            //展示修改界面
            $("#myUpdateIndexInfo").modal('show');
        }

        //删除按钮的点击事件（表格上的按钮）
        function Delete_Info() {
            var ids = "";
            //取表格的选中行数据
            var arrselections = $("#table").bootstrapTable('getSelections');
            //判断表格中选中行只能选一行
            if (arrselections.length <= 0) {
                pageAlert("操作失败", "请选择有效数据!", "error");
                return;
            }
            $.each(arrselections, function (i, item) {
                if (ids == "") {
                    ids = item.id;
                }
                else {
                    ids += "," + item.id;
                }
            });
            var id = ids;
            $('#deleteInfoId').val(id);
            //展示删除界面
            $("#myDeleteIndexInfo").modal('show');
        }

        //新增用户，关闭对话框之前移除数据
        $("#myAddIndexInfo").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
            $("#txtSortId").val("");
            $("#txtTitle").val("");
            $("#txtPagekeyw").val("");
            $("#txtPagedesc").val("");
            $('#spnDrpdCate').text("请选择类别");
            $("#txtpicpath").val("");
            $("#txtAbstract").val("");
            $('#txtInfo').summernote('code', "");
        });

        //修改用户，关闭对话框之前移除数据
        $("#myUpdateIndexInfo").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
            $("#hid_update_id").val("");
            $("#txtSortId").val("");
            $("#txtTitle").val("");
            $("#txtPagekeyw").val("");
            $("#txtPagedesc").val("");
            $('#spnDrpdCate').text("请选择类别");
            $("#txtpicpath").val("");
            $("#txtAbstract").val("");
            $('#txtInfo').summernote('code', "");
        });

        //修改用户，关闭对话框之前移除数据
        $("#myDeleteIndexInfo").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
            $("#deleteInfoId").val("");
            
        });

        $("#img_file").fileinput({
            language: 'zh', //设置语言
            theme: 'fas',
            uploadUrl: 'Ashx/UploadFile.ashx', //上传的地址
            allowedFileExtensions: ['jpg', 'png', 'gif'], //接收的文件后缀,
            overwriteInitial: true,
            maxFileSize: 1000,
            maxFilesNum: 10
            //allowedFileTypes: ['image', 'video', 'flash'],
        });

        //选择文件后立即执行（fileselect：单个文件，filebatchselected：多个文件）
        $('#img_file').on('fileselect', function (event, files) {
            $('#img_file').fileinput('upload'); //上传操作
        });
        //上传文件
        //$("#img_file").fileinput("upload");
        //上传失败处理
        $("#img_file").on("fileerror",
        function (event, data, msg) {
            pageAlert("上传失败", msg, "error");
        });
        //上传成功处理
        $("#img_file").on("fileuploaded",
        function (event, data, previewId, index) {
            var result = data.response; //接收后台返回的数据
            $("#txtpicpath").val(result.Url);
            $("#img_file").fileinput("clear");
        });

        $("#img_file_update").fileinput({
            language: 'zh', //设置语言
            theme: 'fas',
            uploadUrl: 'Ashx/UploadFile.ashx', //上传的地址
            allowedFileExtensions: ['jpg', 'png', 'gif'], //接收的文件后缀,
            overwriteInitial: true,
            maxFileSize: 1000,
            maxFilesNum: 10
            //allowedFileTypes: ['image', 'video', 'flash'],
        });

        //选择文件后立即执行（fileselect：单个文件，filebatchselected：多个文件）
        $('#img_file_update').on('fileselect', function (event, files) {
            $('#img_file_update').fileinput('upload'); //上传操作
        });
        //上传文件
        //$("#img_file").fileinput("upload");
        //上传失败处理
        $("#img_file_update").on("fileerror",
        function (event, data, msg) {
            pageAlert("上传失败", msg, "error");
        });
        //上传成功处理
        $("#img_file_update").on("fileuploaded",
        function (event, data, previewId, index) {
            var result = data.response; //接收后台返回的数据
            $("#txt_update_picpath").val(result.Url);
            $("#img_file_update").fileinput("clear");
        });

        //错误提示
        function PromptText(text) {
            var $b = $('#prompt').find('button');
            $('#prompt').html($b);
            $b.after(text);
        }

        //新增首页设置
        function AddIndexInfo() {
            if ($("#txtSortId").val() == "") {
                $("#txtSortId").parent(".input-group").addClass("has-error");
                $("#prompt").show();
                PromptText("优先级别不能为空！");
                return;
            } else {
                $("#txtSortId").parent(".input-group").removeClass("has-error");
                $("#prompt").hide();
            }
            if ($("#txtTitle").val() == "") {
                $("#txtTitle").parent(".input-group").addClass("has-error");
                $("#prompt").show();
                PromptText("优先级别不能为空！");
                return;
            } else {
                $("#txtTitle").parent(".input-group").removeClass("has-error");
                $("#prompt").hide();
            }
            if ($('#spnDrpdCate').text() == "请选择类别") {
                $("#spnDrpdCate").parent(".input-group").addClass("has-error");
                $("#prompt").show();
                PromptText("请选择类别！");
                return;
            } else {
                $("#spnDrpdCate").parent(".input-group").removeClass("has-error");
                $("#prompt").hide();
            }

            var model = new Object();
            model.action = "addIndexSetInfo";
            model.sortid = $("#txtSortId").val();
            model.title = $("#txtTitle").val();
            model.pagekeyw = $("#txtPagekeyw").val();
            model.pagedesc = $("#txtPagedesc").val();
            model.class_name = $('#spnDrpdCate').text();
            model.picpath = $("#txtpicpath").val();
            model.abstract = $("#txtAbstract").val();
            model.info = $('#txtInfo').summernote('code');

            //将首页设置信息转换成json数据
            var dataInfo = JSON.stringify(model);
            //提交首页设置，进行保存
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": dataInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("添加成功", "保存成功!", "success");
                    } else {
                        pageAlert("添加失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myAddIndexInfo').modal('hide');
                    //刷新数据
                    refreshTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("添加失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myAddIndexInfo').modal('hide');
                    //刷新数据
                    refreshTable();
                }
            });
        }

        //修改首页设置
        function UpdateIndexInfo() {
            //获取要修改的参数
            var model = new Object();
            model.action = "updateIndexSetInfo";
            model.id = $("#hid_update_id").val();
            model.sortid = $("#txt_update_sortid").val();
            model.title = $("#txt_update_title").val();
            model.pagekeyw = $("#txt_update_pagekeyw").val();
            model.pagedesc = $("#txt_update_pagedesc").val();
            model.class_name = $('#spn_update_drpmenu').text();
            model.picpath = $("#txt_update_picpath").val();
            model.abstract = $("#txt_update_abstract").val();
            model.info = $('#txt_update_info').summernote('code');
            //将首页设置信息转换成json数据
            var dataInfo = JSON.stringify(model);
            //提交首页设置，进行修改保存
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": dataInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("修改成功", "修改成功!", "success");
                    } else {
                        pageAlert("修改失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myUpdateIndexInfo').modal('hide');
                    //刷新数据
                    refreshTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("修改失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myUpdateIndexInfo').modal('hide');
                    //刷新数据
                    refreshTable();
                }
            });
        }

        //删除首页设置
        function DeleteIndexInfo() {
            var model = new Object();
            //获取要删除的id
            model.id = $('#deleteInfoId').val();
            model.action = "deleteIndexInfo";
            //将信息转换成json数据
            var dataInfo = JSON.stringify(model);
            //提交网站参数，进行删除
            $.ajax({
                type: "post",
                url: "/BootstrapBackgroundManagement/System/Ashx/SystemManage.ashx",
                data: { "data": dataInfo },
                dataType: "json",
                success: function (data) {
                    if (data.ErrorCode == "0") {
                        pageAlert("操作成功", "删除成功!", "success");
                    } else {
                        pageAlert("操作失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myDeleteIndexInfo').modal('hide');
                    refreshTable();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    pageAlert("操作失败", "网络超时，错误信息为" + XMLHttpRequest.status + ",请稍后重试！", "error");
                    //关闭弹窗
                    $('#myDeleteIndexInfo').modal('hide');
                    refreshTable();
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
