package api.tools;

/**
 * 枚举异常的类型
 */
public enum ResultEnum {

    UNKONW_ERROR(-1, "未知错误"),
    SUCCESS(0, "处理成功"),
    ERROP(1,"处理失败"),
    NOT_EXIST(2,"记录不存在"),
    RollBACK(3,"操作无效，数据回滚"),
    FORBID_POWER(4,"接口已关闭");

    private int code;

    private String msg;

    ResultEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

}