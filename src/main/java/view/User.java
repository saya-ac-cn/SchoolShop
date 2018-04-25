package view;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

    /**
     * 查看收货地址
     * @return
     */
    @RequestMapping(value = "/address.html")
    public String actionAddress()
    {
        String Viewname = "user/address";
        return Viewname;
    }

    /**
     * 添加收货地址
     * @return
     */
    @RequestMapping(value = "/addAddress.html")
    public String actionAddAddress()
    {
        String Viewname = "user/addAddress";
        return Viewname;
    }

    /**
     * 管理收货地址
     * @return
     */
    @RequestMapping(value = "/updateAddress.html")
    public String actionUpdateAddress(@RequestParam(value = "id") Integer id)
    {
        String Viewname = "user/updateAddress";
        return Viewname;
    }

    /**
     * 查看所有的订单
     * @return
     */
    @RequestMapping(value = "/order.html")
    public String actionOrder()
    {
        String Viewname = "user/order";
        return Viewname;
    }

    /**
     * 订单详情
     * @return
     */
    @RequestMapping(value = "/orderDetail.html")
    public String actionOrderDetail(@RequestParam(value = "id") Integer id)
    {
        String Viewname = "user/orderDetail";
        return Viewname;
    }

}
