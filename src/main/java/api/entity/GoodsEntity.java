package api.entity;

/**
 * 商品类
 */
public class GoodsEntity extends BaseEntity{

    private Integer id;
    private Integer shopId;
    private String name;
    private String subtitle;
    private String mainImages;
    private String detail;
    private float price;
    private Integer stock;
    private String status;
    private String createTime;
    private String updateTime;


    /**
     * 添加商品
     * @return
     */
    public boolean insertScenes()
    {
        if(this.getShopId() == null)
        {
            return false;
        }
        if(this.getName() == null || this.getName().trim().equals("") == true || (this.getName().trim().length() < 2 || this.getName().trim().length() > 40))
        {
            return false;
        }
        if(this.getSubtitle() == null || this.getSubtitle().trim().equals("") == true || this.getSubtitle().trim().length() > 70)
        {
            return false;
        }
        if(this.getMainImages() == null || this.getMainImages().trim().equals("") == true)
        {
            return false;
        }
        if(this.getDetail() == null || this.getDetail().trim().equals("") == true || this.getDetail().trim().length() > 255)
        {
            return false;
        }
        if(this.getStatus() == null || this.getStatus().trim().equals("") == true)
        {
            return false;
        }
        if(this.getCreateTime() == null || this.getCreateTime().trim().equals("") == true)
        {
            return false;
        }
        return true;
    }


    /**
     * 修改商品
     * @return
     */
    public boolean updateScenes()
    {
        if(this.getId() == null)
        {
            return false;
        }
        if(this.getShopId() == null)
        {
            return false;
        }
        if(this.getName() == null || this.getName().trim().equals("") == true || (this.getName().trim().length() < 2 || this.getName().trim().length() > 40))
        {
            return false;
        }
        if(this.getSubtitle() == null || this.getSubtitle().trim().equals("") == true || this.getSubtitle().trim().length() > 70)
        {
            return false;
        }
        if(this.getMainImages() == null || this.getMainImages().trim().equals("") == true)
        {
            return false;
        }
        if(this.getDetail() == null || this.getDetail().trim().equals("") == true || this.getDetail().trim().length() > 255)
        {
            return false;
        }
        if(this.getUpdateTime() == null || this.getUpdateTime().trim().equals("") == true)
        {
            return false;
        }
        return true;
    }


    /**
     * 删除商品
     * @return
     */
    public boolean deleteScenes()
    {
        if(this.getId() == null)
        {
            return false;
        }
        if(this.getShopId() == null)
        {
            return false;
        }
        if(this.getStatus() == null || this.getStatus().trim().equals("") == true)
        {
            return false;
        }
        if(this.getUpdateTime() == null || this.getUpdateTime().trim().equals("") == true)
        {
            return false;
        }
        return true;
    }



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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public GoodsEntity() {
    }

    public GoodsEntity(Integer id, Integer shopId) {
        this.id = id;
        this.shopId = shopId;
    }
}
