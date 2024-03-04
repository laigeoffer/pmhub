package com.laigeoffer.pmhub.workflow.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.update.LambdaUpdateChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laigeoffer.pmhub.common.core.domain.PageQuery;
import com.laigeoffer.pmhub.common.core.page.Table2DataInfo;
import com.laigeoffer.pmhub.common.exception.ServiceException;
import com.laigeoffer.pmhub.common.utils.JsonUtils;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import com.laigeoffer.pmhub.common.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.common.constant.ProcessConstants;
import com.laigeoffer.pmhub.workflow.common.enums.FormType;
import com.laigeoffer.pmhub.workflow.domain.MaterialsApprovalSet;
import com.laigeoffer.pmhub.workflow.domain.WfMaterialsScrappedProcess;
import com.laigeoffer.pmhub.workflow.domain.WfModelDeploy;
import com.laigeoffer.pmhub.workflow.domain.WfTaskProcess;
import com.laigeoffer.pmhub.workflow.domain.bo.WfModelBo;
import com.laigeoffer.pmhub.workflow.domain.dto.WfMetaInfoDto;
import com.laigeoffer.pmhub.workflow.domain.vo.WfFormVo;
import com.laigeoffer.pmhub.workflow.domain.vo.WfModelResVO;
import com.laigeoffer.pmhub.workflow.domain.vo.WfModelVo;
import com.laigeoffer.pmhub.workflow.factory.FlowServiceFactory;
import com.laigeoffer.pmhub.workflow.mapper.MaterialsApprovalSetMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfMaterialsScrappedProcessMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfModelDeployMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfTaskProcessMapper;
import com.laigeoffer.pmhub.workflow.service.IWfDeployFormService;
import com.laigeoffer.pmhub.workflow.service.IWfFormService;
import com.laigeoffer.pmhub.workflow.service.IWfModelService;
import com.laigeoffer.pmhub.workflow.utils.ModelUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.StartEvent;
import org.flowable.engine.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * @author canghe
 * @createTime 2022/6/21 9:11
 */
@RequiredArgsConstructor
@Service
@Slf4j
public class WfModelServiceImpl extends FlowServiceFactory implements IWfModelService {

    private final IWfFormService formService;
    private final IWfDeployFormService deployFormService;
    private final WfModelDeployMapper wfModelDeployMapper;
    private final WfTaskProcessMapper wfTaskProcessMapper;
    private final WfMaterialsScrappedProcessMapper wfMaterialsScrappedProcessMapper;
    private final MaterialsApprovalSetMapper materialsApprovalSetMapper;

    @Override
    public Table2DataInfo<WfModelVo> list(WfModelBo modelBo, PageQuery pageQuery) {
        ModelQuery modelQuery = repositoryService.createModelQuery().latestVersion().orderByCreateTime().desc();
        // 构建查询条件
        if (StringUtils.isNotBlank(modelBo.getModelKey())) {
            modelQuery.modelKey(modelBo.getModelKey());
        }
        if (StringUtils.isNotBlank(modelBo.getModelName())) {
            modelQuery.modelNameLike("%" + modelBo.getModelName() + "%");
        }
        if (StringUtils.isNotBlank(modelBo.getCategory())) {
            modelQuery.modelCategory(modelBo.getCategory());
        }
        // 执行查询
        long pageTotal = modelQuery.count();
        if (pageTotal <= 0) {
            return Table2DataInfo.build();
        }
        int offset = pageQuery.getPageSize() * (pageQuery.getPageNum() - 1);
        List<Model> modelList = modelQuery.listPage(offset, pageQuery.getPageSize());
        List<WfModelVo> modelVoList = new ArrayList<>(modelList.size());
        modelList.forEach(model -> {
            WfModelVo modelVo = new WfModelVo();
            modelVo.setModelId(model.getId());
            modelVo.setModelName(model.getName());
            modelVo.setModelKey(model.getKey());
            modelVo.setCategory(model.getCategory());
            modelVo.setCreateTime(model.getCreateTime());
            modelVo.setVersion(model.getVersion());
            WfMetaInfoDto metaInfo = JsonUtils.parseObject(model.getMetaInfo(), WfMetaInfoDto.class);
            if (metaInfo != null) {
                modelVo.setDescription(metaInfo.getDescription());
                modelVo.setFormType(metaInfo.getFormType());
                modelVo.setFormId(metaInfo.getFormId());
            }
            modelVoList.add(modelVo);
        });
        modelVoList.forEach(a -> {
            LambdaQueryWrapper<WfModelDeploy> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(WfModelDeploy::getModelId, a.getModelId());
            WfModelDeploy wfModelDeploy = wfModelDeployMapper.selectOne(queryWrapper);
            if (wfModelDeploy != null) {
                a.setDeployed(wfModelDeploy.getDeployed() == 1);
            } else {
                List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().processDefinitionKey(a.getModelKey()).list();
                a.setDeployed(CollectionUtils.isNotEmpty(list));
            }
        });

        Page<WfModelVo> page = new Page<>();
        page.setRecords(modelVoList);
        page.setTotal(pageTotal);
        return Table2DataInfo.build(page);
    }

