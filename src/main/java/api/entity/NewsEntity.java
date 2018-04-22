package api.entity;


/**
 * 动态实体类
 */
public class NewsEntity extends BaseEntity {
    private Integer id;
    private String title;
    private String content;
    private Integer author;
    private String createTime;
    private String updateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getAuthor() {
        return author;
    }

    public void setAuthor(Integer author) {
        this.author = author;
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

    public NewsEntity() {
    }

    public NewsEntity(String title, String content, Integer author, String createTime) {
        this.title = title;
        this.content = content;
        this.author = author;
        this.createTime = createTime;
    }

    public NewsEntity(Integer id, String title, String content, String updateTime) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.updateTime = updateTime;
    }
}
