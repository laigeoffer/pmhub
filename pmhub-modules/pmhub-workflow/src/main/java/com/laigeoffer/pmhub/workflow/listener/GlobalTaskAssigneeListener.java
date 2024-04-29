package com.laigeoffer.pmhub.workflow.listener;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.log.LogFactory;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.domain.WfTaskMessageDeal;
import com.laigeoffer.pmhub.workflow.listener.strategy.ListenerFactory;
import com.laigeoffer.pmhub.workflow.mapper.ListenerMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfCopyMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfTaskMessageDealMapper;
import com.laigeoffer.pmhub.workflow.utils.ProcessUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEntityEvent;
import org.flowable.engine.delegate.event.AbstractFlowableEngineEventListener;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 创建任务开始（任务节点发生变动）事件
 * @author canghe
 */
@Component
public class GlobalTaskAssigneeListener extends AbstractFlowableEngineEventListener {


    private static WfCopyMapper wfCopyMapper;
    private static ListenerFactory listenerFactory;

    @Autowired
    private void setWfCopyMapper(WfCopyMapper wfCopyMapper, ListenerFactory listenerFactory) {
        GlobalTaskAssigneeListener.wfCopyMapper = wfCopyMapper;
        GlobalTaskAssigneeListener.listenerFactory = listenerFactory;
    }


    private static ListenerMapper listenerMapper;
    @Autowired
    private void setListenerMapper(ListenerMapper listenerMapper) {
        GlobalTaskAssigneeListener.listenerMapper = listenerMapper;
    }

    @Autowired
    private WfTaskMessageDealMapper wfTaskMessageDealMapper;


    public static final String DETAIL_URL = "/workflow/process/detail/%s?definitionId=%s&deployId=%s&taskId=%s&finished=true";
    public static final String SSO_URL = "/sso/wx?url=";


    public static final String INITIATOR = "initiator";





    @Override
    protected void taskAssigned(FlowableEngineEntityEvent event) {
        LogFactory.get().info("任务创建------------------------Start---------------------->");

        TaskEntity taskEntity = (TaskEntity)event.getEntity();
        // 申请人id
        String createUid = taskEntity.getVariable(BpmnXMLConstants.ATTRIBUTE_EVENT_START_INITIATOR).toString();
        // 审批类型
        String type = taskEntity.getVariable(ProcessUtils.APPROVAL_TYPE).toString();
        // 处理人id
        String actinUid = taskEntity.getAssignee();

        WfTaskMessageDeal wfTaskMessageDeal = new WfTaskMessageDeal();
        wfTaskMessageDeal.setTaskId(taskEntity.getId());
        wfTaskMessageDeal.setAssignee(actinUid);
        wfTaskMessageDeal.setInstanceId(taskEntity.getProcessInstanceId());
        wfTaskMessageDealMapper.insert(wfTaskMessageDeal);

        if (StringUtils.isEmpty(createUid)||StringUtils.isEmpty(actinUid)){
            return;
        }

        // 发送消息
        creatWxMessage(
                  Long.parseLong(createUid)
                , Long.parseLong(actinUid)
                , taskEntity.getVariables()
                , taskEntity.getProcessDefinitionId()
                , taskEntity.getProcessInstanceId()
                , taskEntity.getId()
                , taskEntity.getVariable(ProcessUtils.TASK_DETAIL_URL_KEY).toString()
                , null, type
        );


        LogFactory.get().info("任务创建------------------------End---------------------->");
    }


    /**
     * 构建通知信息
     * @param instId  instId
     * @param actinUid  审核人id
     * @param createUid  申请人id
     * @param taskId  taskId
     * @param definitionId  definitionId
     * @param taskName 任务名
     * @param variables 表单数据
     * */
    public static void creatWxMessage(Long createUid
            ,Long actinUid
            ,Map<String, Object> variables
            ,String definitionId
            ,String instId
            ,String taskId
            ,String taskDetailIUrl
            ,String taskName, String type
    ){
        SysUser sysUser = wfCopyMapper.selectUserById(createUid);
        // 申请人信息
        String createWxNickName = sysUser.getNickName();
        // 审批人微信号
        String taskWxName = wfCopyMapper.selectUserById(actinUid).getUserWxName();


        if (StringUtils.isNotEmpty(taskWxName)) {

            // 微信消息接收人
            List<String> userIds = new ArrayList<>();
            userIds.add(taskWxName);


            LogFactory.get().info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>url:" + taskDetailIUrl);

            if (ObjectUtil.isEmpty(taskDetailIUrl)) {
                // TODO: 2024.04.25  
//                taskDetailIUrl = host;
            }

            // 审批任务详情
            StringBuilder infoStr = new StringBuilder();

            if (ObjectUtil.isEmpty(variables)) {
                LogFactory.get().info("详细信息为空");
                infoStr.append("暂无信息");
            } else {
                for (Map.Entry<String, Object> entry : variables.entrySet()) {
                    // 表单文本部分拼接为详情，TASK_DETAIL_URL 设置为详情连接
                    if (!entry.getKey().equals(ProcessUtils.APPROVAL_TYPE) && !entry.getKey().equals(INITIATOR) && !entry.getKey().equals(ProcessUtils.TASK_DETAIL_URL_KEY)) {
                        Object value = entry.getValue();
                        if (value instanceof String) {
                            infoStr.append(entry.getValue()).append(" ");
                        }
                    }
                }
            }


            // 审批流名称
            String processName;
            if (ObjectUtil.isEmpty(taskName)) {
                processName = listenerMapper.getProcessName(definitionId);
            } else {
                processName = taskName;
            }
            // deployId
            String deployId = listenerMapper.getDeployByDefinitionId(definitionId);
            String typeName = listenerMapper.getProcessTypeName(deployId);


            // 审批跳转地址
            String url = String.format(DETAIL_URL, instId, definitionId, deployId, taskId);
            try {
                // TODO: 2024.04.25 关闭发送企微 
//                String processUrl = SsoUrlUtils.ssoCreate(appid, agentid, host + path + SSO_URL + URLEncoder.encode(host + url, CharsetUtil.UTF_8));
//                String taskDetailUrlEncode = SsoUrlUtils.ssoCreate(appid, agentid, host + path + SSO_URL + URLEncoder.encode(taskDetailIUrl, CharsetUtil.UTF_8));
//                ListenerDTO listenerDTO = new ListenerDTO();
//                listenerDTO.setInstId(instId);
//                listenerDTO.setTaskId(taskId);
//                listenerDTO.setWxUserName(taskWxName);
//                listenerDTO.setAssignee(String.valueOf(actinUid));
//                listenerDTO.setUserIds(userIds);
//                listenerDTO.setTitle(processName);
//                listenerDTO.setRemarks(infoStr.toString());
//                listenerDTO.setProcessType(typeName);
//                listenerDTO.setCreateUserName(createWxNickName);
//                listenerDTO.setDetailUrl(taskDetailUrlEncode);
//                listenerDTO.setPanelUrl(processUrl);
//                listenerDTO.setOaTitle(processName + "流程提醒");
//                listenerDTO.setOaContext("您有一个新的审批申请 申请人：" + createWxNickName);
//                listenerDTO.setUserName(wfCopyMapper.selectUserById(actinUid).getUserName());
//                listenerDTO.setLinkUrl(OAUtils.ssoCreate(host + url));
                // 发送企微消息
//                listenerFactory.execute(type, listenerDTO);
            } catch (Exception ex) {
                LogFactory.get().error("审批提醒发送失败：" + ex);
            }
        }



    }

}