    @Override
    public List<WfModelVo> list(WfModelBo modelBo) {
        ModelQuery modelQuery = repositoryService.createModelQuery().latestVersion().orderByCreateTime().desc();
        // 构建查询条件
        if (StringUtils.isNotBlank(modelBo.getModelKey())) {
            modelQuery.modelKey(modelBo.getModelKey());
        }
        if (StringUtils.isNotBlank(modelBo.getModelName())) {
            modelQuery.modelNameLike("%" + modelBo.getModelName() + "%");
        }
        if (StringUtils.isNotBlank(modelBo.getCategory())) {
            modelQuery.modelCategory(modelBo.getCategory());
        }
        List<Model> modelList = modelQuery.list();
        List<WfModelVo> modelVoList = new ArrayList<>(modelList.size());
        modelList.forEach(model -> {
            WfModelVo modelVo = new WfModelVo();
            modelVo.setModelId(model.getId());
            modelVo.setModelName(model.getName());
            modelVo.setModelKey(model.getKey());
            modelVo.setCategory(model.getCategory());
            modelVo.setCreateTime(model.getCreateTime());
            modelVo.setVersion(model.getVersion());
            WfMetaInfoDto metaInfo = JsonUtils.parseObject(model.getMetaInfo(), WfMetaInfoDto.class);
            if (metaInfo != null) {
                modelVo.setDescription(metaInfo.getDescription());
                modelVo.setFormType(metaInfo.getFormType());
                modelVo.setFormId(metaInfo.getFormId());
            }
            modelVoList.add(modelVo);
        });
        return modelVoList;
    }

    @Override
    public Table2DataInfo<WfModelVo> historyList(WfModelBo modelBo, PageQuery pageQuery) {
        ModelQuery modelQuery = repositoryService.createModelQuery()
            .modelKey(modelBo.getModelKey())
            .orderByModelVersion()
            .desc();
        // 执行查询（不显示最新版，-1）
        long pageTotal = modelQuery.count() - 1;
        if (pageTotal <= 0) {
            return Table2DataInfo.build();
        }
        // offset+1，去掉最新版
        int offset = 1 + pageQuery.getPageSize() * (pageQuery.getPageNum() - 1);
        List<Model> modelList = modelQuery.listPage(offset, pageQuery.getPageSize());
        List<WfModelVo> modelVoList = new ArrayList<>(modelList.size());
        modelList.forEach(model -> {
            WfModelVo modelVo = new WfModelVo();
            modelVo.setModelId(model.getId());
            modelVo.setModelName(model.getName());
            modelVo.setModelKey(model.getKey());
            modelVo.setCategory(model.getCategory());
            modelVo.setCreateTime(model.getCreateTime());
            modelVo.setVersion(model.getVersion());
            WfMetaInfoDto metaInfo = JsonUtils.parseObject(model.getMetaInfo(), WfMetaInfoDto.class);
            if (metaInfo != null) {
                modelVo.setDescription(metaInfo.getDescription());
                modelVo.setFormType(metaInfo.getFormType());
                modelVo.setFormId(metaInfo.getFormId());
            }
            modelVoList.add(modelVo);
        });
        Page<WfModelVo> page = new Page<>();
        page.setRecords(modelVoList);
        page.setTotal(pageTotal);
        return Table2DataInfo.build(page);
    }

