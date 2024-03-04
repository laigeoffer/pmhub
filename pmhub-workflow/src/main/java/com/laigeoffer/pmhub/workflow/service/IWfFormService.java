package com.laigeoffer.pmhub.workflow.service;

import com.laigeoffer.pmhub.common.core.domain.PageQuery;
import com.laigeoffer.pmhub.common.core.page.Table2DataInfo;
import com.laigeoffer.pmhub.workflow.domain.bo.WfFormBo;
import com.laigeoffer.pmhub.workflow.domain.vo.WfFormVo;

import java.util.Collection;
import java.util.List;

/**
 * 表单
 *
 * @author canghe
 * @createTime 2022/3/7 22:07
 */
public interface IWfFormService {
    /**
     * 查询流程表单
     *
     * @param formId 流程表单ID
     * @return 流程表单
     */
    WfFormVo queryById(Long formId);

    /**
     * 查询流程表单列表
     *
     * @param bo 流程表单
     * @return 流程表单集合
     */
    Table2DataInfo<WfFormVo> queryPageList(WfFormBo bo, PageQuery pageQuery);

    /**
     * 查询流程表单列表
     *
     * @param bo 流程表单
     * @return 流程表单集合
     */
    List<WfFormVo> queryList(WfFormBo bo);

    /**
     * 新增流程表单
     *
     * @param bo 流程表单
     * @return 结果
     */
    int insertForm(WfFormBo bo);

    /**
     * 修改流程表单
     *
     * @param bo 流程表单
     * @return 结果
     */
    int updateForm(WfFormBo bo);

    /**
     * 批量删除流程表单
     *
     * @param formIds 需要删除的流程表单ID
     * @return 结果
     */
    Boolean deleteWithValidByIds(Collection<Long> formIds);
}
