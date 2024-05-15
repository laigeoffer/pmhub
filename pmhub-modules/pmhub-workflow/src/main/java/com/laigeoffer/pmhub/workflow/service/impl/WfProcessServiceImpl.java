package com.laigeoffer.pmhub.workflow.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.date.BetweenFormatter;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.IORuntimeException;
import cn.hutool.core.io.IoUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.update.LambdaUpdateChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laigeoffer.pmhub.base.core.core.domain.PageQuery;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysDept;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysRole;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.core.page.Table2DataInfo;
import com.laigeoffer.pmhub.base.core.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.base.core.enums.ProjectTaskStatusEnum;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.core.utils.DateUtils;
import com.laigeoffer.pmhub.base.core.utils.JsonUtils;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.common.constant.ProcessConstants;
import com.laigeoffer.pmhub.workflow.common.constant.TaskConstants;
import com.laigeoffer.pmhub.workflow.core.FormConf;
import com.laigeoffer.pmhub.workflow.core.domain.ProcessQuery;
import com.laigeoffer.pmhub.workflow.domain.WfDeployForm;
import com.laigeoffer.pmhub.workflow.domain.WfMaterialsScrappedProcess;
import com.laigeoffer.pmhub.base.core.core.domain.entity.WfTaskProcess;
import com.laigeoffer.pmhub.workflow.domain.vo.*;
import com.laigeoffer.pmhub.workflow.factory.FlowServiceFactory;
import com.laigeoffer.pmhub.workflow.flow.FlowableUtils;
import com.laigeoffer.pmhub.workflow.mapper.WfCopyMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfDeployFormMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfMaterialsScrappedProcessMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfTaskProcessMapper;
import com.laigeoffer.pmhub.workflow.service.IWfDeployService;
import com.laigeoffer.pmhub.workflow.service.IWfProcessService;
import com.laigeoffer.pmhub.workflow.service.IWfTaskService;
import com.laigeoffer.pmhub.workflow.utils.ModelUtils;
import com.laigeoffer.pmhub.workflow.utils.ProcessFormUtils;
import com.laigeoffer.pmhub.workflow.utils.ProcessUtils;
import com.laigeoffer.pmhub.workflow.utils.TaskUtils;
import lombok.RequiredArgsConstructor;
import org.apache.commons.collections4.CollectionUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.model.Process;
import org.flowable.bpmn.model.*;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricActivityInstanceQuery;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.history.HistoricProcessInstanceQuery;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.repository.ProcessDefinitionQuery;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.engine.task.Comment;
import org.flowable.identitylink.api.history.HistoricIdentityLink;
import org.flowable.task.api.Task;
import org.flowable.task.api.TaskQuery;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.api.history.HistoricTaskInstanceQuery;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author canghe
 * @createTime 2022/3/24 18:57
 */
@RequiredArgsConstructor
@Service
public class WfProcessServiceImpl extends FlowServiceFactory implements IWfProcessService {

    private final IWfTaskService wfTaskService;
    private final WfCopyMapper wfCopyMapper;
    private final WfDeployFormMapper deployFormMapper;
    private final WfTaskProcessMapper wfTaskProcessMapper;
    private final IWfDeployService deployService;
    private final WfMaterialsScrappedProcessMapper wfMaterialsScrappedProcessMapper;
//    private final MaterialsChangeRecordsMapper materialsChangeRecordsMapper;
//    private final MaterialsUselessMapper materialsUselessMapper;

    private final String USELESS = "报废";
    private final String DAI_DING = "待定";
    private final List<String> types = Arrays.asList("PURCHASE_INTO", "PURCHASE_OUT", "OTHER_INTO", "OTHER_OUT", "RETURN_INTO");
    private final List<String> ts = Arrays.asList("PURCHASE_INTO", "PURCHASE_OUT", "OTHER_INTO", "OTHER_OUT", "RETURN_INTO", "SUPPLIER_APPROVAL", "task");
    /**
     * 流程定义列表
     *
     * @param pageQuery 分页参数
     * @return 流程定义分页列表数据
     */
    @Override
    public Table2DataInfo<WfDefinitionVo> selectPageStartProcessList(ProcessQuery processQuery, PageQuery pageQuery) {
        Page<WfDefinitionVo> page = new Page<>();
        // 流程定义列表数据查询
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery()
            .latestVersion()
            .active()
            .orderByProcessDefinitionKey()
            .desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(processDefinitionQuery, processQuery);
        long pageTotal = processDefinitionQuery.count();
        if (pageTotal <= 0) {
            return Table2DataInfo.build();
        }
        int offset = pageQuery.getPageSize() * (pageQuery.getPageNum() - 1);
        List<ProcessDefinition> definitionList = processDefinitionQuery.listPage(offset, pageQuery.getPageSize());

        List<WfDefinitionVo> definitionVoList = new ArrayList<>();
        for (ProcessDefinition processDefinition : definitionList) {
            String deploymentId = processDefinition.getDeploymentId();
            Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
            WfDefinitionVo vo = new WfDefinitionVo();
            vo.setDefinitionId(processDefinition.getId());
            vo.setProcessKey(processDefinition.getKey());
            vo.setProcessName(processDefinition.getName());
            vo.setVersion(processDefinition.getVersion());
            vo.setDeploymentId(processDefinition.getDeploymentId());
            vo.setSuspended(processDefinition.isSuspended());
            // 流程定义时间
            vo.setCategory(deployment.getCategory());
            vo.setDeploymentTime(deployment.getDeploymentTime());
            definitionVoList.add(vo);
        }
        definitionVoList.sort(Comparator.comparing(WfDefinitionVo::getDeploymentTime).reversed());
        page.setRecords(definitionVoList);
        page.setTotal(pageTotal);
        return Table2DataInfo.build(page);
    }

    @Override
    public List<WfDefinitionVo> selectStartProcessList(ProcessQuery processQuery) {
        // 流程定义列表数据查询
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery()
                .latestVersion()
                .active()
                .orderByProcessDefinitionKey()
                .asc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(processDefinitionQuery, processQuery);

        List<ProcessDefinition> definitionList = processDefinitionQuery.list();

        List<WfDefinitionVo> definitionVoList = new ArrayList<>();
        for (ProcessDefinition processDefinition : definitionList) {
            String deploymentId = processDefinition.getDeploymentId();
            Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
            WfDefinitionVo vo = new WfDefinitionVo();
            vo.setDefinitionId(processDefinition.getId());
            vo.setProcessKey(processDefinition.getKey());
            vo.setProcessName(processDefinition.getName());
            vo.setVersion(processDefinition.getVersion());
            vo.setDeploymentId(processDefinition.getDeploymentId());
            vo.setSuspended(processDefinition.isSuspended());
            // 流程定义时间
            vo.setCategory(deployment.getCategory());
            vo.setDeploymentTime(deployment.getDeploymentTime());
            definitionVoList.add(vo);
        }
        return definitionVoList;
    }

