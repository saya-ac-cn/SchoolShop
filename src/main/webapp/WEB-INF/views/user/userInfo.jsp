<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/26
  Time: 22:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改个人信息</title>
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
    <script type="text/javascript" src="../../../assets/tools/layer_mobile/layer.js"></script>
</head>
<body>
<div class="container">
    <header data-am-widget="header" class="am-header am-header-default my-header">
        <div class="am-header-left am-header-nav">
            <a href="/view/user/" class="">
                <i class="am-header-icon am-icon-chevron-left"></i>
            </a>
        </div>
        <h1 class="am-header-title">
            <a href="#title-link" class="">会员中心</a>
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
            <li><a href="#">用户中心</a></li>
        </ol>
    </div>

    <div class="cart-panel">
        <div class="am-form-group am-form-icon">
            <i class="am-icon-envelope" style="color:#e9c740"></i>
            <input type="text" id="email" class="am-form-field  my-radius" placeholder="请输入邮箱号码">
        </div>
        <div class="am-form-group am-form-icon">
            <i class="am-icon-phone" style="color:#f09513"></i>
            <input type="text" id="phone" class="am-form-field  my-radius" placeholder="请输入联系电话">
        </div>
        <div class="am-form-group am-form-icon">
            <i class="am-icon-calendar" style="color:#329cd9"></i>
            <input type="text" id="birthday" class="am-form-field  my-radius" placeholder="请选择生日">
        </div>
        <div class="am-form-group am-form-file">
            <div>
                <button type="button" id="test1" class="am-btn am-btn-default am-btn-sm">
                    <i class="am-icon-credit-card" style="color:#78c3ca"></i> 上传logo</button>
                    <div class="layui-upload-list">
                        <p id="demoText"></p>
                    </div>
            </div>
        </div>
        <div class="am-form-group am-form-icon">
            <label class="am-radio-inline">
                <input type="radio"  value="男" name="sex">男
            </label>
            <label class="am-radio-inline">
                <input type="radio" value="女" name="sex"> 女
            </label>
        </div>
        <div class="am-form-group am-form-icon">
            <i class="am-icon-bookmark" style="color:#f09513"></i>
            <input type="text" id="question"  class="am-form-field  my-radius" placeholder="设置密码保护问题">
        </div>
        <div class="am-form-group">
            <textarea class="my-radius" id="answer" style="width: 100%" rows="5" id="doc-ta-1" placeholder="输入您的答案"></textarea>
        </div>
        <p class="am-text-center"><button type="button" onclick="goSave()" class="am-btn am-btn-danger am-radius">确认修改</button></p>
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
<script type="text/javascript">
    var birthday;//生日

    layui.use(['upload','laydate'], function(){
        upload = layui.upload;
        laydate = layui.laydate;


        //日期范围选择
        laydate.render({
            elem: '#birthday'
            ,change: function(value, date, endDate){
                birthday = date.year+"-"+date.month+"-"+date.date;
            }
        });

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '/api/user/logo/upload.yht'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    //$('#logo').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code = 0){
                    return layer.open({
                        content: '上传失败'
                        ,btn: '我知道了'
                    });
                }
                else
                {
                    return layer.open({
                        content: res.msg
                        ,btn: '我知道了'
                    });
                }
                //上传成功
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });

    });

    $(function (){
        getMyinfo();
    });


    //获取个人信息
    function getMyinfo() {
        $.ajax({
            type: "Get",
            url: "/api/user/index/info.yht",
            dataType:"json",
            success: function(data){
                if(data.code == 0){
                    render(data.data);
                    console.log(data.data);
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
        $("#email").val(data.email);
        $("#phone").val(data.phone);
        $("#birthday").val(data.birthday);
        birthday = data.birthday;
        $("#question").val(data.question);
        $("#answer").val(data.answer);
        if(data.sex == '男')
         $("input:radio[value='男']").attr('checked','true');
        if(data.sex == '女')
            $("input:radio[value='女']").attr('checked','true');
    }


    function goSave() {
       var email = $("#email").val();
       var phone= $("#phone").val();
       var question= $("#question").val();
       var answer= $("#answer").val();
       var sex = $('input[name="sex"]:checked').val();
       var sendData = {
           email:email,
           phone:phone,
           birthday:birthday,
           question:question,
           answer:answer,
           sex:sex
       };
        $.ajax({
            type: "PUT",
            url: "/api/user/updateUserInfo.yht",
            data: sendData,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    layer.open({
                        content: '修改成功'
                        ,btn: '我知道了'
                    });
                }
                else {
                    layer.msg(data.msg);
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
