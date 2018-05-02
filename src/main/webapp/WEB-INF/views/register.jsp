<%--
  Created by IntelliJ IDEA.
  User: Pandoras
  Date: 2017/12/19
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
    <base href="<%=basePath%>">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <title>商户入住</title>
    <link type="text/css" rel="stylesheet" href="assets/register/css/login.css">
    <script type="text/javascript" src="assets/register/js/jquery.min.js"></script>
    <script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
</head>
<body class="login_bj" >

<div class="zhuce_body">
    <div class="zhuce_kong">
        <div class="zc">
            <div class="bj_bai">
                <h3>欢迎注册</h3>
                <form action="" id="form_1" method="get">
                    <input id="id" type="text" class="kuang_txt phone" placeholder="学号">
                    <input id="name" type="text" class="kuang_txt phone" placeholder="姓名">
                    <input id="email" type="text" class="kuang_txt email" placeholder="邮箱">
                    <input id="mobile" type="text" class="kuang_txt yanzm" placeholder="Phone">
                    <input id="college" type="text" class="kuang_txt yanzm" placeholder="二级学院">
                    <input id="classes" type="text" class="kuang_txt yanzm" placeholder="班级">
                    <input id="apartment" type="text" class="kuang_txt yanzm" placeholder="所在宿舍">
                    <input id="password" type="password" class="kuang_txt possword" placeholder="密码">
                    <input name="注册" type="button" class="btn_zhuce" value="注册">
                </form>
            </div>
            <div class="bj_right">
                <p>即将开通以下账号登录，敬请期待</p>
                <a href="#" class="zhuce_qq">QQ注册</a>
                <a href="#" class="zhuce_wb">微博注册</a>
                <a href="#" class="zhuce_wx">微信注册</a>
                <p>已有账号？<a href="shopLogin.html">立即登录</a></p>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript">
    var layer;//定义layui模块

    var checkUser = false;//核验是否通过标志位，默认不通过

    layui.use(['layer'], function(){
        layer = layui.layer;
    });

    $(function (){

        $(".btn_zhuce").click(function () {
            var id = $("#id").val().trim();
            var name = $("#name").val().trim();
            var email = $("#email").val().trim();
            var mobile = $("#mobile").val().trim();
            var college = $("#college").val().trim();
            var classes = $("#classes").val().trim();
            var apartment = $("#apartment").val().trim();
            var password = $("#password").val().trim();
            if(id == '')
            {
                layer.msg("学号不可为空");
            }
            else if(checkUser == false)
            {
                layer.msg("该账号已经存在了，换个吧。");
            }
            else if(name == '')
            {
                layer.msg("姓名不可为空");
            }
            else if(email == '')
            {
                layer.msg("邮箱不可为空");
            }
            else if(mobile == '')
            {
                layer.msg("联系电话不可为空");
            }
            else if(college == '')
            {
                layer.msg("二级学院不可为空");
            }
            else if(classes == '')
            {
                layer.msg("班级不可为空");
            }
            else if(apartment == '')
            {
                layer.msg("所在宿舍不可为空");
            }
            else if(password == '' || password.length < 6)
            {
                layer.msg("密码不可为空,且长度在6位以上");
            }
            else
            {
                var sendData = {
                    id :id,
                    name: name,
                    email :email,
                    mobile :mobile,
                    college :college,
                    classes :classes,
                    apartment:apartment,
                    password:password
                };
                go(sendData);
            }
        });


        $("#id").blur(function () {
            var id = $(this).val().trim();
            if(id != '')
            {
                //执行异步查询
                $.ajax({
                    type: "GET",
                    url: "/api/public/studentExist.yht",
                    data:{id:id},
                    dataType:"json",
                    success: function(data){
                        if(data.code == 2){
                           //没有注册过
                            checkUser = true;
                            return false;
                        }
                        else
                        {
                            //注册过
                            checkUser = false
                            layer.msg("该账号已经存在了，换个吧。");
                        }
                    },
                    error:function(data){
                        checkUser = false
                        layer.msg('查询失败');
                        return false;
                    }
                });
            }
        })
    })

    //注册
    function go(data) {
        $.ajax({
            type: "POST",
            url: "/api/public/studentRegister.yht",
            data:data,
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    document.getElementById("form_1").reset();
                    layer.msg("注册成功，赶紧登录吧");
                    return false;
                }
                else
                {
                    layer.msg(data.msg);
                }
            },
            error:function(data){
                layer.msg('注册失败');
                return false;
            }
        });
    }

</script>
</body>
</html>