    @Override
    public Table2DataInfo<WfTaskVo> selectPageOwnProcessList(ProcessQuery processQuery, PageQuery pageQuery) {
        Page<WfTaskVo> page = new Page<>();
        HistoricProcessInstanceQuery historicProcessInstanceQuery = historyService.createHistoricProcessInstanceQuery()
            .startedBy(TaskUtils.getUserId())
            .orderByProcessInstanceStartTime()
            .desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(historicProcessInstanceQuery, processQuery);
        int offset = pageQuery.getPageSize() * (pageQuery.getPageNum() - 1);
        List<HistoricProcessInstance> historicProcessInstances = historicProcessInstanceQuery
            .listPage(offset, pageQuery.getPageSize());
        page.setTotal(historicProcessInstanceQuery.count());
        List<WfTaskVo> taskVoList = new ArrayList<>(10);
        for (HistoricProcessInstance hisIns : historicProcessInstances) {
            WfTaskVo taskVo = new WfTaskVo();
            taskVo.setCreateTime(hisIns.getStartTime());
            taskVo.setFinishTime(hisIns.getEndTime());
            taskVo.setProcInsId(hisIns.getId());

            // 计算耗时
            if (Objects.nonNull(hisIns.getEndTime())) {
                taskVo.setDuration(DateUtils.getDatePoor(hisIns.getEndTime(), hisIns.getStartTime()));
            } else {
                taskVo.setDuration(DateUtils.getDatePoor(DateUtils.getNowDate(), hisIns.getStartTime()));
            }
            // 流程部署实例信息
            Deployment deployment = repositoryService.createDeploymentQuery()
                .deploymentId(hisIns.getDeploymentId()).singleResult();
            taskVo.setDeployId(hisIns.getDeploymentId());
            taskVo.setProcDefId(hisIns.getProcessDefinitionId());
            taskVo.setProcDefName(hisIns.getProcessDefinitionName());
            taskVo.setProcDefVersion(hisIns.getProcessDefinitionVersion());
            taskVo.setCategory(deployment.getCategory());
            // 当前所处流程
            List<Task> taskList = taskService.createTaskQuery().processInstanceId(hisIns.getId()).list();
            if (CollUtil.isNotEmpty(taskList)) {
                taskVo.setTaskId(taskList.get(0).getId());
            } else {
                List<HistoricTaskInstance> historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
                    .processInstanceId(hisIns.getId()).orderByHistoricTaskInstanceEndTime().desc().list();
                if (CollUtil.isNotEmpty(historicTaskInstance)) {
                    taskVo.setTaskId(historicTaskInstance.get(0).getId());
                }
            }
            taskVoList.add(taskVo);
        }
        taskVoList.forEach(task -> {
            if (StringUtils.isNotBlank(task.getTaskId())) {
                Task t = taskService.createTaskQuery().taskId(task.getTaskId()).singleResult();
                if (t != null) {
                    if (StringUtils.isNotBlank(t.getAssignee())) {
                        SysUser sysUser = wfCopyMapper.selectUserById(Long.valueOf(t.getAssignee()));
                        task.setAssigneeName(sysUser.getNickName());
                        task.setTaskName(t.getName());
                        SysDept sysDept = wfCopyMapper.selectDeptById(sysUser.getDeptId());
                        if (sysDept != null) {
                            task.setDeptName(sysDept.getDeptName());
                        }
                    }
                }
            }

        });
        page.setRecords(taskVoList);
        return Table2DataInfo.build(page);
    }

    @Override
    public List<WfTaskVo> selectOwnProcessList(ProcessQuery processQuery) {
        HistoricProcessInstanceQuery historicProcessInstanceQuery = historyService.createHistoricProcessInstanceQuery()
                .startedBy(TaskUtils.getUserId())
                .orderByProcessInstanceStartTime()
                .desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(historicProcessInstanceQuery, processQuery);
        List<HistoricProcessInstance> historicProcessInstances = historicProcessInstanceQuery.list();
        List<WfTaskVo> taskVoList = new ArrayList<>();
        for (HistoricProcessInstance hisIns : historicProcessInstances) {
            WfTaskVo taskVo = new WfTaskVo();
            taskVo.setCreateTime(hisIns.getStartTime());
            taskVo.setFinishTime(hisIns.getEndTime());
            taskVo.setProcInsId(hisIns.getId());

            // 计算耗时
            if (Objects.nonNull(hisIns.getEndTime())) {
                taskVo.setDuration(DateUtils.getDatePoor(hisIns.getEndTime(), hisIns.getStartTime()));
            } else {
                taskVo.setDuration(DateUtils.getDatePoor(DateUtils.getNowDate(), hisIns.getStartTime()));
            }
            // 流程部署实例信息
            Deployment deployment = repositoryService.createDeploymentQuery()
                    .deploymentId(hisIns.getDeploymentId()).singleResult();
            taskVo.setDeployId(hisIns.getDeploymentId());
            taskVo.setProcDefId(hisIns.getProcessDefinitionId());
            taskVo.setProcDefName(hisIns.getProcessDefinitionName());
            taskVo.setProcDefVersion(hisIns.getProcessDefinitionVersion());
            taskVo.setCategory(deployment.getCategory());
            // 当前所处流程
            List<Task> taskList = taskService.createTaskQuery().processInstanceId(hisIns.getId()).list();
            if (CollUtil.isNotEmpty(taskList)) {
                taskVo.setTaskId(taskList.get(0).getId());
            } else {
                List<HistoricTaskInstance> historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
                        .processInstanceId(hisIns.getId()).orderByHistoricTaskInstanceEndTime().desc().list();
                if (CollUtil.isNotEmpty(historicTaskInstance)) {
                    taskVo.setTaskId(historicTaskInstance.get(0).getId());
                }
            }
            taskVoList.add(taskVo);
        }
        return taskVoList;
    }

    @Override
    public Table2DataInfo<WfTaskVo> selectPageTodoProcessList(ProcessQuery processQuery, PageQuery pageQuery) {
        Page<WfTaskVo> page = new Page<>();
        TaskQuery taskQuery = taskService.createTaskQuery()
            .active()
            .includeProcessVariables()
            .taskCandidateOrAssigned(TaskUtils.getUserId())
            .taskCandidateGroupIn(TaskUtils.getCandidateGroup())
            .orderByTaskCreateTime().desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(taskQuery, processQuery);
        page.setTotal(taskQuery.count());
        int offset = pageQuery.getPageSize() * (pageQuery.getPageNum() - 1);
        List<Task> taskList = taskQuery.listPage(offset, pageQuery.getPageSize());
        List<WfTaskVo> flowList = new ArrayList<>();
        for (Task task : taskList) {
            WfTaskVo flowTask = new WfTaskVo();
            // 当前流程信息
            flowTask.setTaskId(task.getId());
            flowTask.setTaskDefKey(task.getTaskDefinitionKey());
            flowTask.setCreateTime(task.getCreateTime());
            flowTask.setProcDefId(task.getProcessDefinitionId());
            flowTask.setTaskName(task.getName());
            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(task.getProcessDefinitionId())
                .singleResult();
            flowTask.setDeployId(pd.getDeploymentId());
            flowTask.setProcDefName(pd.getName());
            flowTask.setProcDefVersion(pd.getVersion());
            flowTask.setProcInsId(task.getProcessInstanceId());

            // 流程发起人信息
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(task.getProcessInstanceId())
                .singleResult();
            SysUser startUser = wfCopyMapper.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
            flowTask.setStartUserId(startUser.getNickName());
            flowTask.setStartUserName(startUser.getNickName());
            SysDept sysDept = wfCopyMapper.selectDeptById(startUser.getDeptId());
            if (sysDept != null) {
                flowTask.setStartDeptName(sysDept.getDeptName());
            }

            // 流程变量
            flowTask.setProcVars(this.getProcessVariables(task.getId()));

            flowList.add(flowTask);
        }
        page.setRecords(flowList);
        return Table2DataInfo.build(page);
    }

    @Override
    public List<WfTaskVo> selectTodoProcessList(ProcessQuery processQuery) {
        TaskQuery taskQuery = taskService.createTaskQuery()
                .active()
                .includeProcessVariables()
                .taskCandidateOrAssigned(TaskUtils.getUserId())
                .taskCandidateGroupIn(TaskUtils.getCandidateGroup())
                .orderByTaskCreateTime().desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(taskQuery, processQuery);
        List<Task> taskList = taskQuery.list();
        List<WfTaskVo> taskVoList = new ArrayList<>();
        for (Task task : taskList) {
            WfTaskVo taskVo = new WfTaskVo();
            // 当前流程信息
            taskVo.setTaskId(task.getId());
            taskVo.setTaskDefKey(task.getTaskDefinitionKey());
            taskVo.setCreateTime(task.getCreateTime());
            taskVo.setProcDefId(task.getProcessDefinitionId());
            taskVo.setTaskName(task.getName());
            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(task.getProcessDefinitionId())
                    .singleResult();
            taskVo.setDeployId(pd.getDeploymentId());
            taskVo.setProcDefName(pd.getName());
            taskVo.setProcDefVersion(pd.getVersion());
            taskVo.setProcInsId(task.getProcessInstanceId());

            // 流程发起人信息
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(task.getProcessInstanceId())
                    .singleResult();
            SysUser startUser = wfCopyMapper.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
            taskVo.setStartUserId(startUser.getNickName());
            taskVo.setStartUserName(startUser.getNickName());
            SysDept sysDept = wfCopyMapper.selectDeptById(startUser.getDeptId());
            if (sysDept != null) {
                taskVo.setStartDeptName(sysDept.getDeptName());
            }
            // 流程变量
            taskVo.setProcVars(this.getProcessVariables(task.getId()));

            taskVoList.add(taskVo);
        }
        return taskVoList;
    }

