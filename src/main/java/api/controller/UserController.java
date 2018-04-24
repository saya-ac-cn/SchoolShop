package api.controller;


import api.entity.UserEntity;
import api.service.impl.UserServiceImpl;
import api.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 会员控制器
 */
@RestController
@RequestMapping(value = "/api/user")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserServiceImpl userServiceImpl;

    /**
     * 修改个人信息+密码
     * @param vo
     * @return
     * @throws Exception
     */
    @PutMapping(value = "/updateUserInfo.yht")
    Result<Integer> updateUserInfo(UserEntity vo) throws Exception
    {
        return userServiceImpl.updateUserInfo(vo);
    }



}
