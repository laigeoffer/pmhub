package com.laigeoffer.pmhub.workflow.service.impl;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.BetweenFormatter;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysDept;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysRole;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.core.utils.JsonUtils;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.common.constant.TaskConstants;
import com.laigeoffer.pmhub.base.core.core.domain.entity.WfTaskProcess;
import com.laigeoffer.pmhub.workflow.domain.bo.WfTaskBo;
import com.laigeoffer.pmhub.workflow.domain.vo.WfFormVo;
import com.laigeoffer.pmhub.workflow.domain.vo.WfTaskVo;
import com.laigeoffer.pmhub.workflow.factory.FlowServiceFactory;
import com.laigeoffer.pmhub.workflow.mapper.WfCopyMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfTaskProcessMapper;
import com.laigeoffer.pmhub.workflow.service.IWfDeployFormService;
import com.laigeoffer.pmhub.workflow.service.IWfInstanceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.api.FlowableObjectNotFoundException;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.task.Comment;
import org.flowable.identitylink.api.history.HistoricIdentityLink;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 工作流流程实例管理
 *
 * @author canghe
 * @createTime 2022/3/10 00:12
 */
@RequiredArgsConstructor
@Service
@Slf4j
public class WfInstanceServiceImpl extends FlowServiceFactory implements IWfInstanceService {

    private final IWfDeployFormService deployFormService;
    private final WfCopyMapper wfCopyMapper;
    private final WfTaskProcessMapper wfTaskProcessMapper;

    /**
     * 结束流程实例
     *
     * @param vo
     */
    @Override
    public void stopProcessInstance(WfTaskBo vo) {
        String taskId = vo.getTaskId();

    }

    /**
     * 激活或挂起流程实例
     *
     * @param state      状态
     * @param instanceId 流程实例ID
     */
    @Override
    public void updateState(Integer state, String instanceId) {

        // 激活
        if (state == 1) {
            runtimeService.activateProcessInstanceById(instanceId);
        }
        // 挂起
        if (state == 2) {
            runtimeService.suspendProcessInstanceById(instanceId);
        }
    }

    /**
     * 删除流程实例ID
     *
     * @param instanceId   流程实例ID
     * @param deleteReason 删除原因
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(String instanceId, String deleteReason) {

        // 查询历史数据
        HistoricProcessInstance historicProcessInstance = getHistoricProcessInstanceById(instanceId);
        if (historicProcessInstance.getEndTime() != null) {
            historyService.deleteHistoricProcessInstance(historicProcessInstance.getId());
            return;
        }
        // 删除流程实例
        runtimeService.deleteProcessInstance(instanceId, deleteReason);
        // 删除历史流程实例
        historyService.deleteHistoricProcessInstance(instanceId);
        // 更新关联关系
        LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
        qw.eq(WfTaskProcess::getInstanceId, instanceId);
        WfTaskProcess wfTaskProcess = wfTaskProcessMapper.selectOne(qw);
        wfTaskProcess.setInstanceId(null);
        wfTaskProcess.setTaskId(null);
        wfTaskProcess.setUpdatedBy(SecurityUtils.getUsername());
        wfTaskProcess.setUpdatedTime(new Date());
        wfTaskProcessMapper.updateById(wfTaskProcess);
    }

    /**
     * 根据实例ID查询历史实例数据
     *
     * @param processInstanceId
     * @return
     */
    @Override
    public HistoricProcessInstance getHistoricProcessInstanceById(String processInstanceId) {
        HistoricProcessInstance historicProcessInstance =
                historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        if (Objects.isNull(historicProcessInstance)) {
            throw new FlowableObjectNotFoundException("流程实例不存在: " + processInstanceId);
        }
        return historicProcessInstance;
    }


