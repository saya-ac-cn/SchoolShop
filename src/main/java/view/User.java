package view;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 用户视图控制器
 */

@Controller
@RequestMapping(value = "/view/user")
public class User {

    /**
     * 用户个人信息页面(主页)
     * @return
     */
    @RequestMapping(value = {"/user.html","/"})
    public String actionUserInfo()
    {
        String Viewname = "user/user";
        return Viewname;
    }

    /**
     * 修改密码
     * @return
     */
    @RequestMapping(value = "/password.html")
    public String actionPassword()
    {
        String Viewname = "user/password";
        return Viewname;
    }

}
