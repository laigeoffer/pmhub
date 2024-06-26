package com.laigeoffer.pmhub.workflow.service.impl;

import cn.hutool.core.io.IORuntimeException;
import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laigeoffer.pmhub.base.core.core.domain.PageQuery;
import com.laigeoffer.pmhub.base.core.core.page.Table2DataInfo;
import com.laigeoffer.pmhub.base.core.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.core.domain.ProcessQuery;
import com.laigeoffer.pmhub.workflow.domain.WfApprovalSet;
import com.laigeoffer.pmhub.workflow.domain.WfDeployForm;
import com.laigeoffer.pmhub.workflow.domain.WfMaterialsScrappedProcess;
import com.laigeoffer.pmhub.base.core.core.domain.entity.WfTaskProcess;
import com.laigeoffer.pmhub.base.core.core.domain.dto.ApprovalSetDTO;
import com.laigeoffer.pmhub.workflow.domain.dto.MaterialsApprovalSetDTO;
import com.laigeoffer.pmhub.workflow.domain.vo.MaterialsApprovalSetVO;
import com.laigeoffer.pmhub.workflow.domain.vo.WfDeployVo;
import com.laigeoffer.pmhub.workflow.factory.FlowServiceFactory;
import com.laigeoffer.pmhub.workflow.mapper.WfApprovalSetMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfDeployFormMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfMaterialsScrappedProcessMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfTaskProcessMapper;
import com.laigeoffer.pmhub.workflow.service.IWfDeployService;
import com.laigeoffer.pmhub.workflow.utils.ProcessUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.flowable.common.engine.impl.db.SuspensionState;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.repository.ProcessDefinitionQuery;
import org.flowable.engine.task.Comment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author canghe
 * @createTime 2022/6/30 9:04
 */
@RequiredArgsConstructor
@Service
@Slf4j
public class WfDeployServiceImpl extends FlowServiceFactory implements IWfDeployService {

    private final RepositoryService repositoryService;
    private final WfDeployFormMapper deployFormMapper;
    private final WfApprovalSetMapper wfApprovalSetMapper;
    private final WfTaskProcessMapper wfTaskProcessMapper;
    private final WfMaterialsScrappedProcessMapper wfMaterialsScrappedProcessMapper;

    @Override
    public Table2DataInfo<WfDeployVo> queryPageList(ProcessQuery processQuery, PageQuery pageQuery) {
        // 流程定义列表数据查询
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery()
                .latestVersion()
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

        List<WfDeployVo> deployVoList = new ArrayList<>(definitionList.size());
        for (ProcessDefinition processDefinition : definitionList) {
            String deploymentId = processDefinition.getDeploymentId();
            Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
            WfDeployVo vo = new WfDeployVo();
            vo.setDefinitionId(processDefinition.getId());
            vo.setProcessKey(processDefinition.getKey());
            vo.setProcessName(processDefinition.getName());
            vo.setVersion(processDefinition.getVersion());
            vo.setCategory(processDefinition.getCategory());
            vo.setDeploymentId(processDefinition.getDeploymentId());
            vo.setSuspended(processDefinition.isSuspended());
            // 流程部署信息
            vo.setCategory(deployment.getCategory());
            vo.setDeploymentTime(deployment.getDeploymentTime());
            deployVoList.add(vo);
        }
        deployVoList.sort(Comparator.comparing(WfDeployVo::getDeploymentTime).reversed());
        Page<WfDeployVo> page = new Page<>();
        page.setRecords(deployVoList);
        page.setTotal(pageTotal);
        return Table2DataInfo.build(page);
    }

    @Override
    public Table2DataInfo<WfDeployVo> queryPublishList(String processKey, PageQuery pageQuery) {
        // 创建查询条件
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery()
                .processDefinitionKey(processKey)
                .orderByProcessDefinitionVersion()
                .desc();
        long pageTotal = processDefinitionQuery.count();
        if (pageTotal <= 0) {
            return Table2DataInfo.build();
        }
        // 根据查询条件，查询所有版本
        int offset = pageQuery.getPageSize() * (pageQuery.getPageNum() - 1);
        List<ProcessDefinition> processDefinitionList = processDefinitionQuery
                .listPage(offset, pageQuery.getPageSize());
        List<WfDeployVo> deployVoList = processDefinitionList.stream().map(item -> {
            WfDeployVo vo = new WfDeployVo();
            vo.setDefinitionId(item.getId());
            vo.setProcessKey(item.getKey());
            vo.setProcessName(item.getName());
            vo.setVersion(item.getVersion());
            vo.setCategory(item.getCategory());
            vo.setDeploymentId(item.getDeploymentId());
            vo.setSuspended(item.isSuspended());
            return vo;
        }).collect(Collectors.toList());
        Page<WfDeployVo> page = new Page<>();
        page.setRecords(deployVoList);
        page.setTotal(pageTotal);
        return Table2DataInfo.build(page);
    }

