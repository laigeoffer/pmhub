package com.laigeoffer.pmhub.workflow.domain.vo;

import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 流程模型对象导出VO
 *
 * @author canghe
 */
@Data
@NoArgsConstructor
public class WfModelExportVo implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 模型ID
     */
    @ExcelProperty(value = "模型ID")
    private String modelId;
    /**
     * 模型Key
     */
    @ExcelProperty(value = "模型Key")
    private String modelKey;
    /**
     * 模型名称
     */
    @ExcelProperty(value = "模型名称")
    private String modelName;
    /**
     * 分类编码
     */
    @ExcelProperty(value = "分类编码")
    private String category;
    /**
     * 流程分类
     */
    @ExcelProperty(value = "流程分类")
    private String categoryName;
    /**
     * 模型版本
     */
    @ExcelProperty(value = "模型版本")
    private Integer version;
    /**
     * 模型描述
     */
    @ExcelProperty(value = "模型描述")
    private String description;
    /**
     * 创建时间
     */
    @ExcelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
}
