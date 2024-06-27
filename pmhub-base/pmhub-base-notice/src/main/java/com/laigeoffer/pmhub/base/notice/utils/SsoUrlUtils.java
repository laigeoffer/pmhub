package com.laigeoffer.pmhub.base.notice.utils;

import cn.hutool.core.util.URLUtil;

/**
 * 企微单点登录地址创建
 * @author canghe
 */
public class SsoUrlUtils {

    public static final String ssoPath = "/sso/wx?url=";

    public static final String wxOauth2Url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=%s&redirect_uri=%s&response_type=code&scope=snsapi_privateinfo&state=STATE&agentid=%s#wechat_redirect";


    /**
     *
     * */
    public static String ssoCreate(String appid,String agentid,String taget){
        return String.format(wxOauth2Url,appid, URLUtil.encode(taget),agentid);
    }

}
