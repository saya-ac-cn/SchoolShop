package api.controller;


import api.entity.*;
import api.service.impl.UserServiceImpl;
import api.tools.Result;
import api.tools.ResultUtil;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 会员控制器
 */
@RestController
@RequestMapping(value = "/api/user")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserServiceImpl userServiceImpl;

    /**
     * 修改个人信息+密码
     * @param vo
     * @return
     * @throws Exception
     */
    @PutMapping(value = "/updateUserInfo.yht")
    Result<Integer> updateUserInfo(UserEntity vo) throws Exception
    {
        return userServiceImpl.updateUserInfo(vo);
    }

    /**
     * 取得用户所有的收货地址
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/address/get.yht")
    public Result<Object> getAllAddress(AddressEntity vo) throws Exception{
        return userServiceImpl.getAllAddress(vo);
    }

    /**
     * 添加用户的收货地址
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/address/add.yht")
    public Result<Integer> addAddress(AddressEntity vo) throws Exception{
        return userServiceImpl.addAddress(vo);
    }

    /**
     * 修改用户的收货地址
     * @param vo
     * @return
     * @throws Exception
     */
    @PutMapping(value = "/address/update.yht")
    public Result<Integer> updateAddress(AddressEntity vo) throws  Exception{
        return userServiceImpl.updateAddress(vo);
    }

    /**
     * 删除用户的收货地址
     * @param vo
     * @return
     * @throws Exception
     */
    @DeleteMapping(value = "/address/dell.yht")
    public Result<Integer> deleteAddress(AddressEntity vo) throws Exception{
        return userServiceImpl.deleteAddress(vo);
    }

    /**
     * 查看用户的所有订单
     * @param vo
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/order/total.yht")
    public Result<Object> getMyOrder(OrderQueryEntity vo) throws Exception
    {
        return userServiceImpl.getMyOrder(vo);
    }

    /**
     * 删除未支付的订单
     * @param orderId
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/order/delete/{orderId}")
    public Result<Object> cancelOrder(@PathVariable("orderId") int orderId) throws Exception{
        return userServiceImpl.cancelOrder(orderId);
    }

    /**
     * 获取个人的数据总览
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/index/total.yht")
    public Result<Object> indexData() throws Exception{
        return userServiceImpl.indexData();
    }

    /**
     * 取出个人信息
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/index/info.yht")
    public Result<Object> getMyinfo() throws Exception
    {
        return userServiceImpl.getMyinfo();
    }

    /**
     * 上传用户logo
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/logo/upload.yht")
    public Result<String> uploadLogo(HttpServletRequest request, MultipartFile file) throws Exception
    {
        return userServiceImpl.uploadLogo(request,file);
    }

    /**
     * 添加到收藏夹
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/collect/add.yht")
    public Result<Integer> addCollect(CollectGoodsEntity vo) throws Exception
    {
        return userServiceImpl.addCollect(vo);
    }

    /**
     * 取消收藏
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/collect/delete.yht")
    public Result<Integer> deleteCollect(CollectGoodsEntity vo) throws Exception
    {
        return userServiceImpl.deleteCollect(vo);
    }

    /**
     * 取出所有的收藏
     * @param vo
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/collect/get.yht")
    public Result<Object> getAllCollect(CollectGoodsEntity vo) throws Exception
    {
        return userServiceImpl.getAllCollect(vo);
    }

    /**
     * 添加到购物车
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/cart/add.yht")
    public Result<Integer> addCart(CartEntity vo) throws Exception
    {
        return userServiceImpl.addCart(vo);
    }

    /**
     * 取出用户的购物车信息
     * @param vo
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/cart/get.yht")
    public Result<Object> getAllCart(CartEntity vo) throws Exception
    {
        return userServiceImpl.getAllCart(vo);
    }

    /**
     * 添加到订单中
     * @param cart
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/order/add.yht")
    public Result<Object> addOrder(@RequestBody List<CartEntity> cart) throws Exception
    {
        return userServiceImpl.addOrder(cart);
    }





}
