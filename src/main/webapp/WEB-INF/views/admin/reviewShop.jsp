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
    <title>审核商户</title>
    <link rel="stylesheet" href="assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="assets/js/ajaxSetup.js"></script>
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
    var layer,form,$,upload,flow,table,shopTable,standTable,alert_stand;
    var Gdata;//全局的数据
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
                {title:'操作', field: null,align:'center',toolbar: '#barDemo',fixed:'right'}
            ]],
            done: function(res, curr, count){
                //渲染成功后回调
            }
        });


        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'edit'){
                Gdata = data;
                popStand();
            }
            if(obj.event === 'dell')
            {
                if(data.status == "1")
                {
                    //要冻结
                    modifyData({studentId:data.id,status:2,shopId:data.Shop.shopId})
                }
                else
                {
                    //要开启
                    modifyData({studentId:data.id,status:1,shopId:data.Shop.shopId})
                }
            }
        });

        table.on('tool(stand)', function(obj){
            var data = obj.data;
            if(obj.event === 'select'){
                layer.close(alert_stand);//关闭窗口
                modifyData({studentId:Gdata.id,standId:data.id,shopId:Gdata.Shop.shopId})
            }
        });


    });

    //修改摊位
    function modifyData(data) {
        ajaxSetup();
        $.ajax({
            type: "PUT",
            url: "/api/admin/shop/review.yht",
            data: data,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    cleanQueryAll();
                    layer.msg("操作成功");
                }
                else {
                    layer.msg("操作失败");
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
        shopTable.reload({where:{
            },page:{curr: 1}});
    }

    //弹出摊位选择窗口
    function popStand(){
        alert_stand = layer.open({
            type: 1,
            title: '选择摊位',
            zIndex: layer.zIndex,
            content: $('#select_stand').html(),
            area: ['600px', '400px'],
            resize:false,
            success: function(layero, index) {
                standTable = table.render({
                    id: 'stand_table',
                    elem: '#stand_table',
                    url:"/api/admin/stand/all.yht",
                    method:'get',
                    loading: true,
                    page:true,
                    limits: [10,20,30,50],
                    limit:10,
                    even:true,					//行间隔背景
                    //size:'sm',					//表格尺寸
                    skin:'row',				//风格 line/row/nob
                    // width: 1000,
                    //height: 'full-119',
                    where:{choise:"1",status:"1"},
                    request: {
                        pageName: 'pages', //页码的参数名称，默认：page
                        limitName: 'rows' //每页数据量的参数名，默认：limit
                    },
                    cols:  [[
                        {title:'识别号', field: 'id',align:'left',fixed:'left'},
                        {title:'摊位名', field: 'standName',align:'left'},
                        {title:'地址', field: 'location',align:'left'},
                        {title:'操作', field: '',align:'center',toolbar: '#actionTpl2'}
                    ]],
                    done: function(res, curr, count){
                        //渲染成功后回调
                    }
                });
            }
        });
    }

</script>
<!--工具栏-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">选择摊位</a>
    <a class="layui-btn layui-btn-xs" lay-event="dell">通过/冻结</a>
</script>
<!-- 单选摊位 -->
<script type="text/template" id="select_stand">
    <table id="stand_table" lay-filter="stand"></table>
</script>
<!-- 选择摊位按钮 -->
<script type="text/html" id="actionTpl2">
    <div class="layui-btn-group">
        <button class="layui-btn layui-btn-sm" lay-event="select">
            选择
        </button>
    </div>
</script>
</body>
</html>
