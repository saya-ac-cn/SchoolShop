package api.controller;

import api.entity.AdminEntity;
import api.entity.ShopEntity;
import api.entity.StandEntity;
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

}
