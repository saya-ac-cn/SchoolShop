
var layer;//定义layui模块

layui.use(['layer'], function(){
    layer = layui.layer;
});

//设置一个全局的变量，便于保存验证码
var code;
function createCode(){
    //首先默认code为空字符串
    code = '';
    //设置长度，这里看需求，我这里设置了4
    var codeLength = 4;
    var codeV = document.getElementById('code');
    //设置随机字符
    var random = new Array(0,1,2,3,4,5,6,7,8,9,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R', 'S','T','U','V','W','X','Y','Z');
    //循环codeLength 我设置的4就是循环4次
    for(var i = 0; i < codeLength; i++){
        //设置随机数范围,这设置为0 ~ 36
        var index = Math.floor(Math.random()*36);
        //字符串拼接 将每次随机的字符 进行拼接
        code += random[index];
    }
    //将拼接好的字符串赋值给展示的Value
    codeV.value = code;
}

//下面就是判断是否== 的代码，无需解释
function validate(){
    var oValue = document.getElementById('vdcode').value.toUpperCase();
    if(oValue ==0){
        layer.msg('请输入验证码');
        return false;
    }else if(oValue != code){
        layer.msg('验证码不正确，请重新输入');
        oValue = ' ';
        createCode();
        return false;
    }else{
        return true;
    }
}


$(function () {

    createCode();

    $('#btn_Login').click(function () {
        if ($.trim($('#userid').val()) == '') {
            layer.msg('请输入您的用户名');
            return false;
        } else if ($.trim($('#pwd').val()) == '') {
            layer.msg('请输入密码');
            return false;
        }else if(validate()!= true) {
            return false;
        }else {
            login();
            return false;//必须返回返回false
        }
    });

})

//处理登录
function login()
{
    console.log('执行');
    $.ajax({
        type: "POST",
        url: "/api/public/adminLogin.yht",
        data:{id:$.trim($('#userid').val()),password:$.trim($('#pwd').val())},
        dataType:"json",
        success: function(data){
            if(data.code == 0){
                window.location.href = "/admin/";
            }
            else
            {
                layer.msg(data.msg);
            }
        },
        error:function(data){
            layer.msg('处理失败');
            return false;
        }
    });
}