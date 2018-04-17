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
    <title>修改商户信息</title>
    <link rel="stylesheet" href="../../../assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="../../../assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="../../../assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            修改商户信息<span id="notice"></span>
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
                    <img class="layui-upload-img" id="logo" src="data:image/jpeg;base64,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">
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
            <div class="layui-row">
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
                    <legend>经营摊位信息</legend>
                </fieldset>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">摊位名</label>
                    <div class="layui-input-inline">
                        <input type="tel" id="standname" aria-disabled="true" disabled="disabled" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">地址</label>
                    <div class="layui-input-inline">
                        <input type="text" id="location" aria-disabled="true" disabled="disabled" class="layui-input">
                    </div>
                </div>
            </div>
            <div class="layui-form-item" id="savaDiv" style="display: none">
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
    var takeData;
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

        getShopInfo();
    });

    //修改商户信息
    function goSave(shopName,description) {
        ajaxSetup();
        $.ajax({
            type: "PUT",
            url: "/api/shop/shopinfo/info.yht",
            data: {shopName:shopName,description:description},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    layer.msg("密码修改成功");
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

    function getShopInfo() {
        ajaxSetup();
        $.ajax({
            type: "GET",
            url: "/api/shop/shopinfo.yht?type=2",
            dataType: "json",
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    takeData = data.data[0];
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
        $("#name").val(takeData.name);
        $("#college").val(takeData.college);
        $("#classes").val(takeData.classes);

        $("#logo").attr("src",takeData.Shop.Files.url);
        $("#shopname").val(takeData.Shop.shopName);
        $("#detail").val(takeData.Shop.description);

        $("#standname").val(takeData.Shop.Stand.standName);
        $("#location").val(takeData.Shop.Stand.location);
        if (takeData.Shop.status == "1") {
            //正常显示
            $("#savaDiv").removeAttr("style");
            $("#notice").text("");
            console.log('执行');
        }
        else if(takeData.Shop.status == "2")
        {
            $("#savaDiv").attr("display","none");
            $("#notice").text("。您的账户正在审核中。");
            $("#shopname").attr("readonly","readonly" );
            $("#detail").attr("readonly","readonly" );
        }
        else
        {
            $("#savaDiv").attr("display","none");
            $("#notice").text("。您的账户已被冻结。");
            $("#shopname").attr("readonly","readonly" );
            $("#detail").attr("readonly","readonly" );
        }
    }

</script>
</body>
</html>
