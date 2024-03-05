package com.laigeoffer.pmhub.workflow.listener.strategy;

import com.alibaba.fastjson2.JSON;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.OtherOutRemindDTO;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

/**
 * 其他出库监听
 * @author canghe
 * @date 2023-07-11 09:37
 */
@Slf4j
@Service("otherOutListenerExecutor")
public class OtherOutListenerExecutor extends ListenerAbstractExecutor {
    @Override
    public void push2Wx(ListenerDTO listenerDTO) {
        log.info("其他出库审批发送消息:{}", JSON.toJSONString(listenerDTO));
        OtherOutRemindDTO otherOutRemindDTO = new OtherOutRemindDTO();
        BeanUtils.copyProperties(listenerDTO, otherOutRemindDTO);
        RocketMqUtils.push2Wx(otherOutRemindDTO);
    }
}
