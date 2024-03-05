package com.laigeoffer.pmhub.workflow.domain.vo;

import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * 我拥有流程对象导出VO
 *
 * @author canghe
 */
@Data
@NoArgsConstructor
public class WfOwnTaskExportVo implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 流程实例ID
     */
    @ExcelProperty(value = "流程编号")
    private String procInsId;

    /**
     * 流程名称
     */
    @ExcelProperty(value = "流程名称")
    private String procDefName;

    /**
     * 流程类别
     */
    @ExcelProperty(value = "流程类别")
    private String category;

    /**
     * 流程版本
     */
    @ExcelProperty(value = "流程版本")
    private int procDefVersion;

    /**
     * 提交时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ExcelProperty(value = "提交时间")
    private Date createTime;

    /**
     * 流程状态
     */
    @ExcelProperty(value = "流程状态")
    private String status;

    /**
     * 任务耗时
     */
    @ExcelProperty(value = "任务耗时")
    private String duration;

    /**
     * 当前节点
     */
    @ExcelProperty(value = "当前节点")
    private String taskName;

    /**
     * 任务完成时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date finishTime;
}