    @Override
    public Table2DataInfo<WfTaskVo> selectPageClaimProcessList(ProcessQuery processQuery, PageQuery pageQuery) {
        Page<WfTaskVo> page = new Page<>();
        TaskQuery taskQuery = taskService.createTaskQuery()
            .active()
            .includeProcessVariables()
            .taskCandidateUser(TaskUtils.getUserId())
            .taskCandidateGroupIn(TaskUtils.getCandidateGroup())
            .orderByTaskCreateTime().desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(taskQuery, processQuery);
        page.setTotal(taskQuery.count());
        int offset = pageQuery.getPageSize() * (pageQuery.getPageNum() - 1);
        List<Task> taskList = taskQuery.listPage(offset, pageQuery.getPageSize());
        List<WfTaskVo> flowList = new ArrayList<>();
        for (Task task : taskList) {
            WfTaskVo flowTask = new WfTaskVo();
            // 当前流程信息
            flowTask.setTaskId(task.getId());
            flowTask.setTaskDefKey(task.getTaskDefinitionKey());
            flowTask.setCreateTime(task.getCreateTime());
            flowTask.setProcDefId(task.getProcessDefinitionId());
            flowTask.setTaskName(task.getName());
            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(task.getProcessDefinitionId())
                .singleResult();
            flowTask.setDeployId(pd.getDeploymentId());
            flowTask.setProcDefName(pd.getName());
            flowTask.setProcDefVersion(pd.getVersion());
            flowTask.setProcInsId(task.getProcessInstanceId());

            // 流程发起人信息
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(task.getProcessInstanceId())
                .singleResult();
            SysUser startUser = wfCopyMapper.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
            flowTask.setStartUserId(startUser.getNickName());
            flowTask.setStartUserName(startUser.getNickName());
            SysDept sysDept = wfCopyMapper.selectDeptById(startUser.getDeptId());
            if (sysDept != null) {
                flowTask.setStartDeptName(sysDept.getDeptName());
            }

            flowList.add(flowTask);
        }
        page.setRecords(flowList);
        return Table2DataInfo.build(page);
    }

    @Override
    public List<WfTaskVo> selectClaimProcessList(ProcessQuery processQuery) {
        TaskQuery taskQuery = taskService.createTaskQuery()
                .active()
                .includeProcessVariables()
                .taskCandidateUser(TaskUtils.getUserId())
                .taskCandidateGroupIn(TaskUtils.getCandidateGroup())
                .orderByTaskCreateTime().desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(taskQuery, processQuery);
        List<Task> taskList = taskQuery.list();
        List<WfTaskVo> flowList = new ArrayList<>();
        for (Task task : taskList) {
            WfTaskVo flowTask = new WfTaskVo();
            // 当前流程信息
            flowTask.setTaskId(task.getId());
            flowTask.setTaskDefKey(task.getTaskDefinitionKey());
            flowTask.setCreateTime(task.getCreateTime());
            flowTask.setProcDefId(task.getProcessDefinitionId());
            flowTask.setTaskName(task.getName());
            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(task.getProcessDefinitionId())
                    .singleResult();
            flowTask.setDeployId(pd.getDeploymentId());
            flowTask.setProcDefName(pd.getName());
            flowTask.setProcDefVersion(pd.getVersion());
            flowTask.setProcInsId(task.getProcessInstanceId());

            // 流程发起人信息
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(task.getProcessInstanceId())
                    .singleResult();
            SysUser startUser = wfCopyMapper.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
            flowTask.setStartUserId(startUser.getNickName());
            flowTask.setStartUserName(startUser.getNickName());
            SysDept sysDept = wfCopyMapper.selectDeptById(startUser.getDeptId());
            if (sysDept != null) {
                flowTask.setStartDeptName(sysDept.getDeptName());
            }

            flowList.add(flowTask);
        }
        return flowList;
    }

    @Override
    public Table2DataInfo<WfTaskVo> selectPageFinishedProcessList(ProcessQuery processQuery, PageQuery pageQuery) {
        Page<WfTaskVo> page = new Page<>();
        HistoricTaskInstanceQuery taskInstanceQuery = historyService.createHistoricTaskInstanceQuery()
            .includeProcessVariables()
            .finished()
            .taskAssignee(TaskUtils.getUserId())
            .orderByHistoricTaskInstanceEndTime()
            .desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(taskInstanceQuery, processQuery);
        int offset = pageQuery.getPageSize() * (pageQuery.getPageNum() - 1);
        List<HistoricTaskInstance> historicTaskInstanceList = taskInstanceQuery.listPage(offset, pageQuery.getPageSize());
        List<WfTaskVo> hisTaskList = new ArrayList<>();
        for (HistoricTaskInstance histTask : historicTaskInstanceList) {
            WfTaskVo flowTask = new WfTaskVo();
            // 当前流程信息
            flowTask.setTaskId(histTask.getId());
            // 审批人员信息
            flowTask.setCreateTime(histTask.getCreateTime());
            flowTask.setFinishTime(histTask.getEndTime());
            flowTask.setDuration(DateUtil.formatBetween(histTask.getDurationInMillis(), BetweenFormatter.Level.SECOND));
            flowTask.setProcDefId(histTask.getProcessDefinitionId());
            flowTask.setTaskDefKey(histTask.getTaskDefinitionKey());
            flowTask.setTaskName(histTask.getName());

            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(histTask.getProcessDefinitionId())
                .singleResult();
            flowTask.setDeployId(pd.getDeploymentId());
            flowTask.setProcDefName(pd.getName());
            flowTask.setProcDefVersion(pd.getVersion());
            flowTask.setProcInsId(histTask.getProcessInstanceId());
            flowTask.setHisProcInsId(histTask.getProcessInstanceId());

            // 流程发起人信息
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                .processInstanceId(histTask.getProcessInstanceId())
                .singleResult();
            SysUser startUser = wfCopyMapper.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
            flowTask.setStartUserId(startUser.getNickName());
            flowTask.setStartUserName(startUser.getNickName());
            SysDept sysDept = wfCopyMapper.selectDeptById(startUser.getDeptId());
            if (sysDept != null) {
                flowTask.setStartDeptName(sysDept.getDeptName());
            }

            // 流程变量
            flowTask.setProcVars(this.getProcessVariables(histTask.getId()));

            hisTaskList.add(flowTask);
        }
        page.setTotal(taskInstanceQuery.count());
        page.setRecords(hisTaskList);
//        Map<String, Object> result = new HashMap<>();
//        result.put("result",page);
//        result.put("finished",true);
        return Table2DataInfo.build(page);
    }

