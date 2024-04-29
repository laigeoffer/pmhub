package com.laigeoffer.pmhub.workflow.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 工作流节点元素视图对象
 *
 * @author canghe
 * @createTime 2022/9/11 22:04
 */
@Data
@ExcelIgnoreUnannotated
public class WfProcNodeVo implements Serializable {
    /**
     * 流程ID
     */
    private String procDefId;
    /**
     * 活动ID
     */
    private String activityId;
    /**
     * 活动名称
     */
    private String activityName;
    /**
     * 活动类型
     */
    private String activityType;
    /**
     * 活动耗时
     */
    private String duration;
    /**
     * 执行人Id
     */
    private Long assigneeId;
    /**
     * 执行人名称
     */
    private String assigneeName;
    /**
     * 候选执行人
     */
    private String candidate;
    /**
     * 任务意见
     */
    private List<CommentVO> commentList;
    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    /**
     * 结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date endTime;
}
