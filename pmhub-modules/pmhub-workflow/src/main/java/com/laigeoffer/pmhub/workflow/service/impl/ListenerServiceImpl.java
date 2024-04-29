package com.laigeoffer.pmhub.workflow.service.impl;

import com.laigeoffer.pmhub.workflow.domain.vo.TodoNumVO;
import com.laigeoffer.pmhub.workflow.mapper.ListenerMapper;
import com.laigeoffer.pmhub.workflow.service.IListenerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 流程监听和微信通知相关服务
 * @author canghe
 */
@Service
public class ListenerServiceImpl implements IListenerService {


    @Autowired
    ListenerMapper listenerMapper;

    /**
     * 获取所有有企微账号的用户的代办任务数量
     * @return 代办任务和企微账号
     * */
    @Override
    public List<TodoNumVO> getTodoNumList(){
        return listenerMapper.getTodoNumList();
    }

    /**
     * 代办事项提醒
     * @param todoNumVO 被提醒人和代办数量
     */
    @Override
    public void sendTodoRemindMessage(TodoNumVO todoNumVO) {

    }

}
