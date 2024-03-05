package com.laigeoffer.pmhub.workflow.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author canghe
 * @createTime 2022/6/28 9:51
 */
@Getter
@AllArgsConstructor
public enum FormType {

    /**
     * 流程表单
     */
    PROCESS(0),

    /**
     * 外置表单
     */
    EXTERNAL(1),

    /**
     * 节点独立表单
     */
    INDEPENDENT(2);

    /**
     * 表单类型
     */
    private final Integer type;
}
