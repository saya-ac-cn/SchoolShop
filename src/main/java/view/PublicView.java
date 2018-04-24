package view;

import api.tools.Service;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;


@Controller
public class PublicView {

    /**
     * 商户登录
     * @return
     */
    @RequestMapping(value = {"/","/shopLogin.html"})
    public String viewShopLogin()
    {
        Integer shopAdmin = Service.utilGetShopID();//在session中取出商户管理员的信息
        String view = "shoplogin";
        if(shopAdmin != null)
        {
            view = "redirect:/view/shop/";
        }
        return view;
    }

    /**
     * 商户入住
     * @return
     */
    @RequestMapping(value = "register.html")
    public String register()
    {
        String view = "register";
        return view;
    }

    /**
     * 商户注销
     * @return
     */
    @RequestMapping(value = {"/shopLogout.html"})
    public String shopLogout()
    {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        request.getSession().removeAttribute("ShopID");
        request.getSession().removeAttribute("ShopAdmin");
        request.getSession().removeAttribute("img");
        String view = "redirect:/shopLogin.html";
        return view;
    }

    /**
     * 管理员登录
     * @return
     */
    @RequestMapping(value = "/adminLogin.html")
    public String viewAdminLogin()
    {
        Integer shopAdmin = Service.utilGetAdminID();//在session中取出商户管理员的信息
        String view = "adminlogin";
        if(shopAdmin != null)
        {
            view = "redirect:/view/admin/";
        }
        return view;
    }

    /**
     * 管理员注销
     * @return
     */
    @RequestMapping(value = {"/adminLogout.html"})
    public String adminLogout()
    {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        request.getSession().removeAttribute("AdminID");
        request.getSession().removeAttribute("AdminName");
        request.getSession().removeAttribute("Adminimg");
        String view = "redirect:/adminLogin.html";
        return view;
    }


    /**
     * 会员注销
     * @return
     */
    @RequestMapping(value = {"/userLogout.html"})
    public String userLogout()
    {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        request.getSession().removeAttribute("UserID");
        request.getSession().removeAttribute("UserName");
        String view = "redirect:/userLogin.html";
        return view;
    }

    /**
     * 会员注册
     * @return
     */
    @RequestMapping(value = "userRegister.html")
    public String userRegister()
    {
        String view = "/user/register";
        return view;
    }

    /**
     * 会员登录
     * @return
     */
    @RequestMapping(value = "/userLogin.html")
    public String viewUserLogin()
    {
        Integer Shop= Service.utilGetShopID();//在session中取出会员的信息
        String view = "/user/login";
        if(Shop != null)
        {
            view = "redirect:/view/user/";
        }
        return view;
    }


}
