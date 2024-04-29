package com.laigeoffer.pmhub.project.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.update.LambdaUpdateChainWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.pmhub.common.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.common.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.common.enums.LogTypeEnum;
import com.laigeoffer.pmhub.common.enums.ProjectStageEnum;
import com.laigeoffer.pmhub.common.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.common.exception.ServiceException;
import com.laigeoffer.pmhub.common.utils.DateUtils;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import com.laigeoffer.pmhub.common.utils.uuid.Seq;
import com.laigeoffer.pmhub.project.domain.*;
import com.laigeoffer.pmhub.project.domain.vo.project.*;
import com.laigeoffer.pmhub.project.domain.vo.project.log.LogVO;
import com.laigeoffer.pmhub.project.mapper.*;
import com.laigeoffer.pmhub.project.service.ProjectLogService;
import com.laigeoffer.pmhub.project.service.ProjectService;
import com.laigeoffer.pmhub.project.domain.*;
import com.laigeoffer.pmhub.project.domain.vo.project.*;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskStatisticsByDateVO;
import com.laigeoffer.pmhub.project.mapper.*;
import com.laigeoffer.pmhub.project.service.project.QueryProjectFactory;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author canghe
 * @date 2022-12-13 10:08
 */
@Service
public class ProjectServiceImpl extends ServiceImpl<ProjectMapper, Project> implements ProjectService {
    @Autowired
    private ProjectMapper projectMapper;
    @Autowired
    private ProjectTaskMapper projectTaskMapper;
    @Autowired
    private ProjectMemberMapper projectMemberMapper;
    @Autowired
    private ProjectStageMapper projectStageMapper;
    @Autowired
    private ProjectLogService projectLogService;
    @Autowired
    private ProjectCollectionMapper projectCollectionMapper;
    @Autowired
    private QueryProjectFactory queryProjectFactory;

    private final String NO_PUBLISHED_NAME = "未发布";
    private final String PUBLISHED_NAME = "已发布";
    private final String PUBLIC = "公开项目";
    private final String PRIVATE = "私有项目";

