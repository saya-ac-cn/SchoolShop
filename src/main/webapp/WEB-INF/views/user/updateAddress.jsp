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
    <title>修改收货地址</title>
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
            <a href="#title-link" class="">修改收货地址</a>
        </h1>
        <div class="am-header-right am-header-nav">
            <button type="button" onclick="deleteData()"  class="am-btn am-btn-secondary">删除</button>
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
        <p class="am-text-center"><button type="button" onclick="goSave()" class="am-btn am-btn-danger am-radius">确认修改</button></p>
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
        getAddress(id);
    });

    function goSave() {
        var name = $("#name").val();
        var phone = $("#phone").val();
        var mobil= $("#mobil").val();
        var address= $("#address").val();
        if(name == '')
        {
            layer.msg("收件人姓名不可为空");
        }
        else if(mobil == '')
        {
            layer.msg("联系电话不可为空");
        }
        else if(address == '')
        {
            layer.msg("收件人地址不可为空");
        }
        else
        {
            var sendData = {
                id:id,
                name :name,
                phone :phone,
                mobil:mobil,
                address:address
            }
            goSend(sendData);
        }
    }

    //修改
    function goSend(data) {
        $.ajax({
            type: "Put",
            url: "/api/user/address/update.yht",
            dataType:"json",
            data:data,
            success: function(data){
                if(data.code == 0){
                    layer.msg("修改成功");
                    return false;
                }
                else
                {
                    layer.msg("修改失败");
                }
            },
            error:function(data){
                layer.msg('操作超时');
                return false;
            }
        });
    }

    //获取收货地址
    function getAddress(id) {
        $.ajax({
            type: "Get",
            url: "/api/user/address/get.yht?id="+id,
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                   var item = data.data[0];
                    $("#name").val(item.name);
                    $("#phone").val(item.phone);
                    $("#mobil").val(item.mobil);
                    $("#address").val(item.address);
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

    //删除事件
    function deleteData()
    {
        layer.confirm('您确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(index){
            $.ajax({
                type: "Delete",
                url: "/api/user/address/dell.yht?id="+id,
                dataType:"json",
                success: function(data){
                    if(data.code == 0){
                        layer.msg("删除成功");
                        window.location.href='/view/user/address.html';
                        return false;
                    }
                    else
                    {
                        layer.msg("删除失败");
                    }
                },
                error:function(data){
                    layer.msg('删除失败');
                    return false;
                }
            });
        });
    }
</script>
</body>
</html>

