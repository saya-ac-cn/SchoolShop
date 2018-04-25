package api.controller;


import api.entity.AddressEntity;
import api.entity.NewsEntity;
import api.entity.OrderQueryEntity;
import api.entity.UserEntity;
import api.service.impl.UserServiceImpl;
import api.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

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


}
