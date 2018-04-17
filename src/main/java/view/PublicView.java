package view;

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
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        Integer shopAdmin = (Integer) request.getSession().getAttribute("ShopID");//在session中取出商户管理员的信息
        String view = "shoplogin";
        if(shopAdmin != null)
        {
            view = "redirect:/shop/";
        }
        return view;
    }


}
