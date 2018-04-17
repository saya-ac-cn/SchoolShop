package api.service.impl;

import api.dao.StudentDAO;
import api.entity.StudentEntity;
import api.handle.MyException;
import api.service.IPublicService;
import api.tools.DesUtil;
import api.tools.Result;
import api.tools.ResultEnum;
import api.tools.ResultUtil;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service("publicService")
public class PublicServiceImpl implements IPublicService {

    @Resource
    @Qualifier("studentDAO")
    private StudentDAO studentDAO;

    /**
     * 判断商户管理员是否存在
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentExist(StudentEntity vo) throws Exception {
        List<StudentEntity> list = studentDAO.queryBasicById(vo);
        if(list.size() > 0)
        {
            return ResultUtil.success(1);
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);//未找到该学生资料
        }
    }

    /**
     * 商户管理员注册
     *
     * @param vo
     * @return
     * @throws Exception
     */
    @Transactional
    public Result<Integer> studentRegister(StudentEntity vo) throws Exception {
        Integer flog = -1;//返回标志
        if(vo.insertScenes() == false)
        {
            return ResultUtil.error(3,"用户输入的数据不符合要求");
        }
        else
        {
            List<StudentEntity> list = studentDAO.queryBasicById(vo);
            if(list.size() > 0)
            {
                throw new MyException(ResultEnum.UNKONW_ERROR);//该用户已注册过
            }
            else
            {
                vo.setPassword(DesUtil.encrypt(vo.getPassword().trim()));
                vo.setStatus("3");//统一置为审核中
                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String datetime=formatter.format(currentTime);
                vo.setCreateTime(datetime);
                if(studentDAO.insert(vo) > 0)
                {
                    return ResultUtil.success();//注册成功
                }
                else
                {
                    throw new MyException(ResultEnum.RollBACK);//注册失败
                }
            }
        }
    }

    /**
     * 商户管理员登录
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentLogin(StudentEntity vo) throws Exception
    {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        Integer sessionShopID= (Integer) request.getSession().getAttribute("ShopID");//在session中取出商户管理员的信息
        if(sessionShopID != null)
        {
            //已登录
            return ResultUtil.success();
        }
        else
        {
            //未登录
            List<StudentEntity> list = studentDAO.queryBasicById(vo);
            if (list.size() == 0)
            {
                //没有该商户管理员的信息
                return ResultUtil.error(1,"密码错误");
            }
            else
            {
                String Password = DesUtil.encrypt(vo.getPassword());//加密后商户管理员的密码
                if(((list.get(0))).getPassword().equals(Password))
                {
                    request.getSession().setAttribute("ShopID", vo.getId());//为之注入用户名
                    return ResultUtil.success();//返回登录成功
                }
                else{
                    //密码错误
                    return ResultUtil.error(1,"密码错误");
                }
            }
        }
    }

}
