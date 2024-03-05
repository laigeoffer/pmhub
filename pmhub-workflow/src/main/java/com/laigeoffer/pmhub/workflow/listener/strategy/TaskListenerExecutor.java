package com.laigeoffer.pmhub.workflow.listener.strategy;

import com.alibaba.fastjson2.JSON;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.ProcessRemindDTO;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
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
        ProcessRemindDTO processRemindDTO = new ProcessRemindDTO();
        BeanUtils.copyProperties(listenerDTO, processRemindDTO);
        RocketMqUtils.push2Wx(processRemindDTO);
    }
}
