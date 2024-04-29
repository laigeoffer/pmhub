package com.laigeoffer.pmhub.workflow.listener.strategy;

import com.alibaba.fastjson2.JSON;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.OutboundRemindDTO;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

/**
 * 采购出库监听
 * @author canghe
 * @date 2023-07-11 09:37
 */
@Slf4j
@Service("purchaseOutListenerExecutor")
public class PurchaseOutListenerExecutor extends ListenerAbstractExecutor {
    @Override
    public void push2Wx(ListenerDTO listenerDTO) {
        log.info("采购出库审批发送消息:{}", JSON.toJSONString(listenerDTO));
        OutboundRemindDTO outboundRemindDTO = new OutboundRemindDTO();
        BeanUtils.copyProperties(listenerDTO, outboundRemindDTO);
        RocketMqUtils.push2Wx(outboundRemindDTO);
    }
}
