package api.entity;

/**
 * 用户订单汇总（只适用于查询）
 */
public class OrderQueryEntity extends BaseEntity {

    private Integer goodsId;//商品编号
    private String imgUrl;// 图片地址,
    private String goodsName;// 商品名,
    private Integer orderId;// 订单号,
    private Double payment;// 付款金额,
    private String status;// 支付状态,
    private  String shopName;//商家名,
    private Float currentPrice;//单价,
    private  Integer quantity;//数量,
    private Double totalPrice;//总价,
    private String address;//收货地址,
    private String createTime;//创建时间,
    private String payTime;//支付时间
    private Integer userId;//用户编号
    private Integer orderDetail;//子订单号
    private Integer shopId;//商户Id
    private Integer studentId;//商户所属管理员账号

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Double getPayment() {
        return payment;
    }

    public void setPayment(Double payment) {
        this.payment = payment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public Float getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(Float currentPrice) {
        this.currentPrice = currentPrice;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(Integer orderDetail) {
        this.orderDetail = orderDetail;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public OrderQueryEntity() {
    }

    public OrderQueryEntity(Integer orderId) {
        this.orderId = orderId;
    }
}
