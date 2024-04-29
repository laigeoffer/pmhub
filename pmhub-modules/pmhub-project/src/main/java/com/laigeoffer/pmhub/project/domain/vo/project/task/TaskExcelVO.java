package com.laigeoffer.pmhub.project.domain.vo.project.task;


import com.laigeoffer.pmhub.base.core.annotation.Excel;

/**
 * @author canghe
 * @date 2022-12-26 14:58
 */
public class TaskExcelVO {
    @Excel(name = "项目编码(必填)")
    private String projectCode;
    @Excel(name = "任务名称(必填)")
    private String taskName;
    @Excel(name = "优先级(必填)")
    private String taskPriority;
    @Excel(name = "执行人(必填)")
    private String username;
    @Excel(name = "开始时间")
    private String beginTime;
    @Excel(name = "结束时间")
    private String endTime;
    @Excel(name = "截止时间")
    private String closeTime;

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskPriority() {
        return taskPriority;
    }

    public void setTaskPriority(String taskPriority) {
        this.taskPriority = taskPriority;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(String closeTime) {
        this.closeTime = closeTime;
    }
}
