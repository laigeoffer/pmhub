package com.laigeoffer.pmhub.project.domain.vo.project.task;


/**
 * @author canghe
 * @date 2022-12-12 10:02
 */

public class TaskStatisticsVO {
    /**
     * 状态
     */
    private Integer status;
    private String statusName;
    /**
     * 任务数
     */
    private Integer taskNum;

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

    public Integer getTaskNum() {
        return taskNum;
    }

    public void setTaskNum(Integer taskNum) {
        this.taskNum = taskNum;
    }
}
