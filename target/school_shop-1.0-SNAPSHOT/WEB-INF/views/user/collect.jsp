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
</head>
<body>
<div class="container">
    <header data-am-widget="header" class="am-header am-header-default my-header">
        <div class="am-header-left am-header-nav">

        </div>
        <h1 class="am-header-title">
            <a href="#title-link" class="">我的收藏</a>
        </h1>
        <div class="am-header-right am-header-nav">

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
            <li><a href="#">我的收藏</a></li>
        </ol>
    </div>
    <div class="am-cf cart-panel" id="orderList">

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

        layer.open({
            content: '您确定删除？'
            , btn: ['确定','取消'] //按钮
            ,yes: function(index){
                goDelete(id);
                layer.close(index);
            }
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
                    layer.open({
                        content: '删除成功'
                        ,btn: '我知道了'
                    });
                }
                else {
                    layer.open({
                        content: '删除失败'
                        ,btn: '我知道了'
                    });
                }
            },
            error: function (data) {
                layer.open({
                    content: '处理失败'
                    ,btn: '我知道了'
                });
                return false;
            }
        });
    }

</script>
</body>
</html>
