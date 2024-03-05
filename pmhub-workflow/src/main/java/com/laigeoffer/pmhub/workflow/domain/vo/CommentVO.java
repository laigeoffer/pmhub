package com.laigeoffer.pmhub.workflow.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.flowable.engine.task.Comment;

import java.util.Date;

/**
 * @author canghe
 * @date 2023-02-24 11:23
 */
@Data
@ExcelIgnoreUnannotated
public class CommentVO implements Comment {

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date time;
    private String id;
    private String userId;
    private String taskId;
    private String processInstanceId;
    private String type;
    private String fullMessage;
    @Override
    public String getId() {
        return id;
    }

    @Override
    public String getUserId() {
        return userId;
    }

    @Override
    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Override
    public Date getTime() {
        return time;
    }

    @Override
    public void setTime(Date time) {
        this.time = time;
    }

    @Override
    public String getTaskId() {
        return taskId;
    }

    @Override
    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    @Override
    public String getProcessInstanceId() {
        return processInstanceId;
    }

    @Override
    public void setProcessInstanceId(String processInstanceId) {
        this.processInstanceId = processInstanceId;
    }

    @Override
    public String getType() {
        return type;
    }

    @Override
    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String getFullMessage() {
        return fullMessage;
    }

    @Override
    public void setFullMessage(String fullMessage) {
        this.fullMessage = fullMessage;
    }
}
