package view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 管理员视图
 */
@Controller
@RequestMapping(value = "/admin")
public class Admin {

    /**
     * 主页
     * @return
     */
    @RequestMapping(value = {"/","/index.html","/home.html"})
    public String actionHome()
    {
        String Viewname = "admin";
        return Viewname;
    }

    /**
     * 个人信息页面
     * @return
     */
    @RequestMapping(value = "/info.html")
    public String actionInfo()
    {
        String Viewname = "admin/adminInfo";
        return Viewname;
    }

    /**
     * 审核商铺页面
     * @return
     */
    @RequestMapping(value = "/reviewShop.html")
    public String reviewShop()
    {
        String Viewname = "admin/reviewShop";
        return Viewname;
    }

    /**
     * 管理摊位
     * @return
     */
    @RequestMapping(value = "/manaStand.html")
    public String manaStand()
    {
        String Viewname = "admin/manaStand";
        return Viewname;
    }

}
