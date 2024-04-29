package com.laigeoffer.pmhub.project.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 任务工时表
 * @author canghe
 * @date 2022-12-12 14:10
 */

@Data
@TableName("pmhub_project_task_work_time")
public class ProjectTaskWorkTime implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId(type = IdType.ASSIGN_UUID)
    private String id;

    /**
     * 任务id
     */
    private String projectTaskId;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 工时
     */
    private BigDecimal workTime;

    /**
     * 项目id
     */
    private String projectId;

    /**
     * 创建人
     */
    private String createdBy;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createdTime;

    /**
     * 更新人
     */
    private String updatedBy;

    /**
     * 更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updatedTime;

}
