package com.laigeoffer.pmhub.workflow.domain.dto;

import lombok.Data;

/**
 * @author canghe
 * @createTime 2022/6/21 9:16
 */
@Data
public class WfMetaInfoDto {

    /**
     * 创建者（username）
     */
    private String createUser;

    /**
     * 流程描述
     */
    private String description;
    /**
     * 表单类型
     */
    private Integer formType;
    /**
     * 表单编号
     */
    private Long formId;

}
