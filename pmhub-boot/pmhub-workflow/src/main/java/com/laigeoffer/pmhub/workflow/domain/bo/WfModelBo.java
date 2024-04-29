package com.laigeoffer.pmhub.workflow.domain.bo;

import com.laigeoffer.pmhub.common.core.validate.AddGroup;
import com.laigeoffer.pmhub.common.core.validate.EditGroup;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * 流程模型对象
 *
 * @author canghe
 * @createTime 2022/6/21 9:16
 */
@Data
public class WfModelBo {
    /**
     * 模型主键
     */
    @NotNull(message = "模型主键不能为空", groups = { EditGroup.class })
    private String modelId;
    /**
     * 模型名称
     */
    @NotNull(message = "模型名称不能为空", groups = { AddGroup.class, EditGroup.class })
    private String modelName;
    /**
     * 模型Key
     */
    @NotNull(message = "模型Key不能为空", groups = { AddGroup.class, EditGroup.class })
    private String modelKey;
    /**
     * 流程分类
     */
    @NotBlank(message = "流程分类不能为空", groups = { AddGroup.class, EditGroup.class })
    private String category;
    /**
     * 描述
     */
    private String description;
    /**
     * 表单类型
     */
    private Integer formType;
    /**
     * 表单主键
     */
    private Long formId;
    /**
     * 流程xml
     */
    private String bpmnXml;
    /**
     * 是否保存为新版本
     */
    private Boolean newVersion;
}
