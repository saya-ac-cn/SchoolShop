package api.service;

import api.entity.*;
import api.tools.Result;

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
     * @param orderId
     * @return
     * @throws Exception
     */
    public Result<Object> cancelOrder(Integer orderId) throws Exception;



}
