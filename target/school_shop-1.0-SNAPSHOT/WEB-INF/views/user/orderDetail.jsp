<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/25
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>订单详情</title>
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
            <a href="#title-link" class="">订单快照</a>
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
            <li><a href="#">提现</a></li>
        </ol>
    </div>

    <div class="cart-panel">
        <ul class="am-list am-list-static am-list-border">
            <li><p><span class="am-fr red2 bold" id="address"></span>收货地址</p></li>
            <li><p><span class="am-fr red2 bold" id="goodsName"></span>商品名</p></li>
            <li><p><span class="am-fr red2 bold" id="totalPrice"></span>总价</p></li>
            <li><p><span class="am-fr red2 bold" id="payment"></span>实付</p></li>
            <li><p><span class="am-fr red2 bold" id="orderId"></span>订单编号</p></li>
            <li><p><span class="am-fr red2 bold" id="createTime"></span>创建时间</p></li>
            <li><p><span class="am-fr red2 bold" id="payTime"></span>支付时间</p></li>
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
    var id = '';
    layui.use(['layer'], function(){
        layer = layui.layer;
    });

    $(function (){
        id = decodeURI(geturldata("id"));
        getOrder(id);
    });


    //获取所有订单
    function getOrder() {
        $.ajax({
            type: "Get",
            url: "/api/user/order/total.yht",
            dataType:"json",
            data:{orderId:id},
            success: function(data){
                if(data.code == 0){
                    var item = data.data[0];
                    if(item.status == "1")
                    {
                        $("#payTime").text(item.payTime);
                        $("#payment").text("￥"+item.payment);
                    }
                    $("#address").text(item.address);
                    $("#goodsName").text(item.goodsName);
                    $("#totalPrice").text("￥"+item.totalPrice);
                    $("#address").text(item.address);
                    $("#orderId").text(item.orderId);
                    $("#createTime").text(item.createTime);

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

</script>
</body>
</html>

