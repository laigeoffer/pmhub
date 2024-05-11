package com.laigeoffer.pmhub.workflow.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laigeoffer.pmhub.base.core.core.domain.PageQuery;
import com.laigeoffer.pmhub.base.core.core.page.Table2DataInfo;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.domain.WfDeployForm;
import com.laigeoffer.pmhub.workflow.domain.WfForm;
import com.laigeoffer.pmhub.workflow.domain.bo.WfFormBo;
import com.laigeoffer.pmhub.workflow.domain.vo.WfFormVo;
import com.laigeoffer.pmhub.workflow.mapper.WfDeployFormMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfFormMapper;
import com.laigeoffer.pmhub.workflow.service.IWfFormService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * 流程表单Service业务层处理
 *
 * @author canghe
 * @createTime 2022/3/7 22:07
 */
@RequiredArgsConstructor
@Service
public class WfFormServiceImpl implements IWfFormService {

    private final WfFormMapper baseMapper;
    private final WfDeployFormMapper wfDeployFormMapper;

    /**
     * 查询流程表单
     *
     * @param formId 流程表单ID
     * @return 流程表单
     */
    @Override
    public WfFormVo queryById(Long formId) {
        return baseMapper.selectVoById(formId);
    }

    /**
     * 查询流程表单列表
     *
     * @param bo 流程表单
     * @return 流程表单
     */
    @Override
    public Table2DataInfo<WfFormVo> queryPageList(WfFormBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<WfForm> lqw = buildQueryWrapper(bo);
        Page<WfFormVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return Table2DataInfo.build(result);
    }

    /**
     * 查询流程表单列表
     *
     * @param bo 流程表单
     * @return 流程表单
     */
    @Override
    public List<WfFormVo> queryList(WfFormBo bo) {
        LambdaQueryWrapper<WfForm> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    /**
     * 新增流程表单
     *
     * @param bo 流程表单
     * @return 结果
     */
    @Override
    public int insertForm(WfFormBo bo) {
        WfForm wfForm = new WfForm();
        wfForm.setFormName(bo.getFormName());
        wfForm.setContent(bo.getContent());
        wfForm.setRemark(bo.getRemark());
        wfForm.setCreateBy(SecurityUtils.getUsername());
        wfForm.setCreateTime(new Date());
        wfForm.setUpdateBy(SecurityUtils.getUsername());
        wfForm.setUpdateTime(new Date());
        return baseMapper.insert(wfForm);
    }

    /**
     * 修改流程表单
     *
     * @param bo 流程表单
     * @return 结果
     */
    @Override
    public int updateForm(WfFormBo bo) {
        return baseMapper.update(new WfForm(), new LambdaUpdateWrapper<WfForm>()
            .set(StrUtil.isNotBlank(bo.getFormName()), WfForm::getFormName, bo.getFormName())
            .set(StrUtil.isNotBlank(bo.getContent()), WfForm::getContent, bo.getContent())
            .set(StrUtil.isNotBlank(bo.getRemark()), WfForm::getRemark, bo.getRemark())
            .set(WfForm::getUpdateBy, SecurityUtils.getUsername()).set(WfForm::getUpdateTime, new Date())
            .eq(WfForm::getFormId, bo.getFormId()));
    }

    /**
     * 批量删除流程表单
     *
     * @param ids 需要删除的流程表单ID
     * @return 结果
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids) {
        List<String> errorIds = new ArrayList<>(10);
        ids.forEach(id -> {
            LambdaQueryWrapper<WfDeployForm> qw = new LambdaQueryWrapper<>();
            qw.eq(WfDeployForm::getFormKey, "key_" + id);
            Long count = wfDeployFormMapper.selectCount(qw);
            if (count > 0L) {
                errorIds.add(id.toString());
            }
        });
        if (CollectionUtils.isNotEmpty(errorIds)) {
            throw new ServiceException("表单主键[" + String.join(",", errorIds) + "]" + "存在历史部署版本不允许删除");
        }
        return baseMapper.deleteBatchIds(ids) > 0;
    }

    private LambdaQueryWrapper<WfForm> buildQueryWrapper(WfFormBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<WfForm> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(bo.getFormName()), WfForm::getFormName, bo.getFormName());
        return lqw.orderByDesc(WfForm::getCreateTime);
    }
}
