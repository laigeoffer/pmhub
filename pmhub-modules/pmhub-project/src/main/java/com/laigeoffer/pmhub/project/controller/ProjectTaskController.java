package com.laigeoffer.pmhub.project.controller;

import com.laigeoffer.pmhub.base.core.annotation.Anonymous;
import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
import com.laigeoffer.pmhub.base.core.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.core.utils.poi.ExcelUtil;
import com.laigeoffer.pmhub.base.security.annotation.RequiresPermissions;
import com.laigeoffer.pmhub.project.domain.Project;
import com.laigeoffer.pmhub.project.domain.ProjectTask;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.LogReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.task.*;
import com.laigeoffer.pmhub.project.service.ProjectTaskService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


/**
 * @author canghe
 * @date 2022-12-09 17:50
 */
@RestController
@RequestMapping("/project")
public class ProjectTaskController {

    @Autowired
    private ProjectTaskService projectTaskService;
//    @Autowired
//    private IWfProcessService processService;
    // TODO: 2024.04.28 暂时注释掉workflow
//    @Autowired
//    private IWfDeployService wfDeployService;

    /**
     * 首页-我的任务
     * @param taskReqVO
     * @return
     */
    @PostMapping("/queryMyTaskList")
    @RequiresPermissions("project:task:queryMyTaskList")
    public AjaxResult queryMyTaskList(@RequestBody TaskReqVO taskReqVO) {
        return AjaxResult.success(projectTaskService.queryMyTaskList(taskReqVO));
    }

    /**
     * 概况-任务概况
     * @param projectVO
     * @return
     */
    @PostMapping("/task/situation")
    @RequiresPermissions("project:task:situation")
    public AjaxResult queryTaskStatusStats(@RequestBody ProjectVO projectVO) {
        return AjaxResult.success(projectTaskService.queryTaskStatusStats(projectVO));
    }
    /**
     * 删除任务
     * @param taskIdsVO
     * @return
     */
    @DeleteMapping("/task/delete")
    @RequiresPermissions("project:task:delete")
    public AjaxResult deleteTask(@RequestBody TaskIdsVO taskIdsVO) {
        List<ProjectTask> projectTasks = projectTaskService.listByIds(taskIdsVO.getTaskIdList());
        List<String> projectIds = projectTasks.stream().map(ProjectTask::getProjectId).distinct().collect(Collectors.toList());
        List<Project> projects = projectTaskService.queryProjectsStatus(projectIds);
        Map<String, List<Project>> map = projects.stream().collect(Collectors.groupingBy(Project::getId));
        StringBuilder projectMsg = new StringBuilder();
        projectTasks.forEach(projectTask -> {
            List<Project> list = map.get(projectTask.getProjectId());
            if (ProjectStatusEnum.PAUSE.getStatus().equals(list.get(0).getStatus())) {
                projectMsg.append(projectTask.getTaskName()).append(",");
            }
        });
        if (StringUtils.isNotBlank(projectMsg.toString())) {
            throw new ServiceException("[" + projectMsg.substring(0, projectMsg.toString().length() - 1) + "]" + "归属项目已暂停，无法删除任务");
        }
        Map<String, List<ProjectTask>> collect = projectTasks.stream().collect(Collectors.groupingBy(ProjectTask::getId));
        // TODO: 2024.04.28 暂时注释掉审批相关流程
//        List<WfTaskProcess> wfTaskProcesses = wfDeployService.selectList(taskIdsVO.getTaskIdList());
//        if (CollectionUtils.isNotEmpty(wfTaskProcesses)) {
//            StringBuilder msg = new StringBuilder();
//            for (WfTaskProcess projectTaskProcess : wfTaskProcesses) {
//                if (StringUtils.isNotBlank(projectTaskProcess.getInstanceId())) {
//                    msg.append(collect.get(projectTaskProcess.getExtraId()).get(0).getTaskName()).append(",");
//                }
//            }
//            if (StringUtils.isNotBlank(msg.toString())) {
//                throw new ServiceException("[" + msg.substring(0, msg.toString().length() - 1) + "]" + "存在审批流程，不允许删除");
//            }
//
//        }
        projectTaskService.deleteTask(taskIdsVO);
        return AjaxResult.success();
    }
    /**
     * 概况-任务详情
     * @param taskReqVO
     * @return
     */
    @PostMapping("/task/detail")
    @RequiresPermissions("project:task:detail")
    public AjaxResult detail(@RequestBody TaskReqVO taskReqVO) {
        return AjaxResult.success(projectTaskService.detail(taskReqVO));
    }

