package com.laigeoffer.pmhub.workflow.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.common.constant.ProcessConstants;
import com.laigeoffer.pmhub.workflow.common.constant.TaskConstants;
import com.laigeoffer.pmhub.workflow.common.enums.FlowComment;
import com.laigeoffer.pmhub.workflow.domain.WfTaskMessageDeal;
import com.laigeoffer.pmhub.base.core.core.domain.entity.WfTaskProcess;
import com.laigeoffer.pmhub.workflow.domain.bo.WfTaskBo;
import com.laigeoffer.pmhub.workflow.factory.FlowServiceFactory;
import com.laigeoffer.pmhub.workflow.flow.CustomProcessDiagramGenerator;
import com.laigeoffer.pmhub.workflow.flow.FlowableUtils;
import com.laigeoffer.pmhub.workflow.mapper.ListenerMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfCopyMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfTaskMessageDealMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfTaskProcessMapper;
import com.laigeoffer.pmhub.workflow.service.IWfCopyService;
import com.laigeoffer.pmhub.workflow.service.IWfTaskService;
import com.laigeoffer.pmhub.workflow.utils.ModelUtils;
import com.laigeoffer.pmhub.workflow.utils.TaskUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.model.Process;
import org.flowable.bpmn.model.*;
import org.flowable.common.engine.api.FlowableException;
import org.flowable.common.engine.api.FlowableObjectNotFoundException;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.image.ProcessDiagramGenerator;
import org.flowable.task.api.DelegationState;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author canghe
 * @createTime 2022/3/10 00:12
 */
@RequiredArgsConstructor
@Service
@Slf4j
public class WfTaskServiceImpl extends FlowServiceFactory implements IWfTaskService {

    private final IWfCopyService copyService;
    private final WfCopyMapper wfCopyMapper;
    private final WfTaskProcessMapper wfTaskProcessMapper;
//    private final WfMaterialsScrappedProcessMapper wfMaterialsScrappedProcessMapper;

    @Autowired
    ListenerMapper listenerMapper;
    @Autowired
    private WfTaskMessageDealMapper wfTaskMessageDealMapper;
//    @Autowired
//    private MaterialsUselessMapper materialsUselessMapper;

