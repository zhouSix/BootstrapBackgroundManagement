<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SysChannelList.aspx.cs" Inherits="System_SysManage_SysChannelList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../bootstrapTable/bootstrap-table.css" rel="stylesheet" type="text/css" />
    <script src="../bootstrapTable/bootstrap-table.js" type="text/javascript"></script>
    <script src="../bootstrapTable/locale/bootstrap-table-zh-CN.js" type="text/javascript"></script>
</head>
<body>
    <ul class="breadcrumb" style="padding: 0px 0px 0px 24px; margin: 0px; background-color: White;">
        <li>
            <h3>
                <i class="glyphicon glyphicon-home"></i><a href="/BootstrapBackgroundManagement/System/Default2.aspx">
                    首页</a></h3>
        </li>
        <li><b>系统管理</b> </li>
        <li class="active">频道管理</li>
    </ul>
    <div class="row" style="margin-left: 5px;">
        <div class="col-sm-12">
            <div class="col-md-12" style="background-color: #dedef8; box-shadow: inset 1px -1px 1px #ddd, inset -1px 1px 1px #ddd;
                font-size: 16; line-height: 45px;">
                频道管理<%--<span style="margin-left: 60px"><a href="#">新增顶级频道</a></span>--%>
                <button id="Button1" type="button" class="btn btn-default" style="margin-left: 60px">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增顶级频道
                </button>
            </div>
            <%--<div id="toolbar" class="btn-group">
            频道管理
                <button id="btn_add" type="button" class="btn btn-default" style="margin-left: 60px">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增顶级频道
                </button>
            </div>--%>
            <table id="table" class="table table-bordered">
            </table>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#table').bootstrapTable({
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
                //pageNumber:1,   
                //每页的记录行数（*）   
                pageSize: 10,
                //可供选择的每页的行数（*）    
                pageList: [10, 25, 50, 100],
                //这个接口需要处理bootstrap table传递的固定参数,并返回特定格式的json数据  
                url: "/BootstrapBackgroundManagement/System/Ashx/TableChannelList.ashx?action=GetChannelListJson",
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
                    checkbox: true
                }, {
                    field: 'id',
                    title: 'ID',
                    align: 'center'
                }, {
                    field: 'sort_name',
                    title: '分类名称',
                    align: 'center'
                }, {
                    field: 'id',
                    title: '新增同级频道',
                    align: 'center',
                    formatter: function (value, row, index) {
                        //通过formatter可以自定义列显示的内容
                        //value：当前field的值，即id
                        //row：当前行的数据
                        var a = '<a href="#" ><span class="glyphicon glyphicon-plus"></span>新增同级频道</a>';
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
                        var a = '<a href="#" ><span class="glyphicon glyphicon-list"></span>管理子频道</a>';
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
                        var a = '<a href="#" ><span class="glyphicon glyphicon-plus"></span>新增子频道</a>';
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
                        var a = '<a href="#" ><span class="glyphicon glyphicon-pencil"></span>编辑</a>';
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
                        var a = '<a href="#" ><span class="glyphicon glyphicon-remove"></span>删除</a>';
                        return a;
                    }
                }],
                pagination: true
            });
        });  
    </script>
</body>
</html>
