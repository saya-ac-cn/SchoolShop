<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/3/24
  Time: 12:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
    <base href="<%=basePath%>">
    <title>商户统一认证登录平台</title>
    <!-- Meta tag Keywords -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Transparent Sign In Form Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- Meta tag Keywords -->
    <!-- css files -->
    <link rel="stylesheet" href="assets/css/font-awesome.css"> <!-- Font-Awesome-Icons-CSS -->
    <link rel="stylesheet" href="assets/css/shoplogin.css" type="text/css" media="all" /> <!-- Style-CSS -->
    <link rel="stylesheet" href="assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <!-- //css files -->
    <!-- web-fonts -->
    <link href="//fonts.googleapis.com/css?family=Raleway:400,500,600,700,800" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet">
    <!-- //web-fonts -->
</head>
<body>
<!--header-->
<div class="header-w3l">
    <h1>商户统一认证登录平台</h1>
</div>
<!--//header-->
<!--main-->
<div class="main-content-agile">
    <div class="sub-main-w3">
        <h2>欢迎登录</h2>
        <form action="#" method="post">
            <div class="icon1">
                <input placeholder="请输入账号" name="userAcct" id="userAcct" type="text" required="">
            </div>

            <div class="icon2" style="padding-bottom:2em">
                <input  placeholder="请输入密码" name="password" id="password" type="password" required="">
            </div>

            <div class="clear"></div>
            <input type="button" id="login"  value="登&nbsp;&nbsp;录">
        </form>
    </div>
</div>
<!--//main-->
<!--footer-->
<div class="footer">
    <p>Copyright© <script>document.write(new Date().getFullYear())</script> saya.ac.cn All Rights Reserved 暖心阁 蜀ICP备16013222-2号</p>
</div>
</body>
<script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
<script>
    var layer,$,element;
    layui.use(['layer','jquery','element'], function() {
        layer = layui.layer,
            $ = layui.jquery,
            element = layui.element;

        //监听回车
        document.onkeydown = function(e){
            if(!e) e = window.event;
            if((e.keyCode || e.which) == 13) $('#login').click();
        };

        //登录事件
        $('#login').on('click', function() {
            var userAcct = $.trim($("#userAcct").val());
            var password = $.trim($("#password").val());
            if(userAcct==""||password==""){
                layer.msg('登录账号或密码不能为空');
                return false;
            }
            login();
            return false;
        });
    });


    //处理登录
    function login()
    {
        console.log('执行');
        $.ajax({
            type: "POST",
            url: "/api/public/studentLogin.yht",
            data:{id:$.trim($("#userAcct").val()),password:$.trim($("#password").val())},
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    window.location.href = "/view/shop/";
                }
                else
                {
                    layer.msg(data.msg);
                }
            },
            error:function(data){
                layer.msg('处理失败');
                return false;
            }
        });
    }
</script>
</html>
