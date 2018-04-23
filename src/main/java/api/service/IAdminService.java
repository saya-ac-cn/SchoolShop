package api.service;

import api.entity.*;
import api.tools.LayuiTable;
import api.tools.Result;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 管理员接口部分
 */
public interface IAdminService {

    /**
     * 获取管理员的详情
     * @return
     * @throws Exception
     */
    public Result<Object> getAdingInfo() throws Exception;

    /**
     * 修改管理员的资料
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateAdminInfo(AdminEntity vo) throws Exception;

    /**
     * 上传用户图片
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    public Result<String> uploadLogo(HttpServletRequest request, MultipartFile file) throws  Exception;

    /**
     * 上传图片（头像的基类）
     * @param request
     * @param file
     * @return
     * @throws Exception
     */
    public Result<String> uploadPictureUtil(HttpServletRequest request, MultipartFile file) throws  Exception;


    /**
     * 获取所有商户信息-管理员用
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> displayAllShopPagin(ShopEntity vo) throws Exception;

    /**
     * 获取所有的摊位
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> displayAllStandPagin(StandEntity vo) throws Exception;

    /**
     * 添加摊位
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> insertStand(StandEntity vo) throws Exception;

    /**
     * 修改摊位
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateStand(StandEntity vo) throws Exception;

    /**
     * 发送消息
     * @param vo
     */
    public void sendMessage(MessageEntity vo);

    /**
     * 分派摊位/修改状态
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> manaShop(ShopEntity vo) throws Exception;

    /**
     * 发布动态
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> addNews(NewsEntity vo) throws Exception;

    /**
     * 修改动态
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateNews(NewsEntity vo) throws Exception;

    /**
     * 删除动态
     * @param id
     * @return
     * @throws Exception
     */
    public Result<Integer> deleteNews(Integer id) throws Exception;

    /**
     * 取出动态
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> getNews(NewsEntity vo) throws Exception;

    /**
     * 获取所有的用户
     * @param vo
     * @return
     * @throws Exception
     */
    public LayuiTable<List> getAllUser(UserEntity vo) throws Exception;

    /**
     * 审核用户的信息
     * @param vo
     * @return
     * @throws Exception
     */
    public Result<Integer> updateUser(UserEntity vo) throws  Exception;


}
