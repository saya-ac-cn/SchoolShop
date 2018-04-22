package api.dao;


import api.entity.MessageEntity;
import api.entity.StandEntity;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("standDAO")
public interface StandDAO {

    /**
     * 获取相关的摊位
     * @param vo
     * @return
     */
    public List<StandEntity> getStand(StandEntity vo, RowBounds rowBounds);

    /**
     * 新增摊位
     * @param vo
     * @return
     */
    public Integer insert(StandEntity vo);

    /**
     * 修改摊位
     * @param vo
     * @return
     */
    public Integer update(StandEntity vo);


}
