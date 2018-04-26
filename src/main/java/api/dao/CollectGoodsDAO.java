package api.dao;


import api.entity.CollectGoodsEntity;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 收藏的商品DAO
 */
@Repository("collectGoodsDAO")
public interface CollectGoodsDAO {


    //添加到收藏夹
    public Integer insert(CollectGoodsEntity vo);

    //删除收藏夹
    public Integer delete(CollectGoodsEntity vo);

    //获取收藏夹
    public List<CollectGoodsEntity> getAll(CollectGoodsEntity vo, RowBounds rowBounds);

}
