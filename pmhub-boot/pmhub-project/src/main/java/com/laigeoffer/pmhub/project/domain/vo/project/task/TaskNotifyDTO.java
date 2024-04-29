package com.laigeoffer.pmhub.project.domain.vo.project.task;

import java.util.Date;

/**
 * @author canghe
 * @date 2023-03-16 09:17
 */
public class TaskNotifyDTO {
    /**
     * 项目id
     */
    private String projectId;
    private Integer status;
    /**
     * 任务id
     */
    private String taskId;
    /**
     * 任务名称
     */
    private String taskName;
    /**
     * 用户id
     */
    private Integer userId;
    /**
     * 企业微信id
     */
    private String userWxName;
    /**
     * 是否逾期提醒
     */
    private Integer msgNotify;
    /**
     * 任务逾期提醒天数
     */
    private Integer notifyDay;
    /**
     * 任务截止时间
     */
    private Date closeTime;

    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserWxName() {
        return userWxName;
    }

    public void setUserWxName(String userWxName) {
        this.userWxName = userWxName;
    }

    public Integer getMsgNotify() {
        return msgNotify;
    }

    public void setMsgNotify(Integer msgNotify) {
        this.msgNotify = msgNotify;
    }

    public Integer getNotifyDay() {
        return notifyDay;
    }

    public void setNotifyDay(Integer notifyDay) {
        this.notifyDay = notifyDay;
    }

    public Date getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Date closeTime) {
        this.closeTime = closeTime;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }
}