    /**
     * 完成任务
     *
     * @param taskBo 请求实体参数
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void complete(WfTaskBo taskBo) {
        Task task = taskService.createTaskQuery().taskId(taskBo.getTaskId()).singleResult();
        if (Objects.isNull(task)) {
            throw new ServiceException("任务不存在");
        }
        // 获取 bpmn 模型
        BpmnModel bpmnModel = repositoryService.getBpmnModel(task.getProcessDefinitionId());
        if (DelegationState.PENDING.equals(task.getDelegationState())) {
            taskService.addComment(taskBo.getTaskId(), taskBo.getProcInsId(), FlowComment.DELEGATE.getType(), taskBo.getComment());
            taskService.resolveTask(taskBo.getTaskId());
        } else {
            taskService.addComment(taskBo.getTaskId(), taskBo.getProcInsId(), FlowComment.NORMAL.getType(), taskBo.getComment());
            taskService.setAssignee(taskBo.getTaskId(), TaskUtils.getUserId());
            if (ObjectUtil.isNotEmpty(taskBo.getVariables())) {
                // 获取模型信息
                String localScopeValue = ModelUtils.getUserTaskAttributeValue(bpmnModel, task.getTaskDefinitionKey(), ProcessConstants.PROCESS_FORM_LOCAL_SCOPE);
                boolean localScope = Convert.toBool(localScopeValue, false);
                taskService.complete(taskBo.getTaskId(), taskBo.getVariables(), localScope);
            } else {
                taskService.complete(taskBo.getTaskId());
            }
        }
        // 设置任务节点名称
        taskBo.setTaskName(task.getName());
        // 处理下一级审批人
        if (StringUtils.isNotBlank(taskBo.getNextUserIds())) {
            this.assignNextUsers(bpmnModel, taskBo.getProcInsId(), taskBo.getNextUserIds());
        }
        // 处理抄送用户
        if (!copyService.makeCopy(taskBo)) {
            throw new RuntimeException("抄送任务失败");
        }
    }

    /**
     * 拒绝任务
     *
     * @param taskBo
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void taskReject(WfTaskBo taskBo) {
        // 当前任务 task
        Task task = taskService.createTaskQuery().taskId(taskBo.getTaskId()).singleResult();
        if (ObjectUtil.isNull(task)) {
            throw new RuntimeException("获取任务信息异常！");
        }
        if (task.isSuspended()) {
            throw new RuntimeException("任务处于挂起状态");
        }
        // 获取流程实例
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
            .processInstanceId(taskBo.getProcInsId())
            .singleResult();
        if (processInstance == null) {
            throw new RuntimeException("流程实例不存在，请确认！");
        }
        // 获取流程定义信息
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
            .processDefinitionId(task.getProcessDefinitionId())
            .singleResult();

        // 添加审批意见
        taskService.addComment(taskBo.getTaskId(), taskBo.getProcInsId(), FlowComment.REJECT.getType(), taskBo.getComment());

        // 获取所有节点信息
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinition.getId());
        EndEvent endEvent = ModelUtils.getEndEvent(bpmnModel);
        // 终止流程
        List<Execution> executions = runtimeService.createExecutionQuery().parentId(task.getProcessInstanceId()).list();
        List<String> executionIds = executions.stream().map(Execution::getId).collect(Collectors.toList());
        runtimeService.createChangeActivityStateBuilder()
            .processInstanceId(task.getProcessInstanceId())
            .moveExecutionsToSingleActivityId(executionIds, endEvent.getId())
            .changeState();
        // 处理抄送用户
        if (!copyService.makeCopy(taskBo)) {
            throw new RuntimeException("抄送任务失败");
        }
    }

    /**
     * 退回任务
     *
     * @param bo 请求实体参数
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void taskReturn(WfTaskBo bo) {
        // 当前任务 task
        Task task = taskService.createTaskQuery().taskId(bo.getTaskId()).singleResult();
        if (ObjectUtil.isNull(task)) {
            throw new RuntimeException("获取任务信息异常！");
        }
        if (task.isSuspended()) {
            throw new RuntimeException("任务处于挂起状态");
        }
        // 获取流程定义信息
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(task.getProcessDefinitionId()).singleResult();
        // 获取所有节点信息
        Process process = repositoryService.getBpmnModel(processDefinition.getId()).getProcesses().get(0);
        // 获取全部节点列表，包含子节点
        Collection<FlowElement> allElements = FlowableUtils.getAllElements(process.getFlowElements(), null);
        // 获取当前任务节点元素
        FlowElement source = null;
        // 获取跳转的节点元素
        FlowElement target = null;
        if (allElements != null) {
            for (FlowElement flowElement : allElements) {
                // 当前任务节点元素
                if (flowElement.getId().equals(task.getTaskDefinitionKey())) {
                    source = flowElement;
                }
                // 跳转的节点元素
                if (flowElement.getId().equals(bo.getTargetKey())) {
                    target = flowElement;
                }
            }
        }

        // 从当前节点向前扫描
        // 如果存在路线上不存在目标节点，说明目标节点是在网关上或非同一路线上，不可跳转
        // 否则目标节点相对于当前节点，属于串行
        Boolean isSequential = FlowableUtils.iteratorCheckSequentialReferTarget(source, bo.getTargetKey(), null, null);
        if (!isSequential) {
            throw new RuntimeException("当前节点相对于目标节点，不属于串行关系，无法回退");
        }


        // 获取所有正常进行的任务节点 Key，这些任务不能直接使用，需要找出其中需要撤回的任务
        List<Task> runTaskList = taskService.createTaskQuery().processInstanceId(task.getProcessInstanceId()).list();
        List<String> runTaskKeyList = new ArrayList<>();
        runTaskList.forEach(item -> runTaskKeyList.add(item.getTaskDefinitionKey()));
        // 需退回任务列表
        List<String> currentIds = new ArrayList<>();
        // 通过父级网关的出口连线，结合 runTaskList 比对，获取需要撤回的任务
        List<UserTask> currentUserTaskList = FlowableUtils.iteratorFindChildUserTasks(target, runTaskKeyList, null, null);
        currentUserTaskList.forEach(item -> currentIds.add(item.getId()));

        // 循环获取那些需要被撤回的节点的ID，用来设置驳回原因
        List<String> currentTaskIds = new ArrayList<>();
        currentIds.forEach(currentId -> runTaskList.forEach(runTask -> {
            if (currentId.equals(runTask.getTaskDefinitionKey())) {
                currentTaskIds.add(runTask.getId());
            }
        }));
        // 设置回退意见
        for (String currentTaskId : currentTaskIds) {
            taskService.addComment(currentTaskId, task.getProcessInstanceId(), FlowComment.REBACK.getType(), bo.getComment());
        }

        try {
            // 1 对 1 或 多 对 1 情况，currentIds 当前要跳转的节点列表(1或多)，targetKey 跳转到的节点(1)
            runtimeService.createChangeActivityStateBuilder()
                .processInstanceId(task.getProcessInstanceId())
                .moveActivityIdsToSingleActivityId(currentIds, bo.getTargetKey()).changeState();
        } catch (FlowableObjectNotFoundException e) {
            throw new RuntimeException("未找到流程实例，流程可能已发生变化");
        } catch (FlowableException e) {
            throw new RuntimeException("无法取消或开始活动");
        }
        extracted(bo.getTaskId());
        // 设置任务节点名称
        bo.setTaskName(task.getName());
        // 处理抄送用户
        if (!copyService.makeCopy(bo)) {
            throw new RuntimeException("抄送任务失败");
        }
    }


    /**
     * 获取所有可回退的节点
     *
     * @param bo
     * @return
     */
    @Override
    public List<UserTask> findReturnTaskList(WfTaskBo bo) {
        // 当前任务 task
        Task task = taskService.createTaskQuery().taskId(bo.getTaskId()).singleResult();
        // 获取流程定义信息
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(task.getProcessDefinitionId()).singleResult();
        // 获取所有节点信息，暂不考虑子流程情况
        Process process = repositoryService.getBpmnModel(processDefinition.getId()).getProcesses().get(0);
        Collection<FlowElement> flowElements = process.getFlowElements();
        // 获取当前任务节点元素
        UserTask source = null;
        if (flowElements != null) {
            for (FlowElement flowElement : flowElements) {
                // 类型为用户节点
                if (flowElement.getId().equals(task.getTaskDefinitionKey())) {
                    source = (UserTask) flowElement;
                }
            }
        }
        // 获取节点的所有路线
        List<List<UserTask>> roads = FlowableUtils.findRoad(source, null, null, null);
        // 可回退的节点列表
        List<UserTask> userTaskList = new ArrayList<>();
        for (List<UserTask> road : roads) {
            if (userTaskList.size() == 0) {
                // 还没有可回退节点直接添加
                userTaskList = road;
            } else {
                // 如果已有回退节点，则比对取交集部分
                userTaskList.retainAll(road);
            }
        }
        return userTaskList;
    }

