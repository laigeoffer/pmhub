package com.laigeoffer.pmhub.workflow.listener.strategy;

import com.alibaba.fastjson2.JSON;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.ScrappedOutRemindDTO;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

/**
 * 物料报废监听
 * @author canghe
 * @date 2023-07-11 09:37
 */
@Slf4j
@Service("scrappedOutListenerExecutor")
public class ScrappedOutListenerExecutor extends ListenerAbstractExecutor {
    @Override
    public void push2Wx(ListenerDTO listenerDTO) {
        log.info("物料报废审批发送消息:{}", JSON.toJSONString(listenerDTO));
        ScrappedOutRemindDTO scrappedOutRemindDTO = new ScrappedOutRemindDTO();
        BeanUtils.copyProperties(listenerDTO, scrappedOutRemindDTO);
        RocketMqUtils.push2Wx(scrappedOutRemindDTO);
    }
}
