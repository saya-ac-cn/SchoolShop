var layer;//定义layui模块
var id = '';
layui.use(['layer'], function(){
    layer = layui.layer;
});

$(function(){

    id = decodeURI(geturldata("id"));
    if(id == null || id == "null")
    {
        getCart("");
        console.log("空值");
    }
    else
    {
        console.log(id);
        getCart(id);//加载购物车数据
    }
});


//获取所有购物车信息
function getCart(id) {
    $.ajax({
        type: "Get",
        url: "/api/user/cart/get.yht",
        dataType:"json",
        data:{id:id},
        success: function(data){
            if(data.code == 0){
                render(data.data);
                return false;
            }
            else
            {
                layer.msg("没有找到数据信息");
            }
        },
        error:function(data){
            layer.msg('获取数据失败');
            return false;
        }
    });
}

function render(data) {
    var htmlText = "";
    $("#cartList").html("");//首先清空
    for(var i = 0; i < data.length;i++)
    {
        var item = data[i];
       htmlText += "<li><div class=\"shop-info\"><input type=\"checkbox\" class=\"check goods-check goodsCheck\">";
       htmlText += "<div class=\"shop-info-img\"><a href=\"#\"><img src=\""+item.Goods.mainImages+"\" /></a></div>";
       htmlText += "<div class=\"shop-info-text\">";
       htmlText += "<input type=\"hidden\" value=\""+item.id+"\" class=\"cartId\">";
       htmlText += "<h4>"+item.Goods.name+"</h4>";
       htmlText += "<div class=\"shop-brief\">"+item.Goods.subtitle+"</div>"
       htmlText += "<div class=\"shop-price\">";
       htmlText += "<div class=\"shop-pices\">￥<b class=\"price\">"+item.Goods.price+"</b></div>"
       htmlText += "<div class=\"shop-arithmetic\"><a href=\"javascript:;\" class=\"minus\">-</a>";
       htmlText += "<span class=\"num\" >"+item.quantity+"</span>";
       htmlText += "<a href=\"javascript:;\" class=\"plus\">+</a>";
       htmlText += "</div></div></div></div></li>"
    }
    htmlText += "<script type=\"text/javascript\">"
    htmlText +="$(function(){\n" +
        "\t// 数量减\n" +
        "\t$(\".minus\").click(function() {\n" +
        "\t\tvar t = $(this).parent().find('.num');\n" +
        "\t\tt.text(parseInt(t.text()) - 1);\n" +
        "\t\tif (t.text() <= 1) {\n" +
        "\t\t\tt.text(1);\n" +
        "\t\t}\n" +
        "\t\tTotalPrice();\n" +
        "\t});\n" +
        "\t// 数量加\n" +
        "\t$(\".plus\").click(function() {\n" +
        "\t\tvar t = $(this).parent().find('.num');\n" +
        "\t\tt.text(parseInt(t.text()) + 1);\n" +
        "\t\tif (t.text() <= 1) {\n" +
        "\t\t\tt.text(1);\n" +
        "\t\t}\n" +
        "\t\tTotalPrice();\n" +
        "\t});\n" +
        "\t/******------------分割线-----------------******/\n" +
        "\t  // 点击商品按钮\n" +
        "  $(\".goodsCheck\").click(function() {\n" +
        "    var goods = $(this).closest(\".shop-group-item\").find(\".goodsCheck\"); //获取本店铺的所有商品\n" +
        "    var goodsC = $(this).closest(\".shop-group-item\").find(\".goodsCheck:checked\"); //获取本店铺所有被选中的商品\n" +
        "    var Shops = $(this).closest(\".shop-group-item\").find(\".shopCheck\"); //获取本店铺的全选按钮\n" +
        "    if (goods.length == goodsC.length) { //如果选中的商品等于所有商品\n" +
        "      Shops.prop('checked', true); //店铺全选按钮被选中\n" +
        "      if ($(\".shopCheck\").length == $(\".shopCheck:checked\").length) { //如果店铺被选中的数量等于所有店铺的数量\n" +
        "        $(\"#AllCheck\").prop('checked', true); //全选按钮被选中\n" +
        "        TotalPrice();\n" +
        "      } else {\n" +
        "        $(\"#AllCheck\").prop('checked', false); //else全选按钮不被选中 \n" +
        "        TotalPrice();\n" +
        "      }\n" +
        "    } else { //如果选中的商品不等于所有商品\n" +
        "      Shops.prop('checked', false); //店铺全选按钮不被选中\n" +
        "      $(\"#AllCheck\").prop('checked', false); //全选按钮也不被选中\n" +
        "      // 计算\n" +
        "      TotalPrice();\n" +
        "      // 计算\n" +
        "    }\n" +
        "  });\n" +
        "  // 点击店铺按钮\n" +
        "  $(\".shopCheck\").click(function() {\n" +
        "    if ($(this).prop(\"checked\") == true) { //如果店铺按钮被选中\n" +
        "      $(this).parents(\".shop-group-item\").find(\".goods-check\").prop('checked', true); //店铺内的所有商品按钮也被选中\n" +
        "      if ($(\".shopCheck\").length == $(\".shopCheck:checked\").length) { //如果店铺被选中的数量等于所有店铺的数量\n" +
        "        $(\"#AllCheck\").prop('checked', true); //全选按钮被选中\n" +
        "        TotalPrice();\n" +
        "      } else {\n" +
        "        $(\"#AllCheck\").prop('checked', false); //else全选按钮不被选中\n" +
        "        TotalPrice();\n" +
        "      }\n" +
        "    } else { //如果店铺按钮不被选中\n" +
        "      $(this).parents(\".shop-group-item\").find(\".goods-check\").prop('checked', false); //店铺内的所有商品也不被全选\n" +
        "      $(\"#AllCheck\").prop('checked', false); //全选按钮也不被选中\n" +
        "      TotalPrice();\n" +
        "    }\n" +
        "  });\n" +
        "  // 点击全选按钮\n" +
        "  $(\"#AllCheck\").click(function() {\n" +
        "    if ($(this).prop(\"checked\") == true) { //如果全选按钮被选中\n" +
        "      $(\".goods-check\").prop('checked', true); //所有按钮都被选中\n" +
        "      TotalPrice();\n" +
        "    } else {\n" +
        "      $(\".goods-check\").prop('checked', false); //else所有按钮不全选\n" +
        "      TotalPrice();\n" +
        "    }\n" +
        "    $(\".shopCheck\").change(); //执行店铺全选的操作\n" +
        "  });\n" +
        "\t//计算\n" +
        "  function TotalPrice() {\n" +
        "    var allprice = 0; //总价\n" +
        "    $(\".shop-group-item\").each(function() { //循环每个店铺\n" +
        "      var oprice = 0; //店铺总价\n" +
        "      $(this).find(\".goodsCheck\").each(function() { //循环店铺里面的商品\n" +
        "        if ($(this).is(\":checked\")) { //如果该商品被选中\n" +
        "          var num = parseInt($(this).parents(\".shop-info\").find(\".num\").text()); //得到商品的数量\n" +
        "          var price = parseFloat($(this).parents(\".shop-info\").find(\".price\").text()); //得到商品的单价\n" +
        "          var total = price * num; //计算单个商品的总价\n" +
        "          oprice += total; //计算该店铺的总价\n" +
        "        }\n" +
        "        $(this).closest(\".shop-group-item\").find(\".ShopTotal\").text(oprice.toFixed(2)); //显示被选中商品的店铺总价\n" +
        "      });\n" +
        "      var oneprice = parseFloat($(this).find(\".ShopTotal\").text()); //得到每个店铺的总价\n" +
        "      allprice += oneprice; //计算所有店铺的总价\n" +
        "    });\n" +
        "    $(\"#AllTotal\").text(allprice.toFixed(2)); //输出全部总价\n" +
        "  }\n" +
        "});\n"
    htmlText += "</script>"
    $("#cartList").html(htmlText);
}

