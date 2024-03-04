package com.laigeoffer.pmhub.workflow.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 流程抄送对象 wf_copy
 *
 * @author canghe
 * @date 2022-05-19
 */
@Data
@TableName("pmhub_wf_copy")
public class WfCopy {

    private static final long serialVersionUID=1L;

    /**
     * 抄送主键
     */
    @TableId(value = "copy_id")
    private Long copyId;
    /**
     * 抄送标题
     */
    private String title;
    /**
     * 流程主键
     */
    private String processId;
    /**
     * 流程名称
     */
    private String processName;
    /**
     * 流程分类主键
     */
    private String categoryId;
    /**
     * 部署主键
     */
    private String deploymentId;
    /**
     * 流程实例主键
     */
    private String instanceId;
    /**
     * 任务主键
     */
    private String taskId;
    /**
     * 用户主键
     */
    private Long userId;
    /**
     * 发起人Id
     */
    private Long originatorId;
    /**
     * 发起人名称
     */
    private String originatorName;
    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @TableLogic
    private String delFlag;

    /**
     * 创建者
     */
    private String createBy;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    /**
     * 更新者
     */
    private String updateBy;

    /**
     * 更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;

}
