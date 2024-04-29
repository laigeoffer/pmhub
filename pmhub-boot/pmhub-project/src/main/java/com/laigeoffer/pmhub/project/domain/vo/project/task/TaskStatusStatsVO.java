package com.laigeoffer.pmhub.project.domain.vo.project.task;


/**
 * @author canghe
 * @date 2022-12-20 09:19
 */

public class TaskStatusStatsVO {
    /**
     * 总数
     */
    private Integer total;
    /**
     * 逾期
     */
    private Integer overdue;
    /**
     * 今日到期
     */
    private Integer expireToday;
    /**
     * 待认领
     */
    private Integer toBeAssign;
    /**
     * 逾期完成
     */
    private Integer doneOverdue;
    /**
     * 完成
     */
    private Integer done;
    /**
     * 未完成
     */
    private Integer unDone;
    /**
     * 时间待定
     */
    private Integer timeUndetermined;

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Integer getOverdue() {
        return overdue;
    }

    public void setOverdue(Integer overdue) {
        this.overdue = overdue;
    }

    public Integer getExpireToday() {
        return expireToday;
    }

    public void setExpireToday(Integer expireToday) {
        this.expireToday = expireToday;
    }

    public Integer getToBeAssign() {
        return toBeAssign;
    }

    public void setToBeAssign(Integer toBeAssign) {
        this.toBeAssign = toBeAssign;
    }

    public Integer getDoneOverdue() {
        return doneOverdue;
    }

    public void setDoneOverdue(Integer doneOverdue) {
        this.doneOverdue = doneOverdue;
    }

    public Integer getDone() {
        return done;
    }

    public void setDone(Integer done) {
        this.done = done;
    }

    public Integer getUnDone() {
        return unDone;
    }

    public void setUnDone(Integer unDone) {
        this.unDone = unDone;
    }

    public Integer getTimeUndetermined() {
        return timeUndetermined;
    }

    public void setTimeUndetermined(Integer timeUndetermined) {
        this.timeUndetermined = timeUndetermined;
    }
}
