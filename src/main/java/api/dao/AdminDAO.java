package api.dao;

import api.entity.AdminEntity;
import api.entity.UserEntity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * 管理员DAO
 */
@Repository("adminDAO")
public interface AdminDAO {


    //根据用户编号或者用户名查询用户
    public AdminEntity getAdmin(AdminEntity vo);

    //修改管理员的信息
    public Integer updateAdmin(AdminEntity vo);

}
