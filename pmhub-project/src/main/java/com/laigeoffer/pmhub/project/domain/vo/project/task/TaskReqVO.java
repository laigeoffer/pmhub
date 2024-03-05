package com.laigeoffer.pmhub.project.domain.vo.project.task;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.laigeoffer.pmhub.project.domain.vo.project.log.ForUpdate;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author canghe
 * @date 2022-12-12 11:10
 */
public class TaskReqVO {
    /**
     * 任务id
     */
    private String taskId;
    /**
     * 页码
     */
    private Integer pageNum;
    /**
     * 页数
     */
    private Integer pageSize;
    /**
     * 项目id
     */
    private String projectId;
    @ForUpdate(fieldName = "任务名称")
    private String taskName;
    /**
     * 阶段code
     */
    private Integer stageCode;
    /**
     * 任务id
     */
    private String executor;
    @ForUpdate(fieldName = "执行人")
    private Long userId;
    @ForUpdate(fieldName = "描述")
    private String description;
    private String createdBy;
    @ForUpdate(fieldName = "执行状态")
    private Integer executeStatus;
    @ForUpdate(fieldName = "任务状态")
    private Integer status;
    private Integer type;
    @ForUpdate(fieldName = "任务优先级")
    private Integer taskPriority;
    /**
     * 所属流程
     */
    private String taskFlow;
    @ForUpdate(fieldName = "开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date beginTime;
    @ForUpdate(fieldName = "结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date endTime;
    @ForUpdate(fieldName = "截止时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date closeTime;
    /**
     * 项目阶段id
     */
    private String projectStageId;
    @ForUpdate(fieldName = "任务进度")
    private BigDecimal taskProcess;

    private String approved;
    private String definitionId;
    private String deploymentId;

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

    public String getDeploymentId() {
        return deploymentId;
    }

    public void setDeploymentId(String deploymentId) {
        this.deploymentId = deploymentId;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public Integer getStageCode() {
        return stageCode;
    }

    public void setStageCode(Integer stageCode) {
        this.stageCode = stageCode;
    }

    public String getExecutor() {
        return executor;
    }

    public void setExecutor(String executor) {
        this.executor = executor;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Integer getExecuteStatus() {
        return executeStatus;
    }

    public void setExecuteStatus(Integer executeStatus) {
        this.executeStatus = executeStatus;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getTaskPriority() {
        return taskPriority;
    }

    public void setTaskPriority(Integer taskPriority) {
        this.taskPriority = taskPriority;
    }

    public String getTaskFlow() {
        return taskFlow;
    }

    public void setTaskFlow(String taskFlow) {
        this.taskFlow = taskFlow;
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

    public String getProjectStageId() {
        return projectStageId;
    }

    public void setProjectStageId(String projectStageId) {
        this.projectStageId = projectStageId;
    }

    public BigDecimal getTaskProcess() {
        return taskProcess;
    }

    public void setTaskProcess(BigDecimal taskProcess) {
        this.taskProcess = taskProcess;
    }
}
