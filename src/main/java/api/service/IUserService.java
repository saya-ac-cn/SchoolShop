package api.service;

import api.entity.UserEntity;
import api.tools.Result;

public interface IUserService {

    /**
     * 修改用户资料+密码
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateUserInfo(UserEntity vo) throws Exception;

}
