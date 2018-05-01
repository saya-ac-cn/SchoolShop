<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/25
  Time: 13:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>添加收货地址</title>
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
            <a href="#title-link" class="">添加收货地址</a>
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
            <li><a href="#">添加收货地址</a></li>
        </ol>
    </div>

    <div class="cart-panel">
        <div class="am-form-group am-form-icon">
            <i class="am-icon-user" style="color:#329cd9"></i>
            <input type="text" id="name" class="am-form-field  my-radius" placeholder="收件人">
        </div>
        <div class="am-form-group am-form-icon">
            <i class="am-icon-phone" style="color:#f09513"></i>
            <input type="text" id="phone" class="am-form-field  my-radius" placeholder="请输入联系电话(固话)">
        </div>
        <div class="am-form-group am-form-icon">
            <i class="am-icon-phone" style="color:#f09513"></i>
            <input type="text" id="mobil" class="am-form-field  my-radius" placeholder="请输入联系电话">
        </div>
        <div class="am-form-group am-form-icon">
            <i class="am-icon-home" style="color:#e9c740"></i>
            <input type="text" id="address" class="am-form-field  my-radius" placeholder="请输入收货地址">
        </div>
        <div class="am-checkbox">
            <label>
                每位用户最多可以添加5条记录
            </label>
        </div>
        <p class="am-text-center"><button type="button" onclick="goSave()" class="am-btn am-btn-danger am-radius">确认添加</button></p>
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
    function goSave() {
        var name = $("#name").val();
        var phone = $("#phone").val();
        var mobil= $("#mobil").val();
        var address= $("#address").val();
        if(name == '')
        {
            layer.open({
                content: '收件人姓名不可为空'
                ,btn: '我知道了'
            });
        }
        else if(mobil == '')
        {
            layer.open({
                content: '联系电话不可为空'
                ,btn: '我知道了'
            });
        }
        else if(address == '')
        {
            layer.open({
                content: '收件人地址不可为空'
                ,btn: '我知道了'
            });
        }
        else
        {
            var sendData = {
                name :name,
                phone :phone,
                mobil:mobil,
                address:address
            }
            goSend(sendData);
        }
    }

    //添加
    function goSend(data) {
        $.ajax({
            type: "Post",
            url: "/api/user/address/add.yht",
            dataType:"json",
            data:data,
            success: function(data){
                if(data.code == 0){
                    layer.open({
                        content: '修改成功'
                        ,btn: '我知道了'
                    });
                    return false;
                }
                else
                {
                    layer.open({
                        content: '修改失败'
                        ,btn: '我知道了'
                    });
                }
            },
            error:function(data){
                layer.open({
                    content: '操作超时'
                    ,btn: '我知道了'
                });
                return false;
            }
        });
    }

</script>
</body>
</html>
