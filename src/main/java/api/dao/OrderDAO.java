package api.dao;

import api.entity.*;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 订单DAO
 */
@Repository("orderDAO")
public interface OrderDAO {

    /**
     * 判断某一商品在订单明细表中是否存在
     * @param goodsId
     * @return
     */
    public Integer existOrderByGoods(@Param("goodsId") Integer goodsId);

    /**
     * 获取子订单详情
     * @param vo
     * @return
     */
    public OrderDetailEntity getOrderDetail(OrderDetailEntity vo);

    /**
     * 查询用户相关的订单
     * @param vo
     * @return
     */
    public List<OrderReport> getOrderReport(OrderReport vo,RowBounds rowBounds);

    /**
     * 查询用户的账户情况
     * @param userID
     * @return
     */
    public WalletEntity getWallet(@Param("userID") Integer userID);

    /**
     * 插入用户资金账户
     * @param vo
     * @return
     */
    public Integer insertWallet(WalletEntity vo);

    /**
     * 变更账户资金
     * @param vo
     * @return
     */
    public Integer updateWallet(WalletEntity vo);

    /**
     * 删除订单
     * @param id
     * @return
     */
    public Integer deleteOrderItem(@Param("id") Integer id);

    /**
     * 查看用户所有的订单
     * @param vo
     * @param rowBounds
     * @return
     */
    public List<OrderQueryEntity> totalMyOrder(OrderQueryEntity vo,RowBounds rowBounds);

    /**
     * 添加一条订单
     * @param vo
     * @return
     */
    public Integer insertOrder(OrderEntity vo);

    /**
     * 添加一条订单子项
     * @param vo
     * @return
     */
    public Integer insertOrderDetail(OrderDetailEntity vo);

    /**
     * 修改订单
     * @param vo
     * @return
     */
    public Integer updateOrder(OrderEntity vo);


    /**
     * 删除子订单
     * @param id
     * @return
     */
    public Integer deleteOrderDetail(@Param("id") Integer id);


}
