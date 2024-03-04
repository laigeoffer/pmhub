package com.laigeoffer.pmhub.project.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author canghe
 * @date 2022-12-09 15:36
 */

@TableName("pmhub_project")
@Data
public class Project implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId(type = IdType.ASSIGN_UUID)
    private String id;

    /**
     * 项目编码
     */
    private String projectCode;

    /**
     * 项目名称
     */
    private String projectName;

    /**
     * 描述
     */
    private String description;

    /**
     * 项目开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date closeBeginTime;

    /**
     * 项目结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date closeEndTime;

    /**
     * 封面
     */
    private String cover;

    /**
     * 项目阶段 默认是0
     */
    private Integer stageCode;

    /**
     * 项目类型 是否私有 0-公开 1-私有
     */
    private Integer type;

    /**
     * 项目编号前缀
     */
    private String prefix;
    private Integer openPrefix;

    /**
     * 是否删除 0-否 1-删除
     */
    private Integer deleted;

    /**
     * 删除时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date deletedTime;

    /**
     * 是否归档 0-否 1-归档
     */
    private Integer archived;

    /**
     * 归档时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date archivedTime;

    /**
     * 是否发布 0-否 1-发布
     */
    private Integer published;

    /**
     * 项目进度
     */
    private BigDecimal ProjectProcess;

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

    /**
     * 项目负责人
     */
    private Long userId;

    /**
     * 项目状态 默认0-未开始
     */
    private Integer status;

    /**
     * 是否自动更新进度 0-否 1-是
     */
    private Integer autoUpdateProcess;

    /**
     * 是否开启任务开始时间
     */
    private Integer openBeginTime;

    /**
     * 是否开启新任务默认开启隐私模式
     */
    private Integer openTaskPrivate;

    /**
     * 是否开启消息提醒
     */
    private Integer msgNotify;
    /**
     * 提醒天数
     */
    private Integer notifyDay;

    @TableField(exist = false)
    private String projectId;
    @TableField(exist = false)
    private Integer projectType;
    private String projectStageId;

}
