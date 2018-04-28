<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/25
  Time: 21:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>确认支付</title>
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
            <li><a href="#">团购</a></li>
        </ol>
    </div>
    <div class="am-cf cart-panel" id="orderList">

    </div>
    <div class="am-cf cart-panel">
        <div class="cart_foot">共<span class="red2 bold" id="total_good"></span>件商品；总价：<span class="red2 bold" id="total_amount">{$price}</span>元</div>
        <div class="cart-tool">
            <a class="am-btn am-btn-sm am-btn-success am-radius" href="../../../assets/user/shoppingcart.html">
                <i class="am-icon-chevron-left"></i>
                返回购物车
            </a>
        </div>
        <div class="my-search-title-panel am-text-sm am-margin-bottom-sm"><i class="am-icon-lightbulb-o am-text-danger"></i> 提示：请用户选择自己收获方便的地址，可以选择到摊位自取的方式。</div>
        <div class="paoduct-title-panel">
            <h2 class="checkout-h2"><span class="am-badge am-round am-badge-warning ">2</span> 确认收货地址</h2>
            <ul class="am-list am-text-sm my-pay-ul" id="addressList">
                <li>12 <input type="radio" class="am-fr" value="" name="address"></li>
            </ul>
        </div>
        <div class="paoduct-title-panel">
            <h2 class="checkout-h2"><span class="am-badge am-round am-badge-warning ">3</span> 支付方式</h2>
            <ul class="am-list am-text-sm my-pay-ul">
                <li><a href="javascript:;" rel="1" class="hover"><span class="am-fr"><i class="am-icon-check-circle"></i>&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../../assets/user/default/wechat.png" class="payimg" />&nbsp;&nbsp;&nbsp;&nbsp;微信支付</a></li>
                <li><a href="javascript:;" rel="2"><span class="am-fr"><i class="am-icon-circle-thin"></i>&nbsp;&nbsp;</span><img src="../../../assets/user/default/alipay.png" class="payimg" /> 支付宝支付</a></li>
                <li><a href="javascript:;" rel="3"><span class="am-fr"><i class="am-icon-circle-thin"></i>&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../../assets/user/default/money.png" class="payimg" />&nbsp;&nbsp;&nbsp;&nbsp;余额支付 &nbsp;&nbsp; <samll class="my-pay-yue">余额：<span class="red2" id="money"></span>  &nbsp;&nbsp;<span onClick="window.location.href='#'" class="red2">充值</span></samll></a></li>
            </ul>
            <script>
                $(document).ready(function(e) {
                    $(".my-pay-ul li > a").click(function(){
                        $(".my-pay-ul li > a").removeClass('hover');
                        $(".my-pay-ul li > a i").removeClass('am-icon-check-circle').addClass('am-icon-circle-thin');
                        $(this).addClass('hover');
                        var val = $(this).attr('rel');
                        $("#paytype").val(val);
                        $(this).find('i').removeClass('am-icon-circle-thin').addClass('am-icon-check-circle');
                    });
                });
            </script>
            <div>
                <ul class="am-avg-sm-2 am-text-center">
                    <li class="am-text-center am-padding-sm"><button type="button" onclick="goBuy()" class="am-btn am-btn-danger am-btn-block am-radius">提交订单</button></li>
                    <li class="am-text-center am-padding-sm"><button type="button" class="am-btn am-btn-success am-btn-block am-radius">继续购物</button></li>
                </ul>
            </div>
        </div>
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
<script type="text/javascript">
    var layer;//定义layui模块

    layui.use(['layer'], function(){
        layer = layui.layer;
    });

    $(function (){
        id = decodeURI(geturldata("id"));//父订单号
        getOrder({orderId:6,status:"2"});
        getAddress();
        getMoney()
    });


    //获取余额
    function getMoney() {
        $.ajax({
            type: "Get",
            url: "/api/user/getMoney.yht",
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    $("#money").text(data.data);
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

    //获取所有订单
    function getOrder(data) {
        $.ajax({
            type: "Get",
            url: "/api/user/order/total.yht",
            dataType:"json",
            data:data,
            success: function(data){
                if(data.code == 0){
                    render(data.data);
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

    function render(data) {
        var htmlText = "";
        $("#orderList").html("");//首先清空
        $("#total_good").text(data.length);
        var totalPrice = 0;//总价
        for(var i = 0; i < data.length;i++)
        {
            var item = data[i];
            htmlText += " <div class=\"withdrawals-panel\">";
            htmlText += "<p class=\"groupby-t-p\">订单号："+item.orderId+"</p>";
            htmlText += "<hr  class=\"am-divider am-divider-default am-cf\"/>";
            htmlText += "<div class=\"groupby-img-panle\"><a href=\"#\"><img src=\""+item.imgUrl+"\" class=\"am-img-responsive\" /></a></div>";
            htmlText += "<div class=\"groupby-info-panle\">"
            htmlText += " <h3><a href=\"#\">"+item.goodsName+"</a></h3>"
            htmlText += "<p>总价：<span class=\"red2 bold\">"+item.totalPrice+"</span> 元 &nbsp; &nbsp;&nbsp;  数量：<span class=\"am-text-success\">"+item.quantity+"</span></p>"
            htmlText += "  <p>商家："+item.shopName+"</p>"
            if(item.status == "1")
            {
                htmlText += "<p>状态：<span class=\"am-text-success\">已付款</span></p>";
            }
            else
            {
                htmlText += "<p>状态：<span class=\"am-text-success\">未付款</span></p>";
            }
            htmlText += " </div> </div>";
            totalPrice += item.totalPrice;
        }
        $("#total_amount").text(totalPrice);
        $("#orderList").html(htmlText);
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

    //获取收货地址
    function getAddress() {
        $.ajax({
            type: "Get",
            url: "/api/user/address/get.yht",
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    renderAddress(data.data);
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

    function goBuy() {
        var address = $('input[name="address"]:checked').val();
        var sendData;//发送的数据
        if(address == -1 || address == '-1')
        {
            sendData = {
                id:id
            }
        }
        else
        {
            sendData = {
                id:id,
                userAddres:address
            }
        }
        $.ajax({
            type: "POST",
            url: "/api/user/buy.yht",
            dataType:"json",
            data:sendData,
            success: function(data){
                if(data.code == 0){
                    layer.msg("支付成功");
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
        return false;
    }

    function renderAddress(data) {
        var htmlText = "";
        $("#addressList").html("");//首先清空
        htmlText += " <li>摊位自取 <input type=\"radio\" class=\"am-fr\" value=\"-1\" checked=\"checked\" name=\"address\"></li>"
        for(var i = 0; i < data.length;i++)
        {
            var item = data[i];
            htmlText += "<li>"+item.name+"&nbsp;&nbsp;&nbsp;"+item.address+"("+item.mobil+")<input type=\"radio\" class=\"am-fr\" value=\""+item.id+"\" name=\"address\"></li>";
        }
        $("#addressList").html(htmlText);
    }

</script>
</body>
</html>
