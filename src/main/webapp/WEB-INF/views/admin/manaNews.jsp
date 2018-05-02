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
    <title>管理动态</title>
    <link rel="stylesheet" href="assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            <h3>管理动态</h3>
        </blockquote>
    </div>
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>平台所有动态列表信息</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <table id="table" lay-filter="demo"></table>
    </div>
</div>
<script type="text/javascript">
    var layer,form,$,upload,flow,table,newsTable;
    var startTime = '',endTime = '';
    layui.use(['layer', 'jquery', 'form','upload','flow','table','element','laydate'], function () {
        layer = layui.layer;
        $ = layui.jquery;
        form = layui.form;
        upload = layui.upload;
        flow = layui.flow;
        table = layui.table;
        laydate = layui.laydate;
        element = layui.element;


        newsTable = table.render({
            id: 'mainTable',
            elem: '#table',
            url:"/api/admin/news/query.yht",
            method:'get',
            loading: true,
            page:{ //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                //,curr: 5 //设定初始在第 5 页
                ,groups: 1 //只显示 1 个连续页码
                ,first: false //不显示首页
                ,last: false //不显示尾页

            },
            limits: [10,20,30,50],
            limit:10,
            even:true,					//行间隔背景
            skin:'row',				//风格 line/row/nob
            height: 'full-119',
            //where:{type:1},
            request: {
                pageName: 'pages', //页码的参数名称，默认：page
                limitName: 'rows' //每页数据量的参数名，默认：limit
            },
            cols:  [[
                {title:'编号', field: 'id',align:'left',fixed:'left'},
                {title:'标题', field: 'title',align:'left',edit: 'text'},
                {title:'来源', field: 'author',align:'left',edit: 'text'},
                {title:'创建时间', field: 'createTime',align:'left'},
                {title:'修改时间', field: 'updateTime',align:'left'},
                {title:'操作', field: null,align:'center', toolbar: '#barDemo'}
            ]],
            done: function(res, curr, count){
                //渲染成功后回调
            }
        });

        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'edit'){
                window.location.href = "/view/admin/modifyNews.html?newsid="+data.id;
            }
            if(obj.event === 'dell')
            {
                layer.confirm('您确定删除？', {
                    btn: ['确定','取消'] //按钮
                }, function(index){
                    goDelete(data.id);
                    layer.close(index);
                });
            }
        });


    });


    //删除动态
    function goDelete(id) {
        ajaxSetup();
        $.ajax({
            type: "delete",
            url: "/api/admin/news/delete/"+id,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    cleanQueryAll();
                    layer.msg("删除成功");
                }
                else {
                    layer.msg("删除失败");
                }
            },
            error: function (data) {
                layer.msg('处理失败');
                return false;
            }
        });
    }


    //清空查询表单
    function cleanQueryAll(){
        newsTable.reload({where:{
            },page:{curr: 1}});
    }
</script>
<!--工具栏-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-xs" lay-event="dell">删除</a>
</script>
</body>
</html>
