package com.laigeoffer.pmhub.base.notice.domain.dto;

import lombok.Data;

/**
 * 消息标题
 * @author canghe
 */
@Data
public class MainTitleDTO {

    /**
     * 一级标题，建议不超过36个字，文本通知型卡片本字段非必填，但不可本字段和sub_title_text都不填，（支持id转译）
     * */
    private String title;

    /**
     * 标题辅助信息，建议不超过44个字，（支持id转译）
     * */
    private String desc;

}
