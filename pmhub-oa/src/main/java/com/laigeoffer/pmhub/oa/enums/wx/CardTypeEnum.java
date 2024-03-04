package com.laigeoffer.pmhub.oa.enums.wx;

/**
 * 模板卡片类型
 * @author canghe
 */
public enum CardTypeEnum {

    /**
     * 按钮交互型
     * */
    BUTTON_INTERACTION("button_interaction"),

    /**
     * 文本通知型
     * */
    TEXT_NOTICE("text_notice");


    private String desc;

    CardTypeEnum(String desc) {
        this.desc = desc;
    }

    @Override
    public String toString(){
        return desc;
    }
}
