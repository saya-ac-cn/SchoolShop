<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/4/6
  Time: 18:22
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
    <title>安全设置</title>
    <link rel="stylesheet" href="../../../assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="../../../assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="../../../assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            修改用户信息
        </blockquote>
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
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>修改密码保护问题</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">密码保护问题</label>
                <div class="layui-input-block">
                    <input type="text" name="question" id="question" lay-verify="required|question" maxlength="20" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">密码保护答案</label>
                <div class="layui-input-block">
                    <textarea name="answer" id="answer" placeholder="请输入答案" lay-verify="required|answer" maxlength="50" class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="mibao">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置表单</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    var layer,form,$;
    layui.use(['layer', 'jquery', 'form'], function () {
        layer = layui.layer;
        $ = layui.jquery;
        form = layui.form;

        getStudentMibao();

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
            goPass(data.field.password_2);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

        //修改密保
        form.on('submit(mibao)', function (data) {
            goMibao(data.field.question,data.field.answer)
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    });

    function getStudentMibao() {
        ajaxSetup();
        $.ajax({
            type: "GET",
            url: "/api/shop/info.yht",
            data: {id: $.trim($('#userid').val()), password: $.trim($('#pwd').val())},
            dataType: "json",
            success: function (data) {
                if (data.code == 0) {
                    $("#answer").val(data.data.answer);
                    $("#question").val(data.data.question);
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

    //修改密码
    function goPass(data) {
        ajaxSetup();
        $.ajax({
            type: "PUT",
            url: "/api/shop/admin/password.yht",
            data: {password:data},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    layer.msg("密码修改成功");
                    getStudentMibao();
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

    //修改密码保护问题
    function goMibao(question,answer) {
        ajaxSetup();
        $.ajax({
            type: "PUT",
            url: "/api/shop/admin/mibao.yht",
            data: {question:question,answer:answer},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    layer.msg("密保修改成功");
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

</script>
</body>
</html>
