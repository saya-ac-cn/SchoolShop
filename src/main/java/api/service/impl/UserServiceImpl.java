package api.service.impl;

import api.dao.*;
import api.entity.*;
import api.handle.MyException;
import api.service.IUserService;
import api.tools.*;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Resource
    @Qualifier("cartDAO")
    private CartDAO cartDAO;

    @Resource
    @Qualifier("collectGoodsDAO")
    private CollectGoodsDAO collectGoodsDAO;

    @Resource
    @Qualifier("filesDAO")
    private FilesDAO filesDAO;

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
        if(vo.getPassword() != null && vo.getPassword().trim().equals("") != true)
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

    /**
     * 统计用户的相关数据信息
     *
     * @return
     * @throws Exception
     */
    public Result<Object> indexData() throws Exception {
        AddressEntity vo1 = new AddressEntity();
        vo1.setUserId(api.tools.Service.utilGetUserID());//注入会员用户的id
        List<AddressEntity> list1 = addressDAO.getAll(vo1);//查询该用户下的所有地址
        Integer address = list1.size();//获取所有的地址数;

        OrderQueryEntity vo2 = new OrderQueryEntity();
        vo2.setUserId(api.tools.Service.utilGetUserID());//注入会员用户的id
        List<OrderQueryEntity> list2 = orderDAO.totalMyOrder(vo2,new RowBounds());//查询该用户下的所有订单
        Integer order = list2.size();//获取用户订单数

        WalletEntity vo3 = orderDAO.getWallet(api.tools.Service.utilGetUserID());//取出用户账户信息
        Double money = vo3.getWallet();//获取账户金额

        CartEntity vo4 = new CartEntity();
        vo4.setUserId(api.tools.Service.utilGetUserID());
        List<CartEntity> list4 = cartDAO.getAll(vo4,new RowBounds());
        Integer cart = list4.size();//取出所有购物车信息

        CollectGoodsEntity vo5 = new CollectGoodsEntity();
        vo4.setUserId(api.tools.Service.utilGetUserID());
        List<CollectGoodsEntity> list5 = collectGoodsDAO.getAll(vo5,new RowBounds());
       Integer collect = list5.size();//取出所有收藏信息

        //放入Map
        Map send = new HashMap();
        send.put("address",address);
        send.put("order",order);
        send.put("money",money);
        send.put("cart",cart);
        send.put("collect",collect);
        return ResultUtil.success(send);
    }

    /**
     * 取出个人信息
     *
     * @return
     * @throws Exception
     */
    public Result<Object> getMyinfo() throws Exception {
        UserEntity vo = new UserEntity();
        vo.setId(api.tools.Service.utilGetUserID());
        List<UserEntity> list = userDAO.getAllUser(vo,new RowBounds());
       if(list.size() > 0)
       {
           return ResultUtil.success(list.get(0));
       }
       else
       {
           throw new MyException(ResultEnum.NOT_EXIST);//没找到有效记录
       }
    }

    /**
     * 上传用户图片
     *
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    public Result<String> uploadLogo(HttpServletRequest request, MultipartFile file) throws Exception {
        //执行上传
        Result<String> resultUtil = this.uploadPictureUtil(request,file);
        String urlPath = "";
        if(resultUtil.getCode() == 0)
        {
            urlPath = resultUtil.getData();
        }
        else
        {
            return ResultUtil.error(-1,"上传失败");
        }
        RowBounds rowBounds = new RowBounds();
        List<FilesEntity> list = filesDAO.getFiles(new FilesEntity("2", api.tools.Service.utilGetUserID()),rowBounds);
        if(list.size() > 0)
        {
            //之前存在logo，删除之
            FileOperate.deletePicture(request,list.get(0).getUrl());
            //保存数据库记录
            FilesEntity model = list.get(0);
            model.setTypy("2");
            model.setUrl(urlPath);
            //执行数据库修改操作
            filesDAO.update(model);
            return ResultUtil.success();
        }
        else
        {
            //不存在logo，不管磁盘上文件，直接写入数据库
            filesDAO.insert(new FilesEntity("2",api.tools.Service.utilGetUserID(),urlPath));
            return ResultUtil.success();
        }
    }

    /**
     * 上传图片（头像的基类）
     *
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    public Result<String> uploadPictureUtil(HttpServletRequest request, MultipartFile file) throws Exception {
        if(!file.isEmpty()) {
            //上传文件名
            String filename = file.getOriginalFilename();
            String filetype = filename.indexOf(".") != -1 ? filename.substring(filename.lastIndexOf(".") + 1, filename.length()) : null;
            if ("GIF".equals(filetype.toUpperCase()) || "PNG".equals(filetype.toUpperCase()) || "JPG".equals(filetype.toUpperCase()) || "JPEG".equals(filetype.toUpperCase())) {
                String reName = FileOperate.generateRandomFilename();//生成随机的文件名

                /********生成今天的日期**********/
                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
                String datetime = formatter.format(currentTime);

                //url路径
                String urlPath = "/picture/"+String.valueOf(api.tools.Service.utilGetUserName())+"/"+datetime;
                //上传文件路径-/picture/目录下该用户当天的文件夹
                String path = request.getServletContext().getRealPath(urlPath);
                File filepath = new File(path,reName);
                //判断路径是否存在，如果不存在就创建一个
                if (!filepath.getParentFile().exists()) {
                    filepath.getParentFile().mkdirs();
                }
                //存放到服务器上的真实路径(不是url路径)
                String truePath = path + File.separator + reName+filetype;
                //存放到数据库中的图片地址
                System.err.println(urlPath+"/"+reName+filetype);
                file.transferTo(new File(truePath));//转存文件到指定的路径
                return ResultUtil.success(urlPath+"/"+reName+filetype);//注册成功
            } else {
                return ResultUtil.error(-1, "图片格式不对，只支持.gif.png.jpg.jpeg");
            }
        }
        else
        {
            return ResultUtil.error(-1,"请选择有效的图片");
        }
    }

    /**
     * 用户添加到收藏夹
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> addCollect(CollectGoodsEntity vo) throws Exception {

        vo.setUserId(api.tools.Service.utilGetUserID());//注入会员用户的id
        List<CollectGoodsEntity> list = collectGoodsDAO.getAll(vo,new RowBounds());//查询该用户下的所有收藏
        if(list.size() > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            vo.setCreateTime(api.tools.Service.utilsTime());
            if(collectGoodsDAO.insert(vo) >0 )
            {
                return ResultUtil.success();
            }
            else
            {
                throw new MyException(ResultEnum.ERROP);
            }
        }
    }

    /**
     * 删除收藏商品
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> deleteCollect(CollectGoodsEntity vo) throws Exception {
        if(collectGoodsDAO.delete(vo) > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.ERROP);
        }
    }

    /**
     * 获取所有的收藏
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> getAllCollect(CollectGoodsEntity vo) throws Exception {
        vo.setUserId(api.tools.Service.utilGetUserID());//注入会员用户的id
        List<CollectGoodsEntity> list = collectGoodsDAO.getAll(vo,new RowBounds());//查询该用户下的所有收藏
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
     * 添加到购物车
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> addCart(CartEntity vo) throws Exception {

        vo.setUserId(api.tools.Service.utilGetUserID());//注明添加者信息
        List<CartEntity> list = cartDAO.getAll(vo,new RowBounds());
        if(list.size() > 0)
        {
            //找到该收藏的商品，改变收藏的数量
            CartEntity old = list.get(0);
            old.setQuantity(vo.getQuantity()+old.getQuantity());//把原来收藏数量加上现在的数量。
            if(cartDAO.update(old) > 0)
            {
                return ResultUtil.success();
            }
            else
            {
                throw new MyException(ResultEnum.ERROP);
            }
        }
        else
        {
            vo.setCreateTime(api.tools.Service.utilsTime());
            if(cartDAO.insert(vo) > 0)
            {
                return ResultUtil.success();
            }
            else
            {
                throw new MyException(ResultEnum.ERROP);
            }
        }
    }


    /**
     * 取出用户的购物车
     *
     * @return
     * @throws Exception
     */
    public Result<Object> getAllCart(CartEntity vo) throws Exception {
        vo.setUserId(api.tools.Service.utilGetUserID());//注入会员用户的id
        List<CartEntity> list = cartDAO.getAll(vo,new RowBounds());//查询该用户下的所有购物车信息
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
     * 删除购物车中的数据，并添加到订单中
     *
     * @param cartList
     * @return
     * @throws Exception
     */
    public Result<Object> addOrder(List<CartEntity> cartList) throws Exception {
        OrderEntity orderEntity;
        OrderDetailEntity orderDetailEntity;

        CartEntity queryResult;

        orderEntity = new OrderEntity(api.tools.Service.utilGetUserID(),0.0,"2", api.tools.Service.utilsTime());
        if( orderDAO.insertOrder(orderEntity)> 0)
        {
            //遍历用户提交的购物车信息
            for(CartEntity cart : cartList)
            {
                queryResult = cartDAO.getAll(cart,new RowBounds()).get(0);//反查这条信息
                orderDetailEntity = new OrderDetailEntity();
                orderDetailEntity.setOrderId(orderEntity.getId());
                orderDetailEntity.setShopId(queryResult.getGoods().getShopId());
                orderDetailEntity.setGoodsId(queryResult.getGoodsId());
                orderDetailEntity.setCurrentPrice(queryResult.getGoods().getPrice());
                orderDetailEntity.setQuantity(cart.getQuantity());
                orderDetailEntity.setTotalPrice(queryResult.getGoods().getPrice()*cart.getQuantity());
                orderDetailEntity.setCreateTime(api.tools.Service.utilsTime());
                orderDAO.insertOrderDetail(orderDetailEntity);//添加到订单子项
                cartDAO.delete(cart);//删除之前的购物车
            }
            return ResultUtil.success(orderEntity.getId());
        }
        else
        {
            //插入子订单失败
            throw new MyException(ResultEnum.ERROP);
        }
    }


    /**
     * 获取用户的余额
     *
     * @return
     * @throws Exception
     */
    public Result<Object> getMoney() throws Exception {
        WalletEntity vo = orderDAO.getWallet(api.tools.Service.utilGetUserID());//取出用户账户信息
        Double money = vo.getWallet();//获取账户金额
        return ResultUtil.success(money);//返回用户的余额
    }

    /**
     * 用户支付
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> buy(OrderEntity vo) throws Exception {

        /*************************求该订单及子订单总额*************************************/
        OrderQueryEntity oldOrder = new OrderQueryEntity();
        oldOrder.setOrderId(vo.getId());
        List<OrderQueryEntity> list = orderDAO.totalMyOrder(oldOrder,new RowBounds());//取出原来的订单信息
        Double payment = 0.0;//支付金额
        //遍历该订单下的子订单，以便统计支付金额。
        for (OrderQueryEntity item : list)
        {
            payment += item.getTotalPrice();//累加每个子订单的价格
        }

        /**********************************获取用户的账户资金*************************************************/
        WalletEntity vo1 = orderDAO.getWallet(api.tools.Service.utilGetUserID());//取出用户账户信息
        Double money = vo1.getWallet();//获取账户金额

        System.err.println(money);
        System.err.println(payment);
        /**************************************判断资金是否充足*********************************************/
        if(money >= payment)
        {
            //钱够
            //准备模型
            vo.setPayment(payment);//设置用户支付的金额
            vo.setStatus("1");//设置支付状态 1 已支付
            vo.setUpdateTime(api.tools.Service.utilsTime());//设置修改时间
            orderDAO.updateOrder(vo);//执行扣款

            //开始扣款
            WalletEntity userWallet = orderDAO.getWallet(api.tools.Service.utilGetUserID());//找出用户的钱包对象
            userWallet.setWallet(userWallet.getWallet()-payment);//扣款
            userWallet.setUpdateTime(api.tools.Service.utilsTime());//操作修改时间
            orderDAO.updateWallet(userWallet);//执行扣款

            //向子订单的商户划款
            //遍历该订单下的子订单，以便划款。
            WalletEntity shopWallet;
            for (OrderQueryEntity item : list)
            {
                shopWallet = orderDAO.getWallet(item.getShopId());//得到商户的钱包
                shopWallet.setWallet(shopWallet.getWallet()+item.getTotalPrice());//划款金额
                shopWallet.setUpdateTime(api.tools.Service.utilsTime());//操作修改时间
                orderDAO.updateWallet(shopWallet);//执行划款
            }
            return ResultUtil.success();//执行成功
        }
        else
        {
            //钱不够
            return ResultUtil.error(9999,"亲，你的钱不够啦");
        }
    }


    /**
     * 删除购物车
     *
     * @param cartId
     * @return
     * @throws Exception
     */
    public Result<Integer> deleteCart(List<Integer> cartId) throws Exception {
        if(cartId.size() > 0 )
        {
            //传输了数据，可以删
            for(Integer item : cartId)
            {
                cartDAO.delete(new CartEntity(item));//执行删除
            }
            return ResultUtil.success();
        }
        else
        {
            //空数据
            throw new MyException(ResultEnum.NOT_EXIST);
        }
    }
}
