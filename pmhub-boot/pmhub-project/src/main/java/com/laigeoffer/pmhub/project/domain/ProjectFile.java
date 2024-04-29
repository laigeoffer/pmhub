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
 * 项目或任务附件表
 * @author canghe
 * @date 2022-12-12 13:49
 */
@Data
@TableName("pmhub_project_file")
public class ProjectFile implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId(type = IdType.ASSIGN_UUID)
    private String id;

    /**
     * 文件归属类型 task 或者 project
     */
    private String type;

    /**
     * type是task 对应就是task的id type是project 对应就是project的id
     */
    private String ptId;

    private Long userId;

    /**
     * 文件名称
     */
    private String fileName;

    /**
     * 扩展名
     */
    private String extension;

    /**
     * 文件完整地址
     */
    private String fileUrl;
    private BigDecimal fileSize;

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

    private String projectId;
    private String pathName;

}

