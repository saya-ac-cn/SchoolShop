package api.dao;

import api.entity.ShopEntity;
import api.entity.StudentEntity;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 商户DAO
 */
@Repository("shopDAO")
public interface ShopDAO {

    /**
     * 根据商户名查询商户
     * @param vo
     * @return
     */
    public List<ShopEntity> queryShopByName(ShopEntity vo);

    /**
     * 根据商户ID查询商户
     * @param shopId
     * @return
     */
    public ShopEntity queryShopByID(@Param("shopId") Integer shopId);

    /**
     * 检查该学生下面是否有商户，以及商户的状态
     * @param StudendID
     * @return
     */
    public List<StudentEntity> queryShopIsexistByStudent(@Param(value = "StudendID") Integer StudendID);

    /**
     * 添加商户
     * @param vo
     * @return
     */
    public int insert(ShopEntity vo);

    /**
     * 修改商户
     * @param vo
     * @return
     */
    public int update(ShopEntity vo);

    /**
     * 获取所有的商户信息
     * @return
     */
    public List<ShopEntity> displayAll(RowBounds rowBounds);

}
