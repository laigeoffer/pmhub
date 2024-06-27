package com.laigeoffer.pmhub.base.notice.domain.dto;

import lombok.Data;

/**
 * 整体卡片的点击跳转事件，text_notice必填本字段
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class CardActionDTO {

    /**
     * 	跳转事件类型，1 代表跳转url，2 代表打开小程序。text_notice卡片模版中该字段取值范围为[1,2]
     * */
    private Integer type;

    /**
     * 跳转链接的url，type是1时必填
     * */
    private String url;

    /**
     * 跳转链接的小程序的appid，必须是与当前应用关联的小程序，type是2时必填
     * */
    private String appid;

    /**
     * 	跳转链接的小程序的pagepath，type是2时选填
     * */
    private String pagepath;

}
