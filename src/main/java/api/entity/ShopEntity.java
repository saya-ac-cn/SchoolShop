package api.entity;

/**
 * 商户实体类
 */
public class ShopEntity extends BaseEntity {

    private Integer shopId;
    private String shopName;
    private Integer studentId;
    private Integer standId;
    private String description;
    private String status;
    private String createTime;
    private String updateTime;

    private StandEntity Stand;

    private FilesEntity Files;

    /**
     * 商铺入驻、修改验证场景
     * 商铺名不为空且在50个字符内
     * 管理员id不为空
     * 摊位号不为空
     * 摊位描述
     * @return
     */
    public boolean insertScenes()
    {
        if(this.getShopName() == null || this.getShopName().trim().equals("") == true || (this.getShopName().trim().length() < 2 || this.getShopName().trim().length() > 50))
        {
            return false;
        }
        if(this.getStudentId() == null)
        {
            return false;
        }
        if(this.getStandId() == null )
        {
            return false;
        }
        if(this.getDescription() == null || this.getDescription().trim().equals("") == true || this.getDescription().trim().length() > 200)
        {
            return false;
        }
        return true;
    }

    /**
     * 修改验证场景
     * 商铺名不为空且在50个字符内
     * 管理员id不为空
     * @return
     */
    public boolean updateScenes()
    {
        if(this.getShopName() == null || this.getShopName().trim().equals("") == true || (this.getShopName().trim().length() < 2 || this.getShopName().trim().length() > 50))
        {
            return false;
        }
        if(this.getStudentId() == null)
        {
            return false;
        }
        if(this.getDescription() == null || this.getDescription().trim().equals("") == true || this.getDescription().trim().length() > 200)
        {
            return false;
        }
        return true;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getStandId() {
        return standId;
    }

    public void setStandId(Integer standId) {
        this.standId = standId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public StandEntity getStand() {
        return Stand;
    }

    public void setStand(StandEntity stand) {
        Stand = stand;
    }

    public FilesEntity getFiles() {
        return Files;
    }

    public void setFiles(FilesEntity files) {
        Files = files;
    }

    public ShopEntity() {
    }
}
