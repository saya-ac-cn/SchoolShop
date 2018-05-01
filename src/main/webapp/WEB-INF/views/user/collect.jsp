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
    <title>我的收藏</title>
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
        getCollect();
    });


    //获取所有收藏
    function getCollect() {
        $.ajax({
            type: "Get",
            url: "/api/user/collect/get.yht",
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    render(data.data);
                    console.log(data.dat);
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
        for(var i = 0; i < data.length;i++)
        {
            var item = data[i];
            htmlText += " <div class=\"withdrawals-panel\">";
            htmlText += "<div class=\"groupby-img-panle\"><a href=\"#\"><img src=\""+item.Goods.mainImages+"\" class=\"am-img-responsive\" /></a></div>";
            htmlText += "<div class=\"groupby-info-panle\">"
            htmlText += " <h3><a href=\"#\">"+item.Goods.name+"</a></h3>"
            htmlText += "<p>"+item.Goods.subtitle+"</p>"
            htmlText += "<p>单价：<span class=\"am-text-success\">"+item.Goods.price+"</span></p>";
            htmlText += " <p> <a href=\"javascript:deleteCollect("+item.id+")\" class=\"am-btn am-btn-primary am-btn-xs am-btn-danger am-radius\">取消收藏</a></p>"
            htmlText += " </div> </div>";
        }
        $("#orderList").html(htmlText);
    }

    function deleteCollect(id) {
        layer.confirm('您确定取消？', {
            btn: ['确定','取消'] //按钮
        }, function(index){
            goDelete(id);
            layer.close(index);
        });
    }

    //删除动态
    function goDelete(id) {
        $.ajax({
            type: "POST",
            url: "/api/user/collect/delete.yht?id="+id,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    getCollect();
                    layer.msg("删除成功");
                }
                else {
                    layer.msg("删除失败");
                }
            },
            error: function (data) {
                layer.msg('处理失败');
                return false;
            }
        });
    }

</script>
</body>
</html>
