<%--
  Created by IntelliJ IDEA.
  User: Saya
  Date: 2018/3/24
  Time: 12:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商户统一认证登录平台</title>
    <link type="text/css" rel="stylesheet" href="../../assets/shop_login/css/login.css">
    <script type="text/javascript" src="../../assets/shop_login/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../../../assets/tools/layui-v2.2.6/layui.js"></script>
    <script type="text/javascript" src="../../assets/shop_login/js/login.js"></script>
</head>
<body style="overflow:hidden">
<div class="pagewrap">
    <div class="main">
        <div class="header"></div>
        <div class="content">
            <div class="con_left"></div>
            <div class="con_right">
                <div class="con_r_top">
                    <a href="javascript:;" class="right"
                       style="color: rgb(51, 51, 51); border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: rgb(46, 85, 142);">商户登录</a>
                </div>
                <ul>
                    <li class="con_r_right" style="display: block;">
                        <form name="form1" method="post" action="#" autocomplete="off">
                            <div class="user">
                                <div><span class="user-icon"></span>
                                    <input type="text" id="userid" name="userid" placeholder="　输入账号" value="">
                                </div>

                                <div><span class="mima-icon"></span>
                                    <input type="password" id="pwd" name="pwd" placeholder="　输入密码" value="">
                                </div>

                                <div><span class="yzmz-icon"></span>
                                    <input id="vdcode" type="text" name="validate" placeholder="　验证码" value=""
                                           style=" width:150px;">　　
                                    <input type = "button" id="code" style="width:100px;cursor: pointer;" alt="看不清？点击更换" onclick="createCode()"/>
                                </div>
                            </div>
                            <br>
                            <button id="btn_Login" type="submit">登 录</button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

</body>
</html>
