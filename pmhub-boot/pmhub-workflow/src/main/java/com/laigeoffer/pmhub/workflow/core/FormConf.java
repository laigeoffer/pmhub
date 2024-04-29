package com.laigeoffer.pmhub.workflow.core;

import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 表单属性类
 *
 * @author canghe
 * @createTime 2022/8/6 18:54
 */
@Data
public class FormConf {

    /**
     * 标题
     */
    private String title;
    /**
     * 表单名
     */
    private String formRef;
    /**
     * 表单模型
     */
    private String formModel;
    /**
     * 表单尺寸
     */
    private String size;
    /**
     * 标签对齐
     */
    private String labelPosition;
    /**
     * 标签宽度
     */
    private Integer labelWidth;
    /**
     * 校验模型
     */
    private String formRules;
    /**
     * 栅格间隔
     */
    private Integer gutter;
    /**
     * 禁用表单
     */
    private Boolean disabled = false;
    /**
     * 栅格占据的列数
     */
    private Integer span;
    /**
     * 表单按钮
     */
    private Boolean formBtns = true;
    /**
     * 表单项
     */
    private List<Map<String, Object>> fields;
}
