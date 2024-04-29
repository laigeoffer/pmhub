package com.laigeoffer.pmhub.project.domain.vo.project.task;


import java.util.List;

/**
 * @author canghe
 * @date 2022-12-23 17:31
 */
public class TaskIdsVO {
    /**
     * 任务id
     */
    private List<String> taskIdList;

    public List<String> getTaskIdList() {
        return taskIdList;
    }

    public void setTaskIdList(List<String> taskIdList) {
        this.taskIdList = taskIdList;
    }
}
