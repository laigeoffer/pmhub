package com.laigeoffer.pmhub.oa.domain.workWx.dto.message.module;

import lombok.Data;

/**
 * 跳转指引样式的列表，该字段可为空数组，但有数据的话需确认对应字段是否必填，列表长度不超过3
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class JumpListDTO {

    /**
     * 	跳转链接类型，0或不填代表不是链接，1 代表跳转url，2 代表跳转小程序
     * */
    private Integer type;

    /**
     * 	跳转链接样式的文案内容，建议不超过18个字
     * */
    private String title;

    /**
     * 跳转链接的url，jump_list.type是1时必填
     * */
    private String url;

    /**
     * 跳转链接的小程序的appid，必须是与当前应用关联的小程序，jump_list.type是2时必填
     * */
    private String appid;

    /**
     * 	跳转链接的小程序的pagepath，jump_list.type是2时选填
     * */
    private String pagepath;

}
