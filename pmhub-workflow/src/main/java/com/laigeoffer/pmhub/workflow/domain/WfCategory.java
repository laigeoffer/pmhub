package com.laigeoffer.pmhub.workflow.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 流程分类对象 wf_category
 *
 * @author canghe
 * @date 2022-01-15
 */
@Data
@TableName("pmhub_wf_category")
public class WfCategory {

    private static final long serialVersionUID=1L;

    /**
     * 分类ID
     */
    @TableId(value = "category_id")
    private Long categoryId;
    /**
     * 分类名称
     */
    private String categoryName;
    /**
     * 分类编码
     */
    private String code;
    /**
     * 备注
     */
    private String remark;
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
