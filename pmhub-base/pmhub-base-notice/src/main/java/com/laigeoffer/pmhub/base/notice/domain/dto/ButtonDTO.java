package com.laigeoffer.pmhub.base.notice.domain.dto;

import com.laigeoffer.pmhub.base.notice.enums.ButtonStateEnum;
import lombok.Data;

/**
 * 按钮，列表长度不超过6
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class ButtonDTO {

    /**
     * 按钮点击事件类型，0 或不填代表回调点击事件，1 代表跳转url
     * */
    private Integer type;

    /**
     * 按钮文案，建议不超过10个字
     * */
    private String text;


    /**
     * 	按钮样式，目前可填1~4，不填或错填默认1
     * */
    private Integer style;

    /**
     * 按钮key值，用户点击后，会产生回调事件将本参数作为EventKey返回，回调事件会带上该key值，最长支持1024字节，不可重复，button_list.type是0时必填
     * */
    private String key;

    /**
     * 跳转事件的url，button_list.type是1时必填
     * */
    private String url;

    /*以下部分为更新按钮时需要的*/

    /**
     * 需要更新的按钮的文案
     * */
    private ButtonStateEnum replace_name;

}
