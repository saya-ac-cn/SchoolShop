package api.service.impl;

import api.dao.*;
import api.entity.*;
import api.handle.MyException;
import api.service.IAdminService;
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
import java.util.List;

@Service("adminServiceImpl")
public class AdminServiceImpl implements IAdminService {

    @Resource
    @Qualifier("adminDAO")
    private AdminDAO adminDAO;

    @Resource
    @Qualifier("filesDAO")
    private FilesDAO filesDAO;

    @Resource
    @Qualifier("shopDAO")
    private ShopDAO shopDAO;

    @Resource
    @Qualifier("standDAO")
    private StandDAO standDAO;

    @Resource
    @Qualifier("messageDAO")
    private MessageDAO messageDAO;

    @Resource
    @Qualifier("newsDAO")
    private NewsDAO newsDAO;

    /**
     * 获取管理员的详情
     *
     * @return
     * @throws Exception
     */
    public Result<Object> getAdingInfo() throws Exception {
        AdminEntity vo = new AdminEntity();
        vo.setId(api.tools.Service.utilGetAdminID());
        vo = adminDAO.getAdmin(vo);
        if(vo != null)
        {
            vo.setPassword(null);//防止敏感数据外泄
            return ResultUtil.success(vo);
        }
        else
        {
            return ResultUtil.error(-1,"没有找到数据呢");
        }
    }

    /**
     * 修改管理员的资料
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateAdminInfo(AdminEntity vo) throws Exception {
        vo.setId(api.tools.Service.utilGetAdminID());//放入账号
        vo.setUpdateTime(api.tools.Service.utilsTime());
        if(vo.getPassword() != null || vo.getPassword().trim().equals("") != true)
        {
            vo.setPassword(DesUtil.encrypt(vo.getPassword().trim()));
        }
        if(adminDAO.updateAdmin(vo) > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.RollBACK);//修改失败事务回滚
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
        List<FilesEntity> list = filesDAO.getFiles(new FilesEntity("2", api.tools.Service.utilGetAdminID()),rowBounds);
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
            filesDAO.insert(new FilesEntity("2",api.tools.Service.utilGetAdminID(),urlPath));
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
                String urlPath = "/picture/"+String.valueOf(api.tools.Service.utilGetAdminID())+"/"+datetime;
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
     * 获取所有商户信息-管理员用
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> displayAllShopPagin(ShopEntity vo) throws Exception {
            RowBounds rowBounds = new RowBounds();
            List<ShopEntity> list = shopDAO.displayAll(rowBounds);
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
                list = shopDAO.displayAll(rowBounds);//获取满足条件的记录集合
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

    /**
     * 获取所有的摊位
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> displayAllStandPagin(StandEntity vo) throws Exception {
        RowBounds rowBounds = new RowBounds();
        List<StandEntity> list = standDAO.getStand(vo,rowBounds);
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
            list = standDAO.getStand(vo,rowBounds);;//获取满足条件的记录集合
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

    /**
     * 添加摊位
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> insertStand(StandEntity vo) throws Exception {
        vo.setStatus("1");//置为正常
        vo.setChoise("1");//置为未选
        vo.setCreateTime(api.tools.Service.utilsTime());
        if(standDAO.insert(vo)>0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.ERROP);
        }
    }

    /**
     * 修改摊位
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateStand(StandEntity vo) throws Exception {
        vo.setUpdateTime(api.tools.Service.utilsTime());
        if(standDAO.update(vo)>0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.ERROP);
        }
    }


    /**
     * 发送消息
     *
     * @param vo
     */
    public void sendMessage(MessageEntity vo) {
        messageDAO.sendMessage(vo);
    }

    /**
     * 分派摊位/修改状态
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> manaShop(ShopEntity vo) throws Exception {
        vo.setUpdateTime(api.tools.Service.utilsTime());
        if (vo.getStand() != null && vo.getStatus().trim().equals("1"))
        {
           if(shopDAO.update(vo) > 0)
           {
               //发送账户通过的消息
               MessageEntity message = new MessageEntity(api.tools.Service.utilGetAdminID(), vo.getStudentId(), "系统消息", "您的商户已经审核通过，请尽情使用吧。", api.tools.Service.utilsTime());
               this.sendMessage(message);
               return ResultUtil.success();
           }
        }
        if (vo.getStand() != null && vo.getStatus().trim().equals("2"))
        {
            //发送账户冻结的消息
            if(shopDAO.update(vo) > 0)
            {
                //发送账户通过的消息
                MessageEntity message = new MessageEntity(api.tools.Service.utilGetAdminID(), vo.getStudentId(), "系统消息", "您的商户已经被冻结，请重新修改资料，然后保存提交。", api.tools.Service.utilsTime());
                this.sendMessage(message);
                return ResultUtil.success();
            }
        }
        else
        {
            //第一步查询原来它选择了摊位没
            ShopEntity shop = shopDAO.queryShopByID(vo.getShopId());
            if(shop.getStandId() != null)
            {
                //已选择的，首先清除之前的，再选择
                standDAO.update(new StandEntity(shop.getStandId(),"1"));//直接置为未选择
            }
            standDAO.update(new StandEntity(vo.getStandId(),"0"));//直接置为选择
            //发送摊位选择的通知
            if(shopDAO.update(vo) > 0)
            {
                //发送账户通过的消息
                MessageEntity message = new MessageEntity(api.tools.Service.utilGetAdminID(), vo.getStudentId(), "系统消息", "我们已经为您分派了商铺摊位，现在，您可以继续使用了。", api.tools.Service.utilsTime());
                this.sendMessage(message);
                return ResultUtil.success();
            }
        }
        return ResultUtil.error(-1,"操作失败");
    }

    /**
     * 发布动态
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> addNews(NewsEntity vo) throws Exception {
        vo.setAuthor(api.tools.Service.utilGetAdminID());
        vo.setCreateTime(api.tools.Service.utilsTime());
        if(newsDAO.insert(vo) > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.ERROP);
        }
    }

    /**
     * 修改动态
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateNews(NewsEntity vo) throws Exception {
        vo.setUpdateTime(api.tools.Service.utilsTime());
        if(newsDAO.update(vo) > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.ERROP);
        }
    }

    /**
     * 删除动态
     *
     * @param id
     * @return
     * @throws Exception
     */
    public Result<Integer> deleteNews(Integer id) throws Exception {
        if(newsDAO.delete(id) > 0)
        {
            return ResultUtil.success();
        }
        else
        {
            throw new MyException(ResultEnum.ERROP);
        }
    }

    /**
     * 取出动态
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> getNews(NewsEntity vo) throws Exception {
        RowBounds rowBounds = new RowBounds();
        List<NewsEntity> list = newsDAO.getAll(vo,rowBounds);
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
            list = newsDAO.getAll(vo,rowBounds);;//获取满足条件的记录集合
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
}
