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
    <!-- 模态框（Modal）- 添加用户(myAddUser) -->
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
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="txtUserName" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    密 码：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="txtPwd" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    确认密码：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="txtPwdConfirm" />
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
                    <button type="button" class="btn btn-primary" onclick="addUser()">
                        添加
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 模态框（Modal）- 修改用户密码(myUpdateUserPwd) -->
    <div class="modal fade" id="myUpdateUserPwd" tabindex="-1" role="dialog" aria-labelledby="myUpdateUserPwd"
        aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel_update">
                        修改密码
                        <input type="hidden" id="hidId_update" name="hidId_update" value="" />
                    </h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered">
                        <tbody>
                            <tr>
                                <td>
                                    密 码：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="txtPwd_update" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    确认密码：
                                </td>
                                <td>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="txtPwdConfirm_update" />
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div id="prompt_update" class="alert alert-danger alert-dismissable">
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
                    <button type="button" class="btn btn-primary" onclick="updateUserPwd()">
                        确定
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- 模态框（Modal）- 用户信息删除确认-->
    <div class="modal fade" id="myDeleteUser" tabindex="-1" role="dialog" aria-labelledby="myDeleteUser"
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
                    <input type="hidden" id="deleteUserId" name="deleteUserId" value="" />
                    <p>
                        您确认要删除该条用户信息吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        取消</button>
                    <button type="button" class="btn btn-primary" onclick="delUser()">
                        确认</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
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
                        var a = '<a href="javascript:void(0);"  data-toggle="modal" data-target="#myUpdateUserPwd" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-pencil"></span>修改密码</a>';
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
                        var a = '<a href="javascript:void(0);" data-toggle="modal" data-target="#myDeleteUser" data-id="' + value + '" data-catename="' + row["sort_name"] + '" ><span class="glyphicon glyphicon-remove"></span>删除</a>';
                        return a;
                    }
                }],
                pagination: true
            });
        }
        //错误提示
         function PromptText(text) {
            var $b = $('#prompt').find('button');
            $('#prompt').html($b);
            $b.after(text);
          }
          //错误提示2
         function PromptUpdateText(text) {
            var $b = $('#prompt_update').find('button');
            $('#prompt_update').html($b);
            $b.after(text);
          }

          //新增、修改 用户名和密码光标离开是判断
       $(document).ready(function(){
       //新增用户，用户名，密码和确认密码光标离开判断
        $("#txtUserName").blur(function(){
            if ($("#txtUserName").val() == "") {
                  $("#txtUserName").parent(".input-group").addClass("has-error");
                  $("#prompt").show();
                  PromptText("用户名不能为空！");
            }else
            {
                  $("#txtUserName").parent(".input-group").removeClass("has-error");
                  $("#prompt").hide();
            }
        });
         $("#txtPwd").blur(function(){
            if ($("#txtPwd").val() == "") {
                  $("#txtPwd").parent(".input-group").addClass("has-error");
                  $("#prompt").show();
                  PromptText("密码不能为空！");
            }else {
                  $("#txtPwd").parent(".input-group").removeClass("has-error");
                  $("#prompt").hide();
           }
         });
         $("#txtPwdConfirm").blur(function(){
            if ($("#txtPwdConfirm").val() == "") {
                  $("#txtPwdConfirm").parent(".input-group").addClass("has-error");
                  $("#prompt").show();
                  PromptText("确认密码不能为空！");
                  }
                  else if($("#txtPwdConfirm").val().length!=$("#txtPwd").val().length)
                  {
                    $("#txtPwdConfirm").parent(".input-group").addClass("has-error");
                    $("#prompt").show();
                    PromptText("密码长度不一致！");
                  }
                  else if($("#txtPwdConfirm").val()!=$("#txtPwd").val())
                  {
                    $("#txtPwdConfirm").parent(".input-group").addClass("has-error");
                    $("#prompt").show();
                    PromptText("密码不相同！");
                  }
                  else
                  {
                      $("#txtPwdConfirm").parent(".input-group").removeClass("has-error");
                      oldLength = $("#txtPwdConfirm").val().length;
                      $("#prompt").hide();
                  }
         });

         //修改密码，密码和确认密码光标离开判断
         $("#txtPwd_update").blur(function(){
            if ($("#txtPwd_update").val() == "") {
                  $("#txtPwd_update").parent(".input-group").addClass("has-error");
                  $("#prompt_update").show();
                  PromptUpdateText("密码不能为空！");
            }else {
                  $("#txtPwd_update").parent(".input-group").removeClass("has-error");
                  $("#prompt_update").hide();
           }
         });
          $("#txtPwdConfirm_update").blur(function(){
            if ($("#txtPwdConfirm_update").val() == "") {
                  $("#txtPwdConfirm_update").parent(".input-group").addClass("has-error");
                  $("#prompt_update").show();
                  PromptUpdateText("确认密码不能为空！");
                  }
                  else if($("#txtPwdConfirm_update").val().length!=$("#txtPwd_update").val().length)
                  {
                    $("#txtPwdConfirm_update").parent(".input-group").addClass("has-error");
                    $("#prompt_update").show();
                    PromptUpdateText("密码长度不一致！");
                  }
                  else if($("#txtPwdConfirm_update").val()!=$("#txtPwd_update").val())
                  {
                    $("#txtPwdConfirm_update").parent(".input-group").addClass("has-error");
                    $("#prompt_update").show();
                    PromptUpdateText("密码不相同！");
                  }
                  else
                  {
                      $("#txtPwdConfirm_update").parent(".input-group").removeClass("has-error");
                      $("#prompt_update").hide();
                  }
         });
       });

       //新增用户信息
        function addUser()
        {
            if ($("#txtUserName").val() == "") {
                  $("#txtUserName").parent(".input-group").addClass("has-error");
                  $("#prompt").show();
                  PromptText("用户名不能为空！");
                  return;
            }else
            {
                  $("#txtUserName").parent(".input-group").removeClass("has-error");
                  oldNameLength = $("#txtUserName").val().length;
                  $("#prompt").hide();
            }

            //密码空值判断
              if ($("#txtPwd").val() == "") {
                  $("#txtPwd").parent(".input-group").addClass("has-error");
                  PromptText("密码不能为空！");
                  oldLength = 0;
                  return;
              } else {
                  $("#txtPwd").parent(".input-group").removeClass("has-error");
                  oldLength = $("#txtPwd").val().length;
                  $("#prompt").hide();
              }
              //密码空值判断
              if ($("#txtPwdConfirm").val() == "") {
                  $("#txtPwdConfirm").parent(".input-group").addClass("has-error");
                  PromptText("确认密码不能为空！");
                  oldLength = 0;
                  return;
              } 
              else if($("#txtPwdConfirm").val().length!=$("#txtPwd").val().length)
              {
                $("#txtPwdConfirm").parent(".input-group").addClass("has-error");
                    $("#prompt").show();
                    PromptText("密码长度不一致！");
                    return;
              }
              else if($("#txtPwdConfirm").val()!=$("#txtPwd").val())
              {
                 $("#txtPwdConfirm").parent(".input-group").addClass("has-error");
                    $("#prompt").show();
                    PromptText("密码不相同！");
                    return;
              }
              else
              {
                  $("#txtPwdConfirm").parent(".input-group").removeClass("has-error");
                  oldLength = $("#txtPwdConfirm").val().length;
                  $("#prompt").hide();
              }
            
            var model = new Object();
            model.action = "AddManager";
            model.userName=$("#txtUserName").val();
            model.pwd=$("#txtPwd").val();

            //将新添加的用户信息转换成json数据
              var userInfo = JSON.stringify(model);

               //ajax数据传输到ashx中的登录一般处理程序中
              $.ajax({
                  type: "post",
                  url: "Ashx/SystemManage.ashx",
                  data: { "data": userInfo },
                  dataType: "json",
                  success: function (data) 
                  {
                    if (data.ErrorCode == "0") 
                    {
                         pageAlert("操作成功", "保存成功!", "success");
                    } else {
                        pageAlert("操作失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myAddUser').modal('hide');
                    refreshTable();
                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                      PromptText("网络超时，请重试！");
                  }
               });
        }

        //修改用户密码
        function updateUserPwd()
        {
            if ($("#txtPwd_update").val() == "") {
                  $("#txtPwd_update").parent(".input-group").addClass("has-error");
                  $("#prompt_update").show();
                  PromptUpdateText("密码不能为空！");
                  return;
            }else {
                  $("#txtPwd_update").parent(".input-group").removeClass("has-error");
                  $("#prompt_update").hide();
           }
           if ($("#txtPwdConfirm_update").val() == "") {
                  $("#txtPwdConfirm_update").parent(".input-group").addClass("has-error");
                  $("#prompt_update").show();
                  PromptUpdateText("确认密码不能为空！");
                  return;
                  }
                  else if($("#txtPwdConfirm_update").val().length!=$("#txtPwd_update").val().length)
                  {
                    $("#txtPwdConfirm_update").parent(".input-group").addClass("has-error");
                    $("#prompt_update").show();
                    PromptUpdateText("密码长度不一致！");
                    return;
                  }
                  else if($("#txtPwdConfirm_update").val()!=$("#txtPwd_update").val())
                  {
                    $("#txtPwdConfirm_update").parent(".input-group").addClass("has-error");
                    $("#prompt_update").show();
                    PromptUpdateText("密码不相同！");
                    return;
                  }
                  else
                  {
                      $("#txtPwdConfirm_update").parent(".input-group").removeClass("has-error");
                      $("#prompt_update").hide();
                  }
            var model = new Object();
            model.action = "updateManagerPwd";
            model.userPwd=$("#txtPwd_update").val();
            model.id=$("#hidId_update").val();

            //将要修改用户信息转换成json数据
              var userInfo = JSON.stringify(model);
              //ajax数据传输到ashx中的登录一般处理程序中
              $.ajax({
                  type: "post",
                  url: "Ashx/SystemManage.ashx",
                  data: { "data": userInfo },
                  dataType: "json",
                  success: function (data) 
                  {
                    if (data.ErrorCode == "0") 
                    {
                         pageAlert("修改成功", "修改成功!", "success");
                    } else {
                        pageAlert("修改失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myUpdateUserPwd').modal('hide');
                    refreshTable();
                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                      PromptUpdateText("网络超时，请重试！");
                  }
               });
        }

        //删除用户信息
        function delUser()
        {
            var model = new Object();
            model.action = "deleteManage";
            model.id=$("#deleteUserId").val();
            //将要修改用户信息转换成json数据
            var userInfo = JSON.stringify(model);
             //ajax数据传输到ashx中的登录一般处理程序中
              $.ajax({
                  type: "post",
                  url: "Ashx/SystemManage.ashx",
                  data: { "data": userInfo },
                  dataType: "json",
                  success: function (data) 
                  {
                    if (data.ErrorCode == "0") 
                    {
                         pageAlert("删除成功", "删除成功!", "success");
                    } else {
                        pageAlert("删除失败", data.ErrorMsg, "error");
                    }
                    //关闭弹窗
                    $('#myDeleteUser').modal('hide');
                    refreshTable();
                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                      PromptUpdateText("网络超时，请重试！");
                  }
               });
        }

         //新增用户,弹窗前隐藏错误提示
        $('#myAddUser').on('show.bs.modal', function (event) {
            $("#prompt").hide();
        });

        //修改用户密码,弹窗前隐藏错误提示，设置要修改用户隐藏的id
        $('#myUpdateUserPwd').on('show.bs.modal', function (event) {
            $("#prompt_update").hide();
             var button = $(event.relatedTarget);
             var id = button.data('id'); //获取要操作的ID
             $('#hidId_update').val(id);  //赋值要修改的Id

        });

        //删除用户，设置要删除用户的隐藏id
         $('#myDeleteUser').on('show.bs.modal', function (event) {
             var button = $(event.relatedTarget);
             var id = button.data('id'); //获取要操作的ID
             $('#deleteUserId').val(id);  //赋值要删除的Id

        });

        //新增用户，关闭对话框之前移除数据
        $("#myAddUser").on("hidden.bs.modal", function () {
            $("#txtUserName").val("");
            $("#txtPwd").val("");
            $("#txtPwdConfirm").val("");
        });

        //修改用户密码，关闭对话框之前移除数据
        $("#myUpdateUserPwd").on("hidden.bs.modal", function () {
            $("#hidId_update").val("");
            $("#txtPwd_update").val("");
            $("#txtPwdConfirm_update").val("");
        });
         //刷新事件
        function refreshTable() {
            $('#table').bootstrapTable('refresh');
        }
    </script>
</asp:Content>
