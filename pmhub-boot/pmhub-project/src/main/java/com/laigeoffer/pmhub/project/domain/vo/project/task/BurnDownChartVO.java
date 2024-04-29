package com.laigeoffer.pmhub.project.domain.vo.project.task;


/**
 * @author canghe
 * @date 2022-12-21 09:45
 */
public class BurnDownChartVO {
    /**
     * 时间
     */
    private String date;
    /**
     * 基础线
     */
    private Integer baseLineNum;
    /**
     * 任务数
     */
    private Integer taskNum;
    /**
     * 未完成
     */
    private Integer unDoneTaskNum;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Integer getBaseLineNum() {
        return baseLineNum;
    }

    public void setBaseLineNum(Integer baseLineNum) {
        this.baseLineNum = baseLineNum;
    }

    public Integer getTaskNum() {
        return taskNum;
    }

    public void setTaskNum(Integer taskNum) {
        this.taskNum = taskNum;
    }

    public Integer getUnDoneTaskNum() {
        return unDoneTaskNum;
    }

    public void setUnDoneTaskNum(Integer unDoneTaskNum) {
        this.unDoneTaskNum = unDoneTaskNum;
    }
}
