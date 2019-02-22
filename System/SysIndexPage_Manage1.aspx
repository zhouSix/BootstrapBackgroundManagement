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
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
                            <li><a onclick="shows1($(this).text())" href="#">Java</a> </li>
                            <li><a onclick="shows1($(this).text())" href="#">数据挖掘</a> </li>
                            <li><a onclick="shows1($(this).text())" href="#">数据通信/网络</a> </li>
                            <li><a onclick="shows1($(this).text())" href="#">分离的链接</a> </li>
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
                <%--<button type="button" class="btn btn-default" style="margin-left: 60px" data-toggle="modal"
                    data-target="#myAddUser">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>添加信息
                </button>--%>
            </div>
            <div id="toolbar" class="btn-group">
                <button id="btn_add" type="button" class="btn btn-default" data-toggle="modal" data-target="#myAddIndexInfo">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
                </button>
                <button id="btn_edit" type="button" class="btn btn-default" data-toggle="modal" data-target="#myUpdateIndexInfo">
                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改
                </button>
                <button id="btn_delete" type="button" class="btn btn-default" data-toggle="modal"
                    data-target="#myDeleteIndexInfo">
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
                                        <input type="text" class="form-control" id="Text0" placeholder="100" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    信息标题：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="Text1" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    SEO关键字：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="Text2" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    SEO描述：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="Text3" style="width: 400px;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    所属栏目：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="Text4" />
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
                                        <input type="text" class="form-control" id="Text7" style="width: 400px;" />
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
                    <button type="button" class="btn btn-primary" onclick="addIndexInfo()">
                        添加
                    </button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function shows1(a) {
            $('#dropdownMenu2').text(a)
        }

        $(function () {
            initTable();
        });

        //初始化表格数据
        function initTable() {
            $('#table').bootstrapTable({
                url: "/BootstrapBackgroundManagement/System/Ashx/TableIndexList.ashx?action=GetIndexListJson",
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
        });

        //新增用户，关闭对话框之前移除数据
        $("#myAddIndexInfo").on("hidden.bs.modal", function () {
            $(this).removeData("bs.modal");
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


         //上传文件
        $("#img_file").fileinput("upload");
        //上传失败处理
        $("#img_file").on("fileerror",
        function(event, data, msg) {
            pageAlert("上传失败", msg, "error");
        });
        //上传成功处理
        $("#img_file").on("fileuploaded",
        function (event, data, previewId, index) {
            var result = data.response; //接收后台返回的数据
            $("#txtpicpath").val(result.Url);
            $("#img_file").fileinput("clear");
        });

    </script>
</asp:Content>
