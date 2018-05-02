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
    <title>管理摊位</title>
    <link rel="stylesheet" href="assets/tools/layui-v2.2.6/css/layui.css" media="all"/>
    <script type="text/javascript" src="assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="assets/js/ajaxSetup.js"></script>
</head>
<body>
<div style="padding:15px;">
    <div class="layui-row">
        <blockquote class="layui-elem-quote layui-text">
            <h3>管理摊位</h3>
        </blockquote>
    </div>
    <div class="layui-row" id="modifyDiv">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>添加货摊信息</legend>
        </fieldset>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">货摊名</label>
                <div class="layui-input-inline">
                    <input type="text" id="standName" name="standName" maxlength="40" lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">地址</label>
                <div class="layui-input-block">
                    <input type="text" name="location" id="location" lay-verify="required"   maxlength="70" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" id="savaDiv" >
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="goSave">立即提交</button>
                    <button type="reset"  class="layui-btn layui-btn-primary">重置表单</button>
                </div>
            </div>
        </form>
    </div>
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>平台所有货摊列表信息</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <table id="table" lay-filter="demo"></table>
    </div>
</div>
<script type="text/javascript">
    var layer,form,$,upload,flow,table,standTable;
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


        standTable = table.render({
            id: 'mainTable',
            elem: '#table',
            //data:[],
            url:"/api/admin/stand/all.yht",
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
                {title:'识别号', field: 'id',align:'left',fixed:'left'},
                {title:'摊位名', field: 'standName',align:'left',edit: 'text'},
                {title:'地址', field: 'location',align:'left',edit: 'text'},
                {title:'状态', field: 'status',align:'center',
                    templet: function(d){
                        var arr = ["正常","维护中"];
                        return arr[d.status-1];
                    }},
                {title:'是否已选', field: 'choise',align:'center',
                    templet: function(d){
                        var arr = ["已选","未选"];
                        return arr[d.choise];
                    }},
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
                if(data.standName != '' && data.location != '')
                {
                    modifyData(data);
                }
                else
                {
                    layer.alert("不能修改成空字段");
                }
            }
            if(obj.event === 'dell')
            {
                if(data.status == "1")
                {
                    //要维护
                    modifyData({id:data.id,status:2})
                }
                else
                {
                    //要开启
                    modifyData({id:data.id,status:1})
                }
            }
        });


        //添加货摊
        form.on('submit(goSave)', function (data) {
            var sendData = {
                standName:data.field.standName,
                location:data.field.location
            }
            goSave(sendData);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });

    });

    //修改摊位
    function modifyData(data) {
        ajaxSetup();
        $.ajax({
            type: "PUT",
            url: "/api/admin/stand/update.yht",
            data: data,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    cleanQueryAll();//相当于重新渲染页面
                    layer.alert("修改成功");
                }
                else {
                    layer.alert("修改失败");
                }
            },
            error: function (data) {
                layer.alert('处理失败');
                return false;
            }
        });
    }

    //添加摊位
    function goSave(data) {
        ajaxSetup();
        $.ajax({
            type: "POST",
            url: "/api/admin/stand/insert.yht",
            data: data,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    cleanQueryAll();//相当于重新渲染页面
                    layer.alert("添加成功");
                }
                else {
                    layer.alert("添加失败");
                }
            },
            error: function (data) {
                layer.alert('处理失败，请重新登录');
                return false;
            }
        });
    }


    //查询
    function query(){
        standTable.reload({where:{
                startTime:startTime,
                endTime:endTime,
            },page:{curr: 1}});
    }

    //清空查询表单
    function cleanQueryAll(){
        standTable.reload({where:{
            },page:{curr: 1}});
    }
</script>
<!--工具栏-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">提交</a>
    <a class="layui-btn layui-btn-xs" lay-event="dell">启用/禁用</a>
</script>
</body>
</html>
