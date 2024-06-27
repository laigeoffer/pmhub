package com.laigeoffer.pmhub.base.notice.domain.dto;

import lombok.Data;

/**
 * 卡片来源样式信息，不需要来源样式可不填写
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class SourceDTO {

    /**
     * 来源图片的url，来源图片的尺寸建议为72*72
     * */
    private String icon_url;

    /**
     * 来源图片的描述，建议不超过20个字，（支持id转译）
     * */
    private String desc;

    /**
     * 来源文字的颜色，目前支持：0(默认) 灰色，1 黑色，2 红色，3 绿色
     * */
    private Integer desc_color;

}
