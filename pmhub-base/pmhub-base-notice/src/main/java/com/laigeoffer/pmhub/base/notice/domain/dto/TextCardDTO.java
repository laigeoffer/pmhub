package com.laigeoffer.pmhub.base.notice.domain.dto;

import lombok.Data;

/**
 * 文本卡片消息
 * @author canghe
 */
@Data
public class TextCardDTO {

    /**
     * 标题，不超过128个字节，超过会自动截断（支持id转译）
     * */
    String title;

    /**
     * 描述，不超过512个字节，超过会自动截断（支持id转译）
     * */
    String description;

    /**
     * 点击后跳转的链接。最长2048字节，请确保包含了协议头(http/https)
     * */
    String url;

    /**
     *	按钮文字。 默认为“详情”， 不超过4个文字，超过自动截断。
     * */
    String btntxt;
}
