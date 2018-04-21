package api.dao;


import api.entity.GoodsEntity;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 文件DAO
 */
@Repository("goodsDAO")
public interface GoodsDAO {

    /**
     * 查询商品
     * @param vo
     * @return
     */
    public List<GoodsEntity> queryToPaging(GoodsEntity vo, RowBounds rowBounds);


    /**
     * 添加商品
     * @param vo
     * @return
     */
    public Integer insert(GoodsEntity vo);

    /**
     * 修改商品
     * @param vo
     * @return
     */
    public Integer update(GoodsEntity vo);


}
