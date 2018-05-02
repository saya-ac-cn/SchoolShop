<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/27
  Time: 0:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>校园便利购</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
    <base href="<%=basePath%>">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="assets/user/amazeui/css/amazeui.min.css"/>
    <link rel="stylesheet" href="assets/user/default/style.css"/>
    <script src="assets/user/amazeui/js/jquery.min.js"></script>
    <script src="assets/user/amazeui/js/amazeui.min.js"></script>
    <script type="text/javascript" src="assets/js/ajaxSetup.js"></script>
</head>
<body>
<div class="container">
    <header data-am-widget="header" class="am-header am-header-default my-header">
        <div class="am-header-left am-header-nav">

        </div>
        <h1 class="am-header-title">
            <a href="#title-link" class="">校园便利购</a>
        </h1>
        <div class="am-header-right am-header-nav">

        </div>
    </header>
    <!-- banner -->
    <div data-am-widget="slider" class="am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}'>
        <ul class="am-slides">
            <li>
                <img src="http://s.amazeui.org/media/i/demos/bing-1.jpg">
            </li>
            <li>
                <img src="http://s.amazeui.org/media/i/demos/bing-2.jpg">
            </li>
            <li>
                <img src="http://s.amazeui.org/media/i/demos/bing-3.jpg">
            </li>
            <li>
                <img src="http://s.amazeui.org/media/i/demos/bing-4.jpg">
            </li>
        </ul>
    </div>
    <div class="am-cf am-g">
        <ul id="goodsList" class="am-avg-sm-2 my-shop-product-list">

        </ul>
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
<script type="text/javascript" src="assets/tools/layer_mobile/layer.js"></script>
<script type="text/javascript">

    $(function (){
        getGoods();
    });


    //获取所有商品
    function getGoods() {
        $.ajax({
            type: "Get",
            url: "/api/public/goods/show.yht",
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    render(data.data);
                    return false;
                }
                else
                {
                    layer.open({
                        content: '没有找到数据信息'
                        ,btn: '我知道了'
                    });
                }
            },
            error:function(data){
                layer.open({
                    content: '获取数据失败'
                    ,btn: '我知道了'
                });
                return false;
            }
        });
    }

    function render(data) {
        var htmlText = "";
        $("#goodsList").html("");//首先清空
        for(var i = 0; i < data.length;i++)
        {
            var item = data[i];
            htmlText += "<li><div class=\"am-panel am-panel-default\"><div class=\"am-panel-bd\">";
            htmlText += "<img onclick='window.location.href=\"/goodsInfo.html?id="+item.id+"\"' class=\"am-img-responsive\" src=\""+item.mainImages+"\" />";
            htmlText += "<h3><a href=\"#\">"+item.name+"</a></h3><div>"
            htmlText += " <span class=\"list-product-price-span\">￥"+item.price+"</span>";
            htmlText += "<span class=\"list-product-commission-span\">库存<br/>"+item.stock+"</span> </div>";
            htmlText += "<hr data-am-widget=\"divider\" style=\"\" class=\"am-divider am-divider-default am-cf\"/><ol class=\"am-avg-sm-3 product-list-share\">";
            if(item.stock > 0)
            {
                htmlText += " <li><a href=\"javascript:buy("+item.id+",1)\" title=\"购买\"><img src=\"assets/user/default/icon1.png\" class=\"am-img-responsive\" /></a></li>";
            }
            else
            {
                htmlText += " <li><a href=\"#\" title=\"购买\"><img src=\"assets/user/default/icon1.png\" class=\"am-img-responsive\" /></a></li>";
            }
            htmlText += " <li><a href=\"javascript:collect("+item.id+")\" title=\"收藏\"><img src=\"assets/user/default/icon3.png\" class=\"am-img-responsive\" /></a></li>";
            htmlText += "</ol></div></div></li>";
        }
        $("#goodsList").html(htmlText);
    }

    //添加到收藏夹
    function collect(id) {
        ajaxSetup();
        $.ajax({
            type: "POST",
            url: "/api/user/collect/add.yht",
            data: {goodsId:id},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    layer.open({
                        content: '收藏成功'
                        ,btn: '我知道了'
                    });
                }
                else {
                    layer.open({
                        content: data.msg
                        ,btn: '我知道了'
                    });
                }
            },
            error: function (data) {
                layer.open({
                    content: '处理失败,请登录'
                    ,btn: '我知道了'
                });
                return false;
            }
        });
    }

    //确定购买，实质上是添加到商品到购物车而已，只是件数为1
    function buy(goodsId,quantity) {
        ajaxSetup();
        $.ajax({
            type: "POST",
            url: "/api/user/cart/add.yht",
            data: {goodsId:goodsId,quantity:quantity},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    // layer.open({
                    //     content: '已添加到购物车'
                    //     ,btn: '我知道了'
                    // });
                    //还要做一个页面的跳转
                    window.location.href = '/view/user/cart.html?id='+data.data;
                }
                else {
                    layer.open({
                        content:data.msg
                        ,btn: '我知道了'
                    });
                }
            },
            error: function (data) {
                layer.open({
                    content:'处理失败'
                    ,btn: '我知道了'
                });
                return false;
            }
        });
    }


</script>
</body>
</html>

