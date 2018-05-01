<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/24
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>会员中心</title>
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

        </div>
        <h1 class="am-header-title">
            <a href="#title-link" class="">会员中心</a>
        </h1>
        <div class="am-header-right am-header-nav">

        </div>
    </header>
    <div class="uchome-info">
        <div class="uchome-info-uimg">
            <img src="<%= (String) session.getAttribute("userImg") %>" />
        </div>
    </div>

    <div class="am-cf uchome-apps">
        <ul class="am-avg-sm-3 uchome-apps-ul">
            <li><a href="/view/user/order.html"><p class="imgp"><img src="../../../assets/user/default/uhomeapp1.png" class="am-img-responsive" /></p><p class="namep">我的订单</p><p class="lastp"  id="order"></p></a></li>
            <li><a href="/view/user/cart.html"><p class="imgp"><img src="../../../assets/user/default/uhomeapp4.png" class="am-img-responsive" /></p><p class="namep">购物车</p><p class="lastp" id="cart"></p></a></li>
            <li><a href="/view/user/collect.html"><p class="imgp"><img src="../../../assets/user/default/uhomeapp7.png" class="am-img-responsive" /></p><p class="namep" >收藏商品</p><p class="lastp" id="collect"></p></a></li>
            <li><a href="/view/user/address.html"><p class="imgp"><img src="../../../assets/user/default/uhomeapp2.png" class="am-img-responsive" /></p><p class="namep" >收货地址</p><p class="lastp" id="address"></p></a></li>
            <li><a href="#"><p class="imgp"><img src="../../../assets/user/default/uhomeapp6.png" class="am-img-responsive" /></p><p class="namep" >我的钱包</p><p class="lastp" id="money"></p></a></li>
            <li><a href="/view/user/userInfo.html"><p class="imgp"><img src="../../../assets/user/default/uhomeapp11.png" class="am-img-responsive" /></p><p class="namep">个人信息</p><p class="lastp">管理</p></a></li>
            <li><a href="/news.html"><p class="imgp"><img src="../../../assets/user/default/uhomeapp12.png" class="am-img-responsive" /></p><p class="namep">系统消息</p><p class="lastp"></p></a></li>
        </ul>

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
                    <span class="am-icon-power-off"><a href="userLogout.html">退出平台</a></span>
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
<script type="text/javascript">
    var layer;//定义layui模块

    layui.use(['layer'], function(){
        layer = layui.layer;
    });

    $(function (){
        getTotal();
    });


    //获取数据总览
    function getTotal() {
        $.ajax({
            type: "Get",
            url: "/api/user/index/total.yht",
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    $("#address").text(data.data.address+"条");
                    $("#money").text("￥"+data.data.money);
                    $("#collect").text(data.data.collect+"条");
                    $("#cart").text(data.data.cart+"件");
                    $("#order").text(data.data.order+"笔");
                    return false;
                }
                else
                {
                    layer.msg("没有找到数据信息");
                }
            },
            error:function(data){
                layer.msg('获取数据失败');
                return false;
            }
        });
    }

</script>
</body>
</html>
