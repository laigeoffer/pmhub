package com.laigeoffer.pmhub.workflow.listener.strategy;

import com.alibaba.fastjson2.JSON;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.InboundRemindDTO;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

/**
 * 采购入库监听
 * @author canghe
 * @date 2023-07-11 09:37
 */
@Slf4j
@Service("purchaseIntoListenerExecutor")
public class PurchaseIntoListenerExecutor extends ListenerAbstractExecutor {
    @Override
    public void push2Wx(ListenerDTO listenerDTO) {
        log.info("采购入库审批发送消息:{}", JSON.toJSONString(listenerDTO));
        InboundRemindDTO inboundRemindDTO = new InboundRemindDTO();
        BeanUtils.copyProperties(listenerDTO, inboundRemindDTO);
        RocketMqUtils.push2Wx(inboundRemindDTO);
    }
}
