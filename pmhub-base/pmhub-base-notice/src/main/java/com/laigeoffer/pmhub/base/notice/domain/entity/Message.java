package com.laigeoffer.pmhub.base.notice.domain.entity;

import lombok.Data;

import java.util.List;

/**
 * 消息
 * @author canghe
 */
@Data
public class Message {

    /**
     * teskid
     * */
    String instId;

    /**
     * 需要通知的用户id清单，为null时无效，长度为0时则为全公司用户
     * */
    List<String> userIds;

    /**
     * 按部门通知id列表，为null时无效，userIds为全公司时无效
     * */
    List<String> deptList;

    /**
     * 按标签通知列表，为null时无效，userIds为全公司时无效
     * */
    List<String> tags;

    /**
     * 通知应用id
     * */
    Integer agentId;

    /**
     * 表示是否开启id转译
     * */
    Boolean enableIdTrans;

    /**
     * 是否开启重复消息检查
     * */
    Boolean enableDuplicateCheck;

    /**
     * 重复消息检查的时间间隔（秒，最大不超过4小时）
     * */
    Integer duplicateCheckInterval;

    String taskId;

    String wxUserName;

    String assignee;
}
