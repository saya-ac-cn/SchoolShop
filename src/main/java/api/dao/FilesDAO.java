package api.dao;

import api.entity.FilesEntity;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 文件DAO
 */
@Repository("filesDAO")
public interface FilesDAO {

    /**
     * 添加图片
     * @param vo
     * @return
     */
    public Integer insert(FilesEntity vo);

    /**
     * 获取图片
     * @param vo
     * @param rowBounds
     * @return
     */
    public List<FilesEntity> getFiles(FilesEntity vo,RowBounds rowBounds);

    /**
     * 修改图片
     * @param vo
     * @return
     */
    public Integer update(FilesEntity vo);

    /**
     * 删除图片
     * @param vo
     * @return
     */
    public Integer delete(FilesEntity vo);

}
