package com.laigeoffer.pmhub.project.domain;

/**
 * @author canghe
 * @date 2022-12-12 14:06
 */

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.laigeoffer.pmhub.project.domain.vo.project.log.ForUpdate;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 项目-任务表
 * @author canghe
 * @date 2022-12-12 13:57
 */
@Data
@TableName("pmhub_project_task")
public class ProjectTask implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId(type = IdType.ASSIGN_UUID)
    private String id;

    /**
     * 创建人
     */
    private String createdBy;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createdTime;
    @TableField(exist = false)
    private String createdDate;

    /**
     * 更新人
     */
    private String updatedBy;

    /**
     * 更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updatedTime;

    /**
     * 任务名称
     */
    @ForUpdate(fieldName = "任务名称")
    private String taskName;

    /**
     * 项目id
     */
    private String projectId;

    /**
     * 任务优先级
     */
    @ForUpdate(fieldName = "任务优先级")
    private Integer taskPriority;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 项目阶段id
     */
    private String projectStageId;

    /**
     * 任务描述
     */
    @ForUpdate(fieldName = "描述")
    private String description;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ForUpdate(fieldName = "开始时间")
    private Date beginTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ForUpdate(fieldName = "结束时间")
    private Date endTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ForUpdate(fieldName = "截止时间")
    private Date closeTime;
    private String taskPid;
    private String assignTo;
    @ForUpdate(fieldName = "任务状态")
    private Integer status;
    @ForUpdate(fieldName = "执行状态")
    private Integer executeStatus;
    @ForUpdate(fieldName = "任务进度")
    private BigDecimal taskProcess;
    private Integer deleted;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date deletedTime;
    private String taskFlow;

}

