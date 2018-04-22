package api.tools;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 服务层助手类
 */
public class Service {

    /**
     * 返回当前时间
     * @return
     */
    public static String utilsTime()
    {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return formatter.format(currentTime);
    }

    /**
     * session中取出商户管理员的信息
     * @return
     */
    public static Integer utilGetShopID()
    {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        return (Integer) request.getSession().getAttribute("ShopID");
    }

    /**
     * session中取出管理员的信息
     * @return
     */
    public static Integer utilGetAdminID()
    {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        return (Integer) request.getSession().getAttribute("AdminID");
    }

}
