package com.laigeoffer.pmhub.workflow.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * 流程批复视图对象
 *
 * @author canghe
 * @createTime 2022/4/4 02:03
 */
@Data
public class WfCommentVo {

    /**
     * 审批类别
     */
    private String type;

    /**
     * 批复内容
     */
    private String message;

    /**
     * 批复时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date time;


}
