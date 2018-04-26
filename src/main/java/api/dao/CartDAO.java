package api.dao;


import api.entity.CartEntity;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 购物车DAO
 */
@Repository("cartDAO")
public interface CartDAO {

    //添加到购物车
    public Integer insert(CartEntity vo);

    //修改购物车
    public Integer update(CartEntity vo);

    //删除购物车
    public Integer delete(CartEntity vo);

    //获取购物车信息
    public List<CartEntity> getAll(CartEntity vo, RowBounds rowBounds);

}