    /**
     * 激活或挂起流程
     *
     * @param state        状态
     * @param definitionId 流程定义ID
     */
    @Override
    public void updateState(String definitionId, String state) {
        if (SuspensionState.ACTIVE.toString().equals(state)) {
            // 激活
            repositoryService.activateProcessDefinitionById(definitionId, true, null);
        } else if (SuspensionState.SUSPENDED.toString().equals(state)) {
            // 挂起
            repositoryService.suspendProcessDefinitionById(definitionId, true, null);
        }
    }

    @Override
    public String queryBpmnXmlById(String definitionId) {
        InputStream inputStream = repositoryService.getProcessModel(definitionId);
        try {
            return IoUtil.readUtf8(inputStream);
        } catch (IORuntimeException exception) {
            throw new RuntimeException("加载xml文件异常");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteByIds(List<String> deployIds) {
        for (String deployId : deployIds) {
            repositoryService.deleteDeployment(deployId, true);
            deployFormMapper.delete(new LambdaQueryWrapper<WfDeployForm>().eq(WfDeployForm::getDeployId, deployId));
        }
    }

    /**
     * 新增或更新审批设置
     *
     * @param approvalSetDTO
     * @param type
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approvalSet(MaterialsApprovalSetDTO approvalSetDTO, String type) {
        WfApprovalSet mas = getMaterialsApprovalSet(type, null);
        if (mas != null) {
            // 更新
            mas.setApproved(approvalSetDTO.getApproved());
            mas.setDefinitionId(approvalSetDTO.getDefinitionId());
            mas.setDeploymentId(approvalSetDTO.getDeploymentId());
            mas.setUpdatedBy(SecurityUtils.getUsername());
            mas.setUpdatedTime(new Date());
            wfApprovalSetMapper.updateById(mas);
        } else {
            // 新增
            WfApprovalSet wfApprovalSet = new WfApprovalSet();
            wfApprovalSet.setApproved(approvalSetDTO.getApproved());
            wfApprovalSet.setType(type);
            wfApprovalSet.setDefinitionId(approvalSetDTO.getDefinitionId());
            wfApprovalSet.setDeploymentId(approvalSetDTO.getDeploymentId());
            wfApprovalSet.setCreatedBy(SecurityUtils.getUsername());
            wfApprovalSet.setCreatedTime(new Date());
            wfApprovalSet.setUpdatedBy(SecurityUtils.getUsername());
            wfApprovalSet.setUpdatedTime(new Date());
            wfApprovalSetMapper.insert(wfApprovalSet);
        }
    }

    private WfApprovalSet getMaterialsApprovalSet(String type, String taskId) {
        LambdaQueryWrapper<WfApprovalSet> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(WfApprovalSet::getType, type);
        if (StringUtils.isNotBlank(taskId)) {
            queryWrapper.eq(WfApprovalSet::getExtraId, taskId);
        } else {
            if (ProjectStatusEnum.TASK.getStatusName().equals(type)) {
                return null;
            }
        }
        return wfApprovalSetMapper.selectOne(queryWrapper);
    }

    /**
     * 根据类型查询审批设置
     *
     * @param type
     * @return
     */
    @Override
    public MaterialsApprovalSetVO queryApprovalSet(String type, String taskId) {
        MaterialsApprovalSetVO materialsApprovalSetVO = new MaterialsApprovalSetVO();
        WfApprovalSet wfApprovalSet = getMaterialsApprovalSet(type, taskId);
        if (wfApprovalSet != null) {
            materialsApprovalSetVO.setApproved(wfApprovalSet.getApproved());
            materialsApprovalSetVO.setType(type);
            materialsApprovalSetVO.setDeploymentId(wfApprovalSet.getDeploymentId());
            materialsApprovalSetVO.setDefinitionId(wfApprovalSet.getDefinitionId());
        }
        return materialsApprovalSetVO;
    }

    @Override
    public boolean updateApprovalSet(ApprovalSetDTO approvalSetDTO, String type) {
        LambdaQueryWrapper<WfTaskProcess> queryWrapper = new LambdaQueryWrapper<>();
        if (ProjectStatusEnum.TASK.getStatusName().equals(type)) {
            queryWrapper.eq(WfTaskProcess::getExtraId, approvalSetDTO.getTaskId()).eq(WfTaskProcess::getType, ProjectStatusEnum.TASK.getStatusName());
        }
        if (ProjectStatusEnum.PROJECT.getStatusName().equals(type)) {
            queryWrapper.eq(WfTaskProcess::getExtraId, approvalSetDTO.getProjectId()).eq(WfTaskProcess::getType, ProjectStatusEnum.PROJECT.getStatusName());
        }
        WfTaskProcess pt = wfTaskProcessMapper.selectOne(queryWrapper);
        if (pt != null) {
            if ("1".equals(pt.getApproved())) {
                if (!Objects.equals(wfTaskProcessMapper.selectStatusByTaskId2(approvalSetDTO.getTaskId()), ProjectStatusEnum.NO_STARTED.getStatus())) {
                    throw new ServiceException("需将任务状态变为未开始才能修改审批设置");
                }
            }
            // 更新
            if (StringUtils.isBlank(pt.getInstanceId())) {
                pt.setApproved(approvalSetDTO.getApproved());
                pt.setDefinitionId(approvalSetDTO.getDefinitionId());
                pt.setDeploymentId(approvalSetDTO.getDeploymentId());
                pt.setUpdatedBy(SecurityUtils.getUsername());
                pt.setUpdatedTime(new Date());
                wfTaskProcessMapper.updateById(pt);
            } else {
                throw new ServiceException("审批中或者已完成的流程不允许修改审批设置");
            }
        } else {
            // 新增
            WfTaskProcess wfTaskProcess = new WfTaskProcess();
            wfTaskProcess.setExtraId(approvalSetDTO.getTaskId());
            wfTaskProcess.setApproved(approvalSetDTO.getApproved());
            wfTaskProcess.setType(ProjectStatusEnum.TASK.getStatusName());
            extracted(approvalSetDTO.getDefinitionId(), approvalSetDTO.getDeploymentId(), wfTaskProcess);
            wfTaskProcessMapper.insert(wfTaskProcess);
        }

        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateApprovalSet2(ApprovalSetDTO approvalSetDTO, String type) {
        LambdaQueryWrapper<WfApprovalSet> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(WfApprovalSet::getExtraId, approvalSetDTO.getTaskId()).eq(WfApprovalSet::getType, ProjectStatusEnum.TASK.getStatusName());
        WfApprovalSet wfApprovalSet = wfApprovalSetMapper.selectOne(queryWrapper);
        // 无需审批
        if ("1".equals(wfApprovalSet.getApproved())) {
            if (!Objects.equals(wfTaskProcessMapper.selectStatusByTaskId2(approvalSetDTO.getTaskId()), ProjectStatusEnum.NO_STARTED.getStatus())) {
                throw new ServiceException("需将任务状态变为未开始才能修改审批设置");
            }
        } else {
            // 需要审批
            LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
            qw.eq(WfTaskProcess::getExtraId, approvalSetDTO.getTaskId()).eq(WfTaskProcess::getType, ProjectStatusEnum.TASK.getStatusName());
            WfTaskProcess pt = wfTaskProcessMapper.selectOne(qw);
            if (pt != null && StringUtils.isNotBlank(pt.getInstanceId())) {
                // 根据 instanceId 查询流程的状态是不是已拒绝
                HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery().processInstanceId(pt.getInstanceId()).singleResult();
                if (historicProcessInstance != null) {
                    if (StringUtils.isBlank(historicProcessInstance.getEndActivityId())) {
                        // 审批中的流程不允许修改审批设置
                        throw new ServiceException("审批中的流程不允许修改审批设置");
                    } else {
                        List<Comment> list = taskService.getProcessInstanceComments(pt.getInstanceId());
                        list.sort(Comparator.comparing(Comment::getTime).reversed());
                        // 已通过的流程不允许修改审批设置
                        if ("1".equals(list.get(0).getType())) {
                            throw new ServiceException("已通过的流程不允许修改审批设置");
                        }
                    }
                }
            }
        }
        wfApprovalSet.setApproved(approvalSetDTO.getApproved());
        wfApprovalSet.setDeploymentId(approvalSetDTO.getDeploymentId());
        wfApprovalSet.setDefinitionId(approvalSetDTO.getDefinitionId());
        wfApprovalSet.setUpdatedBy(SecurityUtils.getUsername());
        wfApprovalSet.setUpdatedTime(new Date());
        wfApprovalSetMapper.updateById(wfApprovalSet);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insertApprovalSet() {
        LambdaQueryWrapper<WfTaskProcess> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(WfTaskProcess::getType, ProjectStatusEnum.TASK.getStatusName());
        List<WfTaskProcess> list = wfTaskProcessMapper.selectList(queryWrapper);
        if (CollectionUtils.isNotEmpty(list)) {
            log.info("开始优化的任务审批设置的数量:{}", list.size());
            list.forEach(wfTaskProcess -> {
                WfApprovalSet wfApprovalSet = new WfApprovalSet();
                wfApprovalSet.setType(ProjectStatusEnum.TASK.getStatusName());
                wfApprovalSet.setApproved(wfTaskProcess.getApproved());
                wfApprovalSet.setDefinitionId(wfTaskProcess.getDefinitionId());
                wfApprovalSet.setDeploymentId(wfTaskProcess.getDeploymentId());
                wfApprovalSet.setCreatedBy(wfTaskProcess.getCreatedBy());
                wfApprovalSet.setCreatedTime(wfTaskProcess.getCreatedTime());
                wfApprovalSet.setUpdatedBy(wfTaskProcess.getUpdatedBy());
                wfApprovalSet.setUpdatedTime(wfTaskProcess.getUpdatedTime());
                wfApprovalSet.setExtraId(wfTaskProcess.getExtraId());
                wfApprovalSetMapper.insert(wfApprovalSet);
                if ("1".equals(wfTaskProcess.getApproved())) {
                    wfTaskProcessMapper.deleteById(wfTaskProcess);
                    log.info("开始删除的任务id:{}", wfTaskProcess.getTaskId());
                }
            });
            log.info("结束优化的任务审批设置");
        }
        return true;

    }

    @Override
    public WfTaskProcess insertWfTaskProcess(String extraId, String type, String approved, String definitionId, String deploymentId) {
        LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
        qw.eq(WfTaskProcess::getExtraId, extraId).eq(WfTaskProcess::getType, type);
        WfTaskProcess wp = wfTaskProcessMapper.selectOne(qw);
        if (wp != null) {
            wp.setApproved(approved);
            wp.setDefinitionId(definitionId);
            wp.setDeploymentId(deploymentId);
            wp.setUpdatedBy(SecurityUtils.getUsername());
            wp.setUpdatedTime(new Date());
            wfTaskProcessMapper.updateById(wp);
            return wp;
        } else {
            WfTaskProcess wfTaskProcess = new WfTaskProcess();
            wfTaskProcess.setExtraId(extraId);
            wfTaskProcess.setType(type);
            wfTaskProcess.setApproved(approved);
            extracted(definitionId, deploymentId, wfTaskProcess);
            wfTaskProcessMapper.insert(wfTaskProcess);
            return wfTaskProcess;
        }
    }

    @Override
    public boolean insertOrUpdateApprovalSet(String extraId, String type, String approved, String definitionId, String deploymentId) {
        LambdaQueryWrapper<WfApprovalSet> qw = new LambdaQueryWrapper<>();
        // 分布式任务异常场景模拟，睡10秒
//        try {
//            Thread.sleep(10000);
//        } catch (InterruptedException e) {
//            throw new RuntimeException(e);
//        }
        qw.eq(WfApprovalSet::getExtraId, extraId).eq(WfApprovalSet::getType, type);
        WfApprovalSet mas = wfApprovalSetMapper.selectOne(qw);
        if (mas != null) {
            mas.setApproved(approved);
            mas.setDefinitionId(definitionId);
            mas.setDeploymentId(deploymentId);
            mas.setUpdatedBy(SecurityUtils.getUsername());
            mas.setUpdatedTime(new Date());
            wfApprovalSetMapper.updateById(mas);
        } else {
            WfApprovalSet wfApprovalSet = new WfApprovalSet();
            wfApprovalSet.setExtraId(extraId);
            wfApprovalSet.setType(type);
            wfApprovalSet.setApproved(approved);
            wfApprovalSet.setDefinitionId(definitionId);
            wfApprovalSet.setDeploymentId(deploymentId);
            wfApprovalSet.setCreatedBy(SecurityUtils.getUsername());
            wfApprovalSet.setCreatedTime(new Date());
            wfApprovalSet.setUpdatedBy(SecurityUtils.getUsername());
            wfApprovalSet.setUpdatedTime(new Date());
            wfApprovalSetMapper.insert(wfApprovalSet);
        }

        return true;
    }

    @Override
    public List<WfMaterialsScrappedProcess> insertScrappedProcess(List<String> ids, MaterialsApprovalSetVO materialsApprovalSetVO) {
        List<WfMaterialsScrappedProcess> list = new ArrayList<>(10);
        if (CollectionUtils.isNotEmpty(ids)) {
            ids.forEach(id -> {
                WfMaterialsScrappedProcess wfMaterialsScrappedProcess = new WfMaterialsScrappedProcess();
                wfMaterialsScrappedProcess.setMaterialId(id);
//                wfMaterialsScrappedProcess.setType(materialsApprovalSetVO.getType());
//                wfMaterialsScrappedProcess.setApproved(materialsApprovalSetVO.getApproved());
//                wfMaterialsScrappedProcess.setDefinitionId(materialsApprovalSetVO.getDefinitionId());
//                wfMaterialsScrappedProcess.setDeploymentId(materialsApprovalSetVO.getDeploymentId());
                wfMaterialsScrappedProcess.setCreatedBy(SecurityUtils.getUsername());
                wfMaterialsScrappedProcess.setCreatedTime(new Date());
                wfMaterialsScrappedProcess.setUpdatedBy(SecurityUtils.getUsername());
                wfMaterialsScrappedProcess.setUpdatedTime(new Date());
                wfMaterialsScrappedProcessMapper.insert(wfMaterialsScrappedProcess);
                list.add(wfMaterialsScrappedProcess);
            });
        }
        return list;
    }

    @Override
    public List<WfTaskProcess> selectList(List<String> taskId) {
        // 查询是否存在关联关系
        LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
        qw.in(WfTaskProcess::getExtraId, taskId);
        return wfTaskProcessMapper.selectList(qw);
    }

    @Override
    public List<WfTaskProcess> selectWfTaskProcessList(List<String> extraId, String type) {
        List<WfTaskProcess> list = new ArrayList<>(10);
        if (CollectionUtils.isNotEmpty(extraId)) {
            LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
            qw.in(WfTaskProcess::getExtraId, extraId).eq(WfTaskProcess::getType, type);
            list = wfTaskProcessMapper.selectList(qw);
        }
        return list;
    }

    @Override
    public void updateProviderApproval(String providerId) {
        LambdaQueryWrapper<WfTaskProcess> qw = new LambdaQueryWrapper<>();
        qw.eq(WfTaskProcess::getExtraId, providerId);
        WfTaskProcess wfTaskProcess = wfTaskProcessMapper.selectOne(qw);
        wfTaskProcess.setTaskId(null);
        wfTaskProcess.setInstanceId(null);
        wfTaskProcess.setUpdatedBy(SecurityUtils.getUsername());
        wfTaskProcess.setUpdatedTime(new Date());
        wfTaskProcessMapper.updateById(wfTaskProcess);
    }

    @Override
    public List<WfMaterialsScrappedProcess> selectScrappedList(List<String> ids) {
        List<WfMaterialsScrappedProcess> list = new ArrayList<>(10);
        if (CollectionUtils.isNotEmpty(ids)) {
            LambdaQueryWrapper<WfMaterialsScrappedProcess> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.in(WfMaterialsScrappedProcess::getMaterialId, ids);
            list = wfMaterialsScrappedProcessMapper.selectList(queryWrapper);
        }
        return list;
    }

    private void extracted(String definitionId, String deploymentId, WfTaskProcess wfTaskProcess) {
        wfTaskProcess.setDefinitionId(definitionId);
        wfTaskProcess.setDeploymentId(deploymentId);
        wfTaskProcess.setCreatedBy(SecurityUtils.getUsername());
        wfTaskProcess.setCreatedTime(new Date());
        wfTaskProcess.setUpdatedBy(SecurityUtils.getUsername());
        wfTaskProcess.setUpdatedTime(new Date());
    }
}
