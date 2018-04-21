package api.dao;

import api.entity.OrderDetailEntity;
import api.entity.OrderEntity;
import api.entity.OrderReport;
import api.entity.WalletEntity;
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
     * 变更账户资金
     * @param vo
     * @return
     */
    public Integer updateWallet(WalletEntity vo);

    /**
     * 删除订单
     * @param vo
     * @return
     */
    public Integer deleteOrderItem(OrderDetailEntity vo);

}
