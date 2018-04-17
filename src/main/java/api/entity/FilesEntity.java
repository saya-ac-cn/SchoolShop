package api.entity;

/**
 * 用户文件
 */
public class FilesEntity extends BaseEntity {

    private Integer pictureId;
    private String  typy;
    private Integer user;
    private String url;

    public Integer getPictureId() {
        return pictureId;
    }

    public void setPictureId(Integer pictureId) {
        this.pictureId = pictureId;
    }

    public String getTypy() {
        return typy;
    }

    public void setTypy(String typy) {
        this.typy = typy;
    }

    public Integer getUser() {
        return user;
    }

    public void setUser(Integer user) {
        this.user = user;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public FilesEntity() {
    }

    public FilesEntity(Integer pictureId, String typy, Integer user) {
        this.pictureId = pictureId;
        this.typy = typy;
        this.user = user;
    }

    public FilesEntity(Integer pictureId,Integer user) {
        this.pictureId = pictureId;
        this.user = user;
    }

    public FilesEntity(String typy, Integer user) {
        this.typy = typy;
        this.user = user;
    }

    public FilesEntity(String typy, Integer user, String url) {
        this.typy = typy;
        this.user = user;
        this.url = url;
    }
}