    @Override
    public List<WfTaskVo> selectFinishedProcessList(ProcessQuery processQuery) {
        HistoricTaskInstanceQuery taskInstanceQuery = historyService.createHistoricTaskInstanceQuery()
                .includeProcessVariables()
                .finished()
                .taskAssignee(TaskUtils.getUserId())
                .orderByHistoricTaskInstanceEndTime()
                .desc();
        // 构建搜索条件
        ProcessUtils.buildProcessSearch(taskInstanceQuery, processQuery);
        List<HistoricTaskInstance> historicTaskInstanceList = taskInstanceQuery.list();
        List<WfTaskVo> hisTaskList = new ArrayList<>();
        for (HistoricTaskInstance histTask : historicTaskInstanceList) {
            WfTaskVo flowTask = new WfTaskVo();
            // 当前流程信息
            flowTask.setTaskId(histTask.getId());
            // 审批人员信息
            flowTask.setCreateTime(histTask.getCreateTime());
            flowTask.setFinishTime(histTask.getEndTime());
            flowTask.setDuration(DateUtil.formatBetween(histTask.getDurationInMillis(), BetweenFormatter.Level.SECOND));
            flowTask.setProcDefId(histTask.getProcessDefinitionId());
            flowTask.setTaskDefKey(histTask.getTaskDefinitionKey());
            flowTask.setTaskName(histTask.getName());

            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(histTask.getProcessDefinitionId())
                    .singleResult();
            flowTask.setDeployId(pd.getDeploymentId());
            flowTask.setProcDefName(pd.getName());
            flowTask.setProcDefVersion(pd.getVersion());
            flowTask.setProcInsId(histTask.getProcessInstanceId());
            flowTask.setHisProcInsId(histTask.getProcessInstanceId());

            // 流程发起人信息
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(histTask.getProcessInstanceId())
                    .singleResult();
            SysUser startUser = wfCopyMapper.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
            flowTask.setStartUserId(startUser.getNickName());
            flowTask.setStartUserName(startUser.getNickName());
            SysDept sysDept = wfCopyMapper.selectDeptById(startUser.getDeptId());
            if (sysDept != null) {
                flowTask.setStartDeptName(sysDept.getDeptName());
            }

            // 流程变量
            flowTask.setProcVars(this.getProcessVariables(histTask.getId()));

            hisTaskList.add(flowTask);
        }
        return hisTaskList;
    }

    @Override
    public String selectFormContent(String definitionId, String deployId) {
        BpmnModel bpmnModel = repositoryService.getBpmnModel(definitionId);
        if (ObjectUtil.isNull(bpmnModel)) {
            throw new RuntimeException("获取流程设计失败！");
        }
        StartEvent startEvent = ModelUtils.getStartEvent(bpmnModel);
        WfDeployFormVo deployFormVo = deployFormMapper.selectVoOne(new LambdaQueryWrapper<WfDeployForm>()
            .eq(WfDeployForm::getDeployId, deployId)
            .eq(WfDeployForm::getFormKey, startEvent.getFormKey())
            .eq(WfDeployForm::getNodeKey, startEvent.getId()));
        return deployFormVo.getContent();
    }

    /**
     * 根据流程定义ID启动流程实例
     *
     * @param procDefId 流程定义Id
     * @param variables 流程变量
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startProcessByDefId(String procDefId, Map<String, Object> variables) {
        try {
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(procDefId).singleResult();
            startProcess(processDefinition, variables);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServiceException("流程启动错误");
        }
    }

    /**
     * 根据流程定义ID启动任务审批流程实例
     *
     * @param procDefId 流程定义Id
     * @param variables 流程变量
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startTaskProcessByDefId(String taskId, String procDefId, String url, Map<String, Object> variables) {
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startTaskProcess(taskId, processDefinition, url, variables);
    }

    /**
     * 根据流程定义ID启动项目发布流程实例
     *
     * @param procDefId 流程定义Id
     * @param variables 流程变量
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int startProjectProcessByDefId(String projectId, String procDefId, String url, Map<String, Object> variables) {
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startProjectProcess(projectId, processDefinition, url, variables);
        return 1;
    }

    /**
     * 根据流程定义ID启动采购入库审批流程实例
     * @param inboundId
     * @param procDefId
     * @param url
     * @param variables
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startInboundProcessByDefId(String inboundId, String procDefId, String url, Map<String, Object> variables) {
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startInboundProcess(inboundId, processDefinition, url, variables);
    }

    /**
     * 根据流程定义ID启动采购退货出库流程实例
     * @param outboundId
     * @param procDefId
     * @param url
     * @param variables
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startOutboundProcessByDefId(String outboundId, String procDefId, String url, Map<String, Object> variables) {
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startOutboundProcess(outboundId, processDefinition, url, variables);
    }

    @Override
    public void startProviderProcessByDefId(String providerId, String procDefId, String url, Map<String, Object> variables) {
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startProviderProcess(providerId, processDefinition, url, variables);
    }


    /**
     * 根据流程定义ID启动其他入库流程实例
     * @param otherIntoId
     * @param procDefId
     * @param url
     * @param variables
     */
    @Override
    public void startOtherIntoProcessByDefId(String otherIntoId, String procDefId, String url, Map<String, Object> variables) {
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startOtherIntoProcess(otherIntoId, processDefinition, url, variables);
    }

    /**
     * 根据流程定义ID启动其他出库流程实例
     * @param otherOutId
     * @param procDefId
     * @param url
     * @param variables
     */
    @Override
    public void startOtherOutProcessByDefId(String otherOutId, String procDefId, String url, Map<String, Object> variables) {
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startOtherOutProcess(otherOutId, processDefinition, url, variables);
    }

    /**
     * 根据流程定义ID启动归还入库流程实例
     * @param returnIntoId
     * @param procDefId
     * @param url
     * @param variables
     */
    @Override
    public void startReturnIntoProcessByDefId(String returnIntoId, String procDefId, String url, Map<String, Object> variables) {
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startReturnIntoProcess(returnIntoId, processDefinition, url, variables);
    }

    /**
     * 根据流程定义ID启动物料报废流程实例
     * @param materialsIds
     * @param procDefId
     * @param url
     * @param variables
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startScrappedProcessByDefId(String materialsIds, String procDefId, String url, Map<String, Object> variables) {

        List<String> ids = Arrays.asList(materialsIds.split(","));
        List<String> errorIds = new ArrayList<>(10);
        List<String> eIds = new ArrayList<>(10);
//        ids.forEach(id -> {
//            MaterialsUseless mus = materialsUselessMapper.selectById(id);
//            if (mus == null) {
//                errorIds.add(id);
//            } else {
//                if (!USELESS.equals(mus.getResolution()) || DAI_DING.equals(mus.getDangerous())) {
//                    errorIds.add(id);
//                }
//                if (mus.getApproved() != 0) {
//                    eIds.add(id);
//                }
//            }
//        });
        if (CollectionUtils.isNotEmpty(errorIds)) {
            throw new ServiceException("[" + String.join(",", errorIds) + "]" + "处理意见不是报废且危废待定，请重新选择之后发起审批");
        }
        if (CollectionUtils.isNotEmpty(eIds)) {
            throw new ServiceException("[" + String.join(",", eIds) + "]" + "不是未审核状态，请重新选择之后发起审批");
        }
        // 判断责任人是否为空
//        List<MaterialsChangeRecords> materialsChangeRecords = materialsChangeRecordsMapper.selectBatchIds(ids);
//        if (CollectionUtils.isNotEmpty(materialsChangeRecords)) {
//            StringBuilder msg = new StringBuilder();
//            for (MaterialsChangeRecords mcr : materialsChangeRecords) {
//                if (mcr.getPrincipalId() == null) {
//                    msg.append(mcr.getId()).append(",");
//                }
//            }
//            if (StringUtils.isNotBlank(msg.toString())) {
//                throw new ServiceException("[" + msg.substring(0, msg.toString().length() - 1) + "]" + "未设置责任人，请重新选择之后发起审批");
//            }
//        }
        ProcessDefinition processDefinition = getProcessDefinition(procDefId);
        startScrappedProcess(ids, processDefinition, url, variables);
    }

    /**
     * 获取流程定义
     * @param procDefId
     * @return
     */
    private ProcessDefinition getProcessDefinition(String procDefId) {
        return repositoryService.createProcessDefinitionQuery().processDefinitionId(procDefId).singleResult();
    }

