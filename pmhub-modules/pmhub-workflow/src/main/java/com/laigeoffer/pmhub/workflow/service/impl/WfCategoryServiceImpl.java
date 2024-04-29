package com.laigeoffer.pmhub.workflow.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.laigeoffer.pmhub.base.core.constant.UserConstants;
import com.laigeoffer.pmhub.base.core.core.domain.PageQuery;
import com.laigeoffer.pmhub.base.core.core.page.Table2DataInfo;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.domain.WfCategory;
import com.laigeoffer.pmhub.workflow.domain.bo.WfCategoryBo;
import com.laigeoffer.pmhub.workflow.domain.vo.WfCategoryVo;
import com.laigeoffer.pmhub.workflow.factory.FlowServiceFactory;
import com.laigeoffer.pmhub.workflow.mapper.WfCategoryMapper;
import com.laigeoffer.pmhub.workflow.service.IWfCategoryService;
import lombok.RequiredArgsConstructor;
import org.apache.commons.collections4.CollectionUtils;
import org.flowable.engine.repository.ModelQuery;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 流程分类Service业务层处理
 *
 * @author canghe
 * @date 2022-01-15
 */
@RequiredArgsConstructor
@Service
public class WfCategoryServiceImpl extends FlowServiceFactory implements IWfCategoryService {

    private final WfCategoryMapper baseMapper;

    @Override
    public WfCategoryVo queryById(Long categoryId){
        return baseMapper.selectVoById(categoryId);
    }

    @Override
    public Table2DataInfo<WfCategoryVo> queryPageList(WfCategoryBo categoryBo, PageQuery pageQuery) {
        LambdaQueryWrapper<WfCategory> lqw = buildQueryWrapper(categoryBo);
        Page<WfCategoryVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return Table2DataInfo.build(result);
    }

    @Override
    public List<WfCategoryVo> queryList(WfCategoryBo categoryBo) {
        LambdaQueryWrapper<WfCategory> lqw = buildQueryWrapper(categoryBo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<WfCategory> buildQueryWrapper(WfCategoryBo categoryBo) {
        Map<String, Object> params = categoryBo.getParams();
        LambdaQueryWrapper<WfCategory> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.isNotBlank(categoryBo.getCategoryName()), WfCategory::getCategoryName, categoryBo.getCategoryName());
        lqw.eq(StringUtils.isNotBlank(categoryBo.getCode()), WfCategory::getCode, categoryBo.getCode());
        return lqw;
    }

    @Override
    public int insertCategory(WfCategoryBo categoryBo) {
        WfCategory add = BeanUtil.toBean(categoryBo, WfCategory.class);
        return baseMapper.insert(add);
    }

    @Override
    public int updateCategory(WfCategoryBo categoryBo) {
        WfCategory update = BeanUtil.toBean(categoryBo, WfCategory.class);
        return baseMapper.updateById(update);
    }

    @Override
    public int deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if(isValid){
            if (CollectionUtils.isNotEmpty(ids)) {
                List<WfCategory> wfCategories = baseMapper.selectBatchIds(ids);
                List<String> codes = wfCategories.stream().map(WfCategory::getCode).distinct().collect(Collectors.toList());
                ModelQuery modelQuery = repositoryService.createModelQuery().latestVersion().orderByCreateTime().desc();
                List<String> errorIds = new ArrayList<>(10);
                codes.forEach(code -> {
                    if (modelQuery.modelCategory(code).count() > 0L) {
                        errorIds.add(code);
                    }
                });
                if (CollectionUtils.isNotEmpty(errorIds)) {
                    throw new ServiceException("分类编码[" + String.join(",", errorIds) + "]" + "存在流程模型，不允许删除");
                }
            }
        }
        return baseMapper.deleteBatchIds(ids);
    }

    /**
     * 校验分类编码是否唯一
     *
     * @param code 分类编码
     * @return 结果
     */
    @Override
    public String checkCategoryCodeUnique(String code) {
        List<WfCategory> wfCategories = baseMapper.selectList(new LambdaQueryWrapper<WfCategory>().eq(WfCategory::getCode, code));
        if (wfCategories.size() >= 1) {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }
}
