package com.laigeoffer.pmhub.workflow.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 流程模型视图对象
 *
 * @author canghe
 * @createTime 2022/6/21 9:16
 */
@Data
public class WfModelVo {
    /**
     * 模型ID
     */
    private String modelId;
    /**
     * 模型名称
     */
    private String modelName;
    /**
     * 模型Key
     */
    private String modelKey;
    /**
     * 分类编码
     */
    private String category;
    /**
     * 版本
     */
    private Integer version;
    /**
     * 表单类型
     */
    private Integer formType;
    /**
     * 表单ID
     */
    private Long formId;
    /**
     * 模型描述
     */
    private String description;
    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    /**
     * 流程xml
     */
    private String bpmnXml;
    /**
     * 表单内容
     */
    private String content;

    private Boolean deployed;
}