    /**
     * 根据类型判断是否有进行中的流程 有则不能发起审批 无则可以并返回 WfTaskProcess
     * @param ids
     * @return
     */
    private List<WfMaterialsScrappedProcess> getScrappedProcess(List<String> ids) {
        LambdaQueryWrapper<WfMaterialsScrappedProcess> qw = new LambdaQueryWrapper<>();
        qw.in(WfMaterialsScrappedProcess::getMaterialId, ids);
        List<WfMaterialsScrappedProcess> scrappedProcessList = wfMaterialsScrappedProcessMapper.selectList(qw);
        if (CollectionUtils.isNotEmpty(scrappedProcessList)) {
            scrappedProcessList.forEach(a -> {
                if (StringUtils.isNotBlank(a.getInstanceId())) {
                    HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                            .processInstanceId(a.getInstanceId())
                            .singleResult();
                    if (historicProcessInstance != null) {
                        if (StringUtils.isBlank(historicProcessInstance.getEndActivityId())) {
                            // 流程未结束不允许重新发起流程
                            throw new ServiceException("存在已发起的审批流程，请重新选择之后再发起");
                        } else {
                            List<Comment> comments = taskService.getProcessInstanceComments(a.getInstanceId());
                            comments.sort(Comparator.comparing(Comment::getTime).reversed());
                            if ("1".equals(comments.get(0).getType())) {
                                throw new ServiceException("存在已通过的审批流程，请重新选择之后再发起");
                            }
                        }
                    }
                }
            });

        } else {
            scrappedProcessList = deployService.insertScrappedProcess(ids, null);
        }
        // 更新 MaterialsUseless
//        LambdaUpdateChainWrapper<MaterialsUseless> updateWrapper = new LambdaUpdateChainWrapper<>(materialsUselessMapper);
//        updateWrapper.in(MaterialsUseless::getRecordId, ids).set(MaterialsUseless::getApproved, 1);
//        updateWrapper.update();
        return scrappedProcessList;
    }

    /**
     * 根据类型判断是否有进行中的流程 有则不能发起审批 无则可以并返回 WfTaskProcess
     * @param extraId
     * @param type
     * @return
     */
    private WfTaskProcess getWfTaskProcess(String extraId, String type) {
        LambdaQueryWrapper<WfTaskProcess> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(WfTaskProcess::getExtraId, extraId).eq(WfTaskProcess::getType, type);
        WfTaskProcess wfTaskProcess = wfTaskProcessMapper.selectOne(queryWrapper);
        MaterialsApprovalSetVO materialsApprovalSetVO;
        if (ProjectStatusEnum.TASK.getStatusName().equals(type)) {
            materialsApprovalSetVO = deployService.queryApprovalSet(type, extraId);
        } else {
            materialsApprovalSetVO = deployService.queryApprovalSet(type, null);
        }

        if (wfTaskProcess != null && StringUtils.isNotBlank(wfTaskProcess.getInstanceId())) {
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(wfTaskProcess.getInstanceId())
                    .singleResult();
            if (historicProcessInstance != null) {
                if (StringUtils.isBlank(historicProcessInstance.getEndActivityId())) {
                    // 流程未结束不允许重新发起流程
                    throw new ServiceException("该审批流程已发起，无需再次发起");
                } else {
                    List<Comment> list = taskService.getProcessInstanceComments(wfTaskProcess.getInstanceId());
                    list.sort(Comparator.comparing(Comment::getTime).reversed());
                    if ("1".equals(list.get(0).getType())) {
                        throw new ServiceException("该审批流程已通过，无需再次发起");
                    }
                    if ("3".equals(list.get(0).getType())) {
                        // 将任务状态改为进行中
                        wfTaskProcessMapper.updateTaskStatus3(extraId);
                    }
                }
            }
            if (ts.contains(type)) {
                wfTaskProcess.setApproved(materialsApprovalSetVO.getApproved());
                wfTaskProcess.setDeploymentId(materialsApprovalSetVO.getDeploymentId());
                wfTaskProcess.setDefinitionId(materialsApprovalSetVO.getDefinitionId());
            }

        } else {
            if (ProjectStatusEnum.PROJECT.getStatusName().equals(type) || ProjectStatusEnum.TASK.getStatusName().equals(type)) {
                // 将任务状态改为进行中
                wfTaskProcessMapper.updateTaskStatus3(extraId);
            }
//            if (types.contains(type)) {
//                MaterialsChangeRecords materialsChangeRecords = materialsChangeRecordsMapper.selectById(extraId);
//                if (materialsChangeRecords.getProcessState() != 0) {
//                    throw new ServiceException("[" + extraId + "]" + "不是未审核状态，无需重新发起审批");
//                }
//            }
            // 新增
            wfTaskProcess = deployService.insertWfTaskProcess(extraId, type, materialsApprovalSetVO.getApproved()
                    , materialsApprovalSetVO.getDefinitionId(), materialsApprovalSetVO.getDeploymentId());
        }
        return wfTaskProcess;
    }


    /**
     * 启动公共流程
     * @param procDef
     * @param type
     * @param url
     * @param variables
     * @return
     */
    private ProcessInstance startCommonProcess(ProcessDefinition procDef, String type, String url, Map<String, Object> variables) {

        // 详情地址
        variables.put(ProcessUtils.TASK_DETAIL_URL_KEY, url);
        // 审批类型 project task 等等
        variables.put(ProcessUtils.APPROVAL_TYPE, type);
        // 直属上级
        queryLeaderId(variables, SecurityUtils.getUserId());
        if (ObjectUtil.isNotNull(procDef) && procDef.isSuspended()) {
            throw new ServiceException("流程已被挂起，请先激活流程");
        }
        // 设置流程发起人Id到流程中
        String userIdStr = TaskUtils.getUserId();
        identityService.setAuthenticatedUserId(userIdStr);
        variables.put(BpmnXMLConstants.ATTRIBUTE_EVENT_START_INITIATOR, userIdStr);
        // 发起流程实例
        return runtimeService.startProcessInstanceById(procDef.getId(), variables);
        // 第一个用户任务为发起人，则自动完成任务
        // wfTaskService.startFirstTask(processInstance, variables);
    }

    /**
     * 将 instanceId、url 和 taskId 更新
     * @param wfTaskProcess
     * @param processInstance
     * @param url
     */
    private void updateWfTaskProcess(WfTaskProcess wfTaskProcess, ProcessInstance processInstance, String url) {
        wfTaskProcess.setInstanceId(processInstance.getId());
        // 当前所处流程
        List<Task> taskList = taskService.createTaskQuery().processInstanceId(processInstance.getProcessInstanceId()).list();
        if (CollUtil.isNotEmpty(taskList)) {
            wfTaskProcess.setTaskId(taskList.get(0).getId());
        } else {
            List<HistoricTaskInstance> historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
                    .processInstanceId(processInstance.getProcessInstanceId()).orderByHistoricTaskInstanceEndTime().desc().list();
            if (CollUtil.isNotEmpty(historicTaskInstance)) {
                wfTaskProcess.setTaskId(historicTaskInstance.get(0).getId());
            }
        }
        wfTaskProcess.setUrl(url);
        wfTaskProcessMapper.updateById(wfTaskProcess);
    }

