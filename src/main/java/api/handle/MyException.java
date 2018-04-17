package api.handle;

import api.tools.ResultEnum;

/**
 * 自定义的异常处理
 */
public class MyException extends RuntimeException {

    private int code;

    public MyException(ResultEnum resultEnum) {
        super(resultEnum.getMsg());
        this.code = resultEnum.getCode();
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

}
