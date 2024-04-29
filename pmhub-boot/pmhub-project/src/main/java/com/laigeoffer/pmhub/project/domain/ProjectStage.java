package com.laigeoffer.pmhub.project.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 项目阶段
 * @author canghe
 * @date 2022-12-12 13:57
 */
@Data
@TableName("pmhub_project_stage")
public class ProjectStage implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId(type = IdType.ASSIGN_UUID)
    private String id;

    /**
     * 阶段编码
     */
    private Integer stageCode;

    /**
     * 阶段名称
     */
    private String stageName;

    /**
     * 阶段描述
     */
    private String description;

    /**
     * 项目id
     */
    private String projectId;

    /**
     * 是否删除 0-否 1-删除
     */
    private Integer deleted;

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

