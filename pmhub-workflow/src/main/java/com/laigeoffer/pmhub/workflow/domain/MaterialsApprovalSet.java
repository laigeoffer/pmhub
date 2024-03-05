package com.laigeoffer.pmhub.workflow.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * @author canghe
 * @date 2023-04-20 13:53
 */
@Data
@TableName("pmhub_materials_approval_set")
public class MaterialsApprovalSet {

    @TableId(type = IdType.ASSIGN_UUID)
    private String id;
    private String type;
    private String approved;
    @TableField(value = "definition_id", updateStrategy = FieldStrategy.IGNORED)
    private String definitionId;
    @TableField(value = "deployment_id", updateStrategy = FieldStrategy.IGNORED)
    private String deploymentId;

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
     * 任务id
     */
    private String extraId;
}
