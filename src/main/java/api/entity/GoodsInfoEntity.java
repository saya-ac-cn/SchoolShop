package api.entity;

/**
 * 商品详情
 */
public class GoodsInfoEntity extends BaseEntity {

    public Integer id;
    public Integer shopId;
    public String name;
    public String subtitle;
    public String mainImages;
    public String detail;
    public Float price;
    public Integer stock;
    public String shopName;
    public String standName;
    public String location;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getMainImages() {
        return mainImages;
    }

    public void setMainImages(String mainImages) {
        this.mainImages = mainImages;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getStandName() {
        return standName;
    }

    public void setStandName(String standName) {
        this.standName = standName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public GoodsInfoEntity() {
    }
}
