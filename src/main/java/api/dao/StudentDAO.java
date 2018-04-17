package api.dao;

import api.entity.StudentEntity;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 学生-商户DAO
 */
@Repository("studentDAO")
public interface StudentDAO {

    /**
     * 查询学生-商户(根据学号)
     * @param vo
     * @return
     */
    public List<StudentEntity> queryBasicById(StudentEntity vo);

    /**
     * 学生-商户注册
     * @param vo
     * @return
     */
    public int insert(StudentEntity vo);

    /**
     * 修改学生-商户
     * @param vo
     * @return
     */
    public int update(StudentEntity vo);

    /**
     * 删除学生-商户
     * @param vo
     * @return
     */
    public int delete(StudentEntity vo);

}
