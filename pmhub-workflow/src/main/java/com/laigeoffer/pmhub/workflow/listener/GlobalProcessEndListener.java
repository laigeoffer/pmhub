package com.laigeoffer.pmhub.workflow.listener;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.log.LogFactory;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.laigeoffer.pmhub.common.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.common.enums.OAMessageStatusEnum;
import com.laigeoffer.pmhub.common.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.common.utils.OAUtils;
import com.laigeoffer.pmhub.common.utils.StringUtils;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.result.ProcessReturnDTO;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import com.laigeoffer.pmhub.oa.utils.SsoUrlUtils;
import com.laigeoffer.pmhub.workflow.domain.WfMaterialsScrappedProcess;
import com.laigeoffer.pmhub.workflow.domain.WfTaskMessageDeal;
import com.laigeoffer.pmhub.workflow.domain.WfTaskProcess;
import com.laigeoffer.pmhub.workflow.domain.vo.TaskCompletedStateVO;
import com.laigeoffer.pmhub.workflow.enums.TaskCompletedStateEnum;
import com.laigeoffer.pmhub.workflow.mapper.*;
import com.laigeoffer.pmhub.workflow.utils.ProcessUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEntityEvent;
import org.flowable.engine.delegate.event.AbstractFlowableEngineEventListener;
import org.flowable.engine.delegate.event.impl.FlowableEntityEventImpl;
import org.flowable.engine.impl.persistence.entity.ExecutionEntityImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import static com.laigeoffer.pmhub.oa.utils.wx.MessageUtils.*;


/**
 * 流程结束全局监听
 *
 * @author canghe*/
@Component
public class GlobalProcessEndListener extends AbstractFlowableEngineEventListener {

    @Autowired
    ListenerMapper listenerMapper;

    @Autowired
    WfCopyMapper wfCopyMapper;

    @Autowired
    private WfTaskProcessMapper wfTaskProcessMapper;

    @Autowired
    private WfTaskMessageDealMapper wfTaskMessageDealMapper;

    @Autowired
    private WfMaterialsScrappedProcessMapper wfMaterialsScrappedProcessMapper;
//    @Autowired
//    private MaterialsChangeRecordsCountService materialsChangeRecordsCountService;
//    @Autowired
//    private MaterialsUselessMapper materialsUselessMapper;
//    @Autowired
//    private MaterialsUselessService materialsUselessService;
//    @Autowired
//    private MaterialsUselessAsyncTaskService materialsUselessAsyncTaskService;




    private boolean isCancelled = false;