    @Override
    public List<ProjectRankVO> queryProjectRankList() {
        List<ProjectRankVO> projectRankVOList = new ArrayList<>(10);
        LoginUser loginUser = SecurityUtils.getLoginUser();
        LambdaQueryWrapper<Project> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Project::getDeleted, 0);
        List<Project> list = projectMapper.selectList(queryWrapper);
        if (CollectionUtils.isEmpty(list)) {
            return projectRankVOList;
        }
        // 对项目进度降序
        List<Project> collect = list.stream().sorted(Comparator.comparing(Project::getProjectProcess).reversed())
                .collect(Collectors.toList());
        collect.forEach(project -> {
            ProjectRankVO projectRankVO = new ProjectRankVO();
            projectRankVO.setProjectId(project.getId());
            projectRankVO.setProjectName(project.getProjectName());
            projectRankVO.setProcess(project.getProjectProcess());
            projectRankVO.setUserName(loginUser.getUsername());
            projectRankVO.setNickName(loginUser.getUser().getNickName());
            projectRankVOList.add(projectRankVO);
        });
        return projectRankVOList;
    }

    @Override
    public List<ProjectVO> queryMyProjectList() {
        List<ProjectVO> projects = projectMapper.queryMyProjectList(SecurityUtils.getUserId());
        projects.forEach( project -> {
            project.setStatusName(ProjectStatusEnum.getStatusNameByStatus(project.getStatus()));
        });
        return projects;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteProject(ProjectVO projectVO) {
        Project project = projectMapper.selectById(projectVO.getProjectId());
        LambdaQueryWrapper<ProjectTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectTask::getProjectId, project.getId()).eq(ProjectTask::getDeleted, 0);
        boolean exist = projectTaskMapper.exists(queryWrapper);
        if (exist) {
            throw new ServiceException("该项目下存在任务不允许删除");
        }
        project.setDeleted(1);
        project.setDeletedTime(new Date());
        project.setUpdatedBy(SecurityUtils.getUsername());
        project.setUpdatedTime(new Date());
        int i = projectMapper.updateById(project);
        // 添加项目日志
        LogVO logVO = new LogVO();
        logVO.setLogType(LogTypeEnum.TRENDS.getStatus());
        logVO.setOperateType("delete");
        logVO.setType(ProjectStatusEnum.PROJECT.getStatusName());
        logVO.setPtId(project.getId());
        logVO.setProjectId(project.getId());
        logVO.setUserId(SecurityUtils.getUserId());
        logVO.setCreatedBy(SecurityUtils.getUsername());
        logVO.setCreatedTime(new Date());
        logVO.setUpdatedBy(SecurityUtils.getUsername());
        logVO.setUpdatedTime(new Date());
        projectLogService.run(logVO);
        return i;
    }

    @Override
    public ProjectResVO detail(String projectId) {
        ProjectResVO detail = projectMapper.detail(projectId);
        if (StringUtils.isNotBlank(detail.getPrefix())) {
            detail.setProjectCode(detail.getPrefix());
        }
        detail.setStatusName(ProjectStatusEnum.getStatusNameByStatus(detail.getStatus()));
        if (detail.getProjectType() == 1) {
            Long userId = SecurityUtils.getUserId();
            LambdaQueryWrapper<ProjectMember> qw = new LambdaQueryWrapper<>();
            qw.eq(ProjectMember::getUserId, userId).eq(ProjectMember::getType, ProjectStatusEnum.PROJECT.getStatusName())
                    .eq(ProjectMember::getPtId, projectId);
            List<ProjectMember> projectMembers = projectMemberMapper.selectList(qw);
            if(CollectionUtils.isEmpty(projectMembers)) {
                throw new ServiceException("该项目为私有项目，你不是项目成员无法查看");
            }

        }
        detail.setProjectTypeName(detail.getProjectType() == 0 ? PUBLIC : PRIVATE);
        LambdaQueryWrapper<ProjectCollection> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectCollection::getUserId, detail.getUserId()).eq(ProjectCollection::getProjectId, detail.getProjectId());
        ProjectCollection projectCollection = projectCollectionMapper.selectOne(queryWrapper);
        detail.setCollected(projectCollection != null);
        detail.setPublishedName(detail.getPublished() == 0 ? NO_PUBLISHED_NAME : PUBLISHED_NAME);
        detail.setNickName(projectMemberMapper.selectUserById(Collections.singletonList(detail.getUserId())).get(0).getNickName());
        return detail;
    }

    @Override
    public List<DoingProjectVO> queryDoingProject() {
        List<DoingProjectVO> list = new ArrayList<>(10);
        LambdaQueryWrapper<Project> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Project::getStatus, ProjectStatusEnum.DOING.getStatus()).eq(Project::getDeleted, 0)
                .orderByDesc(Project::getProjectProcess);
        List<Project> projects = projectMapper.selectList(queryWrapper);

        if (CollectionUtils.isNotEmpty(projects)) {
            List<SysUser> sysUsers = projectMemberMapper.selectUserById(projects.stream().map(Project::getUserId).distinct().collect(Collectors.toList()));
            Map<Long, List<SysUser>> map = sysUsers.stream().collect(Collectors.groupingBy(SysUser::getUserId));
            projects.forEach(a -> {
                DoingProjectVO doingProjectVO = new DoingProjectVO();
                doingProjectVO.setProjectId(a.getId());
                doingProjectVO.setProjectName(a.getProjectName());
                doingProjectVO.setCover(a.getCover());
                doingProjectVO.setProcess(a.getProjectProcess());
                doingProjectVO.setUserId(a.getUserId());
                doingProjectVO.setNickName(map.get(a.getUserId()).get(0).getNickName());
                list.add(doingProjectVO);
            });

        }
        return list;
    }

    /**
     *
     * @param project
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveProject(Project project) {
       project.setProjectCode("P" + Seq.getId());
        project.setUserId(SecurityUtils.getUserId());
        project.setCreatedBy(SecurityUtils.getUsername());
        project.setCreatedTime(new Date());
        project.setUpdatedBy(SecurityUtils.getUsername());
        project.setUpdatedTime(new Date());
        projectMapper.insert(project);
        // 新增项目阶段
        for (ProjectStageEnum value : ProjectStageEnum.values()) {
            ProjectStage projectStage = new ProjectStage();
            projectStage.setProjectId(project.getId());
            projectStage.setStageCode(value.getStatus());
            projectStage.setStageName(value.getStatusName());
            projectStage.setCreatedBy(SecurityUtils.getUsername());
            projectStage.setCreatedTime(new Date());
            projectStage.setUpdatedBy(SecurityUtils.getUsername());
            projectStage.setUpdatedTime(new Date());
            projectStageMapper.insert(projectStage);
        }
        //
        LambdaQueryWrapper<ProjectStage> qw = new LambdaQueryWrapper<>();
        qw.eq(ProjectStage::getProjectId, project.getId()).eq(ProjectStage::getStageCode, ProjectStageEnum.STAGE_0.getStatus());
        project.setProjectStageId( projectStageMapper.selectOne(qw).getId());
        projectMapper.updateById(project);
        // 新增项目成员
        ProjectMember projectMember = new ProjectMember();
        projectMember.setPtId(project.getId());
        projectMember.setType(ProjectStatusEnum.PROJECT.getStatusName());
        projectMember.setUserId(SecurityUtils.getUserId());
        projectMember.setJoinedTime(new Date());
        projectMember.setCreatedTime(new Date());
        projectMember.setCreatedBy(SecurityUtils.getUsername());
        projectMember.setUpdatedBy(SecurityUtils.getUsername());
        projectMember.setUpdatedTime(new Date());
        // 是创建者
        projectMember.setCreator(1);
        projectMemberMapper.insert(projectMember);
        // 添加项目日志
        saveLog("create", project.getId(), null);
        // 邀请成员日志
        saveLog("inviteMember", project.getId(), SecurityUtils.getUserId());
    }

    /**
     * 添加日志
     * @param operateType
     * @param projectId
     * @param userId
     */
    public void saveLog(String operateType, String projectId, Long userId) {
        LogVO logVO = new LogVO();
        logVO.setLogType(LogTypeEnum.TRENDS.getStatus());
        logVO.setOperateType(operateType);
        logVO.setType(ProjectStatusEnum.PROJECT.getStatusName());
        logVO.setPtId(projectId);
        logVO.setProjectId(projectId);
        logVO.setUserId(SecurityUtils.getUserId());
        if (userId != null) {
            logVO.setToUserId(userId);
        }
        logVO.setCreatedBy(SecurityUtils.getUsername());
        logVO.setCreatedTime(new Date());
        logVO.setUpdatedBy(SecurityUtils.getUsername());
        logVO.setUpdatedTime(new Date());
        projectLogService.run(logVO);
    }

    /**
     *
     * @param projectReqVO
     * @return
     */
    @Override
    public PageInfo<ProjectResVO> list(ProjectReqVO projectReqVO) {

        PageHelper.startPage(projectReqVO.getPageNum(), projectReqVO.getPageSize());
        List<ProjectResVO> list = queryProjectFactory.execute(projectReqVO);
        if (CollectionUtils.isNotEmpty(list)) {
            List<SysUser> sysUsers = projectMemberMapper.selectUserById(list.stream().map(ProjectResVO::getUserId).distinct().collect(Collectors.toList()));
            Map<Long, List<SysUser>> map = sysUsers.stream().collect(Collectors.groupingBy(SysUser::getUserId));

            list.forEach(a -> {
                if (StringUtils.isNotBlank(a.getPrefix())) {
                    a.setProjectCode(a.getPrefix());
                }
                a.setStatusName(ProjectStatusEnum.getStatusNameByStatus(a.getStatus()));
                a.setPublishedName(a.getPublished() == 0 ? NO_PUBLISHED_NAME : PUBLISHED_NAME);
                a.setProjectTypeName(a.getProjectType() == 0 ? PUBLIC : PRIVATE);
                a.setNickName(map.get(a.getUserId()).get(0).getNickName());
                LambdaQueryWrapper<ProjectCollection> queryWrapper = new LambdaQueryWrapper<>();
                queryWrapper.eq(ProjectCollection::getUserId, SecurityUtils.getUserId()).eq(ProjectCollection::getProjectId, a.getProjectId());
                ProjectCollection projectCollection = projectCollectionMapper.selectOne(queryWrapper);
                a.setCollected(projectCollection != null);

            });
        }

        return new PageInfo<>(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void archived(String projectId) {
        // 项目是否已发布 未发布不能归档
        Project project = projectMapper.selectById(projectId);
        if (project.getPublished() == 0) {
            throw new ServiceException("项目未发布不允许归档");
        }
        LambdaUpdateChainWrapper<Project> luw = lambdaUpdate().eq(Project::getId, projectId);
        luw.set(Project::getArchived, 1).set(Project::getArchivedTime, new Date()).set(Project::getStatus, ProjectStatusEnum.ARCHIVED.getStatus());
        luw.update();
        // 添加项目日志
        LogVO logVO = new LogVO();
        logVO.setLogType(LogTypeEnum.TRENDS.getStatus());
        logVO.setOperateType("archive");
        logVO.setType(ProjectStatusEnum.PROJECT.getStatusName());
        logVO.setPtId(projectId);
        logVO.setProjectId(projectId);
        logVO.setUserId(SecurityUtils.getUserId());
        logVO.setCreatedBy(SecurityUtils.getUsername());
        logVO.setCreatedTime(new Date());
        logVO.setUpdatedBy(SecurityUtils.getUsername());
        logVO.setUpdatedTime(new Date());
        projectLogService.run(logVO);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancelArchived(String projectId) {
        LambdaUpdateChainWrapper<Project> luw = lambdaUpdate().eq(Project::getId, projectId);
        luw.set(Project::getArchived, 0).set(Project::getArchivedTime, null).set(Project::getStatus, ProjectStatusEnum.DOING.getStatus());
        luw.update();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void quit(String projectId) {
        Project project = projectMapper.selectById(projectId);
        if (SecurityUtils.getUsername().equals(project.getCreatedBy())) {
            throw new ServiceException("项目创建人不能退出");
        }
        LambdaQueryWrapper<ProjectMember> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectMember::getPtId, projectId).eq(ProjectMember::getType, ProjectStatusEnum.PROJECT.getStatusName())
                .eq(ProjectMember::getUserId, SecurityUtils.getUserId());
        projectMemberMapper.delete(queryWrapper);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void editProject(Project project) {
        // 根据项目 id 和 stageCode 查询阶段
        LambdaQueryWrapper<ProjectStage> qw = new LambdaQueryWrapper<>();
        qw.eq(ProjectStage::getProjectId, project.getProjectId()).eq(ProjectStage::getStageCode, project.getStageCode());
        project.setProjectStageId(projectStageMapper.selectOne(qw).getId());
        project.setId(project.getProjectId());
        project.setType(project.getProjectType());
        if (StringUtils.isNotBlank(project.getPrefix())) {
            project.setProjectCode(project.getPrefix());
        }

        if (Objects.equals(project.getStatus(), ProjectStatusEnum.ARCHIVED.getStatus())) {
            if (project.getPublished() == 0) {
                throw new ServiceException("项目未发布不允许归档");
            }
            project.setArchived(1);
            project.setArchivedTime(new Date());
        }
        project.setUpdatedTime(new Date());
        projectMapper.updateById(project);
        // 添加项目日志
        LogVO logVO = new LogVO();
        logVO.setLogType(LogTypeEnum.TRENDS.getStatus());
        logVO.setOperateType("edit");
        logVO.setType(ProjectStatusEnum.PROJECT.getStatusName());
        logVO.setPtId(project.getId());
        logVO.setProjectId(project.getId());
        logVO.setUserId(SecurityUtils.getUserId());
        logVO.setCreatedBy(SecurityUtils.getUsername());
        logVO.setCreatedTime(new Date());
        logVO.setUpdatedBy(SecurityUtils.getUsername());
        logVO.setUpdatedTime(new Date());
        projectLogService.run(logVO);

    }

    @Override
    public List<TaskStatisticsByDateVO> taskStatisticsByDate(String projectId) {
        List<TaskStatisticsByDateVO> list = new ArrayList<>(10);
        LambdaQueryWrapper<ProjectTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectTask::getProjectId, projectId).orderByAsc(ProjectTask::getCreatedTime);
        List<ProjectTask> projectTasks = projectTaskMapper.selectList(queryWrapper);
        if (CollectionUtils.isNotEmpty(projectTasks)) {
            projectTasks.forEach(projectTask -> projectTask.setCreatedDate(DateUtils.parseDateToStr(DateUtils.YYYY_MM_DD, projectTask.getCreatedTime())));
            Map<String, List<ProjectTask>> map = projectTasks.stream().collect(Collectors.groupingBy(ProjectTask::getCreatedDate));
            Date createdTime = projectTasks.get(0).getCreatedTime();
            String beginDate = DateUtils.dateTime(createdTime);
            String endDate = DateUtils.dateTime(new Date());
            List<String> betweenDate = DateUtils.getBetweenDate(beginDate, endDate);
            betweenDate.forEach(date -> {
                TaskStatisticsByDateVO statistics = new TaskStatisticsByDateVO();
                statistics.setDate(date);
                statistics.setTotal(CollectionUtils.isNotEmpty(map.get(date)) ? map.get(date).size() : 0);
                list.add(statistics);
            });
        }
        return list;
    }

    @Override
    public List<ProjectVO> queryAllProject() {
        List<ProjectVO> list = new ArrayList<>(10);
        // 查询未删除的项目
        LambdaQueryWrapper<Project> qw = new LambdaQueryWrapper<>();
        qw.eq(Project::getDeleted, 0);
        List<Project> projects = projectMapper.selectList(qw);
        if (CollectionUtils.isNotEmpty(projects)) {
            projects.forEach(a -> {
                ProjectVO projectVO = new ProjectVO();
                projectVO.setProjectId(a.getId());
                projectVO.setProjectName(a.getProjectName());
                projectVO.setStatus(a.getStatus());
                projectVO.setStatusName(ProjectStatusEnum.getStatusNameByStatus(a.getStatus()));
                list.add(projectVO);
            });

        }
        return list;
    }

    @Override
    public Long countProjectNum() {
        LambdaQueryWrapper<Project> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Project::getDeleted, 0);
        if (projectMapper.selectCount(queryWrapper) == null) {
            return 0L;
        }
        return  projectMapper.selectCount(queryWrapper);
    }

}
