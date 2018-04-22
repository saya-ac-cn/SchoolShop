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
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <title>审核商户</title>
    <link rel="stylesheet" href="../../../assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="../../../assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="../../../assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            <h3>审核商户</h3>
        </blockquote>
    </div>
    <div class="layui-row">
        <table id="table" lay-filter="demo"></table>
    </div>
</div>
<script type="text/javascript">
    var layer,form,$,upload,flow,table,shopTable;
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


        shopTable = table.render({
            id: 'mainTable',
            elem: '#table',
            //data:[],
            url:"/api/admin/shop/all.yht",
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
                {title:'学号', field: 'id',align:'left',fixed:'left'},
                {title:'姓名', field: 'name',align:'left'},
                {title:'二级学院', field: 'college',align:'left'},
                {title:'班级', field: 'classes',align:'left'},
                {title:'商户ID', field: 'Shop',align:'left',
                    templet: function(d){
                        return d.Shop.shopId;
                    }},
                {title:'商铺名', field: 'Shop',align:'left',
                    templet: function(d){
                        return d.Shop.shopName;
                    }},
                {title:'货摊名', field: 'Shop',align:'left',
                    templet: function(d){
                        if(d.Shop.Stand != null)
                        {
                            return d.Shop.Stand.standName;
                        }
                        {
                            return '等待分派';
                        }
                    }},
                {title:'货摊地址', field: 'Shop',align:'left',
                    templet: function(d){
                        if(d.Shop.Stand != null)
                        {
                            return d.Shop.Stand.location;
                        }
                        {
                            return '等待分派';
                        }
                    }},
                {title:'状态', field: 'Shop',align:'center',
                    templet: function(d){
                        var arr = ["正常","冻结","审核中"];
                        return arr[d.Shop.status-1];
                    }},
            ]],
            done: function(res, curr, count){
                //渲染成功后回调
            }
        });

    });


    //查询
    function query(){
        goodsTable.reload({where:{
                startTime:startTime,
                endTime:endTime,
            },page:{curr: 1}});
    }

    //清空查询表单
    function cleanQueryAll(){
        document.getElementById("query_form").reset();
        goodsTable.reload({where:{
            },page:{curr: 1}});
    }


</script>
</body>
</html>
