package api.service.impl;

import api.dao.UserDAO;
import api.entity.UserEntity;
import api.handle.MyException;
import api.service.IUserService;
import api.tools.DesUtil;
import api.tools.Result;
import api.tools.ResultEnum;
import api.tools.ResultUtil;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service(value = "userServiceImpl")
public class UserServiceImpl implements IUserService {

    @Resource
    @Qualifier("userDAO")
    private UserDAO userDAO;

    /**
     * 修改用户资料+密码
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateUserInfo(UserEntity vo) throws Exception {
        vo.setUsername(api.tools.Service.utilGetUserName());//放入账号
        vo.setUpdateTime(api.tools.Service.utilsTime());
        if(vo.getPassword() != null || vo.getPassword().trim().equals("") != true)
        {
            vo.setPassword(DesUtil.encrypt(vo.getPassword().trim()));
        }
        if(userDAO.update(vo) > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.RollBACK);//修改失败事务回滚
        }
    }
}
