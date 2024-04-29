package com.laigeoffer.pmhub.project.service.impl;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.conditions.update.LambdaUpdateChainWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.pmhub.common.config.PmhubConfig;
import com.laigeoffer.pmhub.common.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.common.enums.LogTypeEnum;
import com.laigeoffer.pmhub.common.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.common.enums.ProjectTaskPriorityEnum;
import com.laigeoffer.pmhub.common.enums.ProjectTaskStatusEnum;
import com.laigeoffer.pmhub.common.exception.ServiceException;
import com.laigeoffer.pmhub.common.utils.DateUtils;
import com.laigeoffer.pmhub.common.utils.OAUtils;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import com.laigeoffer.pmhub.common.utils.file.FileUtils;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.notice.TaskAssignRemindDTO;
import com.laigeoffer.pmhub.oa.utils.SsoUrlUtils;
import com.laigeoffer.pmhub.project.domain.*;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.*;
import com.laigeoffer.pmhub.project.domain.vo.project.member.ProjectMemberResVO;
import com.laigeoffer.pmhub.project.domain.vo.project.task.*;
import com.laigeoffer.pmhub.project.mapper.*;
import com.laigeoffer.pmhub.project.service.ProjectLogService;
import com.laigeoffer.pmhub.project.service.ProjectTaskService;
import com.laigeoffer.pmhub.project.service.task.QueryTaskLogFactory;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.rmi.ServerException;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

import static com.laigeoffer.pmhub.oa.utils.SsoUrlUtils.ssoPath;
import static com.laigeoffer.pmhub.oa.utils.wx.MessageUtils.*;

/**
 * @author canghe
 * @date 2022-12-14 15:00
 */
@Service
public class ProjectTaskServiceImpl extends ServiceImpl<ProjectTaskMapper, ProjectTask> implements ProjectTaskService {
    @Autowired
    private ProjectTaskMapper projectTaskMapper;
    @Autowired
    private ProjectMemberMapper projectMemberMapper;
    @Autowired
    private ProjectLogService projectLogService;
    @Autowired
    private ProjectMapper projectMapper;
    @Autowired
    private ProjectStageMapper projectStageMapper;
    @Autowired
    private QueryTaskLogFactory queryTaskLogFactory;
    @Autowired
    private ProjectFileMapper projectFileMapper;

    @Override
    public Long queryTodayTaskNum() {
        LambdaQueryWrapper<ProjectTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.between(ProjectTask::getBeginTime, DateTimeFormatter.ofPattern(DateUtils.YYYY_MM_DD_HH_MM_SS).format(LocalDateTime.now().with(LocalTime.MIN))
                , DateTimeFormatter.ofPattern(DateUtils.YYYY_MM_DD_HH_MM_SS).format(LocalDateTime.now().with(LocalTime.MAX))).eq(ProjectTask::getDeleted, 0);
        if (projectTaskMapper.selectCount(queryWrapper) == null) {
            return 0L;
        }
        return projectTaskMapper.selectCount(queryWrapper);

    }

    @Override
    public Long queryOverdueTaskNum() {
        LambdaQueryWrapper<ProjectTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.lt(ProjectTask::getCloseTime, DateTimeFormatter.ofPattern(DateUtils.YYYY_MM_DD_HH_MM_SS).format(LocalDateTime.now())).eq(ProjectTask::getDeleted, 0)
                .ne(ProjectTask::getExecuteStatus, ProjectTaskStatusEnum.FINISHED.getStatus());
        if (projectTaskMapper.selectCount(queryWrapper) == null) {
            return 0L;
        }
        return projectTaskMapper.selectCount(queryWrapper);
    }