    /**
     * 将 instanceId、url 和 taskId 更新
     * @param scrappedProcess
     * @param processInstance
     * @param url
     */
    private void updateScrappedProcess(List<WfMaterialsScrappedProcess> scrappedProcess, ProcessInstance processInstance, String url) {
        MaterialsApprovalSetVO materialsApprovalSetVO = deployService.queryApprovalSet(ProcessUtils.SCRAPPED_OUT_APPROVAL_TYPE, null);
        if (CollectionUtils.isNotEmpty(scrappedProcess)) {
            String taskId = null;
            // 当前所处流程
            List<Task> taskList = taskService.createTaskQuery().processInstanceId(processInstance.getProcessInstanceId()).list();
            if (CollUtil.isNotEmpty(taskList)) {
                taskId = taskList.get(0).getId();
            } else {
                List<HistoricTaskInstance> historicTaskInstance = historyService.createHistoricTaskInstanceQuery()
                        .processInstanceId(processInstance.getProcessInstanceId()).orderByHistoricTaskInstanceEndTime().desc().list();
                if (CollUtil.isNotEmpty(historicTaskInstance)) {
                    taskId = historicTaskInstance.get(0).getId();
                }
            }
            List<String> ids = scrappedProcess.stream().map(WfMaterialsScrappedProcess::getMaterialId).collect(Collectors.toList());
            if (CollectionUtils.isNotEmpty(ids)) {
                LambdaUpdateChainWrapper<WfMaterialsScrappedProcess> updateWrapper = new LambdaUpdateChainWrapper<>(wfMaterialsScrappedProcessMapper);
                updateWrapper.in(WfMaterialsScrappedProcess::getMaterialId, ids)
                        .set(WfMaterialsScrappedProcess::getApproved, materialsApprovalSetVO.getApproved())
                        .set(WfMaterialsScrappedProcess::getType, materialsApprovalSetVO.getType())
                        .set(WfMaterialsScrappedProcess::getDefinitionId, materialsApprovalSetVO.getDefinitionId())
                        .set(WfMaterialsScrappedProcess::getDeploymentId, materialsApprovalSetVO.getDeploymentId())
                        .set(WfMaterialsScrappedProcess::getInstanceId, processInstance.getId())
                        .set(WfMaterialsScrappedProcess::getTaskId, taskId)
                        .set(WfMaterialsScrappedProcess::getUrl, url);
                updateWrapper.update();
            }
        }

    }

    /**
     * 查询直属上级id
     * @param variables
     * @param userId
     */
    private void queryLeaderId(Map<String, Object> variables, Long userId) {
        SysUser sysUser = wfCopyMapper.selectUserById(userId);
        if (StringUtils.isNotBlank(sysUser.getLeaderId())) {
            // 直属上级
            variables.put(ProcessUtils.LEADER_LIST, Arrays.asList(sysUser.getLeaderId().split(",")));
        }
    }

    /**
     * 通过DefinitionKey启动流程
     * @param procDefKey 流程定义Key
     * @param variables 扩展参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startProcessByDefKey(String procDefKey, Map<String, Object> variables) {
        try {
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionKey(procDefKey).latestVersion().singleResult();
            startProcess(processDefinition, variables);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServiceException("流程启动错误");
        }
    }

    /**
     * 读取xml文件
     * @param processDefId 流程定义ID
     */
    @Override
    public String queryBpmnXmlById(String processDefId) {
        if (StringUtils.isBlank(processDefId)) {
            throw new ServiceException("未设置流程定义，请联系管理员");
        }
        InputStream inputStream = repositoryService.getProcessModel(processDefId);
        try {
            return IoUtil.readUtf8(inputStream);
        } catch (IORuntimeException exception) {
            throw new RuntimeException("加载xml文件异常");
        }
    }

    /**
     * 流程详情信息
     *
     * @param procInsId 流程实例ID
     * @param deployId 流程部署ID
     * @param taskId 任务ID
     * @return
     */
    @Override
    public WfDetailVo queryProcessDetail(String procInsId, String deployId, String taskId) {
        if (StringUtils.isBlank(procInsId)) {
            throw new ServiceException("未发布审批，不存在审批进度");
        }
        WfDetailVo detailVo = new WfDetailVo();
        HistoricTaskInstance taskIns = historyService.createHistoricTaskInstanceQuery()
            .taskId(taskId)
            .includeIdentityLinks()
            .includeProcessVariables()
            .includeTaskLocalVariables()
            .singleResult();
        if (taskIns == null) {
            throw new ServiceException("没有可办理的任务！");
        }
        // 获取Bpmn模型信息
        BpmnModel bpmnModel = repositoryService.getBpmnModel(taskIns.getProcessDefinitionId());
        detailVo.setBpmnXml(ModelUtils.getBpmnXmlStr(bpmnModel));
        detailVo.setTaskFormData(currTaskFormData(deployId, taskIns));
        detailVo.setHistoryProcNodeList(historyProcNodeList(procInsId));
        detailVo.setProcessFormList(processFormList(bpmnModel, procInsId, deployId));
        detailVo.setFlowViewer(getFlowViewer(bpmnModel, procInsId));
        return detailVo;
    }

    /**
     * 启动流程实例
     */
    private void startProcess(ProcessDefinition procDef, Map<String, Object> variables) {
        if (ObjectUtil.isNotNull(procDef) && procDef.isSuspended()) {
            throw new ServiceException("流程已被挂起，请先激活流程");
        }
        // 设置流程发起人Id到流程中
        String userIdStr = TaskUtils.getUserId();
        identityService.setAuthenticatedUserId(userIdStr);
        variables.put(BpmnXMLConstants.ATTRIBUTE_EVENT_START_INITIATOR, userIdStr);
        // 发起流程实例
        ProcessInstance processInstance = runtimeService.startProcessInstanceById(procDef.getId(), variables);
        // 第一个用户任务为发起人，则自动完成任务
        wfTaskService.startFirstTask(processInstance, variables);
    }

    /**
     * 启动任务发布实例
     * @param taskId
     * @param procDef
     * @param url
     * @param variables
     */
    private void startTaskProcess(String taskId, ProcessDefinition procDef, String url, Map<String, Object> variables) {
        // 任务审批相关逻辑
        Integer status = wfTaskProcessMapper.selectStatusByTaskId(taskId);
        if (!ProjectTaskStatusEnum.FINISHED.getStatus().equals(status)) {
            throw new ServiceException("执行状态为已完成才能发起审批");
        }

        WfTaskProcess wfTaskProcess = getWfTaskProcess(taskId, ProcessUtils.TASK_APPROVAL_TYPE);
        ProcessInstance processInstance = startCommonProcess(procDef, ProcessUtils.TASK_APPROVAL_TYPE, url, variables);
        updateWfTaskProcess(wfTaskProcess, processInstance, url);
    }


    /**
     * 启动项目发布实例
     * @param projectId
     * @param procDef
     * @param url
     * @param variables
     */
    private void startProjectProcess(String projectId, ProcessDefinition procDef, String url, Map<String, Object> variables) {

        WfTaskProcess wfTaskProcess = getWfTaskProcess(projectId, ProcessUtils.PROJECT_APPROVAL_TYPE);
        ProcessInstance processInstance = startCommonProcess(procDef, ProcessUtils.PROJECT_APPROVAL_TYPE, url, variables);
        updateWfTaskProcess(wfTaskProcess, processInstance, url);
    }


    /**
     * 启动采购入库审批实例
     * @param inboundId
     * @param procDef
     * @param url
     * @param variables
     */
    private void startInboundProcess(String inboundId, ProcessDefinition procDef, String url, Map<String, Object> variables) {
        WfTaskProcess wfTaskProcess = getWfTaskProcess(inboundId, ProcessUtils.PURCHASE_INTO_APPROVAL_TYPE);
        ProcessInstance processInstance = startCommonProcess(procDef, ProcessUtils.PURCHASE_INTO_APPROVAL_TYPE, url, variables);
        updateWfTaskProcess(wfTaskProcess, processInstance, url);
    }

    /**
     * 启动采购退货出库实例
     * @param outboundId
     * @param procDef
     * @param url
     * @param variables
     */
    private void startOutboundProcess(String outboundId, ProcessDefinition procDef, String url, Map<String, Object> variables) {
        WfTaskProcess wfTaskProcess = getWfTaskProcess(outboundId, ProcessUtils.PURCHASE_OUT_APPROVAL_TYPE);
        ProcessInstance processInstance = startCommonProcess(procDef, ProcessUtils.PURCHASE_OUT_APPROVAL_TYPE, url, variables);
        updateWfTaskProcess(wfTaskProcess, processInstance, url);
    }

