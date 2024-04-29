package com.laigeoffer.pmhub.oa.domain.workWx;

import lombok.Data;

/**
 * 企微消息模板
 * @author canghe
 */
@Data
public class WxMessage {

    /**
     * 成员ID列表（消息接收者，多个接收者用‘|’分隔，最多支持1000个）。特殊情况：指定为@all，则向关注该企业应用的全部成员发送
     * */
    private String touser;

    /**
     * 部门ID列表，多个接收者用‘|’分隔，最多支持100个。当touser为@all时忽略本参数
     * */
    private String toparty;

    /**
     * 标签ID列表，多个接收者用‘|’分隔，最多支持100个。当touser为@all时忽略本参数
     * */
    private String totag;

    /**
     * 消息类型，模板卡片固定为：template_card
     * */
    private String msgtype = "template_card";

    /**
     * 企业应用的id，整型。企业内部开发，可在应用的设置页面查看；第三方服务商，可通过接口 获取企业授权信息 获取该参数值
     * */
    private Integer agentid;

    /**
     * 表示是否开启id转译，0表示否，1表示是，默认0
     * */
    private Integer enable_id_trans;

    /**
     * 表示是否开启重复消息检查，0表示否，1表示是，默认0
     * */
    private Integer enable_duplicate_check;

    /**
     * 表示是否重复消息检查的时间间隔，默认1800s，最大不超过4小时
     * */
    private Integer duplicate_check_interval;

}