    @Override
    public List<TaskStatisticsVO> queryTaskStatisticsList() {
        LambdaQueryWrapper<ProjectTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectTask::getDeleted, 0);
        List<TaskStatisticsVO> taskStatisticsVOList = new ArrayList<>(10);
        List<ProjectTask> list = projectTaskMapper.selectList(queryWrapper);
        if (CollectionUtils.isEmpty(list)) {
            for (ProjectTaskStatusEnum value : ProjectTaskStatusEnum.values()) {
                TaskStatisticsVO taskStatisticsVO = new TaskStatisticsVO();
                taskStatisticsVO.setStatus(value.getStatus());
                taskStatisticsVO.setStatusName(value.getStatusName());
                taskStatisticsVO.setTaskNum(0);
                taskStatisticsVOList.add(taskStatisticsVO);
            }
            return taskStatisticsVOList;
        } else {
            // 待认领
            TaskStatisticsVO noClaim = new TaskStatisticsVO();
            noClaim.setStatus(ProjectTaskStatusEnum.NO_CLAIMED.getStatus());
            noClaim.setStatusName(ProjectTaskStatusEnum.NO_CLAIMED.getStatusName());
            noClaim.setTaskNum((int) list.stream().filter(a -> a.getUserId() == null).count());
            taskStatisticsVOList.add(noClaim);
            // 进行中
            List<ProjectTask> doingList = list.stream().filter(a -> ProjectTaskStatusEnum.DOING.getStatus().equals(a.getStatus())).collect(Collectors.toList());
            TaskStatisticsVO doing = new TaskStatisticsVO();
            doing.setStatus(ProjectTaskStatusEnum.DOING.getStatus());
            doing.setStatusName(ProjectTaskStatusEnum.DOING.getStatusName());
            doing.setTaskNum(doingList.size());
            taskStatisticsVOList.add(doing);
            // 已完成
            List<ProjectTask> finishList = list.stream().filter(a -> ProjectTaskStatusEnum.FINISHED.getStatus().equals(a.getStatus())).collect(Collectors.toList());
            TaskStatisticsVO finish = new TaskStatisticsVO();
            finish.setStatus(ProjectTaskStatusEnum.FINISHED.getStatus());
            finish.setStatusName(ProjectTaskStatusEnum.FINISHED.getStatusName());
            finish.setTaskNum(finishList.size());
            taskStatisticsVOList.add(finish);
            // 已逾期
            List<ProjectTask> overdueList = list.stream().filter(a -> a.getCloseTime() != null && a.getCloseTime().getTime() < new Date().getTime()).collect(Collectors.toList());
            TaskStatisticsVO overdue = new TaskStatisticsVO();
            overdue.setStatus(ProjectTaskStatusEnum.OVERDUE.getStatus());
            overdue.setStatusName(ProjectTaskStatusEnum.OVERDUE.getStatusName());
            overdue.setTaskNum(overdueList.size());
            taskStatisticsVOList.add(overdue);
        }