//用户提交,生成订单
function goBuy() {
    var checkedNum = 0;//用户选择的总数
    var sendData = Array();
    $(".shop-group-item").each(function() { //循环每个店铺
        $(this).find(".goodsCheck").each(function() { //循环店铺里面的商品
            if ($(this).is(":checked")) { //如果该商品被选中
                checkedNum = checkedNum + 1;//统计计数
                var quantity = parseInt($(this).parents(".shop-info").find(".num").text()); //得到商品的数量
                var cartId =parseInt($(this).parents(".shop-info").find(".cartId").val()); //得到购物车单号
                var item = {
                    id : cartId,
                    quantity:quantity
                }
                sendData.push(item);
            }
        });
    });
    if(checkedNum != 0)
    {
        //用户选择了商铺
        $.ajax({
            type: "POST",//规定请求的类型
            url: "/api/user/order/add.yht",//请求地址
            data: JSON.stringify(sendData), //发送到服务器的数据
            dataType:"json",//预期服务器返回的数据类型
            contentType:"application/json",
            success:function(datas){//收到后台的响应
                if(datas.code = 0)
                {
                    //最后是data
                    layer.alert('分派成功。', {
                        title:'页面提示',
                        icon: 1,
                        skin: 'layer-ext-moon',
                    });
                    console.log(datas);
                }else
                {
                    layer.msg('分派失败', {
                        time: 5000, //5s后自动关闭
                        btn: ['知道了']
                    });
                }
            },
            error: function () {//没有收到请求
                layer.msg('操作失败', {
                    time: 5000, //5s后自动关闭
                    btn: ['知道了']
                });
                return false;
            }
        })
    }
    return false;
}

//情况购物车
function deleteCart(){
    var checkedNum = 0;//用户选择的总数
    var sendData = Array();
    $(".shop-group-item").each(function() { //循环每个店铺
        $(this).find(".goodsCheck").each(function() { //循环店铺里面的商品
            if ($(this).is(":checked")) { //如果该商品被选中
                checkedNum = checkedNum + 1;//统计计数
                var cartId =parseInt($(this).parents(".shop-info").find(".cartId").val()); //得到购物车单号
                sendData.push(cartId);
            }
        });
    });
    if(checkedNum != 0)
    {
        //用户选择了商铺
        $.ajax({
            type: "POST",//规定请求的类型
            url: "/api/user/cart/delete.yht",//请求地址
            data: JSON.stringify(sendData), //发送到服务器的数据
            dataType:"json",//预期服务器返回的数据类型
            contentType:"application/json",
            success:function(datas){//收到后台的响应
                if(datas.code = 0)
                {
                    //最后是data
                    layer.alert('删除成功。', {
                        title:'页面提示',
                        icon: 1,
                        skin: 'layer-ext-moon',
                    });
                    console.log(datas);
                }else
                {
                    layer.msg('删除失败', {
                        time: 5000, //5s后自动关闭
                        btn: ['知道了']
                    });
                }
            },
            error: function () {//没有收到请求
                layer.msg('操作失败', {
                    time: 5000, //5s后自动关闭
                    btn: ['知道了']
                });
                return false;
            }
        })
    }
    return false;
}

function geturldata(variable) //eg:abc.html?id=123&type=1。使用geturldata("id")将取得123，使用type将取得1
{
    var query=window.location.search.substr(1);
    var vars=query.split("&")
    for(var i=0;i<vars.length;i++)
    {
        var pair=vars[i].split("=");
        if(pair[0]==variable)
            return pair[1];
    }
    return null;
}