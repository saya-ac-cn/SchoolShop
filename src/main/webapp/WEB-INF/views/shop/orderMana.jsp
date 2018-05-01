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
    <title>管理订单</title>
    <link rel="stylesheet" href="../../../assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="../../../assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="../../../assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            <form action="" class="layui-form" id="query_form">
                <div class="layui-inline">
                    <div class="layui-input-inline" style="width: 200px;">
                        <input type="text" id="query_date" class="layui-input" autocomplete="off" placeholder="下单时间" style="width:200px"/>
                    </div>
                </div>
                <a href="javascript:;" class="layui-btn layui-btn-sm" onclick="query()">
                    <i class="layui-icon">&#xe615;</i> 搜索
                </a>
                <a href="javascript:;" class="layui-btn layui-btn-sm" onclick="cleanQueryAll(0)">
                    <i class="layui-icon">&#x1006;</i> 清空
                </a>
            </form>
        </blockquote>
    </div>
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>订单统计信息</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <table id="table" lay-filter="demo"></table>
    </div>
</div>
<script type="text/javascript">
    var layer,form,$,upload,flow,table,goodsTable;
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

        //日期范围选择
        laydate.render({
            elem: '#query_date'
            ,range: true //或 range: '~' 来自定义分割字符
            ,change: function(value, date, endDate){
                startTime = date.year+"-"+date.month+"-"+date.date;
                endTime = endDate.year+"-"+endDate.month+"-"+endDate.date;
                console.log(startTime); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
                console.log(endTime); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
            }
        });

        goodsTable = table.render({
            id: 'mainTable',
            elem: '#table',
            //data:[],
            url:"/api/shop/order/report.yht",
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
            //height: 'full-119',
            //where:{type:1},
            request: {
                pageName: 'pages', //页码的参数名称，默认：page
                limitName: 'rows' //每页数据量的参数名，默认：limit
            },
            cols:  [[
                {title:'订单号', field: 'parentId',align:'left',fixed:'left'},
                {title:'商品名', field: 'name',align:'left'},
                {title:'用户', field: 'username',align:'left'},
                {title:'收货地址', field: 'address',align:'left'},
                {title:'联系方式', field: 'mobil',align:'left'},
                {title:'单价', field: 'currentPrice',align:'center',
                    templet: function(d){
                        return "￥ "+d.currentPrice;
                    }},
                {title:'数量', field: 'quantity',align:'center'},
                {title:'总价', field: 'totalPrice',align:'left',
                    templet: function(d){
                        return "￥ "+d.totalPrice;
                    }},
                {title:'状态', field: 'status',align:'center',
                    templet: function(d){
                        var arr = ["已支付","未支付"];
                        return arr[d.status-1];
                    }},
                {title:'下单时间',field:'createTime',align:'left'},
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
                if(data.status == 2 || data.status == '2')
                {
                    layer.confirm('您确定撤销订单？', {
                        btn: ['确定','取消'] //按钮
                    }, function(){
                        goSave(data.orderId);
                    });
                }
                else
                {
                    layer.msg("已支付的订单不能直接在平台中取消");
                }
            }
        });

    });

    //删除订单
    function goSave(data) {
        ajaxSetup();
        $.ajax({
            type: "POST",
            url: "/api/shop/order/delete.yht",
            data: {orderDetail:data},
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    layer.msg("操作成功");
                    goodsTable.reload({where:{
                        },page:{curr: 1}});
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
<!--工具栏-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">撤销订单</a>
</script>
</body>
</html>
