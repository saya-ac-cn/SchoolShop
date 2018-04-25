package api.service.impl;

import api.dao.AddressDAO;
import api.dao.NewsDAO;
import api.dao.OrderDAO;
import api.dao.UserDAO;
import api.entity.*;
import api.handle.MyException;
import api.service.IUserService;
import api.tools.DesUtil;
import api.tools.Result;
import api.tools.ResultEnum;
import api.tools.ResultUtil;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service(value = "userServiceImpl")
public class UserServiceImpl implements IUserService {

    @Resource
    @Qualifier("userDAO")
    private UserDAO userDAO;

    @Resource
    @Qualifier("addressDAO")
    private AddressDAO addressDAO;

    @Resource
    @Qualifier("orderDAO")
    private OrderDAO orderDAO;

    /**
     * 修改用户资料+密码
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateUserInfo(UserEntity vo) throws Exception {
        vo.setUsername(api.tools.Service.utilGetUserName());//放入账号
        vo.setUpdateTime(api.tools.Service.utilsTime());
        if(vo.getPassword() != null || vo.getPassword().trim().equals("") != true)
        {
            vo.setPassword(DesUtil.encrypt(vo.getPassword().trim()));
        }
        if(userDAO.update(vo) > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.RollBACK);//修改失败事务回滚
        }
    }


    /**
     * 获取用户所有的收货地址
     *
     * @return
     * @throws Exception
     */
    public Result<Object> getAllAddress(AddressEntity vo) throws Exception {
        vo.setUserId(api.tools.Service.utilGetUserID());//注入会员用户的id
        List<AddressEntity> list = addressDAO.getAll(vo);//查询该用户下的所有地址
        if(list.size() > 0)
        {
            return ResultUtil.success(list);
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);
        }
    }

    /**
     * 用户添加收货地址
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> addAddress(AddressEntity vo) throws Exception {

        AddressEntity query = new AddressEntity();
        query.setUserId(api.tools.Service.utilGetUserID());//注入会员用户的id
        List<AddressEntity> list = addressDAO.getAll(query);//查询该用户下的所有地址
        if(list.size() > 5)
        {
            return ResultUtil.error(-1,"您的收货地址太多啦，只能添加5个");
        }
        else
        {
            vo.setCreateTime(api.tools.Service.utilsTime());
            vo.setUserId(api.tools.Service.utilGetUserID());
            if(addressDAO.insert(vo) > 0)
            {
                return ResultUtil.success();
            }
            else
            {
                return ResultUtil.error(-1,"添加失败");
            }
        }
    }

    /**
     * 用户修改收货地址
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateAddress(AddressEntity vo) throws Exception {
       vo.setUpdateTime(api.tools.Service.utilsTime());
       vo.setUserId(api.tools.Service.utilGetUserID());
       if(addressDAO.update(vo) > 0)
       {
           return ResultUtil.success();
       }
       else
       {
           throw new MyException(ResultEnum.ERROP);
       }
    }

    /**
     * 删除用户的收货地址
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> deleteAddress(AddressEntity vo) throws Exception {
        vo.setUserId(api.tools.Service.utilGetUserID());
        if(addressDAO.delete(vo) > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.ERROP);
        }
    }


    /**
     * 获取用户的订单
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> getMyOrder(OrderQueryEntity vo) throws Exception {
        vo.setUserId(api.tools.Service.utilGetUserID());//注入会员用户的id
        List<OrderQueryEntity> list = orderDAO.totalMyOrder(vo,new RowBounds());//查询该用户下的所有订单
        if(list.size() > 0)
        {
            return ResultUtil.success(list);
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);
        }
    }


    /**
     * 删除未支付订单
     *
     * @param orderId
     * @return
     * @throws Exception
     */
    public Result<Object> cancelOrder(Integer orderId) throws Exception {
        OrderQueryEntity vo = new OrderQueryEntity();
        vo.setUserId(api.tools.Service.utilGetUserID());
        vo.setOrderId(orderId);
        vo = orderDAO.totalMyOrder(vo,new RowBounds()).get(0);
        if(vo.getStatus().trim().equals("1"))
        {
            return ResultUtil.error(-1,"删除失败");
        }
        else
        {
            if(orderDAO.deleteOrderItem(vo.getOrderId()) > 0)
            {
                return ResultUtil.success();
            }
            else
            {
                return ResultUtil.error(-1,"删除失败");
            }
        }
    }

}
