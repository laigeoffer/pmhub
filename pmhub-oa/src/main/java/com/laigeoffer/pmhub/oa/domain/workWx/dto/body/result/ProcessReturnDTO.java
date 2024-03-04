package com.laigeoffer.pmhub.oa.domain.workWx.dto.body.result;

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
 * 审批流结束回执
 * @author canghe
 */
@JsonTypeInfo(use = JsonTypeInfo.Id.NAME, include = JsonTypeInfo.As.PROPERTY, property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = ProcessReturnDTO.class, name = "审批流结束回执")
})
@EqualsAndHashCode(callSuper = true)
@Data
public class ProcessReturnDTO extends Message {

    private static final String HEAD_DESC = "审批流程提醒";
    private static final String TYPE_TITLE = "您申请的流程%s";

    private static final String[] DETAIL_TEXT = {"处理时间","说明"};

    private static final String BUTTON_TEXT = "查看详情";

    /**
     * 企微消息类型
     * */
    public final String msgType = "text_notice";

    /**
     * 流程名称
     * */
    private String processName;

    /**
     * 审批状态
     * */
    private String processState;

    /**
     * 审批状态说明
     * */
    private String processStateDesc;


    /**
     * 处理时间
     * */
    private String timeStr;

    /**
     * 申请详情url
     * */
    private String detailUrl;

    /**
     * 审批界面url
     * */
    private String panelUrl;


    /**
     * 审批内容备注
     * */
    private String remarks;

    private String userName;

    private String oaTitle;
    private String oaContext;
    private String linkUrl;


    public ProcessReturnDTO(String processName
            , String processState
            , String processStateDesc
            , String timeStr
            , String detailUrl
            , String panelUrl
            , String remarks, String userName, String oaTitle, String oaContext, String linkUrl){
        this.processName = processName;
        this.processState = processState;
        this.processStateDesc = processStateDesc;
        this.timeStr = timeStr;
        this.detailUrl = detailUrl;
        this.panelUrl = panelUrl;
        this.remarks =remarks;
        this.userName = userName;
        this.oaTitle = oaTitle;
        this.oaContext = oaContext;
        this.linkUrl = linkUrl;
    }


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
        templateCardDTO.setCard_type(CardTypeEnum.TEXT_NOTICE.toString());
        SourceDTO sourceDTO = new SourceDTO();
        sourceDTO.setDesc(HEAD_DESC);
        sourceDTO.setDesc_color(1);
        templateCardDTO.setSource(sourceDTO);
        // 消息id
        templateCardDTO.setTask_id(System.currentTimeMillis()+IdUtil.simpleUUID());

        // 主题
        MainTitleDTO mainTitleDTO = new MainTitleDTO();
        mainTitleDTO.setTitle(String.format(TYPE_TITLE,processState));
        mainTitleDTO.setDesc(String.format("【%s】任务状态变更",processName));
        templateCardDTO.setMain_title(mainTitleDTO);

        // 状态描述
        EmphasisContentDTO emphasisContent = new EmphasisContentDTO();
        emphasisContent.setTitle(processState);
        emphasisContent.setDesc(processStateDesc);
        templateCardDTO.setEmphasis_content(emphasisContent);

        // 下方排列
        List<HorizontalContentListDTO> horizontalContentListDTOs = new ArrayList<>();
        HorizontalContentListDTO urlInfo = new HorizontalContentListDTO();
        urlInfo.setKeyname(DETAIL_TEXT[0]);
        urlInfo.setValue(timeStr);
        horizontalContentListDTOs.add(urlInfo);
        HorizontalContentListDTO urlInfo1 = new HorizontalContentListDTO();
        urlInfo1.setKeyname(DETAIL_TEXT[1]);
        urlInfo1.setValue(remarks);
        horizontalContentListDTOs.add(urlInfo1);
        templateCardDTO.setHorizontal_content_list(horizontalContentListDTOs);


        CardActionDTO cardActionDTO = new CardActionDTO();
        cardActionDTO.setType(1);
        cardActionDTO.setUrl(panelUrl);
        templateCardDTO.setCard_action(cardActionDTO);

        List<JumpListDTO> jumpListDTOS = new ArrayList<>();
        JumpListDTO b1 = new JumpListDTO();
        b1.setType(1);
        b1.setUrl(panelUrl);
        b1.setTitle(BUTTON_TEXT);
        jumpListDTOS.add(b1);
        templateCardDTO.setJump_list(jumpListDTOS);

        processWxMessageDTO.setTemplate_card(templateCardDTO);
        return processWxMessageDTO;
    }

}
