package api.service.impl;

import api.dao.FilesDAO;
import api.dao.ShopDAO;
import api.dao.StudentDAO;
import api.entity.FilesEntity;
import api.entity.ShopEntity;
import api.entity.StudentEntity;
import api.handle.MyException;
import api.service.IShopService;
import api.tools.*;
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
        if(vo.insertScenes() == false)
        {
            return ResultUtil.error(3,"用户输入的数据不符合要求");
        }
        else
        {
            List<ShopEntity> list = shopDAO.queryShopByName(vo);
            if(list.size() > 0)
            {
                throw new MyException(ResultEnum.UNKONW_ERROR);//该商户已注册过
            }
            else
            {
                RequestAttributes ra = RequestContextHolder.getRequestAttributes();
                HttpServletRequest request = ((ServletRequestAttributes)ra).getRequest();
                vo.setStudentId((Integer) request.getSession().getAttribute("ShopID"));//在session中取出商户管理员的信息
                vo.setStatus("3");//统一置为审核中
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
                    throw new MyException(ResultEnum.RollBACK);//注册失败
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
            Paging paging =new Paging();
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
     * 修改商户信息
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> shopUpdateInfo(ShopEntity vo) throws Exception {
        return null;
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
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Object> updateShopInfo(ShopEntity vo) throws Exception {
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
}
