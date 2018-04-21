package api.dao;

import api.entity.UserEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 用户DAO
 */
@Repository("userDAO")
public interface UserDAO {


    //根据用户名查询用户
    public UserEntity getUser(@Param("username") String username);

}
