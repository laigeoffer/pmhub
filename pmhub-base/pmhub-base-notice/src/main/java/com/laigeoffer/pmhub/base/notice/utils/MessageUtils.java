package com.laigeoffer.pmhub.base.notice.utils;

import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.laigeoffer.pmhub.base.notice.domain.entity.WxMessage;
import com.laigeoffer.pmhub.base.notice.domain.entity.WxResult;
import com.laigeoffer.pmhub.base.notice.domain.entity.WxUpdateMessage;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 企微消息推送相关工具类
 * @author canghe
 */
@Component
public class MessageUtils {

    /**
     * 服务器host
     * */
    public static String host;
    @Value("${pmhub.workWx.host}")
    private void setHost(String host) {
        MessageUtils.host = host;
    }

    /**
     * 后端路由
     * */
    public static String path;
    @Value("${pmhub.workWx.path}")
    private void setPath(String path) {
        MessageUtils.path = path;
    }

    /**
     * appid
     * */
    public static String appid;
    @Value("${pmhub.workWx.corpid}")
    private void setAppid(String appid) {
        MessageUtils.appid = appid;
    }

    /**
     * agentid
     * */
    public static String agentid;
    @Value("${pmhub.workWx.agentid}")
    private void setAgentid(String agentid) {
        MessageUtils.agentid = agentid;
    }


    /**
     * 企微消息发送api
     * */
    public static final String WORK_WX_MESSAGE_URL = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s";

    /**
     * 企微消息更新api
     * */
    public static final String WORK_WX_MESSAGE_UPDATE_URL = "https://qyapi.weixin.qq.com/cgi-bin/message/update_template_card?access_token=%s";

    /**
     * 发送应用消息
     * */
    public static WxResult sendMessage(WxMessage wxMessage){
        wxMessage.setAgentid(PublicUtil.getAgentId());
        String url = String.format(WORK_WX_MESSAGE_URL,PublicUtil.getWorkWxToken());
        JSONObject re = JSONUtil.parseObj(HttpRequest.post(url)
                .body(JSONUtil.toJsonStr(wxMessage))
                .execute().body());
        return JSONUtil.toBean(re,WxResult.class);
    }

    public static WxResult updateMessage(WxUpdateMessage wxMessage){
        wxMessage.setAgentid(PublicUtil.getAgentId());
        String url = String.format(WORK_WX_MESSAGE_UPDATE_URL,PublicUtil.getWorkWxToken());
        JSONObject re = JSONUtil.parseObj(HttpRequest.post(url)
                .body(JSONUtil.toJsonStr(wxMessage))
                .execute().body());
        return JSONUtil.toBean(re,WxResult.class);
    }

}
