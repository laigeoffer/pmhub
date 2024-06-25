package com.laigeoffer.pmhub.project.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.pmhub.api.system.UserFeignService;
import com.laigeoffer.pmhub.api.system.domain.dto.SysUserDTO;
import com.laigeoffer.pmhub.base.core.constant.SecurityConstants;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.core.domain.vo.SysUserVO;
import com.laigeoffer.pmhub.base.core.enums.ProjectTaskPriorityEnum;
import com.laigeoffer.pmhub.base.core.enums.ProjectTaskStatusEnum;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.project.domain.Project;
import com.laigeoffer.pmhub.project.domain.ProjectLog;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.LogVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.ProjectLogVO;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskExportVO;
import com.laigeoffer.pmhub.project.mapper.ProjectLogMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectMemberMapper;
import com.laigeoffer.pmhub.project.service.ProjectLogService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author canghe
 * @date 2022-12-21 11:41
 */
@Service
public class ProjectLogServiceImpl extends ServiceImpl<ProjectLogMapper, ProjectLog> implements ProjectLogService {

    @Autowired
    private ProjectMapper projectMapper;
    @Autowired
    private ProjectMemberMapper projectMemberMapper;
    @Autowired
    private ProjectLogMapper projectLogMapper;
    @Resource
    private UserFeignService userFeignService;

    @Transactional(rollbackFor = Exception.class)
    public void run(LogVO logVO) {
        ProjectLog projectLog = new ProjectLog();
        // project task
        projectLog.setType(logVO.getType());
        projectLog.setPtId(logVO.getPtId());
        projectLog.setOperateType(logVO.getOperateType());
        projectLog.setUserId(logVO.getUserId());
        projectLog.setLogType(logVO.getLogType());
        projectLog.setToUserId(logVO.getToUserId());
        projectLog.setProjectId(logVO.getProjectId());
        projectLog.setCreatedBy(logVO.getCreatedBy());
        projectLog.setCreatedTime(logVO.getCreatedTime());
        projectLog.setUpdatedBy(logVO.getUpdatedBy());
        projectLog.setUpdatedTime(logVO.getUpdatedTime());
        projectLog.setContent(logVO.getContent());
        projectLog.setRemark(logVO.getRemark());

        Project project = projectMapper.selectById(projectLog.getPtId());
        SysUser sysUser = new SysUser();
        if (projectLog.getToUserId() != null) {
            // 根据 userIds 查询用户列表
            SysUserDTO sysUserDTO = new SysUserDTO();
            sysUserDTO.setUserIds(Collections.singletonList(projectLog.getToUserId()));
            R<List<SysUserVO>> userResult = userFeignService.listOfInner(sysUserDTO, SecurityConstants.INNER);

            if (Objects.isNull(userResult) || CollectionUtils.isEmpty(userResult.getData())) {
                throw new ServiceException("远程调用查询用户列表：" + projectLog.getToUserId() + " 失败");
            }
            List<SysUserVO> userVOList = userResult.getData();
            if (CollectionUtils.isNotEmpty(userVOList)) {
                sysUser = userVOList.get(0);
            }
        }

        String type = projectLog.getOperateType();
        if ("create".equals(type)) {
            projectLog.setRemark("创建了项目");
            projectLog.setContent(project.getProjectName());
        } else if ("edit".equals(type)) {
            projectLog.setRemark("编辑了项目");
            projectLog.setContent(project.getProjectName());
        } else if ("delete".equals(type)) {
            projectLog.setRemark("删除了项目");
            projectLog.setContent(project.getProjectName());
        } else if ("content".equals(type)) {
            projectLog.setRemark("更新了备注");
            projectLog.setContent(project.getDescription());
        } else if ("clearContent".equals(type)) {
            projectLog.setRemark("清空了备注");
        } else if ("inviteMember".equals(type)) {
            projectLog.setRemark("加入了项目");
            projectLog.setContent(sysUser.getNickName());
        } else if ("removeMember".equals(type)) {
            projectLog.setRemark("移除了成员" + sysUser.getNickName());
            projectLog.setContent(sysUser.getNickName());
        } else if ("recycle".equals(type)) {
            projectLog.setRemark("把项目移到了回收站");
        } else if ("recovery".equals(type)) {
            projectLog.setRemark("恢复了项目");
        } else if ("archive".equals(type)) {
            projectLog.setContent(project.getProjectName());
            projectLog.setRemark("归档了项目");
        } else if ("uploadProjectFile".equals(type)) {
            projectLog.setRemark("上传了项目文件");
            projectLog.setContent(logVO.getContent());
        } else if ("uploadTaskFile".equals(type)) {
            projectLog.setRemark("上传了任务交付物");
            projectLog.setContent(logVO.getContent());
        } else if ("invitePartakeTask".equals(type)) {
            projectLog.setRemark(logVO.getRemark());
            projectLog.setContent(logVO.getContent());
        }
        baseMapper.insert(projectLog);
    }

    @Override
    public PageInfo<ProjectLogVO> list(ProjectVO projectVO) {
        PageHelper.startPage(projectVO.getPageNum(), projectVO.getPageSize());
        List<ProjectLogVO> projectLogVOS = projectLogMapper.queryLogList(projectVO.getProjectId());
        if (CollectionUtils.isEmpty(projectLogVOS)) {
            return new PageInfo<>();
        }
        // 拿到userids
        List<Long> userIds = projectLogVOS.stream().map(ProjectLogVO::getUserId)
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
        projectLogVOS.forEach(a -> {

            // 设置用户信息
            SysUserVO sysUserVO = userMap.get(a.getUserId());
            if (Objects.nonNull(sysUserVO)) {
                a.setUserName(sysUserVO.getUserName());
                a.setNickName(sysUserVO.getNickName());
                a.setAvatar(sysUserVO.getAvatar());
            }
        });
        return new PageInfo<>(projectLogVOS);
    }
}
