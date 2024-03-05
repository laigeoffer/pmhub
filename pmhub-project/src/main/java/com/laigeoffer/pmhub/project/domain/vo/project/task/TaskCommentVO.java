package com.laigeoffer.pmhub.project.domain.vo.project.task;


import java.util.List;

/**
 * @author canghe
 * @date 2022-12-21 14:44
 */
public class TaskCommentVO {
    /**
     * 项目id
     */
    private String projectId;
    /**
     * 任务id
     */
    private String taskId;
    /**
     * 评论
     */
    private String comment;
    /**
     * 用户id
     */
    private List<Long> userIdList;

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

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public List<Long> getUserIdList() {
        return userIdList;
    }

    public void setUserIdList(List<Long> userIdList) {
        this.userIdList = userIdList;
    }
}
