package api.service.impl;

import api.dao.*;
import api.entity.*;
import api.handle.MyException;
import api.service.IShopService;
import api.tools.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service(value = "shopServiceImpl")
public class ShopServiceImpl implements IShopService {

    @Resource
    @Qualifier("studentDAO")
    private StudentDAO studentDAO;

    @Resource
    @Qualifier("shopDAO")
    private ShopDAO shopDAO;

    @Resource
    @Qualifier("filesDAO")
    private FilesDAO filesDAO;

    @Resource
    @Qualifier("goodsDAO")
    private GoodsDAO goodsDAO;

    @Resource
    @Qualifier("orderDAO")
    private OrderDAO orderDAO;

    @Resource
    @Qualifier("userDAO")
    private UserDAO userDAO;

    @Resource
    @Qualifier("messageDAO")
    private MessageDAO messageDAO;

    /**
     * 获取用户的基本信息
     * @return
     * @throws Exception
     */
    public Result<StudentEntity> getStudentInfo(StudentEntity vo) throws Exception{
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        vo.setId((Integer) request.getSession().getAttribute("ShopID"));//在session中取出商户管理员的信息
        List<StudentEntity> list = studentDAO.queryBasicById(vo);
        if(list.size() > 0)
        {
            vo = list.get(0);
            vo.setPassword(null);//防止敏感数据外泄
            return ResultUtil.success(vo);
        }
        else
        {
            //throw new MyException(ResultEnum.NOT_EXIST)
            return ResultUtil.error(-1,"没有找到数据呢");
        }
    }

