package com.laigeoffer.pmhub.project.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.pmhub.common.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.LogVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.ProjectLogVO;
import com.laigeoffer.pmhub.project.mapper.ProjectLogMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectMemberMapper;
import com.laigeoffer.pmhub.project.domain.Project;
import com.laigeoffer.pmhub.project.domain.ProjectLog;
import com.laigeoffer.pmhub.project.service.ProjectLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;

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
            sysUser = projectMemberMapper.selectUserById(Collections.singletonList(projectLog.getToUserId())).get(0);
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
        return new PageInfo<>(projectLogMapper.queryLogList(projectVO.getProjectId()));
    }
}
