package com.laigeoffer.projectaihub.project.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.laigeoffer.projectaihub.common.core.domain.entity.SysUser;
import com.laigeoffer.projectaihub.project.domain.ProjectMember;
import com.laigeoffer.projectaihub.project.domain.vo.project.member.ProjectMemberReqVO;
import com.laigeoffer.projectaihub.project.domain.vo.project.member.ProjectMemberResVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author canghe
 * @date 2022-12-12 14:29
 */
public interface ProjectMemberMapper extends BaseMapper<ProjectMember> {

    List<ProjectMemberResVO> searchMember(@Param("data") ProjectMemberReqVO projectMemberReqVO);
    /**
     * 根据昵称或邮箱模糊查询用户
     * @param keyword
     * @return
     */
    List<ProjectMemberResVO> queryUserList(@Param("keyword") String keyword);

    List<SysUser> selectUserById(@Param("userIdList") List<Long> userId);
    List<SysUser> selectUserByUsername(@Param("usernameList") List<String> usernameList);
    List<ProjectMemberResVO> queryExecutorList(@Param("projectId") String projectId);
    List<ProjectMemberResVO> queryTaskUserList(@Param("taskId") String taskId);
}