    /**
     * 商户管理员修改个人信息
     *
     * @param vo
     * @return
     * @throws Exception
     */
    @Transactional
    public Result<Integer> studentUpdateInfo(StudentEntity vo) throws Exception {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        vo.setId((Integer) request.getSession().getAttribute("ShopID"));//在session中取出商户管理员的信息
        List<StudentEntity> list = studentDAO.queryBasicById(vo);
        if(list.size() > 0)
        {
            if(vo.updateScenes())
            {
                vo.setStatus("3");//统一置为审核中
                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String datetime=formatter.format(currentTime);
                vo.setUpdateTime(datetime);
                if(studentDAO.update(vo) > 0)
                {
                    return ResultUtil.success();
                }
                else
                {
                    throw new MyException(ResultEnum.RollBACK);//修改失败事务回滚
                }
            }
            else
            {
                return ResultUtil.error(2,"您输入的数据格式有问题");
            }
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);//未找到该学生资料
        }
    }

    /**
     * 商户管理员修改密码
     *
     * @param vo
     * @return
     * @throws Exception
     */
    @Transactional
    public Result<Integer> studentUpdatePass(StudentEntity vo) throws Exception {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        vo.setId((Integer) request.getSession().getAttribute("ShopID"));//在session中取出商户管理员的信息
        List<StudentEntity> list = studentDAO.queryBasicById(vo);
        if(list.size() > 0)
        {
            if(vo.updatePasswordScenes())
            {
                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String datetime=formatter.format(currentTime);
                vo.setUpdateTime(datetime);
                vo.setPassword(DesUtil.encrypt(vo.getPassword().trim()));
                if(studentDAO.update(vo) > 0)
                {
                    return ResultUtil.success();
                }
                else
                {
                    throw new MyException(ResultEnum.RollBACK);//修改失败事务回滚
                }
            }
            else
            {
                return ResultUtil.error(2,"您输入的数据格式有问题");
            }
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);//未找到该学生资料
        }
    }


    /**
     * 商户管理员修改密码保护问题
     * @param vo
     * @return
     * @throws Exception
     */
    @Transactional
    public Result<Integer> studentUpdateMibao(StudentEntity vo) throws  Exception
    {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        vo.setId((Integer) request.getSession().getAttribute("ShopID"));//在session中取出商户管理员的信息
        List<StudentEntity> list = studentDAO.queryBasicById(vo);
        if(list.size() > 0)
        {
            if(vo.updateMiBaoScenes())
            {
                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String datetime=formatter.format(currentTime);
                vo.setUpdateTime(datetime);
                if(studentDAO.update(vo) > 0)
                {
                    return ResultUtil.success();
                }
                else
                {
                    throw new MyException(ResultEnum.RollBACK);//修改失败事务回滚
                }
            }
            else
            {
                return ResultUtil.error(2,"您输入的数据格式有问题");
            }
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);//未找到该学生资料
        }
    }


    /**
     * 商户入住
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> shopRegister(ShopEntity vo) throws Exception {
        Integer flog = -1;//返回标志
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        vo.setStudentId((Integer) request.getSession().getAttribute("ShopID"));//在session中取出商户管理员的信息
        if(vo.insertScenes() == false)
        {
            return ResultUtil.error(3,"用户输入的数据不符合要求");
        }
        else
        {
            List<ShopEntity> list = shopDAO.queryShopByName(vo);
            if(list.size() > 0)
            {
                return ResultUtil.error(1,"该商户已注册过");
            }
            else
            {
                vo.setStatus("2");//统一置为审核中
                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String datetime=formatter.format(currentTime);
                vo.setCreateTime(datetime);
                if(shopDAO.insert(vo) > 0)
                {
                    return ResultUtil.success();//注册成功
                }
                else
                {
                    return ResultUtil.error(999,"注册失败");
                }
            }
        }
    }

    /**
     * 上传图片
     * @param request
     * @param file
     * @param type
     * @return
     * @throws Exception
     */
    public Result<String> uploadPictureGoods(HttpServletRequest request, MultipartFile file,String type) throws Exception {
        Result<String> resultUtil = this.uploadPictureUtil(request,file);
        if(resultUtil.getCode() == 0)
        {
            String urlPath = resultUtil.getData();
            filesDAO.insert(new FilesEntity(type,(Integer) request.getSession().getAttribute("ShopID"),urlPath));
        }
        return resultUtil;
    }


    /**
     * 浏览图片
     *
     * @param page
     * @param rows
     * @return
     * @throws Exception
     */
    public Result<Object> viewPicture(Integer page, Integer rows) throws Exception {
        RowBounds rowBounds = new RowBounds();
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        List<FilesEntity> list = filesDAO.getFiles(new FilesEntity(null,(Integer) request.getSession().getAttribute("ShopID"),""),rowBounds);
        if(list.size() > 0)
        {
            Paging paging = new Paging();
            //每页显示的图片数量
            if(rows == null || rows == 0)
            {
                rows = 10;
            }
            paging.setPageSize(rows);//每页显示记录的数量
            paging.setDateSum(list.size());//总记录数
            paging.setTotalPage();
            paging.setPageNow(page);//设置当前的页码
            rowBounds = new RowBounds((paging.getPageNow()-1)*paging.getPageSize(),paging.getPageSize());
            list = filesDAO.getFiles(new FilesEntity(null,(Integer) request.getSession().getAttribute("ShopID"),""),rowBounds);;//获取满足条件的记录集合
            paging.setGrid(list);
            return ResultUtil.success(paging);
        }else
        {
            throw new MyException(ResultEnum.NOT_EXIST);
        }
    }


    /**
     * 删除图片
     * @param request
     * @param pictureId
     * @return
     * @throws Exception
     */
    public Result<Object> deletePicture(HttpServletRequest request,Integer pictureId) throws Exception {
        RowBounds rowBounds = new RowBounds();
        FilesEntity model = new FilesEntity(pictureId,(Integer) request.getSession().getAttribute("ShopID"));
        List<FilesEntity> list = filesDAO.getFiles(model,rowBounds);
        if(list.size() > 0)
        {
            //找到记录
            if(filesDAO.delete(model) > 0);//删除记录
            {
                String url = list.get(0).getUrl();
                FileOperate.deletePicture(request,url);
                return ResultUtil.success();
            }
        }
        return ResultUtil.error(-1,"删除失败");
    }


    /**
     * 上传图片（头像、商户logo、商品图片的基类）
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
                String urlPath = "/picture/"+String.valueOf(request.getSession().getAttribute("ShopID"))+"/"+datetime;

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
                System.out.println("不是我们想要的文件类型,请按要求重新上传");
                return ResultUtil.error(-1, "图片格式不对，只支持.gif.png.jpg.jpeg");
            }
        }
        else
        {
            return ResultUtil.error(-1,"请选择有效的图片");
        }
    }

    /**
     * 展示商户的详细资料
     * @param request
     * @return
     * @throws Exception
     */
    public Result<Object> displayShopInfo(HttpServletRequest request) throws Exception{
        List<StudentEntity> list = shopDAO.queryShopIsexistByStudent((Integer) request.getSession().getAttribute("ShopID"));
        if(list.size() > 0)
        {
            return ResultUtil.success(list);
        }
        else
        {
            //该账户下，没有商户
            return ResultUtil.error(-1,"不存在该商户的资料");
        }
    }

    /**
     * 检查商户的账户状态
     *
     * @return
     * @throws Exception
     */
    public String checkShopStatus() throws Exception {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        List<StudentEntity> list = shopDAO.queryShopIsexistByStudent((Integer) request.getSession().getAttribute("ShopID"));
        System.err.println(list);
        if(list.size() > 0)
        {
            ShopEntity shop = list.get(0).getShop();
            if(shop.getStatus().equals("1"))
            {
                //账户信息正常
                return "ok";
            }
            if(shop.getStatus().equals("2"))
            {
                //审核中
                return "checking";
            }
            else
            {
                //冻结中
                return "refuse";
            }
        }
        else
        {
            //该账户下，没有商户
            return "noexist";
        }
    }

    /**
     * 上传商铺头像
     *
     * @param request
     * @param file
     * @param type
     * @return
     * @throws Exception
     */
    public Result<String> uploadLogo(HttpServletRequest request, MultipartFile file, String type) throws Exception {
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
        List<FilesEntity> list = filesDAO.getFiles(new FilesEntity(type,(Integer) request.getSession().getAttribute("ShopID")),rowBounds);
        if(list.size() > 0)
        {
            //之前存在logo，删除之
            FileOperate.deletePicture(request,list.get(0).getUrl());
            //保存数据库记录
            FilesEntity model = list.get(0);
            model.setTypy(type);
            model.setUrl(urlPath);
            //执行数据库修改操作
            filesDAO.update(model);
            return ResultUtil.success();
        }
        else
        {
            //不存在logo，不管磁盘上文件，直接写入数据库
            filesDAO.insert(new FilesEntity(type,(Integer) request.getSession().getAttribute("ShopID"),urlPath));
            return ResultUtil.success();
        }
    }

    /**
     * 修改商户信息
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> updateShopInfo(ShopEntity vo) throws Exception{
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
        Integer studentId = (Integer) request.getSession().getAttribute("ShopID");
        List<StudentEntity> list = shopDAO.queryShopIsexistByStudent(studentId);
        if(list.size() > 0)
        {
            ShopEntity shop = list.get(0).getShop();
            if(shop.getStatus().equals("1"))
            {
                //账户信息正常，可以修改
                vo.setStudentId(studentId);
                vo.setStatus("2");//置为审核中
                vo.setShopId(shop.getShopId());
                if(vo.updateScenes())
                {
                    if(shopDAO.update(vo)>0)
                    {
                        return ResultUtil.success();
                    }
                    else
                    {
                        return ResultUtil.error(999,"修改失败");
                    }
                }
                else
                {
                    return ResultUtil.error(1,"您填写的信息不符合要求");
                }
            }
            if(shop.getStatus().equals("2"))
            {
                //审核中
                return ResultUtil.error(2,"正在审核中的商户不允许修改");
            }
            else
            {
                //冻结中
                return ResultUtil.error(3,"冻结中的商户不允许修改");
            }
        }
        else
        {
            //该账户下，没有商户
            return ResultUtil.error(-1,"没有找到该商户");
        }
    }


    /**
     * 添加商品
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> insertGoods(GoodsEntity vo) throws Exception {
        List<StudentEntity> list = shopDAO.queryShopIsexistByStudent(api.tools.Service.utilGetShopID());
        if (list.size() > 0) {
            ShopEntity shop = list.get(0).getShop();
            if (shop.getStatus().equals("1")) {
                //账户信息正常，可以添加
                vo.setShopId(shop.getShopId());
                vo.setStatus("1");//
                vo.setCreateTime(api.tools.Service.utilsTime());
                if (vo.insertScenes()) {
                    if (goodsDAO.insert(vo) > 0) {
                        return ResultUtil.success();
                    } else {
                        return ResultUtil.error(999, "添加失败");
                    }
                } else {
                    return ResultUtil.error(1, "您填写的商品信息不符合要求");
                }
            }
            if (shop.getStatus().equals("2")) {
                //审核中
                return ResultUtil.error(2, "正在审核中的商户不允许添加商品");
            } else {
                //冻结中
                return ResultUtil.error(3, "冻结中的商户不允许添加商品");
            }
        } else {
            //该账户下，没有商户
            return ResultUtil.error(-1, "没有找到该商户");
        }
    }

    /**
     * 商品分页
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> goodsPaging(GoodsEntity vo) throws Exception {
        List<StudentEntity> shoplist = shopDAO.queryShopIsexistByStudent(api.tools.Service.utilGetShopID());
        if (shoplist.size() > 0) {
            if (StringUtils.isNotBlank(vo.getStartTime())) {
                vo.setStartTime(vo.getStartTime());
            }
            if (StringUtils.isNotBlank(vo.getEndTime())) {
                vo.setEndTime(vo.getEndTime());
            }
            vo.setShopId(shoplist.get(0).getShop().getShopId());
            RowBounds rowBounds = new RowBounds();
            List<GoodsEntity> list = goodsDAO.queryToPaging(vo,rowBounds);
            if(list.size() > 0)
            {
                LayuiTable<List> out = new LayuiTable();
                out.setCount(list.size());
                Paging paging =new Paging();
                //每页显示的商品数量
                if(vo.getRows() == null || vo.getRows() == 0)
                {
                    vo.setRows(10);
                }
                paging.setPageSize(vo.getRows());//每页显示记录的数量
                paging.setDateSum(list.size());//总记录数
                paging.setTotalPage();
                paging.setPageNow(vo.getPages());//设置当前的页码
                rowBounds = new RowBounds((paging.getPageNow()-1)*paging.getPageSize(),paging.getPageSize());
                list = goodsDAO.queryToPaging(vo,rowBounds);;//获取满足条件的记录集合
                paging.setGrid(list);
                out.setCode(0);
                out.setMsg("查询成功");
                out.setData(list);
                return out;
            }else
            {
                throw new MyException(ResultEnum.NOT_EXIST);
            }
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);
        }
    }

    /**
     * 修改商品
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> updateGoods(GoodsEntity vo) throws Exception {
        List<StudentEntity> list = shopDAO.queryShopIsexistByStudent(api.tools.Service.utilGetShopID());
        if (list.size() > 0) {
            ShopEntity shop = list.get(0).getShop();
            if (shop.getStatus().equals("1")) {
                //账户信息正常，可以修改
                vo.setShopId(shop.getShopId());
                vo.setUpdateTime(api.tools.Service.utilsTime());
                if (vo.updateScenes()) {
                    if (goodsDAO.update(vo) > 0) {
                        return ResultUtil.success();
                    } else {
                        return ResultUtil.error(999, "修改失败");
                    }
                } else {
                    return ResultUtil.error(1, "您填写的商品信息不符合要求");
                }
            }
            if (shop.getStatus().equals("2")) {
                //审核中
                return ResultUtil.error(2, "正在审核中的商户不允许修改商品");
            } else {
                //冻结中
                return ResultUtil.error(3, "冻结中的商户不允许修改商品");
            }
        } else {
            //该账户下，没有商户
            return ResultUtil.error(-1, "没有找到该商户");
        }
    }

    /**
     * 下架商品
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> deleteGoods(GoodsEntity vo) throws Exception {
        List<StudentEntity> list = shopDAO.queryShopIsexistByStudent(api.tools.Service.utilGetShopID());
        if (list.size() > 0) {
            ShopEntity shop = list.get(0).getShop();
            if (shop.getStatus().equals("1")) {
                //账户信息正常，可以删除
                //查询该商品是否可以删除
                if(vo.getStatus().trim().equals("2")== true && orderDAO.existOrderByGoods(vo.getId()) > 0)
                {
                    //该商品正处于交易中不能删除
                    return ResultUtil.error(1000, "该商品正处于交易中不能删除");
                }
                vo.setShopId(shop.getShopId());
                vo.setUpdateTime(api.tools.Service.utilsTime());
                if (vo.deleteScenes()) {
                    if (goodsDAO.update(vo) > 0) {
                        return ResultUtil.success();
                    } else {
                        return ResultUtil.error(999, "下架失败");
                    }
                } else {
                    return ResultUtil.error(1, "您填写的商品信息不符合要求");
                }
            }
            if (shop.getStatus().equals("2")) {
                //审核中
                return ResultUtil.error(2, "正在审核中的商户不允许修改商品");
            } else {
                //冻结中
                return ResultUtil.error(3, "冻结中的商户不允许修改商品");
            }
        } else {
            //该账户下，没有商户
            return ResultUtil.error(-1, "没有找到该商户");
        }
    }


    /**
     * 获取订单报表
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> orderReportPagin(OrderReport vo) throws Exception {
        List<StudentEntity> shoplist = shopDAO.queryShopIsexistByStudent(api.tools.Service.utilGetShopID());
        if (shoplist.size() > 0) {
            if (StringUtils.isNotBlank(vo.getStartTime())) {
                vo.setStartTime(vo.getStartTime());
            }
            if (StringUtils.isNotBlank(vo.getEndTime())) {
                vo.setEndTime(vo.getEndTime());
            }
            vo.setShopId(shoplist.get(0).getShop().getShopId());
            RowBounds rowBounds = new RowBounds();
            List<OrderReport> list = orderDAO.getOrderReport(vo,rowBounds);
            if(list.size() > 0)
            {
                LayuiTable<List> out = new LayuiTable();
                out.setCount(list.size());
                Paging paging =new Paging();
                //每页显示的记录数量
                if(vo.getRows() == null || vo.getRows() == 0)
                {
                    vo.setRows(10);
                }
                paging.setPageSize(vo.getRows());//每页显示记录的数量
                paging.setDateSum(list.size());//总记录数
                paging.setTotalPage();
                paging.setPageNow(vo.getPages());//设置当前的页码
                rowBounds = new RowBounds((paging.getPageNow()-1)*paging.getPageSize(),paging.getPageSize());
                list = orderDAO.getOrderReport(vo,rowBounds);;//获取满足条件的记录集合
                paging.setGrid(list);
                out.setCode(0);
                out.setMsg("查询成功");
                out.setData(list);
                return out;
            }else
            {
                throw new MyException(ResultEnum.NOT_EXIST);
            }
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);
        }
    }


    /**
     * 撤销订单
     * param uorderDetail（子订单号）
     * @return
     * @throws Exception
     */
    public Result<Object> deleteOrder(Integer orderDetail) throws Exception {
        List<StudentEntity> list = shopDAO.queryShopIsexistByStudent(api.tools.Service.utilGetShopID());
        if (list.size() > 0) {
            ShopEntity shop = list.get(0).getShop();
            if (shop.getStatus().equals("1")) {
                //账户信息正常，可以撤销
                //第一步,根据子订单号，找出相关实体数据
                OrderDetailEntity model = orderDAO.getOrderDetail(new OrderDetailEntity(orderDetail));

                Integer orderId = model.getOrderId();//取出订单父类编号
                //然后通过父类繁荣编号 反查子订单数

                List<OrderQueryEntity> qurylist =  orderDAO.totalMyOrder(new OrderQueryEntity(orderId),new RowBounds());
                if(qurylist.size() > 1)
                {
                    orderDAO.deleteOrderDetail(orderDetail);
                    return ResultUtil.success();
                }
                if(qurylist.size() == 1)
                {
                    //执行级联删除
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
                throw new MyException(ResultEnum.ERROP);
            }
            if (shop.getStatus().equals("2")) {
                //审核中
                return ResultUtil.error(2, "正在审核中的商户不允许撤销订单");
            } else {
                //冻结中
                return ResultUtil.error(3, "冻结中的商户不允许撤销订单");
            }
        } else {
            //该账户下，没有商户
            return ResultUtil.error(-1, "没有找到该商户");
        }
    }


    /**
     * 获取相关的站内消息
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> getMessage(MessageEntity vo) throws Exception {
        List<StudentEntity> shoplist = shopDAO.queryShopIsexistByStudent(api.tools.Service.utilGetShopID());
        if (shoplist.size() > 0) {
            if (StringUtils.isNotBlank(vo.getStartTime())) {
                vo.setStartTime(vo.getStartTime());
            }
            if (StringUtils.isNotBlank(vo.getEndTime())) {
                vo.setEndTime(vo.getEndTime());
            }
            vo.setReceive(api.tools.Service.utilGetShopID());
            RowBounds rowBounds = new RowBounds();
            List<MessageEntity> list = messageDAO.getAllMessage(vo,rowBounds);
            if(list.size() > 0)
            {
                LayuiTable<List> out = new LayuiTable();
                out.setCount(list.size());
                Paging paging =new Paging();
                //每页显示的记录数量
                if(vo.getRows() == null || vo.getRows() == 0)
                {
                    vo.setRows(10);
                }
                paging.setPageSize(vo.getRows());//每页显示记录的数量
                paging.setDateSum(list.size());//总记录数
                paging.setTotalPage();
                paging.setPageNow(vo.getPages());//设置当前的页码
                rowBounds = new RowBounds((paging.getPageNow()-1)*paging.getPageSize(),paging.getPageSize());
                list = messageDAO.getAllMessage(vo,rowBounds);//获取满足条件的记录集合
                paging.setGrid(list);
                out.setCode(0);
                out.setMsg("查询成功");
                out.setData(list);
                return out;
            }else
            {
                throw new MyException(ResultEnum.NOT_EXIST);
            }
        }
        else
        {
            throw new MyException(ResultEnum.NOT_EXIST);
        }
    }
}
