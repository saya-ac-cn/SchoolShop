<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/15
  Time: 0:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <title>修改个人信息</title>
    <link rel="stylesheet" href="../../../assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="../../../assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="../../../assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            修改个人信息<span id="notice"></span>
        </blockquote>
    </div>
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>基础性信息</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-inline">
                    <input type="text" id="id" aria-disabled="true" disabled="disabled" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                    <input type="text" id="username" aria-disabled="true" disabled="disabled" class="layui-input">
                </div>
            </div>
            <div class="layui-row">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                    <legend>用户详细信息</legend>
                </fieldset>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">Logo</label>
                <div class="layui-input-inline layui-upload-list">
                    <img class="layui-upload-img" id="logo" src="<%= (String) session.getAttribute("Adminimg") %>">
                </div>
                <div class="layui-upload" style="padding: 1.5em">
                    <button type="button" class="layui-btn" id="test1">上传图片</button>
                    <div class="layui-upload-list">
                        <p id="demoText"></p>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" id="email" name="email" lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">联系方式</label>
                <div class="layui-input-inline">
                    <input type="text" id="mobil" name="mobil" lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" id="savaDiv">
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="goSave">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置表单</button>
                </div>
            </div>
        </form>
    </div>
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>修改密码</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">请输入密码</label>
                <div class="layui-input-inline">
                    <input type="password" id="password_1" name="password_1" lay-verify="required|pass" maxlength="20" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">密码必须6到12位，且不能出现空格</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">请再次输入密码</label>
                <div class="layui-input-inline">
                    <input type="password" id="password_2" name="password_2" lay-verify="required|pass" maxlength="20" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">两次密码必须一致</div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="password">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置表单</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    var layer,form,$;
    var takeData;
    layui.use(['layer', 'jquery', 'form','upload'], function () {
        layer = layui.layer;
        $ = layui.jquery;
        form = layui.form;
        upload = layui.upload;

        form.verify({
            pass: [/(.+){6,12}$/, '密码必须6到20位'],
            question: function(value){
                if(value.length < 5 || value.length >= 20){
                    return '您的密码问题字符串过短或过长，5至20个以内';
                }
            },
            answer: function(value){
                if(value.length < 3 || value.length >= 50){
                    return '您的密码问题字符串过短或过长，3至50个以内';
                }
            }
        });

        //修改密码
        form.on('submit(password)', function (data) {
            if (data.field.password_1 != data.field.password_2) {
                layer.msg("两次密码输入不一致", {
                    icon: 5,
                    anim: 6
                });
                return false;
            }
            var sendData = {
                password:data.field.password_2
            };
            goSave(sendData);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        //修改用户信息
        form.on('submit(goSave)', function (data) {
            var sendData = {
                email:data.field.email,
                mobile:data.field.mobile
            };
            goSave(sendData);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '/api/admin/upload.yht'
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

        getAdminInfo();
    });

    //修改商户信息
    function goSave(data) {
        ajaxSetup();
        $.ajax({
            type: "PUT",
            url: "/api/admin/admin/info.yht",
            data: data,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    layer.msg("修改成功");
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

    function getAdminInfo() {
        ajaxSetup();
        $.ajax({
            type: "GET",
            url: "/api/admin/info.yht",
            dataType: "json",
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    takeData = data.data;
                    console.log(takeData);
                    render();
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
    function render() {
        $("#id").val(takeData.id);
        $("#username").val(takeData.username);
        $("#email").val(takeData.email);
        $("#mobil").val(takeData.mobil);
    }

</script>
</body>
</html>
