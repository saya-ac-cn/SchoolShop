<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/25
  Time: 13:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>管理收货地址</title>
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
            <a href="#title-link" class="">收货地址</a>
        </h1>
        <div class="am-header-right am-header-nav">
            <button type="button" onclick="javascript:window.location.href='/view/user/addAddress.html'"  class="am-btn am-btn-secondary">添加</button>
        </div>
    </header>
    <div class="uchome-info">
        <div class="uchome-info-uimg">
            <img src="../../../assets/user/default/img1.jpg" />
        </div>
        <div class="uchome-info-uinfo">

        </div>
    </div>
    <div class="my-nav-bar">
        <ol class="am-breadcrumb">
            <li><a href="#">首页</a></li>
            <li><a href="#">升级为商家</a></li>
        </ol>
    </div>
    <div class="am-panel am-panel-default">
        <div class="am-panel-hd">
            收货地址管理
        </div>
        <div class="am-panel-bd" id="addressList">

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
        getAddress();
    });


    //获取收货地址
    function getAddress() {
        $.ajax({
            type: "Get",
            url: "/api/user/address/get.yht",
            dataType:"json",
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
        $("#addressList").html("");//首先清空
        for(var i = 0; i < data.length;i++)
        {
            var item = data[i];
            htmlText += " <div class=\"partners-title-panel\">";
            htmlText += " <div class=\"partners-title-panel-title\"><span onclick='myhref("+item.id+")' class=\"am-fr\">管理</span>"+item.address+"</div>";
            htmlText += "</div>";
        }
        $("#addressList").html(htmlText);
    }

    function myhref(id) {
        window.location.href = "/view/user/updateAddress.html?id="+id;
    }
</script>
</body>
</html>
