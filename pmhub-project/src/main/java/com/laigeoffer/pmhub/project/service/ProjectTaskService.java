package com.laigeoffer.pmhub.project.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.LogReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.ProjectLogVO;
import com.laigeoffer.pmhub.project.domain.Project;
import com.laigeoffer.pmhub.project.domain.ProjectTask;
import com.laigeoffer.pmhub.project.domain.vo.project.member.ProjectMemberResVO;
import com.laigeoffer.pmhub.project.domain.vo.project.task.*;
import com.laigeoffer.pmhub.project.domain.vo.project.task.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @author canghe
 * @date 2022-12-14 15:00
 */
public interface ProjectTaskService extends IService<ProjectTask> {
    /**
     * 今日任务数
     * @return
     */
    Long queryTodayTaskNum();

    /**
     * 逾期任务数
     * @return
     */
    Long queryOverdueTaskNum();

    /**
     * 任务状态统计
     * @return
     */
    List<TaskStatisticsVO> queryTaskStatisticsList();

    PageInfo<TaskResVO> queryMyTaskList(TaskReqVO taskReqVO);
    TaskStatusStatsVO queryTaskStatusStats(ProjectVO projectVO);

    void deleteTask(TaskIdsVO taskIdsVO);

    TaskResVO detail(TaskReqVO taskReqVO);

    List<ProjectMemberResVO> queryExecutorList(TaskReqVO taskReqVO);

    PageInfo<TaskResVO> list(TaskReqVO taskReqVO);

    String add(TaskReqVO taskReqVO);

    void edit(TaskReqVO taskReqVO);

    List<TaskResVO> queryChildTask(TaskReqVO taskReqVO);

    List<BurnDownChartVO> burnDownChart(ProjectVO projectVO);

    List<ProjectMemberResVO> queryUserList(ProjectTaskReqVO projectTaskReqVO);

    void addComment(TaskCommentVO taskCommentVO);


    List<ProjectLogVO> queryTaskLogList(LogReqVO logReqVO);

    void downloadTemplate(String taskId, HttpServletResponse response) throws IOException;

    List<TaskExportVO> exportAll();
    List<TaskExportVO> export(String taskIds);

    void importTask(List<TaskExcelVO> taskList);

    void downloadTaskTemplate(HttpServletResponse response) throws IOException;

    PageInfo<TaskResVO> taskList(TaskReqVO taskReqVO);

    Long countTaskNum();

    List<Project> queryProjectsStatus(List<String> projectIds);

}
