package com.laigeoffer.projectaihub.workflow.service;

import com.laigeoffer.projectaihub.workflow.domain.vo.TodoNumVO;

import java.util.List;

/**
 * 流程监听和微信通知相关服务
 * @author canghe
 */
public interface IListenerService {

    /**
     * 获取所有有企微账号的用户的代办任务数量
     * @return 代办任务和企微账号
     * */
    List<TodoNumVO> getTodoNumList();

    /**
     * 代办事项提醒
     * @param todoNumVO 被提醒人和代办数量
     * */
    void sendTodoRemindMessage(TodoNumVO todoNumVO);


}
