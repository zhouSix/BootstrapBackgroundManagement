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
<body>
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
                            <br>
                            <div class="input-group input-group-lg">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" class="form-control" id="inputUserName" placeholder="请输入用户名" />
                            </div>
                            <br>
                            <div class="input-group input-group-lg">
                                <span class="input-group-addon"><i class="	glyphicon glyphicon-asterisk"></i></span>
                                <input type="password" class="form-control" id="inputPassword" placeholder="请输入密码"/>
                            </div>
                            <div class="input-group input-group-lg">
                                <input type="text" class="form-control" id="Text1" placeholder="请输入用户名" />
                            </div>
                            <div class="input-group input-group-lg">
                                <button type="submit" class="btn btn-primary btn-lg">
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
</body>
</html>
