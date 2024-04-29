package com.laigeoffer.pmhub.project.domain.vo.project.task;

import com.laigeoffer.pmhub.common.annotation.Excel;

import java.util.Date;

/**
 * @author canghe
 * @date 2022-12-22 09:20
 */
public class TaskExportVO {

    @Excel(name = "任务名称")
    private String taskName;
    @Excel(name = "所属项目")
    private String projectName;
    @Excel(name = "所处阶段")
    private String stageName;
    @Excel(name = "执行人")
    private String executor;
    private Integer status;
    private Integer executeStatus;
    private Integer taskPriority;
    @Excel(name = "执行状态")
    private String executeStatusName;
    @Excel(name = "任务状态")
    private String statusName;
    @Excel(name = "优先级")
    private String taskPriorityName;
    @Excel(name = "创建人")
    private String createdBy;
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss", type = Excel.Type.EXPORT)
    private Date createdTime;

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getStageName() {
        return stageName;
    }

    public void setStageName(String stageName) {
        this.stageName = stageName;
    }

    public String getExecutor() {
        return executor;
    }

    public void setExecutor(String executor) {
        this.executor = executor;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getExecuteStatus() {
        return executeStatus;
    }

    public void setExecuteStatus(Integer executeStatus) {
        this.executeStatus = executeStatus;
    }

    public Integer getTaskPriority() {
        return taskPriority;
    }

    public void setTaskPriority(Integer taskPriority) {
        this.taskPriority = taskPriority;
    }

    public String getExecuteStatusName() {
        return executeStatusName;
    }

    public void setExecuteStatusName(String executeStatusName) {
        this.executeStatusName = executeStatusName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getTaskPriorityName() {
        return taskPriorityName;
    }

    public void setTaskPriorityName(String taskPriorityName) {
        this.taskPriorityName = taskPriorityName;
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
}
