package com.laigeoffer.pmhub.oa.domain.workWx.dto.message.body.template.update;

import com.laigeoffer.pmhub.oa.domain.workWx.WxUpdateMessage;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.message.module.ButtonDTO;
import lombok.Data;

/**
 * 更新微信消息按钮状态模板
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class ProcessWxMessageStateUpdateDTO extends WxUpdateMessage {

    /**
     * 按钮
     * */
    private ButtonDTO button = new ButtonDTO();

}
