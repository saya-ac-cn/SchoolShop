package api.service;

import api.entity.AdminEntity;
import api.entity.StudentEntity;
import api.tools.Result;

/**
 * 公共业务层-用于处理不需要登录的业务
 */
public interface IPublicService {

    /**
     * 判断用户是否存在
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentExist(StudentEntity vo) throws Exception;

    /**
     * 用户注册
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

}
