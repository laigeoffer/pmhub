package com.laigeoffer.pmhub.oa.domain.workWx.dto.message.body.template;

import com.laigeoffer.pmhub.oa.domain.workWx.WxMessage;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.message.template.TemplateCardDTO;
import lombok.Data;

/**
 * 微信提醒消息模板
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class ProcessWxMessageDTO extends WxMessage {

    /**
     * 卡片模板
     * */
    private TemplateCardDTO template_card;

}
