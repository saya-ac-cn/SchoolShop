package api.dao;


import api.entity.NewsEntity;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 动态DAO
 */
@Repository("newsDAO")
public interface NewsDAO {

    //获取所有的动态
    public List<NewsEntity> getAll(NewsEntity vo, RowBounds rowBounds);

    //发布动态
    public Integer insert(NewsEntity vo);

    //修改动态
    public Integer update(NewsEntity vo);

    //删除动态
    public Integer delete(@Param("id") Integer id);


}
