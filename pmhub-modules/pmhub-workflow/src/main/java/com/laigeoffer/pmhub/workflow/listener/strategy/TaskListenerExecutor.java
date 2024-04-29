package com.laigeoffer.pmhub.workflow.listener.strategy;

import com.alibaba.fastjson2.JSON;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 任务监听
 * @author canghe
 * @date 2023-07-11 09:37
 */
@Slf4j
@Service("taskListenerExecutor")
public class TaskListenerExecutor extends ListenerAbstractExecutor {
    @Override
    public void push2Wx(ListenerDTO listenerDTO) {
        log.info("任务审批发送消息:{}", JSON.toJSONString(listenerDTO));
        // TODO: 2024.04.25 任务发送企微消息暂时关闭 
//        ProcessRemindDTO processRemindDTO = new ProcessRemindDTO();
//        BeanUtils.copyProperties(listenerDTO, processRemindDTO);
//        RocketMqUtils.push2Wx(processRemindDTO);
    }
}
