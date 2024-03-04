package com.laigeoffer.pmhub.system.domain;

import lombok.Data;

/**
 * OAuth2 参数
 * @author canghe
 * @date 2024/01/10
 */
@Data
public class PmhubOAuth2 {

    /**
     * 组装Authorize接口的url参数
     * @param code 鉴权码
     * @return {@link String}
     */
    private String getAuthorizeParams(String code){
        return "?code="+code+"&state="+state;
    }

    /**
     * 组装Authorize成功后接口的重定向路径
     * @param code 鉴权码
     * @return {@link String}
     */
    public String getAuthorizeRedirectUrl(String code){
        return redirect_uri + getAuthorizeParams(code);
    }

    /**
     * 授权重定向路径
     */
    public static final String AUTHORIZE_URL = "/authorize";

    /**
     * 参数分割符
     */
    public static final String SPLIT_STR = "\\?";


    /**
     * clientID
     */
    String client_id;

    /**
     * clientSecret
     */
    String client_secret;

    /**
     * 重定向地址
     */
    String redirect_uri;

    /**
     * 试图登录的账户
     */
    String login;

    /**
     * 需要的授权范围
     */
    String scope;

    /**
     * code验证模式的code验证码
     */
    String code;

    /**
     * 访问安全识别码：一个不可猜测的随机字符串。它用于防止跨站点请求伪造攻击。
     */
    String state;

    /**
     * 在 OAuth 流期间，是否会向未经身份验证的用户提供注册的选项。缺省值为 。在策略禁止注册时使用。true false
     */
    String allow_signup;

    /**
     * 授权方式 code【code验证模式】
     */
    String response_type;



}
