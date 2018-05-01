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
    <title>修改商品</title>
    <style>
        .maindiv{
            width: 100%;
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
            height: 140px;
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
                        <input type="text" id="query_name" class="layui-input" autocomplete="off" placeholder="请输入商品名" style="width:200px"/>
                    </div>
                    <div class="layui-input-inline" style="width: 200px;">
                        <input type="text" id="query_date" class="layui-input" autocomplete="off" placeholder="添加时间" style="width:200px"/>
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
    <div class="layui-row" id="modifyDiv" style="display: none">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>修改商品信息</legend>
        </fieldset>
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <label class="layui-form-label">商品名</label>
                <div class="layui-input-inline">
                    <input type="text" id="name" name="name" maxlength="40" lay-verify="required" class="layui-input">
                    <input type="hidden" id="shopID" name="shopID" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">副标题</label>
                <div class="layui-input-block">
                    <input type="text" name="subtitle" id="subtitle" lay-verify="required"   maxlength="70" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">商品logo</label>
                    <div class="layui-input-inline">
                        <img class="layui-upload-img" style=" width: 140px;height: auto" name="logo" id="logo">
                    </div>
                    <button type="button" class="layui-btn" onclick="choise()">选择图片</button>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">商品描述</label>
                <div class="layui-input-block">
                    <textarea name="detail" id="detail" placeholder="请输入简介" lay-verify="required"  class="layui-textarea"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">价格</label>
                    <div class="layui-input-inline">
                        <input type="number" name="price" id="price" lay-verify="required"  class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">库存</label>
                    <div class="layui-input-inline">
                        <input type="number" name="stock" id="stock" lay-verify="required" class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item" id="savaDiv" >
                <div class="layui-input-block">
                    <button type="submit" class="layui-btn" lay-submit="" lay-filter="goSave">立即提交</button>
                    <button type="button" onclick="closeDiv()" class="layui-btn layui-btn-primary">关闭表单</button>
                </div>
            </div>
        </form>
    </div>
    <div class="layui-row">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>管理商品信息</legend>
        </fieldset>
    </div>
    <div class="layui-row">
        <table id="table" lay-filter="demo"></table>
    </div>
</div>
<script type="text/javascript">
    var layer,form,$,upload,flow,table,goodsTable;
    var pageSize = 6;
    var pageIndex = 1;
    var selectDiv;
    var Gurl = '';
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
            url:"/api/shop/goods/pagin.yht",
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
                {title:'编号', field: 'id',align:'left',fixed:'left'},
                {title:'商品名', field: 'name',align:'center',},
                {title:'副标题', field: 'subtitle',align:'center'},
                {title:'单价', field: 'price',align:'left',
                    templet: function(d){
                        return "￥ "+d.price;
                    }},
                {title:'库存', field: 'stock',align:'left'},
                {title:'状态', field: 'status',align:'center',
                    templet: function(d){
                        var arr = ["在售","下架"];
                        return arr[d.status-1];
                    }},
                {title:'创建时间',field:'createTime',align:'left'},
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
                $("#modifyDiv").show(1000);
                console.log(JSON.stringify(data));
                renderForm(data);
            }
        });

        //修改商品
        form.on('submit(goSave)', function (data) {
            if (Gurl == '') {
                layer.msg("请选择Logo", {
                    icon: 5,
                    anim: 6
                });
                return false;
            }
            var sendData = {
                id:$("#shopID").val(),
                name:data.field.name,
                subtitle:data.field.subtitle,
                mainImages:Gurl,
                detail:data.field.detail,
                price:data.field.price,
                stock:data.field.stock
            };
           goSave(sendData);
            return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
        });
    });

    //渲染表单
    function renderForm(data) {
        $("#name").val(data.name);
        $("#shopID").val(data.id);
        $("#subtitle").val(data.subtitle);
        $("#logo").attr("src",data.mainImages);
        Gurl = data.mainImages;
        $("#detail").val(data.detail);
        $("#price").val(data.price);
        $("#stock").val(data.stock);
    }

    function showImg() {
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
                                strHtml += '<button onclick="selectImg(\''+value.url+'\')" class="layui-btn layui-btn-primary layui-btn-sm" title="选择" style="position: absolute; top: 0; left: 0;"><i class="layui-icon">&#xe63f;</i></button> ';
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
    }

    //弹出图片选择
    function choise()
    {
        selectDiv = layer.open({
            type: 1,
            title: '选择图片',
            zIndex: layer.zIndex,
            content: $('#actionChoise').html(),
            area: ['600px', '400px'],
            resize:false,
            success: function(layero, index) {
                showImg();
            }
        });
    }

    //选择图片后回调
    function selectImg(url)
    {
        Gurl = url;
        $("#logo").attr("src",Gurl);
        layer.closeAll();
    }


    //修改商品
    function goSave(data) {
        ajaxSetup();
        $.ajax({
            type: "PUT",
            url: "/api/shop/goods/update.yht",
            data: data,
            dataType:"json",//预期服务器返回的数据类型
            success: function (data) {
                if (data.code == 0) {
                    console.log(data);
                    closeDiv();
                    cleanQueryAll()
                    layer.alert("修改成功");
                    getShopInfo();
                }
                else {
                    layer.alert(data.msg);
                }
            },
            error: function (data) {
                layer.alert('处理失败');
                return false;
            }
        });
    }

    //查询
    function query(){
        goodsTable.reload({where:{
                startTime:startTime,
                endTime:endTime,
                name:$("#query_name").val().trim()
            },page:{curr: 1}});
    }

    //隐藏表单
    function closeDiv() {
        $("#modifyDiv").hide(1000);
    }

    //清空查询表单
    function cleanQueryAll(){
        document.getElementById("query_form").reset();
        goodsTable.reload({where:{
            },page:{curr: 1}});
    }


</script>
<!-- 图片选择模板 -->
<script type="text/html" id="actionChoise">
    <div style="width:100%">
        <div style="padding:1em" class="layui-row maindiv">
            <ul class="flow-default yuyue_list imglist" id="LAY_demo1" ></ul>
        </div>
    </div>
</script>
<!--工具栏-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</script>
</body>
</html>
