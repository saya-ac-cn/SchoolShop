<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/27
  Time: 12:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品详情</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="../../../assets/user/amazeui/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../../assets/user/default/style.css"/>
    <script src="../../../assets/user/amazeui/js/jquery.min.js"></script>
    <script src="../../../assets/user/amazeui/js/amazeui.min.js"></script>
    <script type="text/javascript" src="../../../assets/tools/layer_mobile/layer.js"></script>
    <script type="text/javascript" src="../../../assets/js/ajaxSetup.js"></script>
</head>
<body>
<div class="container">
    <header data-am-widget="header" class="am-header am-header-default my-header">
        <div class="am-header-left am-header-nav">
            <a href="/" class="">
                <i class="am-header-icon am-icon-chevron-left"></i>
            </a>
        </div>
        <h1 class="am-header-title">
            <a href="#title-link" class="">商品详情</a>
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

    <div class="gray-panel">
        <div class="paoduct-title-panel">
            <h1 class="product-h1" id="name"></h1>
            <h3 style="font-size: 14px" id="subtitle"></h3>
            <p><span class="am-fr product-title-gray-text" onclick="collect()"><i class="am-icon-star"></i>收藏</span><span class="bold">价格：</span><span class="red2" id="price"></span></p>
        </div>
        <div class="my-search-title-panel">

            <hr data-am-widget="divider" style="" class="am-divider-default am-margin-bottom-sm"/>
            <p class="my-search-titp-p am-text-sm bold" id="mainImages"></p>
            <hr data-am-widget="divider" style="" class="am-divider-default am-margin-bottom-sm"/>
            <p class="my-search-titp-p am-text-sm bold">数量</p>
            <div style="overflow:hidden">
                <form class="am-form-inline" role="form">
                    <button type="button" class="am-btn am-btn-default" style="float:left" onClick="subtractQty();" ><i class="am-icon-minus"></i></button>
                    <input type="number" name="txtQty" id="txtQty" class="am-form-field txt-qty am-text-center am-text-sm" value="1" style=" width:60px; margin-right:0px; height:37px; display:inline; float:left">
                    <button type="button" class="am-btn am-btn-default" style="float:left" onClick="addQty();"><i class="am-icon-plus"></i></button>
                </form>
            </div>
            <hr data-am-widget="divider" style="" class="am-divider-default am-margin-bottom-sm"/>
            <div>
                <ul class="am-avg-sm-2 am-text-center">
                    <li class="am-text-center am-padding-sm"><button type="button" onclick="addCart()" class="am-btn am-btn-success am-btn-block am-radius">加入购物车</button></li>
                    <li class="am-text-center am-padding-sm"><button type="button" onclick="buy()" class="am-btn am-btn-danger am-btn-block am-radius">立即购买</button></li>
                </ul>
            </div>
        </div>
        <div class="paoduct-title-panel">
            <h2 class="product-h1" id="shopName"></h2>
            <p><span class="am-fr product-title-gray-text"></span><span class="product-title-gray-text" id="location"></span></p>
            <hr data-am-widget="divider" style="" class="am-divider-default am-margin-bottom-sm"/>
        </div>
    </div>
    <!-- 商品详情 -->

    <div data-am-widget="tabs" class="am-tabs am-tabs-d2">
        <ul class="am-tabs-nav am-cf">
            <li class="am-active">
                <a href="[data-tab-panel-0]">详情</a>
            </li>
        </ul>
        <div class="am-tabs-bd">
            <div data-tab-panel-0 class="am-tab-panel am-active" id="detail"></div>
        </div>
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
</body>
<script type="text/javascript">

    var stock;

    function checkIsInteger(str)
    {
        //如果为空，则通过校验
        if(str == "")
            return true;
        if(/^(\-?)(\d+)$/.test(str))
            return true;
        else
            return false;
    }
    var errordialog=function(c){
        alert(c)
    }
    //检验商品数量
    function checkCounts(id) {
        var Counts = $("#" + id).val();
        if (Counts == "") {
            errordialog("请填写数量!");
            return false;
        }
        else if (!checkIsInteger(Counts)) {
            errordialog("商品数量不是整数!");
            return false;
        }
        else if (Counts < 1) {
            errordialog("商品数量不能小于1!");
            return false;
        }
        else if (Counts > stock) {
            errordialog("商品数量不能大于库存数!");
            return false;
        }
        else {
            return true;
        }
    }

    //加
    function addQty(){
        checkCounts('txtQty');
        var qty = parseInt($('#txtQty').val());
        if(qty >= stock){
            errordialog("商品数量不能大于库存数!");
            return;
        }
        $('#txtQty').val(qty+1);
    }

    //减
    function subtractQty(){
        checkCounts('txtQty');
        var qty = parseInt($('#txtQty').val());
        if(qty <=1){
            errordialog("商品数量不能小于1");
            return;
        }
        $('#txtQty').val(qty-1);
    }

    var id = '';

    $(function (){
        id = decodeURI(geturldata("id"));
        getGoods(id);
    });

    //获取商品详情
    function getGoods() {
        $.ajax({
            type: "Get",
            url: "/api/public/goods/info.yht?id="+id,
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    $("#name").text(data.data[0].name);
                    $("#subtitle").text(data.data[0].subtitle);
                    $("#price").text("￥"+data.data[0].price);
                    $("#mainImages").html("<img src=\""+data.data[0].mainImages+"\" class=\"am-img-responsive\" style='width: 8em;height:auto' />");
                    $("#shopName").text(data.data[0].shopName);
                    $("#location").html("<i class=\"am-icon-crosshairs\"></i>"+data.data[0].location);
                    $("#detail").html(data.data[0].detail);
                    stock = data.data[0].stock;
                    return false;
                }
                else
                {
                    layer.open({
                        content: '没有找到商品数据信息'
                        ,btn: '我知道了'
                    });
                }
            },
            error:function(data){
                layer.open({
                    content: '获取商品数据失败'
                    ,btn: '我知道了'
                });
                return false;
            }
        });
    }

    function geturldata(variable) //eg:abc.html?id=123&type=1。使用geturldata("id")将取得123，使用type将取得1
    {
        var query=window.location.search.substr(1);
        var vars=query.split("&")
        for(var i=0;i<vars.length;i++)
        {
            var pair=vars[i].split("=");
            if(pair[0]==variable)
                return pair[1];
        }
        return null;
    }

    //添加到收藏夹
    function collect() {
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
                        content:data.msg
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

    //加入购物车
    function addCart() {
        ajaxSetup();
        $.ajax({
            type: "POST",
            url: "/api/user/cart/add.yht",
            data: {goodsId:id,quantity:$('#txtQty').val()},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    layer.open({
                        content: '已添加到购物车'
                        ,btn: '我知道了'
                    });
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

    //购买
    //购买成功后，还要跳转到购物车页面
    function buy() {
        ajaxSetup();
        $.ajax({
            type: "POST",
            url: "/api/user/cart/add.yht",
            data: {goodsId:id,quantity:$('#txtQty').val()},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
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
</html>
