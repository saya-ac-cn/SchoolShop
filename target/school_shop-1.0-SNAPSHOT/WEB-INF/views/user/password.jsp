<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/24
  Time: 23:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="../../../assets/user/amazeui/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../assets/user/default/style.css"/>
    <script src="../../../assets/user/amazeui/js/jquery.min.js"></script>
    <script src="../../../assets/user/amazeui/js/amazeui.min.js"></script>
    <script type="text/javascript" src="../../../assets/tools/layui-v2.2.6/layui.js"></script>
</head>

<body>
<div class="container">
    <header data-am-widget="header" class="am-header am-header-default my-header">
        <div class="am-header-left am-header-nav">
            <a href="/view/user/" class="">
                <i class="am-header-icon am-icon-chevron-left"></i>
            </a>
        </div>
        <h1 class="am-header-title">
            <a href="#title-link" class="">修改密码</a>
        </h1>
        <div class="am-header-right am-header-nav">
            <button type="button" onclick="gosave()" class="am-btn am-btn-secondary">确定</button>
        </div>
    </header>
    <div class="uchome-info">
        <div class="uchome-info-uimg">
            <img src="<%= (String) session.getAttribute("userImg") %>" />
        </div>
    </div>
    <div class="cart-panel" style="padding-top: 4em;padding-bottom: 2em">
        <form class="am-form">
            <div class="am-form-group am-form-icon">
                <i class="am-icon-lock" style="color:#329cd9"></i>
                <input type="password" id="password1" class="am-form-field  my-radius" placeholder="请输入您的密码">
            </div>
            <div class="am-form-group am-form-icon">
                <i class="am-icon-lock" style="color:#329cd9"></i>
                <input type="password" id="password2" class="am-form-field  my-radius" placeholder="请再次输入您的密码">
            </div>
            <div class="am-comment-bd" style="font-size: 12px">
               密码必须是6位以上的字符构成
            </div>
        </form>
    </div>


    <footer data-am-widget="footer" class="am-footer am-footer-default" data-am-footer="{  }">
        <hr data-am-widget="divider" style="" class="am-divider am-divider-default"/>
        <div class="am-footer-miscs ">
            <p>CopyRight© <script>document.write(new Date().getFullYear())</script>saya.ac.cn.</p>
            <p>蜀ICP备16013222-2号</p>
        </div>
    </footer>
    <!--底部-->
    <div data-am-widget="navbar" class="am-navbar am-cf my-nav-footer " id="">
        <ul class="am-navbar-nav am-cf am-avg-sm-4 my-footer-ul">
            <li>
                <a href="/" class="">
                    <span class="am-icon-home"></span>
                    <span class="am-navbar-label">首页</span>
                </a>
            </li>
            <li>
                <a href="/news.html" class="">
                    <span class="am-icon-th-list"></span>
                    <span class="am-navbar-label">资讯</span>
                </a>
            </li>
            </li>
            <li style="position:relative">
                <a href="javascript:;" onClick="showFooterNav();" class="">
                    <span class="am-icon-user"></span>
                    <span class="am-navbar-label">我的</span>
                </a>
                <div class="footer-nav" id="footNav">
                    <span class="am-icon-user"><a href="/view/user/userInfo.html">个人资料</a></span>
                    <span class="am-icon-th-list"><a href="/view/user/cart.html">已选商品</a></span>
                    <span class="am-icon-suitcase"><a href="/view/user/order.html">我的订单</a></span>
                    <span class=" am-icon-bank"><a href="/view/user/address.html">收货地址</a></span>
                    <span class="am-icon-cog"><a href="/view/user/userInfo.html">修改密码</a></span>
                    <span class="am-icon-power-off"><a href="/userLogout.html">退出平台</a></span>
                </div>
            </li>
        </ul>
        <script>
            function showFooterNav(){
                $("#footNav").toggle();
            }
        </script>
    </div>
</div>
<script type="text/javascript" src="../../../assets/tools/layer_mobile/layer.js"></script>
<script type="text/javascript">

    function gosave() {
        var password1 = $("#password1").val().trim();
        var password2 = $("#password2").val().trim();
        if(password1 == '' || password2 == '' || password1.length < 6 || password2.length < 6)
        {
            layer.open({
                content: '密码不可为空且长度在6位以上'
                ,btn: '我知道了'
            });
        }
        else if(password1 != password2)
        {
            layer.open({
                content: '两次输入的密码必须一致'
                ,btn: '我知道了'
            });
        }
        else
        {
            $.ajax({
                type: "PUT",
                url: "/api/user/updateUserInfo.yht",
                data:{password:password2},
                dataType:"json",
                success: function(data){
                    if(data.code == 0){
                        layer.open({
                            content: '修改成功'
                            ,btn: '我知道了'
                        });
                        return false;
                    }
                    else
                    {
                        layer.open({
                            content: data.msg
                            ,btn: '我知道了'
                        });
                        layer.msg();
                    }
                },
                error:function(data){
                    layer.open({
                        content: '修改失败'
                        ,btn: '我知道了'
                    });
                    return false;
                }
            });
        }
    }
</script>
</body>
</html>

