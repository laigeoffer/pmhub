package com.laigeoffer.pmhub.base.notice.domain.dto;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.laigeoffer.pmhub.base.notice.domain.entity.Message;
import com.laigeoffer.pmhub.base.notice.utils.StringCreateUtils;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 任务已逾期提醒
 * @author canghe
 */
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = TaskOvertimeRemindDTO.class, name = "任务已逾期提醒")
})
@EqualsAndHashCode(callSuper = true)
@Data
public class TaskOvertimeRemindDTO extends Message {

    private static final String DESC = "<div class='gray'>%s</div> <div class='normal'>您的任务【%s】已经逾期，请及时处理！</div>";
    private static final String MSG_TITLE = "任务逾期提醒";
    private static final String BUTTON_TEXT = "查看详情";

    /**
     * 企微消息类型固定为 textCard
     * */
    public final String msgType = "textcard";


    /**
     * 任务名
     * */
    private String taskName;


    /**
     * 详情url
     * */
    private String detailUrl;

    private String oaTitle;
    private String oaContext;
    private String userName;
    private String linkUrl;


    /**
     * 转微信消息
     * */
    public NoticeWxMessageDTO toWxMessage(){
        NoticeWxMessageDTO noticeWxMessageDTO = new NoticeWxMessageDTO();

        // 设置通知对象
        // 拼接微信格式的用户id
        noticeWxMessageDTO.setTouser(StringCreateUtils.listStringCompose(getUserIds(),"|"));

        // 设置应用id
        noticeWxMessageDTO.setAgentid(getAgentId());

        // 是否开启id转译
        if (ObjectUtil.isNotEmpty(getEnableIdTrans())&&getEnableIdTrans()){
            noticeWxMessageDTO.setEnable_id_trans(1);
        }else {
            noticeWxMessageDTO.setEnable_id_trans(0);
        }
        // 是否开启重复消息检查
        if (ObjectUtil.isNotEmpty(getEnableDuplicateCheck())&&getEnableDuplicateCheck()){
            noticeWxMessageDTO.setEnable_duplicate_check(1);
        }else {
            noticeWxMessageDTO.setEnable_duplicate_check(0);
        }
        // 重复消息检查的时间间隔
        noticeWxMessageDTO.setDuplicate_check_interval(getDuplicateCheckInterval());

        // 设置模板消息
        TextCardDTO textcard = new TextCardDTO();
        textcard.setBtntxt(BUTTON_TEXT);
        textcard.setUrl(detailUrl);
        textcard.setDescription(String.format(DESC, DateUtil.now(),taskName));
        textcard.setTitle(MSG_TITLE);

        noticeWxMessageDTO.setMsgtype(msgType);
        noticeWxMessageDTO.setTextcard(textcard);
        return noticeWxMessageDTO;
    }

}
