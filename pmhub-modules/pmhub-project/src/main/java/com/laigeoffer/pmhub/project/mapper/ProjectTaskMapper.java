package com.laigeoffer.pmhub.project.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.laigeoffer.pmhub.project.domain.Project;
import com.laigeoffer.pmhub.project.domain.ProjectTask;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskExportVO;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskNotifyDTO;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskResVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author canghe
 * @date 2022-12-12 14:34
 */
public interface ProjectTaskMapper extends BaseMapper<ProjectTask> {

    List<TaskResVO> queryMyCreatedTaskList(@Param("projectId") String projectId, @Param("username") String username);
    List<TaskResVO> queryMyExecutedTaskList(@Param("projectId") String projectId, @Param("userId") Long userId);
    List<TaskResVO> queryMyPartookTaskList(@Param("projectId") String projectId, @Param("userId") Long userId);
    TaskResVO detail(@Param("taskId") String taskId);
    List<TaskResVO> queryChildTask(@Param("taskId") String taskId);
    List<TaskResVO> list(@Param("data") TaskReqVO taskReqVO, @Param("userId") Long userId);
    List<TaskResVO> taskList(@Param("data") TaskReqVO taskReqVO);
    List<TaskExportVO> exportAll(@Param("userId") Long userId);
    List<TaskExportVO> export(@Param("taskIdList") List<String> taskIdList);
    List<TaskNotifyDTO> queryTaskNotifyJob();
    List<TaskNotifyDTO> queryTaskNotifyJob2();
    String queryVxUserName(@Param("userId") Long userId);

    String queryApproved(@Param("taskId") String taskId);
    Integer queryProjectStatus(@Param("projectId") String projectId);
    List<Project> queryProjectsStatus(@Param("projectIds") List<String> projectIds);

}