    /**
     * 删除任务
     *
     * @param bo 请求实体参数
     */
    @Override
    public void deleteTask(WfTaskBo bo) {
        // todo 待确认删除任务是物理删除任务 还是逻辑删除，让这个任务直接通过？
        taskService.deleteTask(bo.getTaskId(), bo.getComment());
    }

    /**
     * 认领/签收任务
     *
     * @param taskBo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void claim(WfTaskBo taskBo) {
        Task task = taskService.createTaskQuery().taskId(taskBo.getTaskId()).singleResult();
        if (Objects.isNull(task)) {
            throw new ServiceException("任务不存在");
        }
        taskService.claim(taskBo.getTaskId(), TaskUtils.getUserId());
    }

    /**
     * 取消认领/签收任务
     *
     * @param bo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void unClaim(WfTaskBo bo) {
        taskService.unclaim(bo.getTaskId());
    }

    /**
     * 委派任务
     *
     * @param bo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delegateTask(WfTaskBo bo) {
        // 当前任务 task
        Task task = taskService.createTaskQuery().taskId(bo.getTaskId()).singleResult();
        if (ObjectUtil.isEmpty(task)) {
            throw new ServiceException("获取任务失败！");
        }

        // TODO: 2024.04.25 删除oa模块暂时
//        RocketMqUtils.cleanMessage(bo.getTaskId() + "_" + SecurityUtils.getUserId());
//        OAUtils.restfulCall2(OAUtils.ALTER_MESSAGE_API, OAUtils.mapToStr(OAUtils.alterCustomMessageSingle(bo.getTaskId() + "_" + bo.getAssignee(), OAMessageStatusEnum.DEAL.getStatus(), wfCopyMapper.selectUserById(SecurityUtils.getUserId()).getUserName())), "OAUtils.ALTER_MESSAGE_API");
        LambdaQueryWrapper<WfTaskMessageDeal> qw = new LambdaQueryWrapper<>();
        qw.eq(WfTaskMessageDeal::getTaskId, bo.getTaskId()).eq(WfTaskMessageDeal::getAssignee, SecurityUtils.getUserId());
        wfTaskMessageDealMapper.delete(qw);
        StringBuilder commentBuilder = new StringBuilder(wfCopyMapper.selectUserById(SecurityUtils.getUserId()).getNickName())
            .append("->");
        SysUser user = wfCopyMapper.selectUserById(Long.parseLong(bo.getUserId()));
        if (ObjectUtil.isNotNull(user)) {
            commentBuilder.append(user.getNickName());
        } else {
            commentBuilder.append(bo.getUserId());
        }
        if (StringUtils.isNotBlank(bo.getComment())) {
            commentBuilder.append(": ").append(bo.getComment());
        }
        // 添加审批意见
        taskService.addComment(bo.getTaskId(), task.getProcessInstanceId(), FlowComment.DELEGATE.getType(), commentBuilder.toString());
        // 设置办理人为当前登录人
        taskService.setOwner(bo.getTaskId(), TaskUtils.getUserId());
        // 执行委派
        taskService.delegateTask(bo.getTaskId(), bo.getUserId());
        // 设置任务节点名称
        bo.setTaskName(task.getName());
        // 处理抄送用户
        if (!copyService.makeCopy(bo)) {
            throw new RuntimeException("抄送任务失败");
        }

    }


    /**
     * 转办任务
     *
     * @param bo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void transferTask(WfTaskBo bo) {
        // 当前任务 task
        Task task = taskService.createTaskQuery().taskId(bo.getTaskId()).singleResult();

        if (ObjectUtil.isEmpty(task)) {
            throw new ServiceException("获取任务失败！");
        }
        extracted(bo.getTaskId());
        StringBuilder commentBuilder = new StringBuilder(wfCopyMapper.selectUserById(SecurityUtils.getUserId()).getNickName())
            .append("->");
        SysUser user = wfCopyMapper.selectUserById(Long.parseLong(bo.getUserId()));
        if (ObjectUtil.isNotNull(user)) {
            commentBuilder.append(user.getNickName());
        } else {
            commentBuilder.append(bo.getUserId());
        }
        if (StringUtils.isNotBlank(bo.getComment())) {
            commentBuilder.append(": ").append(bo.getComment());
        }
        // 添加审批意见
        taskService.addComment(bo.getTaskId(), task.getProcessInstanceId(), FlowComment.TRANSFER.getType(), commentBuilder.toString());
        // 设置拥有者为当前登录人
        taskService.setOwner(bo.getTaskId(), TaskUtils.getUserId());
        // 转办任务
        taskService.setAssignee(bo.getTaskId(), bo.getUserId());
        // 设置任务节点名称
        bo.setTaskName(task.getName());
        // 处理抄送用户
        if (!copyService.makeCopy(bo)) {
            throw new RuntimeException("抄送任务失败");
        }

    }

    private void extracted(String taskId) {
        // TODO: 2024.04.25 删除oa模块暂时
//        RocketMqUtils.cleanMessage(taskId + "_" + SecurityUtils.getUserId());
//        OAUtils.restfulCall2(OAUtils.ALTER_MESSAGE_API, OAUtils.mapToStr(OAUtils.alterCustomMessageSingle(taskId + "_" + SecurityUtils.getUserId(), OAMessageStatusEnum.DEAL.getStatus(), wfCopyMapper.selectUserById(SecurityUtils.getUserId()).getUserName())), OAUtils.ALTER_MESSAGE_API);
        LambdaQueryWrapper<WfTaskMessageDeal> qw = new LambdaQueryWrapper<>();
        qw.eq(WfTaskMessageDeal::getTaskId, taskId).eq(WfTaskMessageDeal::getAssignee, SecurityUtils.getUserId());
        wfTaskMessageDealMapper.delete(qw);
    }

    /**
     * 取消申请
     *
     * @param bo
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void stopProcess(WfTaskBo bo) {
        List<Task> task = taskService.createTaskQuery().processInstanceId(bo.getProcInsId()).list();
        if (CollectionUtils.isEmpty(task)) {
            throw new RuntimeException("流程未启动或已执行完成，取消申请失败");
        }

        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(bo.getProcInsId()).singleResult();

        if(ObjectUtil.isEmpty(processInstance)){
            throw new RuntimeException("流程在审批中，且部分节点已被审批，不能取消，如确实需要取消申请，请联系审批人员驳回申请！");
        }

        runtimeService.deleteProcessInstance(bo.getProcInsId(), "取消原因");

        // 更新关联关系
        LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
        qw.eq(WfTaskProcess::getInstanceId, bo.getProcInsId());
        WfTaskProcess wfTaskProcess = wfTaskProcessMapper.selectOne(qw);
        if (wfTaskProcess != null) {
            wfTaskProcess.setInstanceId(null);
            wfTaskProcess.setTaskId(null);
            wfTaskProcess.setUrl(null);
            wfTaskProcess.setUpdatedBy(SecurityUtils.getUsername());
            wfTaskProcess.setUpdatedTime(new Date());
            wfTaskProcessMapper.updateById(wfTaskProcess);
            // 更新审核状态
            wfTaskProcessMapper.updateProcessState2(wfTaskProcess.getExtraId());
            // 取消修改任务状态为未开始
            wfTaskProcessMapper.updateTaskStatus2(wfTaskProcess.getExtraId());
        }
        // 取消报废流程之后更新相应的审批申请
//        LambdaQueryWrapper<WfMaterialsScrappedProcess> qw2 = new LambdaQueryWrapper<>();
//        qw2.eq(WfMaterialsScrappedProcess::getInstanceId, bo.getProcInsId());
//        List<WfMaterialsScrappedProcess> scrappedProcessList = wfMaterialsScrappedProcessMapper.selectList(qw2);
//        List<String> ids = scrappedProcessList.stream().map(WfMaterialsScrappedProcess::getMaterialId).collect(Collectors.toList());
//        LambdaUpdateChainWrapper<WfMaterialsScrappedProcess> updateWrapper = new LambdaUpdateChainWrapper<>(wfMaterialsScrappedProcessMapper);
//        updateWrapper.eq(WfMaterialsScrappedProcess::getInstanceId, bo.getProcInsId())
//                .set(WfMaterialsScrappedProcess::getInstanceId, null)
//                .set(WfMaterialsScrappedProcess::getTaskId, null)
//                .set(WfMaterialsScrappedProcess::getUrl, null)
//                .set(WfMaterialsScrappedProcess::getUpdatedBy, SecurityUtils.getUsername())
//                .set(WfMaterialsScrappedProcess::getUpdatedTime, new Date());
//        updateWrapper.update();
//        if (CollectionUtils.isNotEmpty(ids)) {
//            LambdaQueryWrapper<MaterialsUseless> qw3 = new LambdaQueryWrapper<>();
//            qw3.in(MaterialsUseless::getRecordId, ids);
//            List<MaterialsUseless> mus = materialsUselessMapper.selectList(qw3);
//            mus.forEach(materialsUseless -> {
//                materialsUseless.setApproved(0);
//                materialsUselessMapper.updateById(materialsUseless);
//            });
//        }

    }

    /**
     * 撤回流程
     *
     * @param taskBo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void revokeProcess(WfTaskBo taskBo) {
        String procInsId = taskBo.getProcInsId();
        String taskId = taskBo.getTaskId();
        // 校验流程是否结束
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
            .processInstanceId(procInsId)
            .active()
            .singleResult();
        if(ObjectUtil.isNull(processInstance)) {
            throw new RuntimeException("流程已结束或已挂起，无法执行撤回操作");
        }
        // 获取待撤回任务实例
        HistoricTaskInstance currTaskIns = historyService.createHistoricTaskInstanceQuery()
            .taskId(taskId)
            .taskAssignee(TaskUtils.getUserId())
            .singleResult();
        if (ObjectUtil.isNull(currTaskIns)) {
            throw new RuntimeException("当前任务不存在，无法执行撤回操作");
        }
        // 获取 bpmn 模型
        BpmnModel bpmnModel = repositoryService.getBpmnModel(currTaskIns.getProcessDefinitionId());
        UserTask currUserTask = ModelUtils.getUserTaskByKey(bpmnModel, currTaskIns.getTaskDefinitionKey());
        // 查找下一级用户任务列表
        List<UserTask> nextUserTaskList = ModelUtils.findNextUserTasks(currUserTask);
        List<String> nextUserTaskKeys = nextUserTaskList.stream().map(UserTask::getId).collect(Collectors.toList());

        // 获取当前节点之后已完成的流程历史节点
        List<HistoricTaskInstance> finishedTaskInsList = historyService.createHistoricTaskInstanceQuery()
            .processInstanceId(procInsId)
            .taskCreatedAfter(currTaskIns.getEndTime())
            .finished()
            .list();
        for (HistoricTaskInstance finishedTaskInstance : finishedTaskInsList) {
            // 检查已完成流程历史节点是否存在下一级中
            if (CollUtil.contains(nextUserTaskKeys, finishedTaskInstance.getTaskDefinitionKey())) {
                throw new RuntimeException("下一流程已处理，无法执行撤回操作");
            }
        }
        // 获取所有激活的任务节点，找到需要撤回的任务
        List<Task> activateTaskList = taskService.createTaskQuery().processInstanceId(procInsId).list();
        List<String> revokeExecutionIds = new ArrayList<>();
        for (Task task : activateTaskList) {
            // 检查激活的任务节点是否存在下一级中，如果存在，则加入到需要撤回的节点
            if (CollUtil.contains(nextUserTaskKeys, task.getTaskDefinitionKey())) {
                // 添加撤回审批信息
                taskService.setAssignee(task.getId(), TaskUtils.getUserId());
                taskService.addComment(task.getId(), task.getProcessInstanceId(), FlowComment.REVOKE.getType(), wfCopyMapper.selectUserById(SecurityUtils.getUserId()).getNickName() + "撤回流程审批");
                revokeExecutionIds.add(task.getExecutionId());
            }
        }
        try {
            runtimeService.createChangeActivityStateBuilder()
                .processInstanceId(procInsId)
                .moveExecutionsToSingleActivityId(revokeExecutionIds, currTaskIns.getTaskDefinitionKey()).changeState();
        } catch (FlowableObjectNotFoundException e) {
            throw new RuntimeException("未找到流程实例，流程可能已发生变化");
        } catch (FlowableException e) {
            throw new RuntimeException("执行撤回操作失败");
        }
    }

    /**
     * 获取流程过程图
     *
     * @param processId
     * @return
     */
    @Override
    public InputStream diagram(String processId) {
        String processDefinitionId;
        // 获取当前的流程实例
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processId).singleResult();
        // 如果流程已经结束，则得到结束节点
        if (Objects.isNull(processInstance)) {
            HistoricProcessInstance pi = historyService.createHistoricProcessInstanceQuery().processInstanceId(processId).singleResult();

            processDefinitionId = pi.getProcessDefinitionId();
        } else {// 如果流程没有结束，则取当前活动节点
            // 根据流程实例ID获得当前处于活动状态的ActivityId合集
            ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processId).singleResult();
            processDefinitionId = pi.getProcessDefinitionId();
        }

        // 获得活动的节点
        List<HistoricActivityInstance> highLightedFlowList = historyService.createHistoricActivityInstanceQuery()
            .processInstanceId(processId).orderByHistoricActivityInstanceStartTime().asc().list();

        List<String> highLightedFlows = new ArrayList<>();
        List<String> highLightedNodes = new ArrayList<>();
        //高亮线
        for (HistoricActivityInstance tempActivity : highLightedFlowList) {
            if ("sequenceFlow".equals(tempActivity.getActivityType())) {
                //高亮线
                highLightedFlows.add(tempActivity.getActivityId());
            } else {
                //高亮节点
                highLightedNodes.add(tempActivity.getActivityId());
            }
        }

        //获取流程图
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);
        ProcessEngineConfiguration configuration = processEngine.getProcessEngineConfiguration();
        //获取自定义图片生成器
        ProcessDiagramGenerator diagramGenerator = new CustomProcessDiagramGenerator();
        return diagramGenerator.generateDiagram(bpmnModel, "png", highLightedNodes, highLightedFlows, configuration.getActivityFontName(),
            configuration.getLabelFontName(), configuration.getAnnotationFontName(), configuration.getClassLoader(), 1.0, true);

    }

    /**
     * 获取流程变量
     *
     * @param taskId 任务ID
     * @return 流程变量
     */
    @Override
    public Map<String, Object> getProcessVariables(String taskId) {
        HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
            .includeProcessVariables()
            .finished()
            .taskId(taskId)
            .singleResult();
        if (Objects.nonNull(historicTaskInstance)) {
            return historicTaskInstance.getProcessVariables();
        }
        return taskService.getVariables(taskId);
    }

    /**
     * 启动第一个任务
     * @param processInstance 流程实例
     * @param variables 流程参数
     */
    @Override
    public void startFirstTask(ProcessInstance processInstance, Map<String, Object> variables) {
        // 若第一个用户任务为发起人，则自动完成任务
        List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInstance.getProcessInstanceId()).list();
        if (CollUtil.isNotEmpty(tasks)) {
            String userIdStr = (String) variables.get(TaskConstants.PROCESS_INITIATOR);
            for (Task task : tasks) {
                if (StrUtil.equals(task.getAssignee(), userIdStr)) {
                    taskService.addComment(task.getId(), processInstance.getProcessInstanceId(), FlowComment.NORMAL.getType(), wfCopyMapper.selectUserById(SecurityUtils.getUserId()).getNickName() + "发起流程申请");
                    taskService.complete(task.getId(), variables);
                }
            }
        }
    }

    /**
     * 指派下一任务审批人
     * @param bpmnModel bpmn模型
     * @param processInsId 流程实例id
     * @param userIds 用户ids
     */
    private void assignNextUsers(BpmnModel bpmnModel, String processInsId, String userIds) {
        // 获取所有节点信息
        List<Task> list = taskService.createTaskQuery()
            .processInstanceId(processInsId)
            .list();
        if (list.size() == 0) {
            return;
        }
        Queue<String> assignIds = CollUtil.newLinkedList(userIds.split(","));
        if (list.size() == assignIds.size()) {
            for (Task task : list) {
                taskService.setAssignee(task.getId(), assignIds.poll());
            }
            return;
        }
        // 优先处理非多实例任务
        Iterator<Task> iterator = list.iterator();
        while (iterator.hasNext()) {
            Task task = iterator.next();
            if (!ModelUtils.isMultiInstance(bpmnModel, task.getTaskDefinitionKey())) {
                if (!assignIds.isEmpty()) {
                    taskService.setAssignee(task.getId(), assignIds.poll());
                }
                iterator.remove();
            }
        }
        // 若存在多实例任务，则进行动态加减签
        if (CollUtil.isNotEmpty(list)) {
            if (assignIds.isEmpty()) {
                // 动态减签
                for (Task task : list) {
                    runtimeService.deleteMultiInstanceExecution(task.getExecutionId(), true);
                }
            } else {
                // 动态加签
                for (String assignId : assignIds) {
                    Map<String, Object> assignVariables = Collections.singletonMap(BpmnXMLConstants.ATTRIBUTE_TASK_USER_ASSIGNEE, assignId);
                    runtimeService.addMultiInstanceExecution(list.get(0).getTaskDefinitionKey(), list.get(0).getProcessInstanceId(), assignVariables);
                }
            }
        }
    }
}