    private void startProviderProcess(String providerId, ProcessDefinition procDef, String url, Map<String, Object> variables) {
        WfTaskProcess wfTaskProcess = getWfTaskProcess(providerId, "SUPPLIER_APPROVAL");
        ProcessInstance processInstance = startCommonProcess(procDef, "SUPPLIER_APPROVAL", url, variables);
        updateWfTaskProcess(wfTaskProcess, processInstance, url);
    }


    /**
     * 启动其他入库实例
     * @param otherIntoId
     * @param procDef
     * @param url
     * @param variables
     */
    private void startOtherIntoProcess(String otherIntoId, ProcessDefinition procDef, String url, Map<String, Object> variables) {
        WfTaskProcess wfTaskProcess = getWfTaskProcess(otherIntoId, ProcessUtils.OTHER_INTO_APPROVAL_TYPE);
        ProcessInstance processInstance = startCommonProcess(procDef, ProcessUtils.OTHER_INTO_APPROVAL_TYPE, url, variables);
        updateWfTaskProcess(wfTaskProcess, processInstance, url);
    }

    /**
     * 启动其他出库实例
     * @param otherOutId
     * @param procDef
     * @param url
     * @param variables
     */
    private void startOtherOutProcess(String otherOutId, ProcessDefinition procDef, String url, Map<String, Object> variables) {
        WfTaskProcess wfTaskProcess = getWfTaskProcess(otherOutId, ProcessUtils.OTHER_OUT_APPROVAL_TYPE);
        ProcessInstance processInstance = startCommonProcess(procDef, ProcessUtils.OTHER_OUT_APPROVAL_TYPE, url, variables);
        updateWfTaskProcess(wfTaskProcess, processInstance, url);
    }

    /**
     * 启动归还入库实例
     * @param returnIntoId
     * @param procDef
     * @param url
     * @param variables
     */
    private void startReturnIntoProcess(String returnIntoId, ProcessDefinition procDef, String url, Map<String, Object> variables) {
        WfTaskProcess wfTaskProcess = getWfTaskProcess(returnIntoId, ProcessUtils.RETURN_INTO_APPROVAL_TYPE);
        ProcessInstance processInstance = startCommonProcess(procDef, ProcessUtils.RETURN_INTO_APPROVAL_TYPE, url, variables);
        updateWfTaskProcess(wfTaskProcess, processInstance, url);
    }
    /**
     * 启动报废出库实例
     * @param ids
     * @param procDef
     * @param url
     * @param variables
     */
    private void startScrappedProcess(List<String> ids, ProcessDefinition procDef, String url, Map<String, Object> variables) {
        // ProcessUtils.SCRAPPED_OUT_APPROVAL_TYPE
        List<WfMaterialsScrappedProcess> scrappedProcess = getScrappedProcess(ids);
        ProcessInstance processInstance = startCommonProcess(procDef, ProcessUtils.SCRAPPED_OUT_APPROVAL_TYPE, url, variables);
        updateScrappedProcess(scrappedProcess, processInstance, url);
    }
    /**
     * 获取流程变量
     *
     * @param taskId 任务ID
     * @return 流程变量
     */
    private Map<String, Object> getProcessVariables(String taskId) {
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
     * 获取当前任务流程表单信息
     */
    private FormConf currTaskFormData(String deployId, HistoricTaskInstance taskIns) {
        WfDeployFormVo deployFormVo = deployFormMapper.selectVoOne(new LambdaQueryWrapper<WfDeployForm>()
            .eq(WfDeployForm::getDeployId, deployId)
            .eq(WfDeployForm::getFormKey, taskIns.getFormKey())
            .eq(WfDeployForm::getNodeKey, taskIns.getTaskDefinitionKey()));
        if (ObjectUtil.isNotEmpty(deployFormVo)) {
            FormConf currTaskFormData = JsonUtils.parseObject(deployFormVo.getContent(), FormConf.class);
            if (null != currTaskFormData) {
                currTaskFormData.setFormBtns(false);
                ProcessFormUtils.fillFormData(currTaskFormData, taskIns.getTaskLocalVariables());
                return currTaskFormData;
            }
        }
        return null;
    }

    /**
     * 获取历史流程表单信息
     */
    private List<FormConf> processFormList(BpmnModel bpmnModel, String procInsId, String deployId) {
        List<FormConf> procFormList = new ArrayList<>();
        HistoricProcessInstance historicProcIns = historyService.createHistoricProcessInstanceQuery().processInstanceId(procInsId).includeProcessVariables().singleResult();
        List<HistoricActivityInstance> activityInstanceList = historyService.createHistoricActivityInstanceQuery()
            .processInstanceId(procInsId).finished()
            .activityTypes(CollUtil.newHashSet(BpmnXMLConstants.ELEMENT_EVENT_START, BpmnXMLConstants.ELEMENT_TASK_USER))
            .orderByHistoricActivityInstanceStartTime().asc()
            .list();
        List<String> processFormKeys = new ArrayList<>();
        for (HistoricActivityInstance activityInstance : activityInstanceList) {
            // 获取当前节点流程元素信息
            FlowElement flowElement = ModelUtils.getFlowElementById(bpmnModel, activityInstance.getActivityId());
            // 获取当前节点表单Key
            String formKey = ModelUtils.getFormKey(flowElement);
            if (formKey == null) {
                continue;
            }
            boolean localScope = Convert.toBool(ModelUtils.getElementAttributeValue(flowElement, ProcessConstants.PROCESS_FORM_LOCAL_SCOPE), false);
            Map<String, Object> variables;
            if (localScope) {
                // 查询任务节点参数，并转换成Map
                variables = historyService.createHistoricVariableInstanceQuery()
                    .processInstanceId(procInsId)
                    .taskId(activityInstance.getTaskId())
                    .list()
                    .stream()
                    .collect(Collectors.toMap(HistoricVariableInstance::getVariableName, HistoricVariableInstance::getValue));
            } else {
                if (processFormKeys.contains(formKey)) {
                    continue;
                }
                variables = historicProcIns.getProcessVariables();
                processFormKeys.add(formKey);
            }
            // 非节点表单此处查询结果可能有多条，只获取第一条信息
            List<WfDeployFormVo> formInfoList = deployFormMapper.selectVoList(new LambdaQueryWrapper<WfDeployForm>()
                .eq(WfDeployForm::getDeployId, deployId)
                .eq(WfDeployForm::getFormKey, formKey)
                .eq(localScope, WfDeployForm::getNodeKey, flowElement.getId()));
            WfDeployFormVo formInfo = formInfoList.iterator().next();
            if (ObjectUtil.isNotNull(formInfo)) {
                // 旧数据 formInfo.getFormName() 为 null
                String formName = Optional.ofNullable(formInfo.getFormName()).orElse(StringUtils.EMPTY);
                String title = localScope ? formName.concat("(" + flowElement.getName() + ")") : formName;
                FormConf formConf = JsonUtils.parseObject(formInfo.getContent(), FormConf.class);
                if (null != formConf) {
                    formConf.setTitle(title);
                    formConf.setDisabled(true);
                    formConf.setFormBtns(false);
                    ProcessFormUtils.fillFormData(formConf, variables);
                    procFormList.add(formConf);
                }
            }
        }
        return procFormList;
    }

    @Deprecated
    private void buildStartFormData(HistoricProcessInstance historicProcIns, Process process, String deployId, List<FormConf> procFormList) {
        procFormList = procFormList == null ? new ArrayList<>() : procFormList;
        HistoricActivityInstance startInstance = historyService.createHistoricActivityInstanceQuery()
            .processInstanceId(historicProcIns.getId())
            .activityId(historicProcIns.getStartActivityId())
            .singleResult();
        StartEvent startEvent = (StartEvent) process.getFlowElement(startInstance.getActivityId());
        WfDeployFormVo startFormInfo = deployFormMapper.selectVoOne(new LambdaQueryWrapper<WfDeployForm>()
            .eq(WfDeployForm::getDeployId, deployId)
            .eq(WfDeployForm::getFormKey, startEvent.getFormKey())
            .eq(WfDeployForm::getNodeKey, startEvent.getId()));
        if (ObjectUtil.isNotNull(startFormInfo)) {
            FormConf formConf = JsonUtils.parseObject(startFormInfo.getContent(), FormConf.class);
            if (null != formConf) {
                formConf.setTitle(startEvent.getName());
                formConf.setDisabled(true);
                formConf.setFormBtns(false);
                ProcessFormUtils.fillFormData(formConf, historicProcIns.getProcessVariables());
                procFormList.add(formConf);
            }
        }
    }

    @Deprecated
    private void buildUserTaskFormData(String procInsId, String deployId, Process process, List<FormConf> procFormList) {
        procFormList = procFormList == null ? new ArrayList<>() : procFormList;
        List<HistoricActivityInstance> activityInstanceList = historyService.createHistoricActivityInstanceQuery()
            .processInstanceId(procInsId).finished()
            .activityType(BpmnXMLConstants.ELEMENT_TASK_USER)
            .orderByHistoricActivityInstanceStartTime().asc()
            .list();
        for (HistoricActivityInstance instanceItem : activityInstanceList) {
            UserTask userTask = (UserTask) process.getFlowElement(instanceItem.getActivityId(), true);
            String formKey = userTask.getFormKey();
            if (formKey == null) {
                continue;
            }
            // 查询任务节点参数，并转换成Map
            Map<String, Object> variables = historyService.createHistoricVariableInstanceQuery()
                .processInstanceId(procInsId)
                .taskId(instanceItem.getTaskId())
                .list()
                .stream()
                .collect(Collectors.toMap(HistoricVariableInstance::getVariableName, HistoricVariableInstance::getValue));
            WfDeployFormVo deployFormVo = deployFormMapper.selectVoOne(new LambdaQueryWrapper<WfDeployForm>()
                .eq(WfDeployForm::getDeployId, deployId)
                .eq(WfDeployForm::getFormKey, formKey)
                .eq(WfDeployForm::getNodeKey, userTask.getId()));
            if (ObjectUtil.isNotNull(deployFormVo)) {
                FormConf formConf = JsonUtils.parseObject(deployFormVo.getContent(), FormConf.class);
                if (null != formConf) {
                    formConf.setTitle(userTask.getName());
                    formConf.setDisabled(true);
                    formConf.setFormBtns(false);
                    ProcessFormUtils.fillFormData(formConf, variables);
                    procFormList.add(formConf);
                }
            }
        }
    }

    /**
     * 获取历史任务信息列表
     */
    private List<WfProcNodeVo> historyProcNodeList(String procInsId) {
        List<HistoricActivityInstance> historicActivityInstanceList =  historyService.createHistoricActivityInstanceQuery()
            .processInstanceId(procInsId)
            .activityTypes(CollUtil.newHashSet(BpmnXMLConstants.ELEMENT_EVENT_START, BpmnXMLConstants.ELEMENT_EVENT_END, BpmnXMLConstants.ELEMENT_TASK_USER))
            .orderByHistoricActivityInstanceStartTime().desc()
            .orderByHistoricActivityInstanceEndTime().desc()
            .list();

        HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
            .processInstanceId(procInsId)
            .singleResult();

        List<Comment> commentList = taskService.getProcessInstanceComments(procInsId);

        List<WfProcNodeVo> elementVoList = new ArrayList<>();
        for (HistoricActivityInstance activityInstance : historicActivityInstanceList) {
            WfProcNodeVo elementVo = new WfProcNodeVo();
            elementVo.setProcDefId(activityInstance.getProcessDefinitionId());
            elementVo.setActivityId(activityInstance.getActivityId());
            elementVo.setActivityName(activityInstance.getActivityName());
            elementVo.setActivityType(activityInstance.getActivityType());
            elementVo.setCreateTime(activityInstance.getStartTime());
            elementVo.setEndTime(activityInstance.getEndTime());
            if (ObjectUtil.isNotNull(activityInstance.getDurationInMillis())) {
                elementVo.setDuration(DateUtil.formatBetween(activityInstance.getDurationInMillis(), BetweenFormatter.Level.SECOND));
            }

            if (BpmnXMLConstants.ELEMENT_EVENT_START.equals(activityInstance.getActivityType())) {
                if (ObjectUtil.isNotNull(historicProcessInstance)) {
                    Long userId = Long.parseLong(historicProcessInstance.getStartUserId());
                    SysUser user = wfCopyMapper.selectUserById(userId);
                    if (user != null) {
                        elementVo.setAssigneeId(user.getUserId());
                        elementVo.setAssigneeName(user.getNickName());
                    }
                }
            } else if (BpmnXMLConstants.ELEMENT_TASK_USER.equals(activityInstance.getActivityType())) {
                if (StringUtils.isNotBlank(activityInstance.getAssignee())) {
                    SysUser user = wfCopyMapper.selectUserById(Long.parseLong(activityInstance.getAssignee()));
                    elementVo.setAssigneeId(user.getUserId());
                    elementVo.setAssigneeName(user.getNickName());
                }
                // 展示审批人员
                List<HistoricIdentityLink> linksForTask = historyService.getHistoricIdentityLinksForTask(activityInstance.getTaskId());
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
                    elementVo.setCandidate(stringBuilder.substring(0, stringBuilder.length() - 1));
                }
                // 获取意见评论内容
                if (CollUtil.isNotEmpty(commentList)) {
                    List<CommentVO> comments = new ArrayList<>();
                    for (Comment comment : commentList) {
                        if (comment.getTaskId().equals(activityInstance.getTaskId())) {
                            CommentVO commentVO = new CommentVO();
                            BeanUtils.copyProperties(comment, commentVO);
                            comments.add(commentVO);
                        }
                    }
                    elementVo.setCommentList(comments);
                }
            }
            elementVoList.add(elementVo);
        }
        return elementVoList;
    }

