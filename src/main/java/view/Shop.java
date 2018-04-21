package view;


import api.service.impl.ShopServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 商家视图控制器
 */

@Controller
@RequestMapping(value = "/shop")
public class Shop {

    @Autowired
    @Qualifier("shopServiceImpl")
    private ShopServiceImpl shopServiceImpl;

    /**
     * 主页
     * @return
     */
    @RequestMapping(value = {"/","/index.html","/home.html"})
    public String actionHome()
    {
        String Viewname = "shop";
        return Viewname;
    }

    /**
     * 用户个人信息页面
     * @return
     */
    @RequestMapping(value = {"/userInfo.html"})
    public String actionUserInfo()
    {
        String Viewname = "shop/userInfo";
        return Viewname;
    }

    /**
     * 修改密码和修改密保
     * @return
     */
    @RequestMapping(value = {"/setting.html"})
    public String actionSetting()
    {
        String Viewname = "shop/setting";
        return Viewname;
    }

    /**
     * 管理商户图片
     * @return
     */
    @RequestMapping(value = {"/pictureMana.html"})
    public String actionPicturnMana()
    {
        String Viewname = "shop/pictureMana";
        return Viewname;
    }

    /**
     * 查看个人商户详情
     * @return
     */
    @RequestMapping(value = "/shopinfo.html")
    public String actionViewShopInfo() throws Exception
    {
        String Viewname = "";
        if(shopServiceImpl.checkShopStatus().equals("noexist") == true)
        {
            //跳转至注册页面
            Viewname = "shop/registerShop";
        }
        else
        {
            //直接显示
            Viewname = "shop/manaShopInfo";
        }
        return Viewname;
    }

    /**
     * 添加商品
     * @return
     */
    @RequestMapping(value = "/addGoods.html")
    public String addGoods()
    {
        String Viewname = "shop/addGoods";
        return Viewname;
    }

    /**
     * 修改商品
     * @return
     */
    @RequestMapping(value = "/modifyGoods.html")
    public String goodsModify()
    {
        String Viewname = "shop/modifyGoods";
        return Viewname;
    }

    /**
     * 下架商品
     * @return
     */
    @RequestMapping(value = "/deleteGoods.html")
    public String deleteGoods()
    {
        String Viewname = "shop/deleteGoods";
        return Viewname;
    }

    /**
     * 订单统计
     * @return
     */
    @RequestMapping(value = "/orderReport.html")
    public String orderReport()
    {
        String Viewname = "shop/orderReport";
        return Viewname;
    }

    /**
     * 管理订单
     * @return
     */
    @RequestMapping(value = "/orderMana.html")
    public String orderMana()
    {
        String Viewname = "shop/orderMana";
        return Viewname;
    }


}
