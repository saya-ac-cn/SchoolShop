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
    <script type="text/javascript" src="../../../assets/js/ajaxSetup.js"></script>
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
            <a href="#title-link" class="">校园便利购</a>
        </h1>
        <div class="am-header-right am-header-nav">
            <a href="#right-link" class="">
                <i class="am-header-icon  am-icon-home"></i>
            </a>
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
            <li>
                <div class="am-panel am-panel-default">
                    <div class="am-panel-bd">
                        <img class="am-img-responsive" src="../../../assets/user/default/img2.jpg" />
                        <h3><a href="#">电蟒原装智能遥控器</a></h3>
                        <div>
                            <span class="list-product-price-span">￥89.00</span>
                            <span class="list-product-commission-span">库存<br/>2</span>
                        </div>
                        <hr data-am-widget="divider" style="" class="am-divider am-divider-default am-cf"/>
                        <ol class="am-avg-sm-3 product-list-share">
                            <li><a href="#" title="购买"><img src="../../../assets/user/default/icon1.png" class="am-img-responsive" /></a></li>
                            <li><a href="#" title="收藏"><img src="../../../assets/user/default/icon3.png" class="am-img-responsive" /></a></li>
                        </ol>
                    </div>
                </div>
            </li>
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

    layui.use(['layer'], function(){
        layer = layui.layer;
    });

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
        $("#goodsList").html("");//首先清空
        for(var i = 0; i < data.length;i++)
        {
            var item = data[i];
            htmlText += "<li><div class=\"am-panel am-panel-default\"><div class=\"am-panel-bd\">";
            htmlText += "<img class=\"am-img-responsive\" src=\""+item.mainImages+"\" />";
            htmlText += "<h3><a href=\"#\">"+item.name+"</a></h3><div>"
            htmlText += " <span class=\"list-product-price-span\">￥"+item.price+"</span>";
            htmlText += "<span class=\"list-product-commission-span\">库存<br/>"+item.stock+"</span> </div>";
            htmlText += "<hr data-am-widget=\"divider\" style=\"\" class=\"am-divider am-divider-default am-cf\"/><ol class=\"am-avg-sm-3 product-list-share\">";
            htmlText += " <li><a href=\"#\" title=\"购买\"><img src=\"../../../assets/user/default/icon1.png\" class=\"am-img-responsive\" /></a></li>";
            htmlText += " <li><a href=\"javascript:collect("+item.id+")\" title=\"收藏\"><img src=\"../../../assets/user/default/icon3.png\" class=\"am-img-responsive\" /></a></li>";
            htmlText += "</ol></div></div></li>";
        }
        $("#goodsList").html(htmlText);
    }

    function deleteOrder(id) {
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
            url: "/api/user/order/delete/"+id,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    getOrder();
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
                    alert("收藏成功");
                }
                else {
                    layer.msg(data.msg);
                }
            },
            error: function (data) {
                alert('处理失败');
                return false;
            }
        });
    }


</script>
</body>
</html>

