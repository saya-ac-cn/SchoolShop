package api.service;

import api.entity.*;
import api.tools.Result;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IUserService {

    /**
     * 修改用户资料+密码
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateUserInfo(UserEntity vo) throws Exception;

    /**
     * 获取用户所有的收货地址
     * @return
     * @throws Exception
     */
    public Result<Object> getAllAddress(AddressEntity vo) throws Exception;

    /**
     * 用户添加收货地址
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> addAddress(AddressEntity vo) throws Exception;

    /**
     * 用户修改收货地址
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateAddress(AddressEntity vo) throws  Exception;

    /**
     * 删除用户的收货地址
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> deleteAddress(AddressEntity vo) throws Exception;

    /**
     * 获取用户的订单
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> getMyOrder(OrderQueryEntity vo) throws Exception;

    /**
     * 删除订单
     * @param orderDetail
     * @return
     * @throws Exception
     */
    public Result<Object> cancelOrder(Integer orderDetail) throws Exception;


    /**
     * 统计用户的相关数据信息
     * @return
     * @throws Exception
     */
    public Result<Object> indexData() throws Exception;

    /**
     * 取出个人信息
     * @return
     * @throws Exception
     */
    public Result<Object> getMyinfo() throws Exception;



    /**
     * 上传用户图片
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    public Result<String> uploadLogo(HttpServletRequest request, MultipartFile file) throws  Exception;

    /**
     * 上传图片（头像的基类）
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    public Result<String> uploadPictureUtil(HttpServletRequest request, MultipartFile file) throws  Exception;

    /**
     * 用户添加到收藏夹
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> addCollect(CollectGoodsEntity vo) throws Exception;

    /**
     * 删除收藏商品
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> deleteCollect(CollectGoodsEntity vo) throws Exception;

    /**
     * 获取所有的收藏
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> getAllCollect(CollectGoodsEntity vo) throws Exception;

    /**
     * 添加到购物车
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> addCart(CartEntity vo) throws Exception;

    /**
     * 取出用户的购物车
     * @return
     * @throws Exception
     */
    public Result<Object> getAllCart(CartEntity vo) throws Exception;

    /**
     * 删除购物车中的数据，并添加到订单中
     * @param cartList
     * @return
     * @throws Exception
     */
    public Result<Object> addOrder(List<CartEntity> cartList) throws Exception;

    /**
     * 获取用户的余额
     * @return
     * @throws Exception
     */
    public Result<Object> getMoney() throws Exception;

    /**
     * 用户支付
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> buy(OrderEntity vo) throws Exception;


    /**
     * 删除购物车
     * @param cartId
     * @return
     * @throws Exception
     */
    public Result<Integer> deleteCart(List<Integer> cartId) throws Exception;
//    public Result<Integer> updateCart(CartEntity vo) throws Exception;
//


}