    /**
     * 任务详情-查询执行人
     * @param taskReqVO
     * @return
     */
    @PostMapping("/task/queryExecutorList")
    @RequiresPermissions("project:task:queryExecutorList")
    public AjaxResult queryExecutorList(@RequestBody TaskReqVO taskReqVO) {
        return AjaxResult.success(projectTaskService.queryExecutorList(taskReqVO));
    }

    /**
     * 添加任务
     * @param taskReqVO
     * @return
     */
    @RequiresPermissions("project:task:add")
    @PostMapping("/task/add")
    public AjaxResult add(@RequestBody TaskReqVO taskReqVO) {
        String taskId = projectTaskService.add(taskReqVO);
        // TODO: 2024.04.28 暂时注释掉审批相关流程
//        wfDeployService.insertOrUpdateApprovalSet(taskId, ProjectStatusEnum.TASK.getStatusName(), taskReqVO.getApproved()
//                , taskReqVO.getDefinitionId(), taskReqVO.getDeploymentId());
        return AjaxResult.success();
    }
    /**
     * 添加子任务
     * @param taskReqVO
     * @return
     */
    @RequiresPermissions("project:task:addChildTask")
    @PostMapping("/task/addChildTask")
    public AjaxResult addChildTask(@RequestBody TaskReqVO taskReqVO) {
        String taskId = projectTaskService.add(taskReqVO);
        // TODO: 2024.04.28 暂时注释掉审批相关流程
//        wfDeployService.insertOrUpdateApprovalSet(taskId, ProjectStatusEnum.TASK.getStatusName(), taskReqVO.getApproved()
//                , taskReqVO.getDefinitionId(), taskReqVO.getDeploymentId());
        return AjaxResult.success();
    }

    /**
     * 修改任务
     * @param taskReqVO
     * @return
     */
    @RequiresPermissions("project:task:edit")
    @PostMapping("/task/edit")
    public AjaxResult edit(@RequestBody TaskReqVO taskReqVO) {
        projectTaskService.edit(taskReqVO);
        return AjaxResult.success();
    }

    /**
     * 我的任务列表
     * @param taskReqVO
     * @return
     */
    @RequiresPermissions("project:task:list")
    @PostMapping("/task/list")
    public AjaxResult list(@RequestBody TaskReqVO taskReqVO) {
        return AjaxResult.success(projectTaskService.list(taskReqVO));
    }
    /**
     * 查询子任务
     * @param taskReqVO
     * @return
     */
    @RequiresPermissions("project:task:queryChildTask")
    @PostMapping("/task/queryChildTask")
    public AjaxResult queryChildTask(@RequestBody TaskReqVO taskReqVO) {
        return AjaxResult.success(projectTaskService.queryChildTask(taskReqVO));
    }

    /**
     * 任务交付物模板下载
     * @throws IOException
     */
    @PostMapping("/task/file/downloadTemplate")
    public void downloadTemplate(@RequestParam("taskId") String taskId, HttpServletResponse response) throws IOException {
        projectTaskService.downloadTemplate(taskId, response);
    }
    /**
     * 任务模板下载
     * @throws IOException
     */
    @PostMapping("/task/downloadTaskTemplate")
    public void downloadTaskTemplate(HttpServletResponse response) throws IOException {
        projectTaskService.downloadTaskTemplate(response);
    }

