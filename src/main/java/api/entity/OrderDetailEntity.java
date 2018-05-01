package api.entity;

/**
 * 订单明细
 */
public class OrderDetailEntity {

    private Integer id;
    private Integer orderId;
    private Integer goodsId;
    private float currentPrice;
    private Integer quantity;
    private double totalPrice;
    private String createTime;
    private String updateTime;

    private Integer shopId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public float getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(float currentPrice) {
        this.currentPrice = currentPrice;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public OrderDetailEntity() {
    }

    public OrderDetailEntity(Integer id, Integer orderId, Integer goodsId, Integer shopId) {
        this.id = id;
        this.orderId = orderId;
        this.goodsId = goodsId;
        this.shopId = shopId;
    }

    public OrderDetailEntity(Integer id) {
        this.id = id;
    }
}
