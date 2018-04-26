<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/26
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车</title>
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
            <a href="#left-link" class="">
                <i class="am-header-icon am-icon-chevron-left"></i>
            </a>
        </div>
        <h1 class="am-header-title">
            <a href="#title-link" class="">会员中心</a>
        </h1>
        <div class="am-header-right am-header-nav">
            <a href="#right-link" class="">
                <i class="am-header-icon  am-icon-home"></i>
            </a>
        </div>
    </header>
    <div class="uchome-info">
        <div class="uchome-info-uimg">
            <img src="<%= (String) session.getAttribute("userImg") %>" />
        </div>
        <div class="uchome-info-uinfo">

        </div>
    </div>
    <div class="my-nav-bar">
        <ol class="am-breadcrumb">
            <li><a href="#">首页</a></li>
            <li><a href="#">分类</a></li>
            <li class="am-active">内容</li>
        </ol>
    </div>
    <div class="am-cf cart-panel">
        <div class="cart-list-panel">
            <ul class="am-avg-sm-1 cart-panel-ul">
                <li>
                    <div class="imgpanel"><a href="#"><img src="../../../assets/user/default/img3.jpg" class="am-img-responsive" /></a></div>
                    <div class="infopanel">
                        <h3><a href="#">450ml柔顺丰盈护发素正品</a></h3>
                        <p>品牌：乔治卡罗尔</p>
                        <p>价格：<span class="red2 bold">78.00</span> 元</p>
                        <p>总数：<input class="am-input-sm txt-qty" type="number"  min="1" max="10" value="1" /></p>
                        <p><span class="am-fr"><a class="am-badge am-badge-danger am-round">删除</a></span>库存：<span class="red2 bold">100</span> 件</p>
                    </div>
                </li>
                <li>
                    <div class="imgpanel"><a href="#"><img src="../../../assets/user/default/img3.jpg" class="am-img-responsive" /></a></div>
                    <div class="infopanel">
                        <h3><a href="#">450ml柔顺丰盈护发素正品</a></h3>
                        <p>品牌：乔治卡罗尔</p>
                        <p>价格：<span class="red2 bold">78.00</span> 元  X <input class="am-input-sm txt-qty" type="number" value="1" /></p>
                        <p>积分：<span class="red2 bold">78.00</span></p>
                        <p><span class="am-fr"><a class="am-badge am-badge-danger am-round">删除</a></span>库存：<span class="red2 bold">100</span> 件</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="cart_foot">共选中<span class="red2 bold" id="total_good">{$total}</span>种商品；总价：<span class="red2 bold" id="total_amount">{$price}</span>元；总积分：<span class="red2 bold" id="total_jifen">{$jifen}</span></div>
    <div class="cart-tool">
        <a class="am-btn am-btn-sm am-btn-success" href="#">
            <i class="am-icon-chevron-left"></i>
            返回
        </a>
        <a class="am-btn am-btn-sm am-btn-warning" href="#">
            <i class="am-icon-shopping-cart"></i>
            结账
        </a>
    </div>


    <footer data-am-widget="footer" class="am-footer am-footer-default" data-am-footer="{  }">
        <hr data-am-widget="divider" style="" class="am-divider am-divider-default"/>
        <div class="am-footer-miscs ">
            <p>CopyRight©2018 saya.ac.cn.</p>
            <p>蜀ICP备xxxxx</p>
        </div>
    </footer>
    <!--底部-->
    <div data-am-widget="navbar" class="am-navbar am-cf my-nav-footer " id="">
        <ul class="am-navbar-nav am-cf am-avg-sm-4 my-footer-ul">
            <li>
                <a href="/wap/" class="">
                    <span class="am-icon-home"></span>
                    <span class="am-navbar-label">首页</span>
                </a>
            </li>
            <li>
                <a href="###" class="">
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
                    <span class="am-icon-user"><a href="#">个人资料</a></span>
                    <span class="am-icon-th-list"><a href="#">已选商品</a></span>
                    <span class="am-icon-suitcase"><a href="#">我的订单</a></span>
                    <span class=" am-icon-bank"><a href="#">收货地址</a></span>
                    <span class="am-icon-cog"><a href="#">修改密码</a></span>
                    <span class="am-icon-power-off"><a href="#">退出平台</a></span>
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
</body>
</html>
