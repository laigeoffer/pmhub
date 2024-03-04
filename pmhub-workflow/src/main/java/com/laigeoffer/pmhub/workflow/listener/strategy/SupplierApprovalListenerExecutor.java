package com.laigeoffer.pmhub.workflow.listener.strategy;

import com.alibaba.fastjson2.JSON;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.ProviderRemindDTO;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

/**
 * 供应商监听
 * @author canghe
 * @date 2023-07-11 09:37
 */
@Slf4j
@Service("supplierApprovalListenerExecutor")
public class SupplierApprovalListenerExecutor extends ListenerAbstractExecutor {
    @Override
    public void push2Wx(ListenerDTO listenerDTO) {
        log.info("供应商审批发送消息:{}", JSON.toJSONString(listenerDTO));
        ProviderRemindDTO providerRemindDTO = new ProviderRemindDTO();
        BeanUtils.copyProperties(listenerDTO, providerRemindDTO);
        RocketMqUtils.push2Wx(providerRemindDTO);
    }
}
