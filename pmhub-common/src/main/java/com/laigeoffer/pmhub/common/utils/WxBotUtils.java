package com.laigeoffer.pmhub.common.utils;

import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONObject;

/**
 * 企微机器人通知
 * @author canghe
 */
public class WxBotUtils {


    /**
     * 发送企微机器人消息
     * */
    public static String sendMessage(String msg, String url){
        JSONObject jsonObject = new JSONObject();
        JSONObject jsonMsg = new JSONObject();
        jsonObject.set("msgtype","text");
        jsonMsg.set("content",msg);
        jsonObject.set("text",jsonMsg);
        String result2 = HttpRequest.post(url)
                .body(jsonObject.toString())
                .execute().body();
        return result2;
    }

}
