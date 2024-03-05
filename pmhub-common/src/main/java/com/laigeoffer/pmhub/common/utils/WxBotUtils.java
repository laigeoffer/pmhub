package com.laigeoffer.pmhub.common.utils;

import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONObject;

/**
 * 企微机器人通知
 * @author canghe
 */
public class WxBotUtils {

    private static final String URL = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=dbfaae98-6faf-4f52-98d1-ae166a2e1fda";


    /**
     * 发送企微机器人消息
     * */
    public static String sendMessage(String msg){
        JSONObject jsonObject = new JSONObject();
        JSONObject jsonMsg = new JSONObject();
        jsonObject.set("msgtype","text");
        jsonMsg.set("content",msg);
        jsonObject.set("text",jsonMsg);
        String result2 = HttpRequest.post(URL)
                .body(jsonObject.toString())
                .execute().body();
        return result2;
    }

}
