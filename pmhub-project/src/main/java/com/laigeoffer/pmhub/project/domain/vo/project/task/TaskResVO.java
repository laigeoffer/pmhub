package com.laigeoffer.pmhub.project.domain.vo.project.task;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author canghe
 * @date 2022-12-12 10:36
 */
public class TaskResVO {
    /**
     * 项目id
     */
    private String projectId;
    /**
     * 阶段id
     */
    private String projectStageId;
    /**
     * 项目名
     */
    private String projectName;
    /**
     * 任务id
     */
    private String taskId;
    /**
     * 任务名
     */
    private String taskName;
    /**
     * 状态
     */
    private Integer status;
    private String statusName;
    /**
     * 执行人
     */
    private String executor;
    /**
     * 执行状态
     */
    private Integer executeStatus;
    private String executeStatusName;
    /**
     * 优先级
     */
    private Integer taskPriority;
    private String taskPriorityName;
    /**
     * 阶段名
     */
    private String stageName;
    private String createdBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createdTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updatedTime;
    /**
     * 进度
     */
    private BigDecimal taskProcess;
    /**
     * 所属流程
     */
    private String taskFlow;
    /**
     * 描述
     */
    private String description;
    /**
     * 开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date beginTime;
    /**
     * 结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date endTime;
    /**
     * 截止时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date closeTime;
    /**
     * 用户id
     */
    private Long userId;

    private String approved;
    private String definitionId;
    private String procInsId;
    private String deployId;
    private String taskProcessId;
    private Integer period;

    public Integer getPeriod() {
        return period;
    }

    public void setPeriod(Integer period) {
        this.period = period;
    }

    public String getApproved() {
        return approved;
    }

    public void setApproved(String approved) {
        this.approved = approved;
    }

    public String getDefinitionId() {
        return definitionId;
    }

    public void setDefinitionId(String definitionId) {
        this.definitionId = definitionId;
    }

    public String getProcInsId() {
        return procInsId;
    }

    public void setProcInsId(String procInsId) {
        this.procInsId = procInsId;
    }

    public String getDeployId() {
        return deployId;
    }

    public void setDeployId(String deployId) {
        this.deployId = deployId;
    }

    public String getTaskProcessId() {
        return taskProcessId;
    }

    public void setTaskProcessId(String taskProcessId) {
        this.taskProcessId = taskProcessId;
    }

    private WorkFlowable workFlowable;

    public WorkFlowable getWorkFlowable() {
        return workFlowable;
    }

    public void setWorkFlowable(WorkFlowable workFlowable) {
        this.workFlowable = workFlowable;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getProjectStageId() {
        return projectStageId;
    }

    public void setProjectStageId(String projectStageId) {
        this.projectStageId = projectStageId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getExecutor() {
        return executor;
    }

    public void setExecutor(String executor) {
        this.executor = executor;
    }

    public Integer getExecuteStatus() {
        return executeStatus;
    }

    public void setExecuteStatus(Integer executeStatus) {
        this.executeStatus = executeStatus;
    }

    public String getExecuteStatusName() {
        return executeStatusName;
    }

    public void setExecuteStatusName(String executeStatusName) {
        this.executeStatusName = executeStatusName;
    }

    public Integer getTaskPriority() {
        return taskPriority;
    }

    public void setTaskPriority(Integer taskPriority) {
        this.taskPriority = taskPriority;
    }

    public String getTaskPriorityName() {
        return taskPriorityName;
    }

    public void setTaskPriorityName(String taskPriorityName) {
        this.taskPriorityName = taskPriorityName;
    }

    public String getStageName() {
        return stageName;
    }

    public void setStageName(String stageName) {
        this.stageName = stageName;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public Date getUpdatedTime() {
        return updatedTime;
    }

    public void setUpdatedTime(Date updatedTime) {
        this.updatedTime = updatedTime;
    }

    public BigDecimal getTaskProcess() {
        return taskProcess;
    }

    public void setTaskProcess(BigDecimal taskProcess) {
        this.taskProcess = taskProcess;
    }

    public String getTaskFlow() {
        return taskFlow;
    }

    public void setTaskFlow(String taskFlow) {
        this.taskFlow = taskFlow;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Date closeTime) {
        this.closeTime = closeTime;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
