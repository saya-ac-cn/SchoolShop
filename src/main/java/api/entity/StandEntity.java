package api.entity;

public class StandEntity extends BaseEntity{

    private Integer id;
    private String standName;
    private String location;
    private String status;
    private String createTime;
    private String updateTime;

    private String choise;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStandName() {
        return standName;
    }

    public void setStand_name(String standName) {
        this.standName = standName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setStandName(String standName) {
        this.standName = standName;
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

    public String getChoise() {
        return choise;
    }

    public void setChoise(String choise) {
        this.choise = choise;
    }

    public StandEntity() {
    }

    public StandEntity(Integer id, String choise) {
        this.id = id;
        this.choise = choise;
    }
}
