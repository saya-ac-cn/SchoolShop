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
    <title>运维管理员统一认证登录平台</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link href="assets/css/adminlogin.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>

</head>
<body>
<div class="headerDiv">
    运维管理员统一认证登录平台
</div>
<div class="login_box">
    <div class="login_l_img"><img src="assets/images/login-img.png" /></div>
    <div class="login">
        <div class="login_logo"><a href="#"><img src="assets/images/login_logo.png" /></a></div>
        <div class="login_name">
            <p>用户登录</p>
        </div>
        <form method="post">
            <input name="username" id=username type="text"  value="用户名" onfocus="this.value=''" onblur="if(this.value==''){this.value='用户名'}">
            <span id="password_text" onclick="this.style.display='none';document.getElementById('password').style.display='block';" >密码</span>
            <input name="password" type="password" id="password" style="display:none;" onblur="if(this.value==''){document.getElementById('password_text').style.display='block';this.style.display='none'};"/>
            <input id="login" value="登录" style="width:100%;" type="submit">
        </form>
    </div>
    <div class="copyright">Copyright© <script>document.write(new Date().getFullYear())</script> saya.ac.cn All Rights Reserved 暖心阁 蜀ICP备16013222-2号</div>
</div>
</body>
<script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
<script type="text/javascript">

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
            var username = $.trim($("#username").val());
            var password = $.trim($("#password").val());
            if(username==""||password==""){
                layer.msg('登录账号或密码不能为空');
                return false;
            }
            login()
            return false;
        });
    });

    //处理登录
    function login()
    {
        console.log('执行');
        $.ajax({
            type: "POST",
            url: "/api/public/adminLogin.yht",
            data:{id:$.trim($("#username").val()),password:password = $.trim($("#password").val())},
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    window.location.href = "/view/admin/";
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
