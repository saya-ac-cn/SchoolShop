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
    <title>发布动态</title>
    <link rel="stylesheet" href="assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            发布动态<span id="notice"></span>
        </blockquote>
    </div>
    <div class="layui-row">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">标题</label>
                <div class="layui-input-block">
                    <input type="text" id="title" name="title" lay-verify="required" maxlength="100" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">内容</label>
                <div class="layui-input-block">
                    <textarea name="content" id="content" placeholder="请输入内容"  class="layui-textarea"></textarea>
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
</div>

<script type="text/javascript">
    var layer,form,layedit,upload,$;
    layui.use(['layer', 'jquery', 'form','upload','layedit'], function () {
        layer = layui.layer;
        form = layui.form;
        upload = layui.upload;
        $ = layui.jquery;
        layedit = layui.layedit;

        //自定义工具栏
        var index = layedit.build('content', {
            tool: [
                'strong' //加粗
                ,'italic' //斜体
                ,'underline' //下划线
                ,'del' //删除线

                ,'|' //分割线

                ,'left' //左对齐
                ,'center' //居中对齐
                ,'right' //右对齐
                ,'link' //超链接
                ,'unlink' //清除链接
                ,'help' //帮助
            ]
            ,height: 300
        })

        //修改用户信息
        form.on('submit(goSave)', function (data) {
            if(layedit.getText(index) == '')
            {
                layer.msg("请输入内容");
            }
            else
            {
                var sendData = {
                    title:data.field.title,
                    content:layedit.getContent(index)
                };
                goSave(sendData);
            }
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });


    });

    //发布动态
    function goSave(data) {
        ajaxSetup();
        $.ajax({
            type: "POST",
            url: "/api/admin/news/add.yht",
            data: data,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    layer.msg("发布成功");
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
