package api.dao;

import api.entity.UserEntity;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户DAO
 */
@Repository("userDAO")
public interface UserDAO {


    //根据用户名查询用户
    public UserEntity getUser(@Param("username") String username);

    //查询所有的用户
    public List<UserEntity> getAllUser(UserEntity vo, RowBounds rowBounds);

    //修改用户的信息
    public Integer update(UserEntity vo);

    //添加用户
    public Integer insert(UserEntity vo);

}
