package com.laigeoffer.pmhub.oa.domain.workWx.dto.message.module;

import lombok.Data;

/**
 * 引用文献样式
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class QuoteAreaDTO {

    /**
     * 	引用文献样式区域点击事件，0或不填代表没有点击事件，1 代表跳转url，2 代表跳转小程序
     * */
    private Integer type;

    /**
     * 点击跳转的url，quote_area.type是1时必填
     * */
    private String url;

    /**
     * 点击跳转的小程序的appid，必须是与当前应用关联的小程序，quote_area.type是2时必填
     * */
    private String appid;

    /**
     * 点击跳转的小程序的pagepath，quote_area.type是2时选填
     * */
    private String pagepath;

    /**
     * 	引用文献样式的标题
     * */
    private String title;

    /**
     * 	引用文献样式的引用文案
     * */
    private String quote_text;


}
