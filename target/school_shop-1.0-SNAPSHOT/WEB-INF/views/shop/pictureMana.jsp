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
    <title>管理图片</title>
    <link rel="stylesheet" href="../../../assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <style>
        .maindiv{
            width: 1200px;
            margin: 0 auto;
            height: auto;
            min-height: 200px;
            /*background-color: #2aabd2;*/
            margin-top: 0px;
        }

        .imglist{
            width: 1200px;
            position: relative;
            list-style: none;
            z-index: 1;
            float: left;
            height: auto;
        }
        .imglist li{
            list-style: none;
            float: left;
            width: auto;
            height: auto;
            margin-right: 5px;
            margin-bottom: 5px;
        }

        .imglist li:hover{
            opacity:0.6;//设置透明度
        }

        .imglist li:last-child:hover{
            filter: brightness(50%);
            -webkit-filter:brightness(50%);
            transform: scale(1.4);
        }


        .imglist li img{
            height: 191px;
            width: auto;
            background-color: rgb(163, 166, 185);
        }

        @media screen and (max-width: 1000px) {
            .maindiv{width:600px}
            .imglist{width: auto}
        }

        @media screen and (min-width: 1000px) {
            .maindiv{width:1200px}
            .imglist{width: auto}
        }


        .imgbox {
            position:relative;
        }

    </style>
    <script type="text/javascript" src="../../../assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="../../../assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            管理图片
        </blockquote>
    </div>
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>上传图片</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <div class="layui-upload">
            <button type="button" class="layui-btn" id="test1">上传图片</button>
            <div class="layui-upload-list">
                <img class="layui-upload-img" id="demo1">
                <p id="demoText"></p>
            </div>
        </div>
    </div>
    <div class="layui-row maindiv">
        <ul class="flow-default yuyue_list imglist" id="LAY_demo1" ></ul>
    </div>
</div>
<script type="text/javascript">
    var layer,form,$,upload,flow;
    var pageSize = 10;
    var pageIndex = 1;
    layui.use(['layer', 'jquery', 'form','upload','flow'], function () {
        layer = layui.layer;
        $ = layui.jquery;
        form = layui.form;
        upload = layui.upload;
        flow = layui.flow;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '/api/shop/upload.yht?type=3'
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result); //图片链接（base64）
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

        flow.load({
            elem: '#LAY_demo1' //指定列表容器
            ,done: function(pageIndex, next){ //到达临界点（默认滚动触发），触发下一页
                var lis = [];
                //以jQuery的Ajax请求为例，请求下一页数据（注意：page是从2开始返回）
                $.ajax({
                    type: "GET",
                    url: '/api/shop/viewPicture/'+pageIndex,
                    data: { rows: pageSize},
                    success: function (res) {
                        if(res.code == 0)
                        {
                            var data = res.data;
                            var strHtml;//输出的html字符串
                            //假设你的列表返回在data集合中
                            layui.each(data.grid, function(index, value){
                                strHtml = "";//初始化
                                strHtml += '<li class="imgitem hactive" >';
                                strHtml += '<div class="imgbox">';
                                strHtml += '<a href="#" target="_blank">';
                                strHtml += '<img class="main_img img-hover" lay-src='+value.url+'>';
                                strHtml += '</a>';
                                strHtml += '<button onclick="deleteConfirm('+value.pictureId+')" class="layui-btn layui-btn-primary layui-btn-sm" title="删除" style="position: absolute; top: 0; left: 0;"><i class="layui-icon">&#xe640;</i></button> ';
                                strHtml += '</div>';
                                strHtml += '</li>';
                                lis.push(strHtml);//每条数据都压入数组，LayUI会自动将每条信息插入Html的ID为#LAY_demo1的元素
                            });
                            //pageIndex = data.pageNow;
                            //执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                            //只有当前页小于总页数的情况下，才会继续出现加载更多
                            console.log("当前页"+pageIndex);
                            console.log("总页数"+data.totalPage);
                            console.log(pageIndex <= data.totalPage)
                            next(lis.join(''), pageIndex+1 <= data.totalPage);
                            flow.lazyimg()
                        }
                    }
                });
            }
        });


    });

    function deleteConfirm(id)
    {
        layer.confirm('您确定删除？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            layer.msg('已提交', {icon: 1});
            deletePicture(id);
        });
    }

    function deletePicture(id) {
        $.ajax({
            type: "DELETE",
            url: '/api/shop/picture/delete/'+id,
            success: function (res) {
                if(res.code == 0)
                {
                    layer.msg('已删除', {icon: 1});
                }
                else
                {
                    layer.msg('删除失败');
                }
            }
        });
    }


</script>
</body>
</html>