    @Override
    public WfModelVo getModel(String modelId) {
        // 获取流程模型
        Model model = repositoryService.getModel(modelId);
        if (ObjectUtil.isNull(model)) {
            throw new RuntimeException("流程模型不存在！");
        }
        // 获取流程图
        String bpmnXml = queryBpmnXmlById(modelId);
        WfModelVo modelVo = new WfModelVo();
        modelVo.setModelId(model.getId());
        modelVo.setModelName(model.getName());
        modelVo.setModelKey(model.getKey());
        modelVo.setCategory(model.getCategory());
        modelVo.setCreateTime(model.getCreateTime());
        modelVo.setVersion(model.getVersion());
        modelVo.setBpmnXml(bpmnXml);
        WfMetaInfoDto metaInfo = JsonUtils.parseObject(model.getMetaInfo(), WfMetaInfoDto.class);
        if (metaInfo != null) {
            modelVo.setDescription(metaInfo.getDescription());
            modelVo.setFormType(metaInfo.getFormType());
            modelVo.setFormId(metaInfo.getFormId());
            if (FormType.PROCESS.getType().equals(metaInfo.getFormType())) {
                WfFormVo wfFormVo = formService.queryById(metaInfo.getFormId());
                modelVo.setContent(wfFormVo.getContent());
            }
        }
        return modelVo;
    }