        return taskStatisticsVOList;
    }

    @Override
    public PageInfo<TaskResVO> queryMyTaskList(TaskReqVO taskReqVO) {
        PageInfo<TaskResVO> pageInfo;
        PageHelper.startPage(taskReqVO.getPageNum(), taskReqVO.getPageSize());
        switch (taskReqVO.getType()) {
            // 我执行的
            case 1:
                pageInfo = new PageInfo<>(projectTaskMapper.queryMyExecutedTaskList(taskReqVO.getProjectId(), SecurityUtils.getUserId()));
                if (CollectionUtils.isNotEmpty(pageInfo.getList())) {
                    pageInfo.getList().forEach(a -> a.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getStatus())));
                }
                return pageInfo;
            // 我参与的
            case 2:
                pageInfo = new PageInfo<>(projectTaskMapper.queryMyPartookTaskList(taskReqVO.getProjectId(), SecurityUtils.getUserId()));
                if (CollectionUtils.isNotEmpty(pageInfo.getList())) {
                    pageInfo.getList().forEach(a -> a.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getStatus())));
                }
                return pageInfo;
            // 我创建的
            case 3:
                pageInfo = new PageInfo<>(projectTaskMapper.queryMyCreatedTaskList(taskReqVO.getProjectId(), SecurityUtils.getUsername()));
                if (CollectionUtils.isNotEmpty(pageInfo.getList())) {
                    pageInfo.getList().forEach(a -> a.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getStatus())));
                }
                return pageInfo;
        }
        return new PageInfo<>();
    }

    @Override
    public TaskStatusStatsVO queryTaskStatusStats(ProjectVO projectVO) {
        TaskStatusStatsVO taskStatusStatsVO = new TaskStatusStatsVO();
        LambdaQueryWrapper<ProjectTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectTask::getProjectId, projectVO.getProjectId());
        queryWrapper.eq(ProjectTask::getDeleted, 0);
        List<ProjectTask> projectTasks = projectTaskMapper.selectList(queryWrapper);
        if (CollectionUtils.isNotEmpty(projectTasks)) {
            taskStatusStatsVO.setTotal(projectTasks.size());
            taskStatusStatsVO.setToBeAssign((int) projectTasks.stream().filter(a -> a.getUserId() == null).count());
            taskStatusStatsVO.setUnDone((int) projectTasks.stream().filter(a -> !Objects.equals(a.getStatus(), ProjectTaskStatusEnum.FINISHED.getStatus())).count());
            taskStatusStatsVO.setDone((int) projectTasks.stream().filter(a -> Objects.equals(a.getStatus(), ProjectTaskStatusEnum.FINISHED.getStatus())).count());
            taskStatusStatsVO.setDoneOverdue((int) projectTasks.stream().filter(a -> a.getCloseTime() != null && a.getCloseTime().getTime() < new Date().getTime() && Objects.equals(a.getStatus(), ProjectTaskStatusEnum.FINISHED.getStatus())).count());
            taskStatusStatsVO.setExpireToday((int) projectTasks.stream().filter(a -> a.getCloseTime() != null && DateUtils.dateTime(new Date()).compareTo(DateUtils.dateTime(a.getCloseTime())) == 0).count());
            taskStatusStatsVO.setTimeUndetermined((int) projectTasks.stream().filter(a -> a.getEndTime() == null).count());
            taskStatusStatsVO.setOverdue((int) projectTasks.stream().filter(a -> a.getCloseTime() != null && a.getCloseTime().getTime() < new Date().getTime()).count());

        } else {
            taskStatusStatsVO.setTotal(0);
            taskStatusStatsVO.setToBeAssign(0);
            taskStatusStatsVO.setUnDone(0);
            taskStatusStatsVO.setDone(0);
            taskStatusStatsVO.setDoneOverdue(0);
            taskStatusStatsVO.setExpireToday(0);
            taskStatusStatsVO.setTimeUndetermined(0);
            taskStatusStatsVO.setOverdue(0);
        }
        return taskStatusStatsVO;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void  deleteTask(TaskIdsVO taskIdsVO) {
        LambdaUpdateChainWrapper<ProjectTask> wrapper = lambdaUpdate().in(ProjectTask::getId, taskIdsVO.getTaskIdList());
        wrapper.set(ProjectTask::getDeleted, 1).set(ProjectTask::getDeletedTime, new Date());
        wrapper.update();
    }

    @Override
    public TaskResVO detail(TaskReqVO taskReqVO) {
        TaskResVO detail = projectTaskMapper.detail(taskReqVO.getTaskId());
        detail.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(detail.getStatus()));
        detail.setExecuteStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(detail.getExecuteStatus()));
        if (detail.getUserId() != null) {
            List<SysUser> sysUsers = projectMemberMapper.selectUserById(Collections.singletonList(detail.getUserId()));
            detail.setExecutor(sysUsers.get(0).getNickName());
        }
        detail.setCreatedBy(projectMemberMapper.selectUserByUsername(Collections.singletonList(detail.getCreatedBy())).get(0).getNickName());
        detail.setTaskPriorityName(ProjectTaskPriorityEnum.getStatusNameByStatus(detail.getTaskPriority()));
        return detail;
    }

    @Override
    public List<ProjectMemberResVO> queryExecutorList(TaskReqVO taskReqVO) {
        return projectMemberMapper.queryExecutorList(taskReqVO.getProjectId());
    }

    @Override
    public PageInfo<TaskResVO> list(TaskReqVO taskReqVO) {
        PageHelper.startPage(taskReqVO.getPageNum(), taskReqVO.getPageSize());
        List<TaskResVO> list = projectTaskMapper.list(taskReqVO, SecurityUtils.getUserId());
        if (CollectionUtils.isNotEmpty(list)) {
            list.forEach(a -> {
                WorkFlowable workFlowable = new WorkFlowable();
                workFlowable.setTaskId(a.getTaskProcessId());
                workFlowable.setApproved(a.getApproved());
                workFlowable.setDeploymentId(a.getDeployId());
                workFlowable.setProcInsId(a.getProcInsId());
                workFlowable.setDefinitionId(a.getDefinitionId());
                a.setWorkFlowable(workFlowable);
                a.setTaskPriorityName(ProjectTaskPriorityEnum.getStatusNameByStatus(a.getTaskPriority()));
                a.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getStatus()));
                a.setExecuteStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getExecuteStatus()));
                if (a.getEndTime() != null && a.getBeginTime() != null) {
                    a.setPeriod(DateUtils.differentDaysByMillisecond(a.getEndTime(), a.getBeginTime()));
                }
            });
        }
        return new PageInfo<>(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String add(TaskReqVO taskReqVO) {
        if (ProjectStatusEnum.PAUSE.getStatus().equals(projectTaskMapper.queryProjectStatus(taskReqVO.getProjectId()))) {
            throw new ServiceException("归属项目已暂停，无法新增任务");
        }
        ProjectTask projectTask = new ProjectTask();
        if (StringUtils.isNotBlank(taskReqVO.getTaskId())) {
            projectTask.setTaskPid(taskReqVO.getTaskId());
        }
        BeanUtils.copyProperties(taskReqVO, projectTask);
        projectTask.setCreatedBy(SecurityUtils.getUsername());
        projectTask.setCreatedTime(new Date());
        projectTask.setUpdatedBy(SecurityUtils.getUsername());
        projectTask.setUpdatedTime(new Date());
        projectTaskMapper.insert(projectTask);
        insertMember(projectTask.getId(), 1, SecurityUtils.getUserId());
        // 添加日志
        saveLog("addTask", projectTask.getId(), taskReqVO.getProjectId(), taskReqVO.getTaskName(), "参与了任务", null);
        // 将执行人加入
        if (taskReqVO.getUserId() != null && !Objects.equals(taskReqVO.getUserId(), SecurityUtils.getUserId())) {
            insertMember(projectTask.getId(), 0, taskReqVO.getUserId());
            // 添加日志
            saveLog("invitePartakeTask", projectTask.getId(), taskReqVO.getProjectId(), taskReqVO.getTaskName(), "邀请 " + projectMemberMapper.selectUserById(Collections.singletonList(taskReqVO.getUserId())).get(0).getNickName() + " 参与任务", taskReqVO.getUserId());
        }
        // 任务指派消息提醒
        extracted(taskReqVO.getTaskName(), taskReqVO.getUserId(), SecurityUtils.getUsername(), projectTask.getId());
        return projectTask.getId();
    }

    private void extracted(String taskName, Long userId, String username, String taskId) {
        String name = projectTaskMapper.queryVxUserName(userId);
        if (StringUtils.isNotBlank(name)) {
            TaskAssignRemindDTO taskAssignRemindDTO = new TaskAssignRemindDTO();
            taskAssignRemindDTO.setTaskName(taskName);
            taskAssignRemindDTO.setUserIds(Collections.singletonList(name));
            taskAssignRemindDTO.setCreator(projectTaskMapper.queryNickName(username));
            // 设置任务详情地址
            String url = SsoUrlUtils.ssoCreate(appid, agentid, host + path + ssoPath + URLEncoder.encode(host + "/pmhub-project/my-task/info?taskId=" + taskId));
            taskAssignRemindDTO.setDetailUrl(url);
            taskAssignRemindDTO.setUserName(username);
            taskAssignRemindDTO.setOaTitle("任务指派提醒");
            taskAssignRemindDTO.setOaContext("【" + projectTaskMapper.queryNickName(username) + "】给您指派了任务【" + taskName + "】，请及时处理！");
            taskAssignRemindDTO.setLinkUrl(OAUtils.ssoCreate(host + "/pmhub-project/my-task/info?taskId=" + taskId));
            // TODO: 2024.03.03 @canghe 推送消息暂时关闭
//            RocketMqUtils.push2Wx(taskAssignRemindDTO);
        }

    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void edit(TaskReqVO taskReqVO) {
        ProjectTask oldObj = projectTaskMapper.selectById(taskReqVO.getTaskId());
        if (ProjectStatusEnum.PAUSE.getStatus().equals(projectTaskMapper.queryProjectStatus(oldObj.getProjectId()))) {
            throw new ServiceException("归属项目已暂停，无法操作任务");
        }
        if (ProjectStatusEnum.PAUSE.getStatus().equals(projectTaskMapper.queryProjectStatus(taskReqVO.getProjectId()))) {
            throw new ServiceException("该任务不能切换到已暂停的项目");
        }
        if (!Objects.equals(oldObj.getStatus(), taskReqVO.getStatus())) {
            // 根据 taskId 去查询 是否需要审批
            String queryApproved = projectTaskMapper.queryApproved(taskReqVO.getTaskId());
            String approved = "0";
            if (approved.equals(queryApproved)) {
                throw new ServiceException("该任务需要审批，任务状态不允许手动修改");
            } else {
                if (!SecurityUtils.getUsername().equals(oldObj.getCreatedBy())) {
                    throw new ServiceException("该任务不需要审批，只有创建人才能修改任务状态");
                }
            }
        }
        ProjectTask projectTask = new ProjectTask();
        BeanUtils.copyProperties(taskReqVO, projectTask);
        projectTask.setId(taskReqVO.getTaskId());
        projectTask.setProjectId(taskReqVO.getProjectId());
        projectTask.setUpdatedTime(new Date());
        projectTaskMapper.updateById(projectTask);

        LambdaQueryWrapper<ProjectMember> qw = new LambdaQueryWrapper<>();
        qw.eq(ProjectMember::getPtId, taskReqVO.getTaskId()).eq(ProjectMember::getType, ProjectStatusEnum.TASK.getStatusName());
        List<ProjectMember> projectMembers = projectMemberMapper.selectList(qw);
        if (projectMembers.size() == 1) {
            if (!Objects.equals(taskReqVO.getUserId(), projectMembers.get(0).getUserId())) {
                ProjectMember projectMember = new ProjectMember();
                projectMember.setPtId(taskReqVO.getTaskId());
                projectMember.setType(ProjectStatusEnum.TASK.getStatusName());
                projectMember.setJoinedTime(new Date());
                projectMember.setUserId(taskReqVO.getUserId());
                projectMember.setCreatedBy(SecurityUtils.getUsername());
                projectMember.setCreatedTime(new Date());
                projectMember.setUpdatedBy(SecurityUtils.getUsername());
                projectMember.setUpdatedTime(new Date());
                projectMemberMapper.insert(projectMember);
            }
        } else if (projectMembers.size() == 2) {
            Map<Long, List<ProjectMember>> map = projectMembers.stream().collect(Collectors.groupingBy(ProjectMember::getUserId));
            List<ProjectMember> pms = map.get(taskReqVO.getUserId());
            if (CollectionUtils.isEmpty(pms)) {
                // 将creator为0的进行更新
                LambdaQueryWrapper<ProjectMember> lqw = new LambdaQueryWrapper<>();
                lqw.eq(ProjectMember::getPtId, taskReqVO.getTaskId()).eq(ProjectMember::getCreator, 0);
                ProjectMember projectMember = projectMemberMapper.selectOne(lqw);
                projectMember.setUserId(taskReqVO.getUserId());
                projectMember.setUpdatedBy(SecurityUtils.getUsername());
                projectMember.setUpdatedTime(new Date());
                projectMember.setJoinedTime(new Date());
                projectMemberMapper.updateById(projectMember);
            } else {
                if (pms.get(0).getCreator() == 1) {
                    // 删除creator为0的
                    LambdaQueryWrapper<ProjectMember> lqw = new LambdaQueryWrapper<>();
                    lqw.eq(ProjectMember::getPtId, taskReqVO.getTaskId()).eq(ProjectMember::getCreator, 0);
                    projectMemberMapper.delete(lqw);
                }
            }
        }
        if (!oldObj.getUserId().equals(taskReqVO.getUserId())) {
            // 任务指派消息提醒
            extracted(taskReqVO.getTaskName(), taskReqVO.getUserId(), SecurityUtils.getUsername(), taskReqVO.getTaskId());
        }
        ProjectTask newObj = projectTaskMapper.selectById(taskReqVO.getTaskId());
        List<LogDataVO> data = FieldUtils.getChangedFields(newObj, oldObj);
        data.forEach(a -> {
            // 添加日志
            LogVO lv = new LogVO();
            lv.setLogType(LogTypeEnum.TRENDS.getStatus());
            lv.setOperateType("editTask");
            lv.setType(ProjectStatusEnum.TASK.getStatusName());
            lv.setPtId(projectTask.getId());
            lv.setProjectId(projectTask.getProjectId());
            lv.setUserId(SecurityUtils.getUserId());

            lv.setRemark(a.getRemark());
            List<LogContentVO> logContentVOList = a.getLogContentVOList();
            logContentVOList.forEach(logContentVO -> {
                switch (logContentVO.getField()) {
                    case "userId":
                        logContentVO.setOldValue(projectMemberMapper.selectUserById(Collections.singletonList(Long.valueOf(logContentVO.getOldValue()))).get(0).getNickName());
                        logContentVO.setNewValue(projectMemberMapper.selectUserById(Collections.singletonList(Long.valueOf(logContentVO.getNewValue()))).get(0).getNickName());
                        break;
                    case "status":
                    case "executeStatus":
                        logContentVO.setOldValue(ProjectTaskStatusEnum.getStatusNameByStatus(Integer.parseInt(logContentVO.getOldValue())));
                        logContentVO.setNewValue(ProjectTaskStatusEnum.getStatusNameByStatus(Integer.parseInt(logContentVO.getNewValue())));
                        break;
                    case "taskPriority":
                        logContentVO.setOldValue(ProjectTaskPriorityEnum.getStatusNameByStatus(Integer.parseInt(logContentVO.getOldValue())));
                        logContentVO.setNewValue(ProjectTaskPriorityEnum.getStatusNameByStatus(Integer.parseInt(logContentVO.getNewValue())));
                        break;
                }
            });
            lv.setContent(JSON.toJSONString(logContentVOList));
            lv.setCreatedBy(SecurityUtils.getUsername());
            lv.setCreatedTime(new Date());
            lv.setUpdatedBy(SecurityUtils.getUsername());
            lv.setUpdatedTime(new Date());
            projectLogService.run(lv);
            if (ProjectTaskStatusEnum.FINISHED.getStatus().equals(taskReqVO.getStatus())) {
                projectTask.setTaskProcess(new BigDecimal("100"));
            }
            projectTaskMapper.updateById(projectTask);
        });
    }

    @Override
    public List<TaskResVO> queryChildTask(TaskReqVO taskReqVO) {
        List<TaskResVO> taskResVOList = projectTaskMapper.queryChildTask(taskReqVO.getTaskId());
        taskResVOList.forEach(detail -> {
            detail.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(detail.getStatus()));
            detail.setExecuteStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(detail.getExecuteStatus()));
            if (detail.getUserId() != null) {
                detail.setExecutor(projectMemberMapper.selectUserById(Collections.singletonList(detail.getUserId())).get(0).getNickName());
            }
            detail.setCreatedBy(projectMemberMapper.selectUserByUsername(Collections.singletonList(detail.getCreatedBy())).get(0).getNickName());
            detail.setTaskPriorityName(ProjectTaskPriorityEnum.getStatusNameByStatus(detail.getTaskPriority()));
        });
        return taskResVOList;
    }

    @Override
    public List<BurnDownChartVO> burnDownChart(ProjectVO projectVO) {
        List<BurnDownChartVO> list = new ArrayList<>(10);
        LambdaQueryWrapper<ProjectTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectTask::getProjectId, projectVO.getProjectId()).orderByAsc(ProjectTask::getCreatedTime);
        List<ProjectTask> projectTasks = projectTaskMapper.selectList(queryWrapper);

        if (CollectionUtils.isNotEmpty(projectTasks)) {
            Date createdTime = projectTasks.get(0).getCreatedTime();
            String beginDate = DateUtils.dateTime(createdTime);
            String endDate = DateUtils.dateTime(new Date());
            List<String> betweenDate = DateUtils.getBetweenDate(beginDate, endDate);
            betweenDate.forEach(date -> {
                LocalDate now = LocalDate.parse(date, DateTimeFormatter.ofPattern(DateUtils.YYYY_MM_DD)).plusDays(1);
                BurnDownChartVO burnDownChartVO = new BurnDownChartVO();
                burnDownChartVO.setDate(date);
                LambdaQueryWrapper<ProjectTask> qw = new LambdaQueryWrapper<>();
                qw.eq(ProjectTask::getProjectId, projectVO.getProjectId()).lt(ProjectTask::getCreatedTime, now);
                List<ProjectTask> projectTasks2 = projectTaskMapper.selectList(qw);
                burnDownChartVO.setTaskNum(projectTasks2.size());
                burnDownChartVO.setUnDoneTaskNum((int) projectTasks2.stream().filter(a -> !Objects.equals(a.getStatus(), ProjectTaskStatusEnum.FINISHED.getStatus())).count());
                burnDownChartVO.setBaseLineNum((int) projectTasks2.stream().filter(a -> !Objects.equals(a.getStatus(), ProjectTaskStatusEnum.FINISHED.getStatus())).filter(o -> {
                    if (o.getEndTime() == null) {
                        if (o.getCreatedTime() != null) {
                            Instant instant = o.getCreatedTime().toInstant();
                            ZoneId zoneId = ZoneId.systemDefault();
                            LocalDate create = instant.atZone(zoneId).toLocalDate();
                            return create.plusDays(5).isAfter(now);
                        }
                        return true;
                    } else {
                        Instant instant = o.getEndTime().toInstant();
                        ZoneId zoneId = ZoneId.systemDefault();
                        LocalDate end = instant.atZone(zoneId).toLocalDate();
                        return end.plusDays(-1).isBefore(now);
                    }
                }).count());
                list.add(burnDownChartVO);
            });
        }
        return list;
    }

    @Override
    public List<ProjectMemberResVO> queryUserList(ProjectTaskReqVO projectTaskReqVO) {
        return projectMemberMapper.queryTaskUserList(projectTaskReqVO.getTaskId());

    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addComment(TaskCommentVO taskCommentVO) {
        ProjectLog projectLog = new ProjectLog();
        projectLog.setProjectId(taskCommentVO.getProjectId());
        projectLog.setOperateType("comment");
        projectLog.setUserId(SecurityUtils.getUserId());
        projectLog.setRemark("添加了评论");
        projectLog.setContent(taskCommentVO.getComment());
        projectLog.setLogType(LogTypeEnum.COMMENT.getStatus());
        projectLog.setPtId(taskCommentVO.getTaskId());
        projectLog.setType(ProjectStatusEnum.TASK.getStatusName());
        projectLog.setCreatedBy(SecurityUtils.getUsername());
        projectLog.setCreatedTime(new Date());
        projectLog.setUpdatedBy(SecurityUtils.getUsername());
        projectLog.setUpdatedTime(new Date());
        projectLogService.save(projectLog);
    }

    /**
     *
     * @param logReqVO
     * @return
     */
    @Override
    public List<ProjectLogVO> queryTaskLogList(LogReqVO logReqVO) {
        PageHelper.startPage(logReqVO.getPageNum(), logReqVO.getPageSize());
        return queryTaskLogFactory.execute(logReqVO.getLogType(), logReqVO.getTaskId());
    }

    @Override
    public void downloadTemplate(String taskId, HttpServletResponse response) throws IOException {

        // 根据 taskId 查询最新的模板
        LambdaQueryWrapper<ProjectFile> lw = new LambdaQueryWrapper<>();
        lw.eq(ProjectFile::getPtId, taskId).eq(ProjectFile::getType, ProjectStatusEnum.TEMPLATE.getStatusName()).orderByDesc(ProjectFile::getCreatedTime);
        List<ProjectFile> projectFiles = projectFileMapper.selectList(lw);
        if (CollectionUtils.isEmpty(projectFiles)) {
            throw new ServerException("不存在模板文件，请上传之后再下载");
        } else {
            String filePath = projectFiles.get(0).getPathName();
            String fileUrl = projectFiles.get(0).getFileUrl();
            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, fileUrl.substring(fileUrl.lastIndexOf("/") + 1));
            FileUtils.writeBytes(filePath, response);
        }

    }

    @Override
    public List<TaskExportVO> exportAll() {
        List<TaskExportVO> list = projectTaskMapper.exportAll(SecurityUtils.getUserId());
        list.forEach(a -> {
            a.setExecuteStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getExecuteStatus()));
            a.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getStatus()));
            a.setTaskPriorityName(ProjectTaskPriorityEnum.getStatusNameByStatus(a.getTaskPriority()));
        });
        return list;
    }

    @Override
    public List<TaskExportVO> export(String taskIds) {
        List<String> taskIdList = Arrays.asList(taskIds.split(","));
        List<TaskExportVO> list = projectTaskMapper.export(taskIdList);
        list.forEach(a -> {
            a.setExecuteStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getExecuteStatus()));
            a.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getStatus()));
            a.setTaskPriorityName(ProjectTaskPriorityEnum.getStatusNameByStatus(a.getTaskPriority()));
        });
        return list;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void importTask(List<TaskExcelVO> taskList) {
        if (CollectionUtils.isEmpty(taskList)) {
            throw new ServiceException("导入任务数据不能为空");
        }
        taskList.forEach(task -> {
            List<SysUser> sysUsers = projectMemberMapper.selectUserByUsername(Collections.singletonList(task.getUsername()));
            if (CollectionUtils.isEmpty(sysUsers)) {
                return;
            }
            ProjectTask projectTask = new ProjectTask();
            projectTask.setTaskName(task.getTaskName());
            projectTask.setBeginTime(DateUtils.parseDate(task.getBeginTime()));
            projectTask.setEndTime(DateUtils.parseDate(task.getEndTime()));
            projectTask.setCloseTime(DateUtils.parseDate(task.getCloseTime()));
            projectTask.setTaskPriority(Integer.valueOf(task.getTaskPriority()));
            LambdaQueryWrapper<Project> qw = new LambdaQueryWrapper<>();
            qw.eq(Project::getProjectCode, task.getProjectCode());
            String projectId = projectMapper.selectOne(qw).getId();
            if (StringUtils.isBlank(projectId)) {
                return;
            }
            // 根据项目id查询成员
            LambdaQueryWrapper<ProjectMember> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(ProjectMember::getPtId, projectId).eq(ProjectMember::getType, ProjectStatusEnum.PROJECT.getStatusName());
            List<ProjectMember> projectMembers = projectMemberMapper.selectList(queryWrapper);
            List<Long> userIds = projectMembers.stream().map(ProjectMember::getUserId).collect(Collectors.toList());
            if (!userIds.contains(sysUsers.get(0).getUserId())) {
                return;
            }
            projectTask.setProjectId(projectId);
            LambdaQueryWrapper<ProjectStage> qw2 = new LambdaQueryWrapper<>();
            qw2.eq(ProjectStage::getProjectId, projectId).orderByAsc(ProjectStage::getStageCode);
            projectTask.setProjectStageId(projectStageMapper.selectList(qw2).get(0).getId());
            projectTask.setUserId(sysUsers.get(0).getUserId());
            projectTask.setCreatedBy(SecurityUtils.getUsername());
            projectTask.setCreatedTime(new Date());
            projectTask.setUpdatedBy(SecurityUtils.getUsername());
            projectTask.setUpdatedTime(new Date());
            projectTaskMapper.insert(projectTask);
            insertMember(projectTask.getId(), 1, SecurityUtils.getUserId());
            // 添加日志
            saveLog("importTask", projectTask.getId(), projectTask.getProjectId(), projectTask.getTaskName()
                    , "导入了任务", null);
            // 将执行人加入
            if (projectTask.getUserId() != null && !Objects.equals(projectTask.getUserId(), SecurityUtils.getUserId())) {
                insertMember(projectTask.getId(), 0, projectTask.getUserId());
                // 添加日志
                saveLog("invitePartakeTask", projectTask.getId(), projectTask.getProjectId(), projectTask.getTaskName()
                        ,"邀请 " + projectMemberMapper.selectUserById(Collections.singletonList(projectTask.getUserId())).get(0).getNickName() + " 参与任务"
                        , projectTask.getUserId());
            }
        });
    }

    void insertMember(String taskId, Integer creator, Long userId) {
        ProjectMember projectMember = new ProjectMember();
        projectMember.setPtId(taskId);
        projectMember.setType(ProjectStatusEnum.TASK.getStatusName());
        projectMember.setJoinedTime(new Date());
        projectMember.setUserId(userId);
        projectMember.setCreatedBy(SecurityUtils.getUsername());
        projectMember.setCreatedTime(new Date());
        projectMember.setUpdatedBy(SecurityUtils.getUsername());
        projectMember.setUpdatedTime(new Date());
        // 是创建者
        projectMember.setCreator(creator);
        projectMemberMapper.insert(projectMember);
    }

    void saveLog(String operateType, String taskId, String projectId, String taskName, String remark, Long userId) {
        LogVO logVO = new LogVO();
        logVO.setLogType(LogTypeEnum.TRENDS.getStatus());
        logVO.setOperateType(operateType);
        logVO.setType(ProjectStatusEnum.TASK.getStatusName());
        logVO.setPtId(taskId);
        logVO.setProjectId(projectId);
        logVO.setUserId(SecurityUtils.getUserId());
        if (userId != null) {
            logVO.setToUserId(userId);
        }
        logVO.setRemark(remark);
        logVO.setContent(taskName);
        logVO.setCreatedBy(SecurityUtils.getUsername());
        logVO.setCreatedTime(new Date());
        logVO.setUpdatedBy(SecurityUtils.getUsername());
        logVO.setUpdatedTime(new Date());
        projectLogService.run(logVO);
    }

    @Override
    public void downloadTaskTemplate(HttpServletResponse response) throws IOException {
        String filePath = PmhubConfig.getProfile() + "/template/taskTemplate.xlsx";
        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
        FileUtils.setAttachmentResponseHeader(response, "任务模板.xlsx");
        FileUtils.writeBytes(filePath, response);
    }

    @Override
    public PageInfo<TaskResVO> taskList(TaskReqVO taskReqVO) {
        PageHelper.startPage(taskReqVO.getPageNum(), taskReqVO.getPageSize());
        List<TaskResVO> list = projectTaskMapper.taskList(taskReqVO);
        list.forEach(a -> {
            a.setTaskPriorityName(ProjectTaskPriorityEnum.getStatusNameByStatus(a.getTaskPriority()));
            a.setStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getStatus()));
            a.setExecuteStatusName(ProjectTaskStatusEnum.getStatusNameByStatus(a.getExecuteStatus()));
            if (a.getEndTime() != null && a.getBeginTime() != null) {
                a.setPeriod(DateUtils.differentDaysByMillisecond(a.getEndTime(), a.getBeginTime()));
            }
            WorkFlowable workFlowable = new WorkFlowable();
            workFlowable.setTaskId(a.getTaskProcessId());
            workFlowable.setApproved(a.getApproved());
            workFlowable.setDeploymentId(a.getDeployId());
            workFlowable.setProcInsId(a.getProcInsId());
            workFlowable.setDefinitionId(a.getDefinitionId());
            a.setWorkFlowable(workFlowable);
        });
        return new PageInfo<>(list);
    }

    @Override
    public Long countTaskNum() {
        LambdaQueryWrapper<ProjectTask> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectTask::getDeleted, 0);
        if (projectTaskMapper.selectCount(queryWrapper) == null) {
            return 0L;
        }
        return projectTaskMapper.selectCount(queryWrapper);
    }

    @Override
    public List<Project> queryProjectsStatus(List<String> projectIds) {
        return projectTaskMapper.queryProjectsStatus(projectIds);
    }

}
