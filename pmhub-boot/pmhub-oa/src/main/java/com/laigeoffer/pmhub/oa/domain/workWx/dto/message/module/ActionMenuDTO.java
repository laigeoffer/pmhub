package com.laigeoffer.pmhub.oa.domain.workWx.dto.message.module;

import lombok.Data;

import java.util.List;

/**
 * 卡片右上角更多操作按钮
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class ActionMenuDTO {

    /**
     * 更多操作界面的描述
     * */
    private String desc;

    /**
     * 操作列表，列表长度取值范围为 [1, 3]
     * */
    private List<ActionListDTO> action_list;
}