    /**
     * 概况-任务燃尽图
     * @param projectVO
     * @return
     */
    @PostMapping("/task/burnDownChart")
    public AjaxResult burnDownChart(@RequestBody ProjectVO projectVO) {
        return AjaxResult.success(projectTaskService.burnDownChart(projectVO));
    }
    /**
     * 添加评论
     * @param taskCommentVO
     * @return
     */
    @RequiresPermissions("project:task:addComment")
    @PostMapping("/task/addComment")
    public AjaxResult addComment(@RequestBody TaskCommentVO taskCommentVO) {
        projectTaskService.addComment(taskCommentVO);
        return AjaxResult.success();
    }
    /**
     * 查询任务成员
     * @param projectTaskReqVO
     * @return
     */
    @PostMapping("/task/queryUserList")
    public AjaxResult queryUserList(@RequestBody ProjectTaskReqVO projectTaskReqVO) {
        return AjaxResult.success(projectTaskService.queryUserList(projectTaskReqVO));
    }

    /**
     * 任务动态
     * @param logReqVO
     * @return
     */
    @PostMapping("/task/log/list")
    @RequiresPermissions("project:task:logList")
    public AjaxResult queryTaskLogList(@RequestBody LogReqVO logReqVO) {
        return AjaxResult.success(projectTaskService.queryTaskLogList(logReqVO));
    }

    /**
     * 导出全部任务
     * @param response
     * @return
     */
    @PostMapping("/task/exportAll")
    public void exportAll(HttpServletResponse response) {
        List<TaskExportVO> list = projectTaskService.exportAll();
        ExcelUtil<TaskExportVO> util = new ExcelUtil<>(TaskExportVO.class);
        util.exportExcel(response, list, "全部任务数据");
    }
    /**
     * 导出任务
     * @param response
     * @return
     */
    @PostMapping("/task/export")
    public void export(@RequestParam("taskIds") String taskIds, HttpServletResponse response) {
        List<TaskExportVO> list = projectTaskService.export(taskIds);
        ExcelUtil<TaskExportVO> util = new ExcelUtil<>(TaskExportVO.class);
        util.exportExcel(response, list, "任务数据");
    }

    /**
     * 导入任务
     * @param file
     * @return
     */
    @PostMapping("/task/import")
    @RequiresPermissions("project:task:import")
    public AjaxResult importData(@RequestParam("file") MultipartFile file) throws Exception {
        ExcelUtil<TaskExcelVO> util = new ExcelUtil<>(TaskExcelVO.class);
        List<TaskExcelVO> list = util.importExcel(file.getInputStream());
        projectTaskService.importTask(list);
        return AjaxResult.success();
    }

    /**
     * 审批设置
     * @param approvalSetDTO
     * @return
     */
//    @PostMapping("/task/updateApprovalSet")
//    @PreAuthorize("@ss.hasPermi('project:task:updateApprovalSet')")
//    public AjaxResult updateApprovalSet(@RequestBody ApprovalSetDTO approvalSetDTO) {
//        // TODO: 2024.04.28 暂时注释掉审批相关流程
////        wfDeployService.updateApprovalSet2(approvalSetDTO, ProjectStatusEnum.TASK.getStatusName());
//        return AjaxResult.success();
//    }


    /**
     * 任务审批根据流程定义id启动流程实例
     *
     * @param processDefId 流程定义id
     * @param variables 变量集合,json对象
     */
    @RequiresPermissions("project:task:approve")
    @PostMapping("/startTaskApprove/{taskId}/{processDefId}")
    public AjaxResult startProjectApproveDefId(@PathVariable(value = "taskId") String taskId, @PathVariable(value = "processDefId") String processDefId, @RequestParam("url") String url, @RequestBody Map<String, Object> variables) {
        // TODO: 2024.04.28 暂时注释掉流程相关
//        processService.startTaskProcessByDefId(taskId, processDefId, url, variables);
        return AjaxResult.success("流程启动成功");

    }

    /**
     * 优化审批设置
     * @return
     */
    @PostMapping("/task/insertApprovalSet")
    @Anonymous
    public AjaxResult updateApprovalSet() {
//        wfDeployService.insertApprovalSet();
        // TODO: 2024.04.28 暂时注释掉审批相关流程
        return AjaxResult.success();
    }

}
