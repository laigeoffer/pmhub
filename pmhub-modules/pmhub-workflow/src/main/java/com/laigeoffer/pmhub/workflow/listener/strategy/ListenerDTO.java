package com.laigeoffer.pmhub.workflow.listener.strategy;

import lombok.Data;

import java.util.List;

/**
 * @author canghe
 * @date 2023-07-11 09:53
 */
@Data
public class ListenerDTO {
    /**
     * 详情地址
     */
    private String detailUrl;
    /**
     * 实例 id
     */
    private String instId;
    /**
     * 流程任务 id
     */
    private String taskId;
    /**
     * 企微姓名
     */
    private String wxUserName;
    /**
     * 执行人
     */
    private String assignee;
    /**
     * 用户 id
     */
    private List<String> userIds;
    /**
     * 标题
     */
    private String title;
    /**
     * 备注
     */
    private String remarks;
    /**
     * 类型
     */
    private String processType;
    /**
     * 创建者
     */
    private String createUserName;
    private String panelUrl;

    private String oaTitle;
    private String oaContext;
    private String userName;
    private String linkUrl;
}
