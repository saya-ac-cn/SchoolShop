<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/15
  Time: 0:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    %>
    <base href="<%=basePath%>">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <title>注册商户</title>
    <link rel="stylesheet" href="assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            注册商户<span id="notice"></span>
        </blockquote>
    </div>
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>商户主体信息</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">学号</label>
                <div class="layui-input-inline">
                    <input type="text" id="id" aria-disabled="true" disabled="disabled" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                    <input type="text" id="name" aria-disabled="true" disabled="disabled" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">二级学院</label>
                    <div class="layui-input-inline">
                        <input type="tel" id="college" aria-disabled="true" disabled="disabled" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">所在班级</label>
                    <div class="layui-input-inline">
                        <input type="text" id="classes" aria-disabled="true" disabled="disabled" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-row">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                    <legend>商户信息</legend>
                </fieldset>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">Logo</label>
                <div class="layui-input-inline layui-upload-list">
                    <img class="layui-upload-img" id="logo">
                </div>
                <div class="layui-upload" style="padding: 1.5em">
                    <button type="button" class="layui-btn" id="test1">上传图片</button>
                    <div class="layui-upload-list">
                        <p id="demoText"></p>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商户名</label>
                <div class="layui-input-block">
                    <input type="text" name="shopname" id="shopname" lay-verify="required|shopname"   maxlength="50" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">商户简介</label>
                <div class="layui-input-block">
                    <textarea name="detail" id="detail" placeholder="请输入简介" lay-verify="required|detail" maxlength="200" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item" id="savaDiv" >
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="goSave">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置表单</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    var layer,form,$;
    layui.use(['layer', 'jquery', 'form','upload'], function () {
        layer = layui.layer;
        $ = layui.jquery;
        form = layui.form;
        upload = layui.upload;

        form.verify({
            shopname: function(value){
                if(value.length < 5 || value.length >= 50){
                    return '您的商户名过长或过短';
                }
            },
            detail: function(value){
                if(value.length < 10 || value.length >= 200){
                    return '您的商户简介过长或过短。';
                }
            }
        });

        //修改密保
        form.on('submit(goSave)', function (data) {
            goSave(data.field.shopname,data.field.detail);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '/api/shop/upload.yht?type=2'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    //$('#logo').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.code = 0){
                    return layer.msg('上传失败');
                }
                else
                {
                    return layer.msg(res.msg);
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

        getStudentInfo();
    });

    function getStudentInfo() {
        ajaxSetup();
        $.ajax({
            type: "GET",
            url: "/api/shop/info.yht",
            data: {id: $.trim($('#userid').val()), password: $.trim($('#pwd').val())},
            dataType: "json",
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    render(data.data);
                }
                else {
                    layer.msg(data.msg);
                }
            },
            error: function (data) {
                layer.msg('处理失败');
                return false;
            }
        });
    }

    //注册
    function goSave(shopName,description) {
        ajaxSetup();
        $.ajax({
            type: "POST",
            url: "/api/shop/shop/register.yht",
            data: {shopName:shopName,description:description},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    layer.msg("注册成功");
                    getShopInfo();
                }
                else {
                    layer.msg(data.msg);
                }
            },
            error: function (data) {
                layer.msg('处理失败');
                return false;
            }
        });
    }

    //渲染表单数据
    function render(data) {
        $("#id").val(data.id);
        $("#name").val(data.name);
        $("#college").val(data.college);
        $("#classes").val(data.classes);
    }
</script>
</body>
</html>
