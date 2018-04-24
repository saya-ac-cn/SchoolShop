package api.service;

import api.entity.*;
import api.tools.LayuiTable;
import api.tools.Result;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 商户管理中心业务层接口
 */
public interface IShopService {


    /**
     * 获取用户的基本信息
     * @return
     * @throws Exception
     */
    public Result<StudentEntity> getStudentInfo(StudentEntity vo) throws Exception;

    /**
     * 商户管理员修改个人信息
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentUpdateInfo(StudentEntity vo) throws  Exception;

    /**
     * 商户管理员修改密码
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentUpdatePass(StudentEntity vo) throws  Exception;


    /**
     * 商户管理员修改密码保护问题
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> studentUpdateMibao(StudentEntity vo) throws  Exception;

    /**
     * 商户入住
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> shopRegister(ShopEntity vo) throws Exception;


    /**
     * 上传商品图片
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    public Result<String> uploadPictureGoods(HttpServletRequest request, MultipartFile file,String type) throws  Exception;

    /**
     * 上传图片（头像、商户logo、商品图片的基类）
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    public Result<String> uploadPictureUtil(HttpServletRequest request, MultipartFile file) throws  Exception;

    /**
     * 浏览图片
     * @param page
     * @param rows
     * @return
     * @throws Exception
     */
    public Result<Object> viewPicture(Integer page,Integer rows) throws Exception;


    /**
     * 删除图片
     * @param request
     * @param pictureId
     * @return
     * @throws Exception
     */
    public Result<Object> deletePicture(HttpServletRequest request,Integer pictureId) throws Exception;

    /**
     * 展示商户的详细资料
     * @param request
     * @return
     * @throws Exception
     */
    public Result<Object> displayShopInfo(HttpServletRequest request)throws Exception;

    /**
     * 检查商户的账户状态
     * @return
     * @throws Exception
     */
    public String checkShopStatus() throws Exception;

    /**
     * 上传商铺头像
     * @param request
     * @param file
     * @param type
     * @return
     * @throws Exception
     */
    public Result<String> uploadLogo(HttpServletRequest request, MultipartFile file,String type) throws Exception;

    /**
     * 修改商户信息
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> updateShopInfo(ShopEntity vo) throws Exception;

    /**
     * 添加商品
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> insertGoods(GoodsEntity vo) throws  Exception;

    /**
     * 商品分页
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> goodsPaging(GoodsEntity vo) throws Exception;

    /**
     * 修改商品
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> updateGoods(GoodsEntity vo) throws Exception;

    /**
     * 下架商品
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> deleteGoods(GoodsEntity vo) throws Exception;

    /**
     * 获取订单报表
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> orderReportPagin(OrderReport vo) throws Exception;

    /**
     * 撤销订单
     * @param itermOrderId 子订单号
     * @param ststus 该订单的状态
     * param user 用户的账号
     * @return
     * @throws Exception
     */
    public Result<Object> deleteOrder(Integer itermOrderId,String ststus,String user) throws Exception;

    /**
     * 获取相关的站内消息
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> getMessage(MessageEntity vo) throws Exception;

}
