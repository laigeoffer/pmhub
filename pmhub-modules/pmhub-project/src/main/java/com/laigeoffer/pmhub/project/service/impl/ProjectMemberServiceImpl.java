package com.laigeoffer.pmhub.project.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.pmhub.api.system.UserFeignService;
import com.laigeoffer.pmhub.api.system.domain.dto.SysUserDTO;
import com.laigeoffer.pmhub.base.core.constant.SecurityConstants;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysRole;
import com.laigeoffer.pmhub.base.core.core.domain.vo.SysUserVO;
import com.laigeoffer.pmhub.base.core.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import com.laigeoffer.pmhub.project.domain.ProjectMember;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.vo.project.member.ProjectMemberReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.member.ProjectMemberResVO;
import com.laigeoffer.pmhub.project.mapper.ProjectMemberMapper;
import com.laigeoffer.pmhub.project.service.ProjectMemberService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author canghe
 * @date 2022-12-15 14:29
 */
@Service
public class ProjectMemberServiceImpl extends ServiceImpl<ProjectMemberMapper, ProjectMember> implements ProjectMemberService {
    @Autowired
    private ProjectMemberMapper projectMemberMapper;
    @Resource
    private UserFeignService userFeignService;

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
        // 根据项目id查询项目成员
        List<ProjectMemberResVO> projectMemberResVOList = projectMemberMapper.searchMember(projectMemberReqVO);
        // 查询用户信息
        List<Long> userIds = projectMemberResVOList.stream().map(ProjectMemberResVO::getUserId).distinct().collect(Collectors.toList());
        SysUserDTO sysUserDTO = new SysUserDTO();
        sysUserDTO.setUserIds(userIds);
        R<List<SysUserVO>> userResult = userFeignService.listOfInner(sysUserDTO, SecurityConstants.INNER);

        if (Objects.isNull(userResult) || CollectionUtils.isEmpty(userResult.getData())) {
            throw new ServiceException("远程调用查询用户列表：" + userIds + " 失败");
        }
        List<SysUserVO> userVOList = userResult.getData();

        // 匹配设置值
        Map<Long, SysUserVO> userMap = userVOList.stream().collect(Collectors.toMap(SysUserVO::getUserId, a -> a));
        projectMemberResVOList.forEach(projectMemberVO -> {
            SysUserVO userVO = userMap.get(projectMemberVO.getUserId());
            if (Objects.nonNull(userVO)) {
                projectMemberVO.setNickName(userVO.getNickName());
                projectMemberVO.setDeptName(userVO.getDept().getDeptName());
                // 多个角色默认只展示一个角色
                List<SysRole> roles = userVO.getRoles();
                projectMemberVO.setRoleName(!roles.isEmpty() ? roles.get(0).getRoleName() : "超级管理员");
            }
        });

        return new PageInfo<>(projectMemberResVOList);
    }

    @Override
    public List<ProjectMemberResVO> queryUserList(String projectId, String keyword) {
        // 根据昵称模糊查询用户列表
        SysUserDTO sysUserDTO = new SysUserDTO();
        sysUserDTO.setNickName(keyword);
        R<List<SysUserVO>> userResult = userFeignService.listOfInner(sysUserDTO, SecurityConstants.INNER);

        if (Objects.isNull(userResult) || CollectionUtils.isEmpty(userResult.getData())) {
            throw new ServiceException("远程调用查询用户列表：" + keyword + " 失败");
        }
        List<SysUserVO> userVOList = userResult.getData();
        // 复制 userVOList 对象到 List<ProjectMemberResVO>
        List<ProjectMemberResVO> memberResVOList = userVOList.stream().map(userVO -> {
            ProjectMemberResVO memberResVO = new ProjectMemberResVO();

            // 手动将 SysUserVO 的字段复制到 ProjectMemberResVO（个别字段）
            memberResVO.setUserId(userVO.getUserId());
            memberResVO.setUserName(userVO.getUserName());
            memberResVO.setNickName(userVO.getNickName());
            memberResVO.setEmail(userVO.getEmail());
            return memberResVO;
        }).collect(Collectors.toList());

        if (CollectionUtils.isEmpty(memberResVOList)) {
            return Collections.emptyList();
        }
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
        // 拿到userids
        List<Long> userIds = list.stream().map(ProjectMemberResVO::getUserId)
                .distinct()
                .collect(Collectors.toList());
        SysUserDTO sysUserDTO = new SysUserDTO();
        sysUserDTO.setUserIds(userIds);
        R<List<SysUserVO>> userResult = userFeignService.listOfInner(sysUserDTO, SecurityConstants.INNER);

        if (Objects.isNull(userResult) || CollectionUtils.isEmpty(userResult.getData())) {
            throw new ServiceException("远程调用查询用户列表：" + userIds + " 失败");
        }
        List<SysUserVO> userVOList = userResult.getData();

        // 匹配设置值
        Map<Long, SysUserVO> userMap = userVOList.stream().collect(Collectors.toMap(SysUserVO::getUserId, a -> a));
        list.forEach(projectMemberResVO -> {
            SysUserVO sysUserVO = userMap.get(projectMemberResVO.getUserId());
            if (Objects.nonNull(sysUserVO)) {
                projectMemberResVO.setUserName(sysUserVO.getUserName());
                projectMemberResVO.setNickName(sysUserVO.getNickName());
                projectMemberResVO.setEmail(sysUserVO.getEmail());
                projectMemberResVO.setAvatar(sysUserVO.getAvatar());
            }
            projectMemberResVO.setJoined(1);
        });
        return list;
    }
}
