package api.entity;

/**
 * 基类模型
 */
public class BaseEntity {

    private String startTime;//开始时间
    private String endTime;//结束时间
    private Integer pages;//第几页
    private Integer rows;//每页显示行数

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }

    public Integer getRows() {
        return rows;
    }

    public void setRows(Integer rows) {
        this.rows = rows;
    }

    public BaseEntity() {
    }
}
