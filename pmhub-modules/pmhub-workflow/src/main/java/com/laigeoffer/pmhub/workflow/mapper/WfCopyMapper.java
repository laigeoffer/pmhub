package com.laigeoffer.pmhub.workflow.mapper;

import com.laigeoffer.pmhub.base.core.core.domain.entity.SysDept;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysRole;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.mapper.BaseMapperPlus;
import com.laigeoffer.pmhub.workflow.domain.WfCopy;
import com.laigeoffer.pmhub.workflow.domain.vo.WfCopyVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 流程抄送Mapper接口
 *
 * @author canghe
 * @date 2022-05-19
 */
@Mapper
public interface WfCopyMapper extends BaseMapperPlus<WfCopyMapper, WfCopy, WfCopyVo> {

    SysUser selectUserById(@Param("userId") Long userId);
    SysRole selectRoleById(@Param("roleId") Long roleId);
    SysDept selectDeptById(@Param("deptId") Long deptId);
    List<Long> selectUserIdsByRoleId(@Param("roleId") Long roleId);
    List<Long> selectUserIds(@Param("deptIds") List<String> deptIds);

}
