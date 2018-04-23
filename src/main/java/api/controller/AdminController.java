package api.controller;

import api.entity.*;
import api.service.impl.AdminServiceImpl;
import api.tools.LayuiTable;
import api.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 管理员控制器
 */
@RestController
@RequestMapping(value = "/api/admin")
public class AdminController {


    @Autowired
    @Qualifier("adminServiceImpl")
    private AdminServiceImpl adminServiceImpl;

    /**
     * 加载用户的信息
     *
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/info.yht")
    public Result<Object> getStudentInfo() throws Exception {
        return adminServiceImpl.getAdingInfo();
    }

    /**
     * 修改管理员的信息
     *
     * @param vo
     * @return
     * @throws Exception
     */
    @PutMapping(value = "/admin/info.yht")
    public Result<Integer> updateAdminInfo(AdminEntity vo) throws Exception {
        return adminServiceImpl.updateAdminInfo(vo);
    }

    /**
     * 用户上传图片
     *
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/upload.yht")
    public Result<String> uploadPicture(HttpServletRequest request, @RequestParam("file") MultipartFile file) throws Exception {
            return adminServiceImpl.uploadLogo(request, file);
    }

    /**
     * 显示所有的商家
     * @param vo
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/shop/all.yht")
    public LayuiTable<List> displayAllShop(ShopEntity vo) throws Exception
    {
        return adminServiceImpl.displayAllShopPagin(vo);
    }

    /**
     * 显示所有的摊位
     * @param vo
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/stand/all.yht")
    public LayuiTable<List> displayAllStandPagin(StandEntity vo) throws Exception
    {
        return adminServiceImpl.displayAllStandPagin(vo);
    }

    /**
     * 添加摊位
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/stand/insert.yht")
    public Result<Integer> insertStand(StandEntity vo) throws Exception
    {
        return adminServiceImpl.insertStand(vo);
    }

    /**
     * 修改摊位
     * @param vo
     * @return
     * @throws Exception
     */
    @PutMapping(value = "/stand/update.yht")
    public Result<Integer> updateStand(StandEntity vo) throws Exception
    {
        return adminServiceImpl.updateStand(vo);
    }

    /**
     * 修改商户的摊位、状态
     * @param vo
     * @return
     * @throws Exception
     */
    @PutMapping(value = "/shop/review.yht")
    public Result<Integer> manaShop(ShopEntity vo) throws Exception
    {
        return adminServiceImpl.manaShop(vo);
    }

    /**
     * 发布动态
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/news/add.yht")
    public Result<Integer> addNews(NewsEntity vo) throws Exception
    {
        return adminServiceImpl.addNews(vo);
    }

    /**
     * 修改动态
     * @param vo
     * @return
     * @throws Exception
     */
    @PutMapping(value = "/news/update.yht")
    public Result<Integer> updateNews(NewsEntity vo) throws Exception
    {
        return adminServiceImpl.updateNews(vo);
    }

    /**
     * 获取动态
     * @param vo
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/news/query.yht")
    public  LayuiTable<List> getNews(NewsEntity vo) throws Exception
    {
        return adminServiceImpl.getNews(vo);
    }

    /**
     * 删除动态
     * @param newsid
     * @return
     * @throws Exception
     */
    @DeleteMapping(value = "/news/delete/{newsid}")
    public Result<Integer> deleteNews(@PathVariable("newsid") int newsid) throws Exception
    {
        return adminServiceImpl.deleteNews(newsid);
    }

    /**
     * 获取所有的用户
     * @param vo
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/user/all.yht")
    public  LayuiTable<List> getAllUser(UserEntity vo) throws Exception
    {
        return adminServiceImpl.getAllUser(vo);
    }

    /**
     * 修改用户
     * @param vo
     * @return
     * @throws Exception
     */
    @PutMapping(value = "/user/update.yht")
    public Result<Integer> updateUser(UserEntity vo) throws Exception
    {
        return adminServiceImpl.updateUser(vo);
    }

}
