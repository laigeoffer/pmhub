package com.laigeoffer.pmhub.base.notice.domain.dto;

import lombok.Data;

import java.util.List;

/**
 * 模板卡片，默认为文本信息卡片
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * 格式参考：
 * <a href="https://developer.work.weixin.qq.com/document/path/90236#%E6%A8%A1%E6%9D%BF%E5%8D%A1%E7%89%87%E6%B6%88%E6%81%AF">
 * </a>
 * @author canghe
 */
@Data
public class TemplateCardDTO {

    /**
     * 模板卡片类型，文本通知型卡片填写 "text_notice"
     * */
    private String card_type = "text_notice";


    /**
     * 卡片来源样式信息，不需要来源样式可不填写
     * */
    private SourceDTO source;

    /**
     * 卡片右上角更多操作按钮
     * */
    private ActionMenuDTO action_menu;

    /**
     * 任务id，同一个应用任务id不能重复，只能由数字、字母和“_-@”组成，最长128字节，填了action_menu字段的话本字段必填
     * */
    private String task_id;

    /**
     * 消息标题
     * */
    private MainTitleDTO main_title;


    /**
     * 引用文献样式
     * */
    private QuoteAreaDTO quote_area;

    /**
     * 关键数据样式
     * */
    private EmphasisContentDTO emphasis_content;


    /**
     * 二级普通文本，建议不超过160个字，（支持id转译）
     * */
    private String sub_title_text;

    /**
     * 	二级标题+文本列表，该字段可为空数组，但有数据的话需确认对应字段是否必填，列表长度不超过6
     * */
    private List<HorizontalContentListDTO> horizontal_content_list;

    /**
     * 	跳转指引样式的列表，该字段可为空数组，但有数据的话需确认对应字段是否必填，列表长度不超过3
     * */
    private List<JumpListDTO> jump_list;

    /**
     * 整体卡片的点击跳转事件，text_notice必填本字段
     * */
    private CardActionDTO card_action;

    /**
     * 按钮
     * */
    private List<ButtonDTO> button_list;


}
