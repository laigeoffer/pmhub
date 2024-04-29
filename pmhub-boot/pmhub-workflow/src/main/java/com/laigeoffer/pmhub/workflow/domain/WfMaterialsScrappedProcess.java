package com.laigeoffer.pmhub.workflow.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author canghe
 * @date 2023-02-28 10:09
 */
@Data
@TableName("pmhub_materials_scrapped_process")
public class WfMaterialsScrappedProcess implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 主键id
     */
    @TableId(type = IdType.ASSIGN_UUID)
    private String id;
    private String approved;
    private String materialId;
    @TableField(value = "instance_id", updateStrategy = FieldStrategy.IGNORED)
    private String instanceId;
    @TableField(value = "deployment_id", updateStrategy = FieldStrategy.IGNORED)
    private String deploymentId;
    @TableField(value = "definition_id", updateStrategy = FieldStrategy.IGNORED)
    private String definitionId;
    @TableField(value = "task_id", updateStrategy = FieldStrategy.IGNORED)
    private String taskId;
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

    private String type;
    @TableField(value = "url", updateStrategy = FieldStrategy.IGNORED)
    private String url;


}