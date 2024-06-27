package com.laigeoffer.pmhub.base.notice.domain.dto;

import lombok.Data;

/**
 * 关键数据样式
 * @author canghe
 */
@Data
public class EmphasisContentDTO {

    /**
     * 关键数据样式的数据内容，建议不超过14个字
     * */
    private String title;

    /**
     * 关键数据样式的数据描述内容，建议不超过22个字
     * */
    private String desc;

}
