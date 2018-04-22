package api.entity;

/**
 * 站内消息模型
 */
public class MessageEntity extends BaseEntity {

    private Integer id;
    private Integer send;
    private Integer receive;
    private String title;
    private String content;
    private String datetime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSend() {
        return send;
    }

    public void setSend(Integer send) {
        this.send = send;
    }

    public Integer getReceive() {
        return receive;
    }

    public void setReceive(Integer receive) {
        this.receive = receive;
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

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public MessageEntity() {
    }

    public MessageEntity(Integer send, Integer receive, String title, String content, String datetime) {
        this.send = send;
        this.receive = receive;
        this.title = title;
        this.content = content;
        this.datetime = datetime;
    }
}
