package com.laigeoffer.pmhub.oa.domain.workWx.dto.message.body.notice;

import com.laigeoffer.pmhub.oa.domain.workWx.WxMessage;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.message.module.TextCardDTO;
import lombok.Data;

/**
 * 提醒消息
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class NoticeWxMessageDTO extends WxMessage {

    /**
     * 卡片模板
     * */
    private TextCardDTO textcard;

}