    @Override
    public String queryBpmnXmlById(String modelId) {
        byte[] bpmnBytes = repositoryService.getModelEditorSource(modelId);
        return StrUtil.utf8Str(bpmnBytes);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public WfModelResVO insertModel(WfModelBo modelBo) {
        Model model = repositoryService.newModel();
        model.setName(modelBo.getModelName());
        model.setKey(modelBo.getModelKey());
        model.setCategory(modelBo.getCategory());
        WfMetaInfoDto wfMetaInfoDto = new WfMetaInfoDto();
        wfMetaInfoDto.setCreateUser(SecurityUtils.getUsername());
        String metaInfo = buildMetaInfo(wfMetaInfoDto, modelBo.getDescription());
        model.setMetaInfo(metaInfo);
        // 保存流程模型
        repositoryService.saveModel(model);
        // 初始化开始节点
        BpmnModel bpmnModel = ModelUtils.getBpmnModel(ModelUtils.buildBpmnXml(modelBo.getModelKey(), modelBo.getModelName(), modelBo.getCategory()));
        repositoryService.addModelEditorSource(model.getId(), ModelUtils.getBpmnXml(bpmnModel));
        // 新增模型部署关联 判断是否部署
        insertOrUpdate(model.getId(), 0);
        // 返回流程模型信息
        WfModelResVO wfModelResVO = new WfModelResVO();
        wfModelResVO.setModelId(model.getId());
        wfModelResVO.setModelKey(modelBo.getModelKey());
        wfModelResVO.setModelName(modelBo.getModelName());
        wfModelResVO.setDescription(modelBo.getDescription());
        wfModelResVO.setCategory(modelBo.getCategory());
        wfModelResVO.setCreateTime(model.getCreateTime());
        wfModelResVO.setVersion(model.getVersion());

        return wfModelResVO;
    }

    /**
     * 新增模型部署关联 判断是否部署
     * @param modelId
     */
    private void insertOrUpdate(String modelId, Integer deployed) {
        LambdaQueryWrapper<WfModelDeploy> qw = new LambdaQueryWrapper<>();
        qw.eq(WfModelDeploy::getModelId, modelId);
        WfModelDeploy wfModelDeploy = wfModelDeployMapper.selectOne(qw);
        if (wfModelDeploy == null) {
            // 新增
            WfModelDeploy wd = new WfModelDeploy();
            wd.setModelId(modelId);
            wd.setDeployed(deployed);
            wd.setCreatedBy(SecurityUtils.getUsername());
            wd.setCreatedTime(new Date());
            wd.setUpdatedBy(SecurityUtils.getUsername());
            wd.setUpdatedTime(new Date());
            wfModelDeployMapper.insert(wd);

        } else {
            // 更新
            wfModelDeploy.setDeployed(deployed);
            wfModelDeploy.setUpdatedBy(SecurityUtils.getUsername());
            wfModelDeploy.setUpdatedTime(new Date());
            wfModelDeployMapper.updateById(wfModelDeploy);
        }
    }

    @Override
    public void updateModel(WfModelBo modelBo) {
        // 根据模型Key查询模型信息
        Model model = repositoryService.getModel(modelBo.getModelId());
        if (ObjectUtil.isNull(model)) {
            throw new RuntimeException("流程模型不存在！");
        }
        model.setCategory(modelBo.getCategory());
        WfMetaInfoDto metaInfoDto = JsonUtils.parseObject(model.getMetaInfo(), WfMetaInfoDto.class);
        String metaInfo = buildMetaInfo(metaInfoDto, modelBo.getDescription());
        model.setMetaInfo(metaInfo);
        // 保存流程模型
        repositoryService.saveModel(model);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveModel(WfModelBo modelBo) {
        // 查询模型信息
        Model model = repositoryService.getModel(modelBo.getModelId());
        if (ObjectUtil.isNull(model)) {
            throw new RuntimeException("流程模型不存在！");
        }
        BpmnModel bpmnModel = ModelUtils.getBpmnModel(modelBo.getBpmnXml());
        if (ObjectUtil.isEmpty(bpmnModel)) {
            throw new RuntimeException("获取模型设计失败！");
        }
        String processName = bpmnModel.getMainProcess().getName();
        // 获取开始节点
        StartEvent startEvent = ModelUtils.getStartEvent(bpmnModel);
        if (ObjectUtil.isNull(startEvent)) {
            throw new RuntimeException("开始节点不存在，请检查流程设计是否有误！");
        }
        // 获取开始节点配置的表单Key
        if (StrUtil.isBlank(startEvent.getFormKey())) {
            throw new RuntimeException("请配置流程表单");
        }
        Model newModel;
        if (Boolean.TRUE.equals(modelBo.getNewVersion())) {
            newModel = repositoryService.newModel();
            newModel.setName(processName);
            newModel.setKey(model.getKey());
            newModel.setCategory(model.getCategory());
            newModel.setMetaInfo(model.getMetaInfo());
            newModel.setVersion(model.getVersion() + 1);
        } else {
            newModel = model;
            // 设置流程名称
            newModel.setName(processName);
        }
        // 保存流程模型
        repositoryService.saveModel(newModel);
        // 保存 BPMN XML
        repositoryService.addModelEditorSource(newModel.getId(), ModelUtils.getBpmnXml(bpmnModel));
        // 新增模型部署关联 判断是否部署
        insertOrUpdate(newModel.getId(), 0);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void latestModel(String modelId) {
        // 获取流程模型
        Model model = repositoryService.getModel(modelId);
        if (ObjectUtil.isNull(model)) {
            throw new RuntimeException("流程模型不存在！");
        }
        String bpmnXml = queryBpmnXmlById(modelId);
        Integer latestVersion = repositoryService.createModelQuery()
            .modelKey(model.getKey())
            .latestVersion()
            .singleResult()
            .getVersion();
        if (model.getVersion().equals(latestVersion)) {
            throw new RuntimeException("当前版本已是最新版！");
        }
        Model newModel = repositoryService.newModel();
        newModel.setName(model.getName());
        newModel.setKey(model.getKey());
        newModel.setCategory(model.getCategory());
        newModel.setMetaInfo(model.getMetaInfo());
        newModel.setVersion(latestVersion + 1);
        // 保存流程模型
        repositoryService.saveModel(newModel);
        // 保存 BPMN XML
        repositoryService.addModelEditorSource(newModel.getId(), StrUtil.utf8Bytes(bpmnXml));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteByIds(Collection<String> ids) {
        List<String> errorIds = new ArrayList<>(10);
        ids.forEach(id -> {
            Model model = repositoryService.getModel(id);
            if (ObjectUtil.isNull(model)) {
                throw new RuntimeException("流程模型不存在！");
            }
            long count = repositoryService.createProcessDefinitionQuery().processDefinitionKey(model.getKey()).count();

            if (count > 0L) {
                errorIds.add(model.getKey());
            }
            if (CollectionUtils.isNotEmpty(errorIds)) {
                throw new ServiceException("模型标识[" + String.join(",", errorIds) + "]" + "存在历史部署版本的流程模型，不允许删除");
            }
            repositoryService.deleteModel(id);
        });
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deployModel(String modelId) {
        // 获取流程模型
        Model model = repositoryService.getModel(modelId);
        if (ObjectUtil.isNull(model)) {
            throw new RuntimeException("流程模型不存在！");
        }
        // 获取流程图
        String bpmnXml = queryBpmnXmlById(modelId);
        BpmnModel bpmnModel = ModelUtils.getBpmnModel(bpmnXml);
        String processName = model.getName() + ProcessConstants.SUFFIX;
        // 部署流程
        Deployment deployment = repositoryService.createDeployment()
            .name(model.getName())
            .key(model.getKey())
            .addBpmnModel(processName, bpmnModel)
            .category(model.getCategory())
            .deploy();
        // 已部署
        insertOrUpdate(modelId, 1);
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey(model.getKey())
                .latestVersion().singleResult();
        // 更新审批设置
        LambdaUpdateChainWrapper<WfTaskProcess> wfTaskProcess = new LambdaUpdateChainWrapper<>(wfTaskProcessMapper);
        wfTaskProcess.likeRight(WfTaskProcess::getDefinitionId, model.getKey()).eq(WfTaskProcess::getApproved, 0)
                .isNull(WfTaskProcess::getInstanceId)
                .set(WfTaskProcess::getDefinitionId, processDefinition.getId())
                .set(WfTaskProcess::getDeploymentId, processDefinition.getDeploymentId());
        wfTaskProcess.update();
        LambdaUpdateChainWrapper<MaterialsApprovalSet> materialsApprovalSet = new LambdaUpdateChainWrapper<>(materialsApprovalSetMapper);
        materialsApprovalSet.likeRight(MaterialsApprovalSet::getDefinitionId, model.getKey())
                .set(MaterialsApprovalSet::getDefinitionId, processDefinition.getId())
                .set(MaterialsApprovalSet::getDeploymentId, processDefinition.getDeploymentId());
        materialsApprovalSet.update();
        LambdaUpdateChainWrapper<WfMaterialsScrappedProcess> wfMaterialsScrappedProcess = new LambdaUpdateChainWrapper<>(wfMaterialsScrappedProcessMapper);
        wfMaterialsScrappedProcess.likeRight(WfMaterialsScrappedProcess::getDefinitionId, model.getKey()).eq(WfMaterialsScrappedProcess::getApproved, 0)
                .isNull(WfMaterialsScrappedProcess::getInstanceId)
                .set(WfMaterialsScrappedProcess::getDefinitionId, processDefinition.getId())
                .set(WfMaterialsScrappedProcess::getDeploymentId, processDefinition.getDeploymentId());
        wfMaterialsScrappedProcess.update();
        // 保存部署表单
        return deployFormService.saveInternalDeployForm(deployment.getId(), bpmnModel);
    }

    /**
     * 构建模型扩展信息
     * @return
     */
    private String buildMetaInfo(WfMetaInfoDto metaInfo, String description) {
        // 只有非空，才进行设置，避免更新时的覆盖
        if (StringUtils.isNotEmpty(description)) {
            metaInfo.setDescription(description);
        }
        if (StringUtils.isNotEmpty(metaInfo.getCreateUser())) {
            metaInfo.setCreateUser(SecurityUtils.getUsername());
        }
        return JsonUtils.toJsonString(metaInfo);
    }
}
