package view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * 管理员视图
 */
@Controller
@RequestMapping(value = "/view/admin")
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

    /**
     * 发布动态
     * @return
     */
    @RequestMapping(value = "/addNews.html")
    public String addNews()
    {
        String Viewname = "admin/addNews";
        return Viewname;
    }

    /**
     * 管理动态
     * @return
     */
    @RequestMapping(value = "/manaNews.html")
    public String manaNews()
    {
        String Viewname = "admin/manaNews";
        return Viewname;
    }

    /**
     * 管理动态
     * @return
     */
    @RequestMapping(value = "/modifyNews.html")
    public String modifyNews(@RequestParam(value = "newsid") Integer newsid)
    {
        String Viewname = "admin/modifyNews";
        return Viewname;
    }

    /**
     * 管理会员
     * @return
     */
    @RequestMapping(value = "/manaUser.html")
    public String manaUser()
    {
        String Viewname = "admin/manaUser";
        return Viewname;
    }

}
