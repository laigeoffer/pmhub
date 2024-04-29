package com.laigeoffer.pmhub.workflow.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;


/**
 * 流程抄送视图对象 wf_copy
 *
 * @author canghe
 * @date 2022-05-19
 */
@Data
@ExcelIgnoreUnannotated
public class WfCopyVo {

    private static final long serialVersionUID = 1L;

    /**
     * 抄送主键
     */
    @ExcelProperty(value = "抄送主键")
    private Long copyId;

    /**
     * 抄送标题
     */
    @ExcelProperty(value = "抄送标题")
    private String title;

    /**
     * 流程主键
     */
    @ExcelProperty(value = "流程主键")
    private String processId;

    /**
     * 流程名称
     */
    @ExcelProperty(value = "流程名称")
    private String processName;

    /**
     * 流程分类主键
     */
    @ExcelProperty(value = "流程分类主键")
    private String categoryId;

    /**
     * 部署主键
     */
    @ExcelProperty(value = "部署主键")
    private String deploymentId;

    /**
     * 流程实例主键
     */
    @ExcelProperty(value = "流程实例主键")
    private String instanceId;

    /**
     * 任务主键
     */
    @ExcelProperty(value = "任务主键")
    private String taskId;

    /**
     * 用户主键
     */
    @ExcelProperty(value = "用户主键")
    private Long userId;

    /**
     * 发起人Id
     */
    @ExcelProperty(value = "发起人主键")
    private Long originatorId;

    /**
     * 发起人名称
     */
    @ExcelProperty(value = "发起人名称")
    private String originatorName;

    /**
     * 抄送时间（创建时间）
     */
    @ExcelProperty(value = "抄送时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
}
