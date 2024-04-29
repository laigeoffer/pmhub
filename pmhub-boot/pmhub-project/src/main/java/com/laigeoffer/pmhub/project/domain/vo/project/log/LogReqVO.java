package com.laigeoffer.pmhub.project.domain.vo.project.log;

/**
 * @author canghe
 * @date 2022-12-21 14:30
 */
public class LogReqVO {
    /**
     * 任务id
     */
    private String taskId;
    /**
     * 类型
     */
    private Integer logType;
    /**
     * 页码
     */
    private Integer pageNum;
    /**
     * 页数
     */
    private Integer pageSize;

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public Integer getLogType() {
        return logType;
    }

    public void setLogType(Integer logType) {
        this.logType = logType;
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
}
