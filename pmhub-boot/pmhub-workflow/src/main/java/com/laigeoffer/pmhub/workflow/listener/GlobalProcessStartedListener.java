package com.laigeoffer.pmhub.workflow.listener;

import cn.hutool.core.date.DateUtil;
import cn.hutool.log.LogFactory;
import com.laigeoffer.pmhub.common.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.common.utils.OAUtils;
import com.laigeoffer.pmhub.common.utils.StringUtils;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.result.ProcessReturnDTO;
import com.laigeoffer.pmhub.workflow.mapper.ListenerMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfCopyMapper;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import com.laigeoffer.pmhub.oa.utils.SsoUrlUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.engine.delegate.event.AbstractFlowableEngineEventListener;
import org.flowable.engine.delegate.event.FlowableProcessStartedEvent;
import org.flowable.engine.delegate.event.impl.FlowableEntityEventImpl;
import org.flowable.engine.impl.persistence.entity.ExecutionEntityImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import static com.laigeoffer.pmhub.oa.utils.wx.MessageUtils.*;

/**
 * 开始全局监听
 * @author canghe
 */
@Component
public class GlobalProcessStartedListener extends AbstractFlowableEngineEventListener {


    @Autowired
    ListenerMapper listenerMapper;

    @Autowired
    WfCopyMapper wfCopyMapper;


    @Override
    protected void processStarted(FlowableProcessStartedEvent event) {
        LogFactory.get().info("进入流程开始监听器------------------------Start---------------------->");


        FlowableEntityEventImpl flowableEntityEvent = (FlowableEntityEventImpl) event;
        ExecutionEntityImpl processInstance = (ExecutionEntityImpl) flowableEntityEvent.getEntity();

        // 获取申请人的微信
        SysUser sysUser = wfCopyMapper.selectUserById(Long.parseLong(processInstance.getVariable(BpmnXMLConstants.ATTRIBUTE_EVENT_START_INITIATOR).toString()));
        String createWxName = sysUser.getUserWxName();

        if (StringUtils.isNotEmpty(createWxName)){
            List<String> userIds = new ArrayList<>();
            userIds.add(createWxName);


            String url = "/work/own";
            // 详情跳转地址
            String processUrl =  SsoUrlUtils.ssoCreate(appid,agentid, host+path+"/sso/wx?url="+ URLEncoder.encode(host+url));
            ProcessReturnDTO processReturnDTO = new ProcessReturnDTO(
                    listenerMapper.getProcessName(flowableEntityEvent.getProcessDefinitionId())
                    , "已提交"
                    , "已进入审批流程"
                    , DateUtil.now()
                    ,processUrl
                    ,processUrl
                    , sysUser.getNickName()+"已提交审批", sysUser.getUserName(), listenerMapper.getProcessName(flowableEntityEvent.getProcessDefinitionId()) + "流程提交提醒", "您申请的流程已提交", OAUtils.ssoCreate(host + url)
            );
            processReturnDTO.setUserIds(userIds);
            RocketMqUtils.push2Wx(processReturnDTO);
        }



        LogFactory.get().info("流程开始监听器------------------------End---------------------->");

        // TODO: 在ACT_RU_TASK 中可以获取下一个节点

    }

}
