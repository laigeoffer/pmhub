package com.laigeoffer.projectaihub.workflow.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.laigeoffer.projectaihub.common.mapper.BaseMapperPlus;
import com.laigeoffer.projectaihub.workflow.domain.vo.WfFormVo;
import com.laigeoffer.projectaihub.workflow.domain.WfForm;
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
