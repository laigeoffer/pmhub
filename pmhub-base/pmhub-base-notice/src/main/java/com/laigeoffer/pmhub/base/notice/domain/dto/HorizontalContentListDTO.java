package com.laigeoffer.pmhub.base.notice.domain.dto;

import lombok.Data;

/**
 * 二级标题+文本列表，该字段可为空数组，但有数据的话需确认对应字段是否必填，列表长度不超过6
 *  TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class HorizontalContentListDTO {

    /**
     * 	链接类型，0或不填代表不是链接，1 代表跳转url，2 代表下载附件，3 代表点击跳转成员详情
     * */
    private Integer type;

    /**
     * 二级标题，建议不超过5个字
     * */
    private String keyname;

    /**
     * 二级文本，type是2，该字段代表文件名称（要包含文件类型），建议不超过30个字，（支持id转译）
     * */
    private String value;

    /**
     * 	链接跳转的url，horizontal_content_list.type是1时必填
     * */
    private String url;

    /**
     * 	附件的media_id，horizontal_content_list.type是2时必填
     * */
    private String media_id;

    /**
     * 	成员详情的userid，horizontal_content_list.type是3时必填
     * */
    private String userid;

}
