package com.laigeoffer.pmhub.project.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.pmhub.common.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import com.laigeoffer.pmhub.project.domain.vo.project.member.ProjectMemberReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.member.ProjectMemberResVO;
import com.laigeoffer.pmhub.project.mapper.ProjectMemberMapper;
import com.laigeoffer.pmhub.project.domain.ProjectMember;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.service.ProjectMemberService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author canghe
 * @date 2022-12-15 14:29
 */
@Service
public class ProjectMemberServiceImpl extends ServiceImpl<ProjectMemberMapper, ProjectMember> implements ProjectMemberService {
    @Autowired
    private ProjectMemberMapper projectMemberMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void inviteMemberList(ProjectVO projectVO) {
        if (CollectionUtils.isNotEmpty(projectVO.getUserIdList())) {
            projectVO.getUserIdList().forEach(a -> {
                ProjectMember projectMember = new ProjectMember();
                projectMember.setUserId(a);
                projectMember.setPtId(projectVO.getProjectId());
                projectMember.setType(ProjectStatusEnum.PROJECT.getStatusName());
                projectMember.setJoinedTime(new Date());
                projectMember.setCreatedBy(SecurityUtils.getUsername());
                projectMember.setCreatedTime(new Date());
                projectMember.setUpdatedBy(SecurityUtils.getUsername());
                projectMember.setUpdatedTime(new Date());
                projectMemberMapper.insert(projectMember);
            });

        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeMemberList(ProjectVO projectVO) {
        LambdaQueryWrapper<ProjectMember> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectMember::getPtId, projectVO.getProjectId()).eq(ProjectMember::getType, ProjectStatusEnum.PROJECT.getStatusName())
                .in(ProjectMember::getUserId, projectVO.getUserIdList());
        projectMemberMapper.delete(queryWrapper);
    }

    @Override
    public PageInfo<ProjectMemberResVO> searchMember(ProjectMemberReqVO projectMemberReqVO) {
        PageHelper.startPage(projectMemberReqVO.getPageNum(), projectMemberReqVO.getPageSize());
        return new PageInfo<>(projectMemberMapper.searchMember(projectMemberReqVO));
    }

    @Override
    public List<ProjectMemberResVO> queryUserList(String projectId, String keyword) {
        List<ProjectMemberResVO> memberResVOList = projectMemberMapper.queryUserList(keyword);
        if (CollectionUtils.isEmpty(memberResVOList)) {
            return Collections.emptyList();
        }
        List<Long> userIds = memberResVOList.stream().map(ProjectMemberResVO::getUserId).distinct().collect(Collectors.toList());
        LambdaQueryWrapper<ProjectMember> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectMember::getPtId, projectId);
        List<ProjectMember> projectMembers = projectMemberMapper.selectList(queryWrapper);
        Map<Long, List<ProjectMember>> map = projectMembers.stream().collect(Collectors.groupingBy(ProjectMember::getUserId));
        memberResVOList.forEach(a -> {
            a.setJoined(CollectionUtils.isNotEmpty(map.get(a.getUserId())) ? 1 : 0);
        });
        return memberResVOList;
    }

    @Override
    public List<ProjectMemberResVO> queryUserListById(String projectId) {
        List<ProjectMemberResVO> list = projectMemberMapper.queryExecutorList(projectId);
        if (CollectionUtils.isEmpty(list)) {
            return Collections.emptyList();
        }
        list.forEach(a -> {
            a.setJoined(1);
        });
        return list;
    }
}
