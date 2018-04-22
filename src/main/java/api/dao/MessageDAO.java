package api.dao;


import api.entity.MessageEntity;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("messageDAO")
public interface MessageDAO {

    /**
     * 获取相关的站内消息
     * @param vo
     * @return
     */
    public List<MessageEntity> getAllMessage(MessageEntity vo, RowBounds rowBounds);

    /**
     * 发送站内消息
     * @param vo
     * @return
     */
    public Integer sendMessage(MessageEntity vo);


}
