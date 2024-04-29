package com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ObjectUtil;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.laigeoffer.pmhub.oa.domain.workWx.Message;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.message.body.template.ProcessWxMessageDTO;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.message.module.*;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.message.template.TemplateCardDTO;
import com.laigeoffer.pmhub.oa.enums.wx.CardTypeEnum;
import com.laigeoffer.pmhub.oa.utils.StringCreateUtils;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.ArrayList;
import java.util.List;

/**
 * 审批提醒
 * @author canghe
 */
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = OutboundRemindDTO.class, name = "采购退货出库审批提醒")
})
@EqualsAndHashCode(callSuper = true)
@Data
public class OutboundRemindDTO extends Message {

    private String headDesc = "审批流程提醒";
    private String typeTitle = "您有一个新的审批申请";

    private String[] detailText = {"申请详情","点击查看"};
    private String userText = "申请人";
    private String buttonText = "开始处理";

    /**
     * 企微消息类型固定为TEMPLATE_CARD
     * */
    public String msgType = "template_card";

    /**
     * 审批类型
     * */
    private String processType;


    /**
     * 申请人姓名
     * */
    private String createUserName;

    /**
     * 申请详情url
     * */
    private String detailUrl;

    /**
     * 审批界面url
     * */
    private String panelUrl;

    /**
     * 审批内容标题
     * */
    private String title;

    /**
     * 审批内容备注
     * */
    private String remarks;

    private String oaTitle;
    private String oaContext;
    private String userName;
    private String linkUrl;

    /**
     * 转微信消息
     * */
    public ProcessWxMessageDTO toWxMessage(){
        ProcessWxMessageDTO processWxMessageDTO = new ProcessWxMessageDTO();

        // 设置通知对象
        // 如果传入了用户id
        if (ObjectUtil.isNotNull(getUserIds())){
            if (getUserIds().size()==0){
                // 如果用户id长度为0，则为全体人员
                processWxMessageDTO.setTouser("@all");
            }else {
                // 拼接微信格式的用户id
                processWxMessageDTO.setTouser(StringCreateUtils.listStringCompose(getUserIds(),"|"));
            }
        }else{
            // 没有设置用户id
            if (ObjectUtil.isNotEmpty(getDeptList())){
                // 设置了部门
                processWxMessageDTO.setToparty(StringCreateUtils.listStringCompose(getDeptList(),"|"));
            }
            if (ObjectUtil.isNotEmpty(getDeptList())){
                // 设置了标签
                processWxMessageDTO.setToparty(StringCreateUtils.listStringCompose(getTags(),"|"));
            }
        }

        // 设置应用id
        processWxMessageDTO.setAgentid(getAgentId());

        // 是否开启id转译
        if (ObjectUtil.isNotEmpty(getEnableIdTrans())&&getEnableIdTrans()){
            processWxMessageDTO.setEnable_id_trans(1);
        }else {
            processWxMessageDTO.setEnable_id_trans(0);
        }
        // 是否开启重复消息检查
        if (ObjectUtil.isNotEmpty(getEnableDuplicateCheck())&&getEnableDuplicateCheck()){
            processWxMessageDTO.setEnable_duplicate_check(1);
        }else {
            processWxMessageDTO.setEnable_duplicate_check(0);
        }
        // 重复消息检查的时间间隔
        processWxMessageDTO.setDuplicate_check_interval(getDuplicateCheckInterval());


        // 设置模板消息
        TemplateCardDTO templateCardDTO = new TemplateCardDTO();
        templateCardDTO.setCard_type(CardTypeEnum.BUTTON_INTERACTION.toString());
        SourceDTO sourceDTO = new SourceDTO();
        sourceDTO.setDesc(headDesc);
        sourceDTO.setDesc_color(1);
        templateCardDTO.setSource(sourceDTO);
        // 消息id
        templateCardDTO.setTask_id(System.currentTimeMillis()+IdUtil.simpleUUID());

        MainTitleDTO mainTitleDTO = new MainTitleDTO();
        mainTitleDTO.setTitle(typeTitle);
        mainTitleDTO.setDesc(processType);
        templateCardDTO.setMain_title(mainTitleDTO);

        QuoteAreaDTO quoteAreaDTO = new QuoteAreaDTO();
        quoteAreaDTO.setType(0);
        //quoteAreaDTO.setUrl(detailUrl);
        quoteAreaDTO.setTitle(title);
        quoteAreaDTO.setQuote_text(remarks);
        templateCardDTO.setQuote_area(quoteAreaDTO);

        templateCardDTO.setSub_title_text("申请人："+createUserName);

        List<HorizontalContentListDTO> horizontalContentListDTOs = new ArrayList<>();
        HorizontalContentListDTO urlInfo = new HorizontalContentListDTO();
        urlInfo.setType(1);
        urlInfo.setKeyname(detailText[0]);
        urlInfo.setValue(detailText[1]);
        //urlInfo.setUrl(detailUrl);
        //horizontalContentListDTOs.add(urlInfo);
        //templateCardDTO.setHorizontal_content_list(horizontalContentListDTOs);


        CardActionDTO cardActionDTO = new CardActionDTO();
        cardActionDTO.setType(1);
        cardActionDTO.setUrl(panelUrl);
        templateCardDTO.setCard_action(cardActionDTO);

        List<ButtonDTO> buttonDTOS = new ArrayList<>();
        ButtonDTO b1 = new ButtonDTO();
        b1.setType(1);
        b1.setUrl(panelUrl);
        b1.setText(buttonText);
        buttonDTOS.add(b1);
        templateCardDTO.setButton_list(buttonDTOS);

        processWxMessageDTO.setTemplate_card(templateCardDTO);
        return processWxMessageDTO;
    }

}
