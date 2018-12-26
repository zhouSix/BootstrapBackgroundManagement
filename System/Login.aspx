<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="System_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <title>亿普格网站后台管理系统</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="js/holder.js" type="text/javascript"></script>
    <style type="text/css">
        .bg
        {
            background: url(images/bluebg.jpg) no-repeat center top;
            width: 100%;
            min-height: 580px;
        }
        .login-container
        {
            width: 375px;
            margin-top: 150px;
        }
    </style>
</head>
<body style="width: 100%;">
    <!-- top logo -->
    <div class="jumbotron" style="margin-bottom: 0; background-color: #436ba6; padding-bottom: 30px;">
        <div class="row">
            <div class="col-md-6 col-md-offset-2">
                <img src="images/blue.png" alt="" />
            </div>
        </div>
    </div>
    <!--end top logo -->
    <!-- container -->
    <div class="bg">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <!-- left company search -->
                <div class="col-xs-6" style="height: 525px;">
                    <a href="http://www.epgwl.com" style="display: block; float: right; margin-top: 490px;
                        width: 350px; line-height: 30px;" target="_blank">公司简介</a>
                </div>
                <!-- end left company search -->
                <!-- right login -->
                <form action="" class="form-horizontal" role="form">
                <div class="login-container col-sm-10  col-sm-offset-1">
                    <div class="panel panel-info">
                        <div class="panel-body" style="background-color: #f7f7f7;">
                            <h3>
                                用户登陆</h3>
                            <br />
                            <div class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" class="form-control" id="inputUserName" oninput="JudgeNameText(this)"
                                    placeholder="请输入用户名" required />
                            </div>
                            <br />
                            <div class="input-group">
                                <span class="input-group-addon"><i class="	glyphicon glyphicon-asterisk"></i>
                                </span>
                                <input type="password" class="form-control" id="inputPassword" oninput="JudgePwdText(this)"
                                    placeholder="请输入密码" required />
                            </div>
                            <br />
                            <div class="input-group">
                                <input type="text" maxlength="4" id="inputValidateCode" class="form-control" placeholder="验证码"
                                    oninput="JudgeVCodeText(this)" style="width: 120px; float: left;" required />
                                <img alt="点击切换验证码" style="cursor: pointer; vertical-align: middle; border: 0px; margin-left: 20px;
                                    float: right;" width="120" height="34" src="Ashx/ValidateCode.ashx" onclick="this.src='Ashx/ValidateCode.ashx?_='+Math.random()" />
                            </div>
                            <br />
                            <div id="prompt" class="alert alert-danger alert-dismissable">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">
                                    &times;
                                </button>
                                错误！请进行一些更改。
                            </div>
                            <br />
                            <div>
                                <button type="button" id="submit" class="btn btn-primary btn-lg btn-block">
                                    登 陆</button>
                            </div>
                        </div>
                    </div>
                </div>
                </form>
                <!-- end right login -->
            </div>
        </div>
    </div>
    <!-- end container -->
    <script type="text/javascript">
        var oldNameLength = 0; var oldPwdLength = 0; var oldVCodeLength = 0; //旧的用户名长度，旧的密码长度，旧的验证码长度

        window.onload = function () {
            $("#prompt").hide();
         }

        function PromptText(text) {
            var $b = $('#prompt').find('button');
            $('#prompt').html($b);
            $b.after(text);
          }

        //登陆
          $("#submit").on("click", function () {
              var model = new Object();
              //用户名空值判断
              if ($("#inputUserName").val() == "") {
                  $("#inputUserName").parent(".input-group").addClass("has-error");
                  $("#prompt").show();
                  PromptText("用户名不能为空！");
                  oldNameLength = 0;
                  return;
              } else {
                  $("#inputUserName").parent(".input-group").removeClass("has-error");
                  oldNameLength = $("#inputUserName").val().length;
                  $("#prompt").hide();
              }
              //密码空值判断
              if ($("#inputPassword").val() == "") {
                  $("#inputPassword").parent(".input-group").addClass("has-error");
                  PromptText("密码不能为空！");
                  oldLength = 0;
                  return;
              } else {
                  $("#inputPassword").parent(".input-group").removeClass("has-error");
                  oldLength = $("#inputPassword").val().length;
                  $("#prompt").hide();
              }

              //验证码空值判断
              if ($("#inputValidateCode").val() == "") {
                  $("#inputValidateCode").parent(".input-group").addClass("has-error");
                  PromptText("验证码不能为空！");
                  oldLength = 0;
                  return;
              } else {
                  //验证码字体长度判断()
                  if ($("#inputValidateCode").val().length != 4) {
                      $("#inputValidateCode").parent(".input-group").addClass("has-error");
                      oldLength = $("#inputValidateCode").val().length;
                      PromptText("验证码是4位数！");
                      return;
                  }
                  else {
                      $("#inputValidateCode").parent(".input-group").removeClass("has-error");
                      oldLength = $("#inputValidateCode").val().length;
                      $("#prompt").hide();
                  }
              }
              model.username = $("#inputUserName").val();
              model.pwd = $("#inputPassword").val();
              model.validatecode = $("#inputValidateCode").val();
              model.action = "loginIn";

              //将登陆的用户信息转换成json数据
              var loginInfo = JSON.stringify(model);

              //ajax数据传输到ashx中的登录一般处理程序中
              $.ajax({
                  type: "post",
                  url: "Ashx/Default.ashx",
                  data: { "data": loginInfo },
                  dataType: "json",
                  success: function (data) {
                      if (data.ErrorCode == "3") {
                          $("#inputValidateCode").parent(".input-group").addClass("has-error");
                          PromptText(data.ErrorMsg);
                          $("#inputUserName").parent(".input-group").removeClass("has-error");
                          $("#inputPassword").parent(".input-group").removeClass("has-error");
                      }
                      else if (data.ErrorCode == "2") {
                          $("#inputUserName").parent(".input-group").addClass("has-error");
                          $("#inputPassword").parent(".input-group").addClass("has-error");
                          $("#errorMsg").html(data.ErrorMsg);
                          PromptText(data.ErrorMsg);
                          $("#inputValidateCode").parent(".input-group").removeClass("hidden");
                      } else if (data.ErrorCode == "0") {
                          window.location.href = "Default.aspx";
                      }
                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                      //                    alert(XMLHttpRequest.status);
                      //                    alert(XMLHttpRequest.readyState);
                      //                    alert(textStatus);
                      PromptText("网络超时，请重试！");

                  }
              });
          });
        //判断用户名的文本变化
        function JudgeNameText(obj) {
            JudgeText(obj, oldNameLength);
        }
        //判断密码的文本变化
        function JudgePwdText(obj) {
            JudgeText(obj, oldPwdLength);
        }
        //判断验证码的文本变化
        function JudgeVCodeText(obj) {
            JudgeText(obj, oldVCodeLength);
        }
        //判断input内的文本变化，文本为空值或文本值变大，消除错误样式
        function JudgeText(obj, oldLength) {
            if ($(obj).val() == "") {
                $(obj).parent(".input-group").removeClass("has-error");
                $("#prompt").hide();
                oldLength = 0;
            }
            else if ($(obj).val().length > oldLength) {
                $(obj).parent(".input-group").removeClass("has-error");
                $("#prompt").hide();
                oldLength = $(obj).val().length;
            }
            else
                oldLength = $(obj).val().length;
        }
       
    </script>
</body>
</html>