    /**
     * 获取流程执行过程
     *
     * @param procInsId
     * @return
     */
    private WfViewerVo getFlowViewer(BpmnModel bpmnModel, String procInsId) {
        // 构建查询条件
        HistoricActivityInstanceQuery query = historyService.createHistoricActivityInstanceQuery()
            .processInstanceId(procInsId);
        List<HistoricActivityInstance> allActivityInstanceList = query.list();
        if (CollUtil.isEmpty(allActivityInstanceList)) {
            return new WfViewerVo();
        }
        // 查询所有已完成的元素
        List<HistoricActivityInstance> finishedElementList = allActivityInstanceList.stream()
            .filter(item -> ObjectUtil.isNotNull(item.getEndTime())).collect(Collectors.toList());
        // 所有已完成的连线
        Set<String> finishedSequenceFlowSet = new HashSet<>();
        // 所有已完成的任务节点
        Set<String> finishedTaskSet = new HashSet<>();
        finishedElementList.forEach(item -> {
            if (BpmnXMLConstants.ELEMENT_SEQUENCE_FLOW.equals(item.getActivityType())) {
                finishedSequenceFlowSet.add(item.getActivityId());
            } else {
                finishedTaskSet.add(item.getActivityId());
            }
        });
        // 查询所有未结束的节点
        Set<String> unfinishedTaskSet = allActivityInstanceList.stream()
            .filter(item -> ObjectUtil.isNull(item.getEndTime()))
            .map(HistoricActivityInstance::getActivityId)
            .collect(Collectors.toSet());
        // DFS 查询未通过的元素集合
        Set<String> rejectedSet = FlowableUtils.dfsFindRejects(bpmnModel, unfinishedTaskSet, finishedSequenceFlowSet, finishedTaskSet);
        return new WfViewerVo(finishedTaskSet, finishedSequenceFlowSet, unfinishedTaskSet, rejectedSet);
    }
}
