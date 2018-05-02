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
    <title>修改用户信息</title>
    <link rel="stylesheet" href="assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="assets/js/ajaxSetup.js"></script>
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
            <legend>用户基本信息</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">学号</label>
                <div class="layui-input-inline">
                    <input type="text" id="id" aria-disabled="true" disabled="disabled" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">不可再编辑</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">姓名</label>
                <div class="layui-input-inline">
                    <input type="text" id="name" aria-disabled="true" disabled="disabled" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">不可再编辑</div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">二级学院</label>
                    <div class="layui-input-inline">
                        <input type="tel" id="college" lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">所在班级</label>
                    <div class="layui-input-inline">
                        <input type="text" id="classes" name="" lay-verify="required" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">宿舍</label>
                <div class="layui-input-inline">
                    <input type="text" name="apartment" id="apartment" lay-verify="required" placeholder="请输入宿舍名"
                           class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">请填写所在宿舍</div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="email" id="email" lay-verify="required|email" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">Phone</label>
                    <div class="layui-input-inline">
                        <input type="text" name="mobile" id="mobile" lay-verify="required|phone" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit="" lay-filter="goSave">立即提交</button>
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
        getStudentInfo();
        form.on('submit(goSave)', function (data) {
            goSave();
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });


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
                    render(data);
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
        if (data.code == 0) {
            var item = data.data;
            $("#id").val(item.id);
            $("#name").val(item.name);
            $("#college").val(item.college);
            $("#classes").val(item.classes);
            $("#apartment").val(item.apartment);
            $("#email").val(item.email);
            $("#mobile").val(item.mobile);
        }
    }

    //保存修改
    function goSave() {
        var sendData = {
            college: $.trim($("#college").val()),
            classes: $.trim($("#classes").val()),
            apartment: $.trim($("#apartment").val()),
            email: $.trim($("#email").val()),
            mobile: $.trim($("#mobile").val())
        };
        ajaxSetup();
        $.ajax({
            type: "PUT",
            url: "/api/shop/admin/info.yht",
            data: sendData,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    layer.msg("修改成功");
                    render(data);
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
