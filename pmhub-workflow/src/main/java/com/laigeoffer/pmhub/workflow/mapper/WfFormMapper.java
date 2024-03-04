package com.laigeoffer.pmhub.workflow.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.laigeoffer.pmhub.common.mapper.BaseMapperPlus;
import com.laigeoffer.pmhub.workflow.domain.WfForm;
import com.laigeoffer.pmhub.workflow.domain.vo.WfFormVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 流程表单Mapper接口
 *
 * @author canghe
 * @createTime 2022/3/7 22:07
 */
public interface WfFormMapper extends BaseMapperPlus<WfFormMapper, WfForm, WfFormVo> {

    List<WfFormVo> selectFormVoList(@Param(Constants.WRAPPER) Wrapper<WfForm> queryWrapper);
}
