package com.laigeoffer.pmhub.project.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @author canghe
 * @date 2023-03-16 09:13
 */
@Data
@TableName("pmhub_project_task_notify")
public class ProjectTaskNotify {

    @TableId(type = IdType.ASSIGN_UUID)
    private String id;
    /**
     * 项目id
     */
    private String projectId;
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
     * 是否逾期
     */
    private Integer overdue;
    /**
     * 截止时间
     */
    private Date closeTime;
}
