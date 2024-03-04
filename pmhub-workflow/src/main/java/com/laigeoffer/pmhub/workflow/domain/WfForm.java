package com.laigeoffer.pmhub.workflow.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 流程表单对象 wf_form
 *
 * @author canghe
 * @createTime 2022/3/7 22:07
 */
@Data
@TableName("pmhub_wf_form")
public class WfForm {
    private static final long serialVersionUID = 1L;

    /**
     * 表单主键
     */
    @TableId(value = "form_id")
    private Long formId;

    /**
     * 表单名称
     */
    private String formName;

    /**
     * 表单内容
     */
    private String content;

    /**
     * 备注
     */
    private String remark;

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

    /**
     * 删除标志（0代表存在 2代表删除）
     */
    @TableLogic
    private String delFlag;
}
