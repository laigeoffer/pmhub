package com.laigeoffer.pmhub.oa.domain.workWx;

import lombok.Data;

import java.util.List;

/**
 * 企微消息更新模板
 * @author canghe
 */
@Data
public class WxUpdateMessage {

    /**
     * 企业的成员ID列表（最多支持1000个）
     * */
    private List<String> userids;

    /**
     * 	企业的部门ID列表（最多支持100个）
     * */
    private List<String> partyids;

    /**
     * 标签ID列表，多个接收者用‘|’分隔，最多支持100个。当touser为@all时忽略本参数
     * */
    private List<String> tagids;

    /**
     * 更新整个任务接收人员
     * */
    private Integer atall ;

    /**
     * 更新卡片所需要消费的code，可通过发消息接口和回调接口返回值获取，一个code只能调用一次该接口，且只能在72小时内调用
     * */
    private String response_code;

    /**
     * 企业应用的id，整型。企业内部开发，可在应用的设置页面查看；第三方服务商，可通过接口 获取企业授权信息 获取该参数值
     * */
    private Integer agentid;

    /**
     * 表示是否开启id转译，0表示否，1表示是，默认0
     * */
    private Integer enable_id_trans;
}