    @Override
    protected void processCompleted(FlowableEngineEntityEvent event) {
        LogFactory.get().info("进入流程完成监听器------------------------Start---------------------->");


        LogFactory.get().info("结束状态："+event.getType());


        FlowableEntityEventImpl flowableEntityEvent = (FlowableEntityEventImpl) event;
        ExecutionEntityImpl processInstance = (ExecutionEntityImpl) flowableEntityEvent.getEntity();

        String type = processInstance.getVariable(ProcessUtils.APPROVAL_TYPE).toString();

        // 获取申请人的微信
        SysUser sysUser = wfCopyMapper.selectUserById(Long.parseLong(processInstance.getVariable(BpmnXMLConstants.ATTRIBUTE_EVENT_START_INITIATOR).toString()));
        String createWxName = sysUser.getUserWxName();

        String definitionId = processInstance.getProcessDefinitionKey();
        String instId = processInstance.getId();

        // 最终结果
        TaskCompletedStateVO taskCompletedStateVO = listenerMapper.getLastTaskCompletedState(flowableEntityEvent.getProcessInstanceId());
        if(ObjectUtil.isEmpty(taskCompletedStateVO)){
            taskCompletedStateVO = new TaskCompletedStateVO();
            taskCompletedStateVO.setTaskType("6");
            taskCompletedStateVO.setTaskTypeDesc(TaskCompletedStateEnum.STOP.toString());
            taskCompletedStateVO.setTaskMessage("任务因其它原因已终止");
        }
        // 审批通过更新任务状态为已完成
        if (TaskCompletedStateEnum.PASS.toString().equals(taskCompletedStateVO.getTaskTypeDesc())) {
            LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
            qw.eq(WfTaskProcess::getInstanceId, instId).eq(WfTaskProcess::getType, type);
            WfTaskProcess wfTaskProcess = wfTaskProcessMapper.selectOne(qw);
            if (ObjectUtil.isNotEmpty(wfTaskProcess)) {
                if (ProjectStatusEnum.TASK.getStatusName().equals(type)) {
                    wfTaskProcessMapper.updateTaskStatus(wfTaskProcess.getExtraId());
                    LogFactory.get().info("更新项目任务id:{}", wfTaskProcess.getExtraId());
                } else if (ProcessUtils.SUPPLIER_APPROVAL_TYPE.equals(type)) {
                    wfTaskProcessMapper.updateProviderStatus(wfTaskProcess.getExtraId());
                    LogFactory.get().info("更新供应商id:{}", wfTaskProcess.getExtraId());
                } else {
//                    String id = wfTaskProcessMapper.selectLinkRecordsId(wfTaskProcess.getExtraId());
//                    MaterialsUseless materialsUseless = materialsUselessMapper.selectById(id);
//                    if (materialsUseless != null && "报废".equals(materialsUseless.getResolution())) {
//                        throw new ServiceException("此申请所关联的入库单[" + id + "]正处于呆滞报废状态，库存已冻结，如需出库请联系管理员");
//                    }
//                    wfTaskProcessMapper.updateProcessState(wfTaskProcess.getExtraId());
//                    LogFactory.get().info("更新单据编号id:{}", wfTaskProcess.getExtraId());
//                    if (StringUtils.isNotBlank(id)) {
//                        materialsChangeRecordsCountService.calcCount(id,1);
//                    } else {
//                        materialsChangeRecordsCountService.calcCount(wfTaskProcess.getExtraId(),1);
//                    }
                }
            }
            if (ProcessUtils.SCRAPPED_OUT_APPROVAL_TYPE.equals(type)) {
//                LambdaQueryWrapper<WfMaterialsScrappedProcess> wrapper = new LambdaQueryWrapper<>();
//                wrapper.eq(WfMaterialsScrappedProcess::getInstanceId, instId);
//                List<WfMaterialsScrappedProcess> scrappedProcessList = wfMaterialsScrappedProcessMapper.selectList(wrapper);
//                LogFactory.get().info("物料报废scrappedProcessList:{}", JSON.toJSONString(scrappedProcessList));
//                scrappedProcessList.forEach(scrappedProcess -> materialsUselessAsyncTaskService.discardAllOrderAsUseless(Collections.singletonList(scrappedProcess.getMaterialId())));
//                List<String> ids = scrappedProcessList.stream().map(WfMaterialsScrappedProcess::getMaterialId).collect(Collectors.toList());
//                if (CollectionUtils.isNotEmpty(ids)) {
//                    LambdaUpdateChainWrapper<MaterialsUseless> updateWrapper = new LambdaUpdateChainWrapper<>(materialsUselessMapper);
//                    updateWrapper.in(MaterialsUseless::getRecordId, ids).set(MaterialsUseless::getApproved, 2);
//                    updateWrapper.update();
//                }
            }

        }
        if (TaskCompletedStateEnum.REJECT.toString().equals(taskCompletedStateVO.getTaskTypeDesc())) {
            LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
            qw.eq(WfTaskProcess::getInstanceId, instId).eq(WfTaskProcess::getType, type);
            WfTaskProcess wfTaskProcess = wfTaskProcessMapper.selectOne(qw);
            if (ObjectUtil.isNotEmpty(wfTaskProcess)) {
                if (!ProjectStatusEnum.TASK.getStatusName().equals(type) && !ProcessUtils.SUPPLIER_APPROVAL_TYPE.equals(type)) {
                    wfTaskProcessMapper.updateProcessState2(wfTaskProcess.getExtraId());
                    LogFactory.get().info("更新单据编号id:{}", wfTaskProcess.getExtraId());
                } else {
                    // 将任务状态改为未开始
                    wfTaskProcessMapper.updateTaskStatus2(wfTaskProcess.getExtraId());
                    LogFactory.get().info("更新项目任务状态id:{}", wfTaskProcess.getExtraId());
                }
            }
            LambdaQueryWrapper<WfMaterialsScrappedProcess> qw2 = new LambdaQueryWrapper<>();
            qw2.eq(WfMaterialsScrappedProcess::getInstanceId, instId);
            List<WfMaterialsScrappedProcess> scrappedProcessList = wfMaterialsScrappedProcessMapper.selectList(qw2);
//            List<String> ids = scrappedProcessList.stream().map(WfMaterialsScrappedProcess::getMaterialId).collect(Collectors.toList());
//            if (CollectionUtils.isNotEmpty(ids)) {
//                LambdaUpdateChainWrapper<MaterialsUseless> updateWrapper = new LambdaUpdateChainWrapper<>(materialsUselessMapper);
//                updateWrapper.in(MaterialsUseless::getRecordId, ids).set(MaterialsUseless::getApproved, 0);
//                updateWrapper.update();
//            }
            // wfMaterialsScrappedProcessMapper.delete(qw2);

        }
        if (StringUtils.isNotEmpty(createWxName)){
            List<String> userIds = new ArrayList<>();
            userIds.add(createWxName);

            // 拼接审批详情页
            String taskId =  listenerMapper.getTaskId(instId);
            String deployId = listenerMapper.getDeployId(taskId);

            String url = String.format("/workflow/process/detail/%s?definitionId=%s&deployId=%s&taskId=%s&finished=false",instId,definitionId,deployId,taskId);
            // 详情跳转地址
            String processUrl =  SsoUrlUtils.ssoCreate(appid,agentid, host+path+"/sso/wx?url="+URLEncoder.encode(host+url));
            ProcessReturnDTO processReturnDTO = new ProcessReturnDTO(
                    listenerMapper.getProcessName(flowableEntityEvent.getProcessDefinitionId())
                    , taskCompletedStateVO.getTaskTypeDesc()
                    ,"流程已结束"
                    , DateUtil.now()
                    ,processUrl
                    ,processUrl
                    ,taskCompletedStateVO.getTaskMessage(), sysUser.getUserName(), listenerMapper.getProcessName(flowableEntityEvent.getProcessDefinitionId()) + "流程结束提醒", "您申请的流程------" + taskCompletedStateVO.getTaskTypeDesc(), OAUtils.ssoCreate(host + url)
            );
            processReturnDTO.setUserIds(userIds);
            RocketMqUtils.push2Wx(processReturnDTO);
        }

        // 清理审批提醒消息
        LambdaQueryWrapper<WfTaskMessageDeal> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(WfTaskMessageDeal::getInstanceId, instId);
        List<WfTaskMessageDeal> wfTaskMessageDeals = wfTaskMessageDealMapper.selectList(queryWrapper);
        TaskCompletedStateVO finalTaskCompletedStateVO = taskCompletedStateVO;
        wfTaskMessageDeals.forEach(a -> {
            RocketMqUtils.cleanMessage(a.getTaskId() + "_" + a.getAssignee());
            OAUtils.restfulCall2(OAUtils.ALTER_MESSAGE_API, OAUtils.mapToStr(OAUtils.alterCustomMessageSingle(a.getTaskId() + "_" + a.getAssignee(), OAMessageStatusEnum.DEAL.getStatus(), wfCopyMapper.selectUserById(Long.valueOf(a.getAssignee())).getUserName())), OAUtils.ALTER_MESSAGE_API);
        });
        wfTaskMessageDealMapper.delete(queryWrapper);
        LogFactory.get().info("流程完成监听器------------------------End---------------------->");

    }

}
