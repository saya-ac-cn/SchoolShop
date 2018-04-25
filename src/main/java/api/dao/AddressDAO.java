package api.dao;

import api.entity.AddressEntity;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 收货地址DAO
 */
@Repository("addressDAO")
public interface AddressDAO {

    /**
     * 添加收货地址
     * @param vo
     * @return
     */
    public Integer insert(AddressEntity vo);

    /**
     * 修改
     * @param vo
     * @return
     */
    public Integer update(AddressEntity vo);


    /**
     * 查询所有的收货地址
     * @param vo
     * @return
     */
    public List<AddressEntity> getAll(AddressEntity vo);

    /**
     * 删除地址
     * @param vo
     * @return
     */
    public Integer delete(AddressEntity vo);


}
