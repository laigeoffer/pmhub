package com.laigeoffer.pmhub.project.controller;

import com.laigeoffer.pmhub.api.workflow.DeployFeignService;
import com.laigeoffer.pmhub.api.workflow.ProcessFeignService;
import com.laigeoffer.pmhub.base.core.constant.SecurityConstants;
import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
import com.laigeoffer.pmhub.base.core.core.domain.dto.ApprovalSetDTO;
import com.laigeoffer.pmhub.base.core.core.domain.dto.ProjectProcessDTO;
import com.laigeoffer.pmhub.base.security.annotation.RequiresPermissions;
import com.laigeoffer.pmhub.project.domain.Project;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectStatisticsResVO;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskReqVO;
import com.laigeoffer.pmhub.project.service.ProjectService;
import com.laigeoffer.pmhub.project.service.ProjectTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @author canghe
 * @date 2022-12-08 17:30
 */
@RestController
@RequestMapping("/project")
public class ProjectController {

    @Autowired
    private ProjectService projectService;
    @Autowired
    private ProjectTaskService projectTaskService;
    @Autowired
    private ProcessFeignService processService;
    @Autowired
    private DeployFeignService wfDeployService;

    /**
     * 增加项目
     * @param project
     * @return
     */
    @RequiresPermissions("project:manage:add")
    @PostMapping("/add")
    public AjaxResult add(@RequestBody Project project) {
        projectService.saveProject(project);
        return AjaxResult.success();
    }

    /**
     * 修改项目
     * @param project
     * @return
     */
    @RequiresPermissions("project:manage:edit")
    @PostMapping("/edit")
    public AjaxResult edit(@RequestBody Project project) {
        projectService.editProject(project);
        return AjaxResult.success();
    }

    /**
     * 项目列表
     * @param projectReqVO
     * @return
     */
    @RequiresPermissions("project:manage:list")
    @PostMapping("/list")
    public AjaxResult list(@RequestBody ProjectReqVO projectReqVO) {
        return AjaxResult.success(projectService.list(projectReqVO));
    }

    /**
     * 首页统计
     * @return
     */
//    @RequiresPermissions("project:manage:statistics")
    @GetMapping("/statistics")
    public AjaxResult statistics() {
        ProjectStatisticsResVO projectStatisticsResVO = new ProjectStatisticsResVO();
        // 项目总数
        projectStatisticsResVO.setProjectNum(projectService.countProjectNum());
        // 任务总数
        projectStatisticsResVO.setTaskNum(projectTaskService.countTaskNum());
        // 今日任务数
        projectStatisticsResVO.setTodayTaskNum(projectTaskService.queryTodayTaskNum());
        // 逾期任务数
        projectStatisticsResVO.setOverdueTaskNum(projectTaskService.queryOverdueTaskNum());
        // 项目进度排行
        projectStatisticsResVO.setProjectRankVOList(projectService.queryProjectRankList());
        // 任务状态统计
        projectStatisticsResVO.setTaskStatisticsVOList(projectTaskService.queryTaskStatisticsList());
        return AjaxResult.success(projectStatisticsResVO);
    }

    /**
     * 查询与我有关的项目
     * @return
     */
//    @RequiresPermissions("project:manage:select")
    @GetMapping("/select")
    public AjaxResult queryMyProject() {
        return AjaxResult.success(projectService.queryMyProjectList());
    }

    /**
     * 查询所有项目
     * @return
     */
    @RequiresPermissions("project:manage:queryAllProject")
    @GetMapping("/queryAllProject")
    public AjaxResult queryAllProject() {
        return AjaxResult.success(projectService.queryAllProject());
    }

    /**
     * 进行中的项目
     * @return
     */
//    @RequiresPermissions("project:manage:doing")
    @GetMapping("/doing")
    public AjaxResult queryDoingProject() {
        return AjaxResult.success(projectService.queryDoingProject());
    }

    /**
     * 删除项目
     * @param projectVO
     * @return
     */
    @RequiresPermissions("project:manage:delete")
    @DeleteMapping("/delete")
    public AjaxResult deleteProject(@RequestBody ProjectVO projectVO) {
        return AjaxResult.success(projectService.deleteProject(projectVO));
    }

    /**
     * 项目详情
     * @param projectVO
     * @return
     */
    @RequiresPermissions("project:manage:detail")
    @PostMapping("/detail")
    public AjaxResult detail(@RequestBody ProjectVO projectVO) {

        return AjaxResult.success(projectService.detail(projectVO.getProjectId()));
    }

    /**
     * 项目归档
     * @param projectVO
     * @return
     */
    @RequiresPermissions("project:manage:archive")
    @PostMapping("/archive")
    public AjaxResult archived(@RequestBody ProjectVO projectVO) {
        projectService.archived(projectVO.getProjectId());
        return AjaxResult.success();
    }

    /**
     * 取消项目归档
     * @param projectVO
     * @return
     */
    @RequiresPermissions("project:manage:cancelArchive")
    @PostMapping("/cancelArchive")
    public AjaxResult cancelArchived(@RequestBody ProjectVO projectVO) {
        projectService.cancelArchived(projectVO.getProjectId());
        return AjaxResult.success();
    }

    /**
     * 退出项目
     * @param projectVO
     * @return
     */
    @RequiresPermissions("project:manage:quit")
    @PostMapping("/quit")
    public AjaxResult quit(@RequestBody ProjectVO projectVO) {
        projectService.quit(projectVO.getProjectId());
        return AjaxResult.success();
    }

    /**
     * 概况-任务每日新增趋势
     * @param projectVO
     * @return
     */
    @RequiresPermissions("project:manage:taskStatisticsByDate")
    @PostMapping("/taskStatisticsByDate")
    public AjaxResult taskStatisticsByDate(@RequestBody ProjectVO projectVO) {

        return AjaxResult.success(projectService.taskStatisticsByDate(projectVO.getProjectId()));
    }
    /**
     * 项目详情-任务列表
     * @param taskReqVO
     * @return
     */
    @RequiresPermissions("project:detail:taskList")
    @PostMapping("/detail/taskList")
    public AjaxResult taskList(@RequestBody TaskReqVO taskReqVO) {

        return AjaxResult.success(projectTaskService.taskList(taskReqVO));
    }
    /**
     * 审批设置
     * @param approvalSetDTO
     * @return
     */
    @PostMapping("/updateApprovalSet")
    @RequiresPermissions("project:manage:updateApprovalSet")
    public AjaxResult updateApprovalSet(@RequestBody ApprovalSetDTO approvalSetDTO) {
        wfDeployService.updateApprovalSet(approvalSetDTO, SecurityConstants.INNER);
        return AjaxResult.success();
    }

    /**
     * 项目发布根据流程定义id启动流程实例
     *
     * @param processDefId 流程定义id
     * @param variables 变量集合,json对象
     */
    @RequiresPermissions("project:manage:approve")
    @PostMapping("/startProjectApprove/{projectId}/{processDefId}")
    public AjaxResult startProjectApproveDefId(@PathVariable(value = "projectId") String projectId, @PathVariable(value = "processDefId") String processDefId, @RequestParam("url") String url, @RequestBody Map<String, Object> variables) {
        ProjectProcessDTO request = new ProjectProcessDTO(projectId,processDefId, url, variables);
        // 远程调用流程服务
        processService.startProjectProcess(request,SecurityConstants.INNER);
        return AjaxResult.success("流程启动成功");

    }

}
