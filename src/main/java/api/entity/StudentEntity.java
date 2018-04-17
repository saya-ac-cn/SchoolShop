package api.entity;

import api.tools.Expression;

/**
 * 学生-商户实体类
 */
public class StudentEntity extends  BaseEntity{

    private Integer id;
    private String name;
    private String password;
    private String college;
    private String classes;
    private String apartment;
    private String email;
    private String mobile;
    private String question;
    private String answer;
    private String status;
    private String createTime;
    private String updateTime;

    private ShopEntity Shop;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCollege() {
        return college;
    }

    public void setCollege(String college) {
        this.college = college;
    }

    public String getClasses() {
        return classes;
    }

    public void setClasses(String classes) {
        this.classes = classes;
    }

    public String getApartment() {
        return apartment;
    }

    public void setApartment(String apartment) {
        this.apartment = apartment;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
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

    public ShopEntity getShop() {
        return Shop;
    }

    public void setShop(ShopEntity shop) {
        Shop = shop;
    }

    public StudentEntity() {
    }

    /**
     * 用户注册验证场景
     * 学号不为空
     * 姓名不为空且在2~20个字符内
     * 密码不为空且在6~20个字符内
     * 系别不为空且在20个字符内
     * 班级不为空且在20个字符内
     * 公寓不为空且在20个字符内
     * 邮箱不为空且在20个字符内
     * 移动电话不为空且在11个字符内
     * 问题不为空限制在30个字符内
     * 答案不为空限制在50个字符内
     * @return
     */
    public boolean insertScenes()
    {
        if(this.getId() == null )
        {
            return false;
        }
        if(this.getName() == null || this.getName().trim().equals("") == true || (this.getName().trim().length() < 2 || this.getName().trim().length() > 20))
        {
           return false;
        }
        if(this.getPassword() == null || this.getPassword().trim().equals("") == true || (this.getPassword().trim().length() < 6 || this.getPassword().trim().length() > 20))
        {
            return false;
        }
        if(this.getCollege() == null || this.getCollege().trim().equals("") == true || this.getClasses().trim().length() > 20)
        {
            return false;
        }
        if(this.getClasses() == null || this.getClasses().trim().equals("") == true || this.getClasses().trim().length() > 20)
        {
            return false;
        }
        if(this.getApartment() == null || this.getApartment().trim().equals("") == true || this.getApartment().trim().length() > 20)
        {
            return false;
        }
        if(this.getEmail() == null || this.getEmail().trim().equals("") == true || this.getEmail().trim().length() >30 || Expression.checkEmaile(this.getEmail().trim()) == false)
        {
            return false;
        }
        if(this.getMobile() == null || this.getMobile().trim().equals("") == true || this.getMobile().trim().length() !=11 || Expression.checkmobile(this.getMobile().trim()) == false)
        {
            return false;
        }
        if(this.getQuestion() == null || this.getQuestion().trim().equals("") == true || this.getQuestion().trim().length() >= 30)
        {
            return false;
        }
        if(this.getAnswer() == null || this.getAnswer().trim().equals("") == true || this.getAnswer().trim().length() >= 50)
        {
            return false;
        }
        return true;
    }

    /**
     * 修改个人信息场景
     * 系别不为空且在20个字符内
     * 班级不为空且在20个字符内
     * 公寓不为空且在20个字符内
     * 邮箱不为空且在20个字符内
     * 移动电话不为空且在11个字符内
     * @return
     */
    public boolean updateScenes()
    {
        if(this.getCollege() == null || this.getCollege().trim().equals("") == true || this.getClasses().trim().length() > 20)
        {
            return false;
        }
        if(this.getClasses() == null || this.getClasses().trim().equals("") == true || this.getClasses().trim().length() > 20)
        {
            return false;
        }
        if(this.getApartment() == null || this.getApartment().trim().equals("") == true || this.getApartment().trim().length() > 20)
        {
            return false;
        }
        if(this.getEmail() == null || this.getEmail().trim().equals("") == true || this.getEmail().trim().length() >30 || Expression.checkEmaile(this.getEmail().trim()) == false)
        {
            return false;
        }
        if(this.getMobile() == null || this.getMobile().trim().equals("") == true || this.getMobile().trim().length() !=11 || Expression.checkmobile(this.getMobile().trim()) == false)
        {
            return false;
        }
        return true;
    }

    /**
     * 修改密码验证场景
     * 密码不为空且在6~20个字符内
     * @return
     */
    public boolean updatePasswordScenes()
    {
        if(this.getPassword() == null || this.getPassword().trim().equals("") == true || (this.getPassword().trim().length() < 6 || this.getPassword().trim().length() > 20))
        {
            return false;
        }
        return true;
    }

    /**
     * 修改密保场景
     * @return
     */
    public boolean updateMiBaoScenes()
    {
        if(this.getQuestion().trim().length() >= 20)
            return false;
        if(this.getAnswer().trim().length() >= 50)
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "StudentEntity{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", college='" + college + '\'' +
                ", classes='" + classes + '\'' +
                ", apartment='" + apartment + '\'' +
                ", email='" + email + '\'' +
                ", mobile='" + mobile + '\'' +
                ", question='" + question + '\'' +
                ", answer='" + answer + '\'' +
                ", status='" + status + '\'' +
                ", createTime='" + createTime + '\'' +
                ", updateTime='" + updateTime + '\'' +
                '}';
    }
}
