package api.service;

import api.entity.AdminEntity;
import api.entity.StudentEntity;
import api.entity.UserEntity;
import api.tools.Result;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 公共业务层-用于处理不需要登录的业务
 */
public interface IPublicService {

    /**
     * 判断用户(商户)是否存在
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentExist(StudentEntity vo) throws Exception;

    /**
     * 用户（商户）注册
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentRegister(StudentEntity vo) throws Exception;


    /**
     * 商户管理员登录
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentLogin(StudentEntity vo) throws Exception;

    /**
     * 运维管理员登录
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> adminLogin(AdminEntity vo) throws Exception;

    /**
     * 判断会员用户是否存在
     * @param username
     * @return
     * @throws Exception
     */
    public Result<Integer> userExist(String username) throws Exception;

    /**
     * 会员登录
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> userLogin(UserEntity vo) throws Exception;

    /**
     * 会员登录
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> userRegister(UserEntity vo)throws Exception;


}