    /**
     * 流程历史流转记录
     *
     * @param procInsId 流程实例Id
     * @return
     */
    @Override
    public Map<String, Object> queryDetailProcess(String procInsId, String deployId) {
        Map<String, Object> map = new HashMap<>();
        if (StringUtils.isNotBlank(procInsId)) {
            List<HistoricTaskInstance> taskInstanceList = historyService.createHistoricTaskInstanceQuery()
                .processInstanceId(procInsId)
                .orderByHistoricTaskInstanceStartTime().desc()
                .list();
            List<Comment> commentList = taskService.getProcessInstanceComments(procInsId);
            List<WfTaskVo> taskVoList = new ArrayList<>(taskInstanceList.size());
            taskInstanceList.forEach(taskInstance -> {
                WfTaskVo taskVo = new WfTaskVo();
                taskVo.setProcDefId(taskInstance.getProcessDefinitionId());
                taskVo.setTaskId(taskInstance.getId());
                taskVo.setTaskDefKey(taskInstance.getTaskDefinitionKey());
                taskVo.setTaskName(taskInstance.getName());
                taskVo.setCreateTime(taskInstance.getStartTime());
                taskVo.setFinishTime(taskInstance.getEndTime());
                if (StringUtils.isNotBlank(taskInstance.getAssignee())) {
                    SysUser user = wfCopyMapper.selectUserById(Long.parseLong(taskInstance.getAssignee()));
                    taskVo.setAssigneeId(user.getUserId());
                    taskVo.setAssigneeName(user.getNickName());
                    SysDept sysDept = wfCopyMapper.selectDeptById(user.getDeptId());
                    if (sysDept != null) {
                        taskVo.setDeptName(sysDept.getDeptName());
                    }
                }
                // 展示审批人员
                List<HistoricIdentityLink> linksForTask = historyService.getHistoricIdentityLinksForTask(taskInstance.getId());
                StringBuilder stringBuilder = new StringBuilder();
                for (HistoricIdentityLink identityLink : linksForTask) {
                    if ("candidate".equals(identityLink.getType())) {
                        if (StringUtils.isNotBlank(identityLink.getUserId())) {
                            SysUser user = wfCopyMapper.selectUserById(Long.parseLong(identityLink.getUserId()));
                            stringBuilder.append(user.getNickName()).append(",");
                        }
                        if (StringUtils.isNotBlank(identityLink.getGroupId())) {
                            if (identityLink.getGroupId().startsWith(TaskConstants.ROLE_GROUP_PREFIX)) {
                                Long roleId = Long.parseLong(StringUtils.stripStart(identityLink.getGroupId(), TaskConstants.ROLE_GROUP_PREFIX));
                                SysRole role = wfCopyMapper.selectRoleById(roleId);
                                stringBuilder.append(role.getRoleName()).append(",");
                            } else if (identityLink.getGroupId().startsWith(TaskConstants.DEPT_GROUP_PREFIX)) {
                                Long deptId = Long.parseLong(StringUtils.stripStart(identityLink.getGroupId(), TaskConstants.DEPT_GROUP_PREFIX));
                                SysDept dept = wfCopyMapper.selectDeptById(deptId);
                                stringBuilder.append(dept.getDeptName()).append(",");
                            }
                        }
                    }
                }
                if (StringUtils.isNotBlank(stringBuilder)) {
                    taskVo.setCandidate(stringBuilder.substring(0, stringBuilder.length() - 1));
                }
                if (ObjectUtil.isNotNull(taskInstance.getDurationInMillis())) {
                    taskVo.setDuration(DateUtil.formatBetween(taskInstance.getDurationInMillis(), BetweenFormatter.Level.SECOND));
                }
                // 获取意见评论内容
                if (CollUtil.isNotEmpty(commentList)) {
                    List<Comment> comments = new ArrayList<>();
                    // commentList.stream().filter(comment -> taskInstance.getId().equals(comment.getTaskId())).collect(Collectors.toList());
                    for (Comment comment : commentList) {
                        if (comment.getTaskId().equals(taskInstance.getId())) {
                            comments.add(comment);
                            // taskVo.setComment(WfCommentDto.builder().type(comment.getType()).comment(comment.getFullMessage()).build());
                        }
                    }
                    taskVo.setCommentList(comments);
                }
                taskVoList.add(taskVo);
            });
            map.put("flowList", taskVoList);
//            // 查询当前任务是否完成
//            List<Task> taskList = taskService.createTaskQuery().processInstanceId(procInsId).list();
//            if (CollectionUtils.isNotEmpty(taskList)) {
//                map.put("finished", true);
//            } else {
//                map.put("finished", false);
//            }
        }
        // 第一次申请获取初始化表单
        if (StringUtils.isNotBlank(deployId)) {
            WfFormVo formVo = deployFormService.selectDeployFormByDeployId(deployId);
            if (Objects.isNull(formVo)) {
                throw new ServiceException("请先配置流程表单");
            }
            map.put("formData", JsonUtils.parseObject(formVo.getContent(), Map.class));
        }
        return map;
    }
}
