package com.laigeoffer.pmhub.oa.utils.wx;

import cn.hutool.cache.CacheUtil;
import cn.hutool.cache.impl.TimedCache;
import cn.hutool.core.util.IdUtil;
import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.hutool.log.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

/**
 * 企业微信工具类
 * @author canghe
 */
@Component
public class PublicUtil {


    /**
     * 单点登录用户信息验证缓存，证明是由企业微信过来的用户，限制浏览器直接请求（超时时间为五分钟）
     * */
    private static TimedCache<String, String> wxUserCache = CacheUtil.newTimedCache(5*60*1000);

    /**
     * 企微鉴权接口地址
     * */
    private static final String WORK_WX_URL = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%s&corpsecret=%s";
    /**
     * 企微IP列表接口地址
     * */
    private static final String WORK_WX_IP_URL = " https://qyapi.weixin.qq.com/cgi-bin/get_api_domain_ip?access_token=%s";

    /**
     * 企微用户基础信息查询接口地址
     * */
    private static final String WORK_WX_USER_BASE_INFO = "https://qyapi.weixin.qq.com/cgi-bin/auth/getuserinfo?access_token=%s&code=%s";

    /**
     * 企微用户公开信息查询接口地址
     * */
    private static final String WORK_WX_USER_PUBLIC_INFO = "https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token=%s&userid=%s";

    /**
     * 企微用户敏感信息查询接口地址
     * */
    private static final String WORK_WX_USER_DETAIL_INFO = "https://qyapi.weixin.qq.com/cgi-bin/auth/getuserdetail?access_token=%s";

    /**
     * 错误代码的key
     * */
    public static final String ERR_CODE_KEY_NAME = "errcode";

    /**
     * 错误信息的key
     * */
    public static final String ERR_MSG_KEY_NAME = "errmsg";

    /**
     * userid的key
     * */
    public static final String USR_ID_KEY = "userid";

    /**
     * 证明是企微单点登录的用户token
     * */
    public static final String USR_TOKEN_KEY = "tmp_token";

    /**
     * 敏感信息ticket的key
     * */
    public static final String USR_TICKET_KEY = "user_ticket";

    /**
     * 用户姓名的key
     * */
    public static final String USR_NICK_KEY = "name";

    /**
     * 用户手机的key
     * */
    public static final String USR_MOBILE_KEY = "mobile";

    /**
     * 用户邮箱的key
     * */
    public static final String USR_EMAIL_KEY = "biz_mail";

    /**
     * 用户头像的key
     * */
    public static final String USR_AVATAR_KEY = "avatar";


    /**
     * 获取到的凭证，最长为512字节
     */
    private static String ACCESS_TOKEN = "ACCESS_TOKEN";

    /**
     * 企业ID
     * */
    private static String CORP_ID = "CORP_ID";

    /**
     * 应用的凭证密钥
     * */
    private static String CORP_SECRET = "CORP_SECRET";

    /**
     * 应用id
     * */
    private static Integer AGENT_ID = 0;

    /**
     * 后端代理转发路由
     * */
    private static String SERVER_PATH = "";


    @Value("${pmhub.workWx.corpid}")
    private void setCorpId(String corpId) {
        PublicUtil.CORP_ID = corpId;
    }

    @Value("${pmhub.workWx.corpsecret}")
    private void setCorpSecret(String corpSecret) {
        PublicUtil.CORP_SECRET = corpSecret;
    }

    @Value("${pmhub.workWx.agentid}")
    private void setAgentId(Integer agentid) {
        PublicUtil.AGENT_ID = agentid;
    }

    public static Integer getAgentId(){
        return AGENT_ID;
    }

    @Value("${pmhub.workWx.path}")
    private void setServerPath(String path) {
        SERVER_PATH = path;
    }

    public static String getServerPath() {
        return SERVER_PATH;
    }

    /**
     * 获取企微token
     * */
    public static String getWorkWxToken(){

        // 拉取企微ip地址列表，测试token是否还有效，无效则重新获取企微token
        JSONObject ipJson = JSONUtil.parseObj(HttpRequest.get(String.format(WORK_WX_IP_URL,ACCESS_TOKEN))
                .execute().body());

        if (ipJson.getInt(ERR_CODE_KEY_NAME) != 0){
            String result2 = HttpRequest.get(String.format(WORK_WX_URL,CORP_ID,CORP_SECRET))
                    .execute().body();
            JSONObject resultJson = JSONUtil.parseObj(result2);
            try {
                if (resultJson.getInt(ERR_CODE_KEY_NAME) == 0){
                    ACCESS_TOKEN = resultJson.getStr("access_token");
                }else {
                    throw new RuntimeException(resultJson.getStr(ERR_MSG_KEY_NAME));
                }
            }catch (Exception ex){
                LogFactory.get().error(ex);
                throw new  RuntimeException(ex.getMessage());
            }
        }
        return ACCESS_TOKEN;
    }


    /**
     * 通过用户code获取用户基础信息
     * */
    public static JSONObject getWxUserBaseInfo(String code){
        // 获取用户基础信息
        JSONObject ipJson = JSONUtil.parseObj(HttpRequest.get(String.format(WORK_WX_USER_BASE_INFO,getWorkWxToken(),code))
                .execute().body());

        if (ipJson.getInt(ERR_CODE_KEY_NAME) == 0){
            String token = IdUtil.randomUUID();
            wxUserCache.put(ipJson.getStr(USR_ID_KEY), token);
            ipJson.set(USR_TOKEN_KEY,token);
        }

        return ipJson;
    }

    /**
     * 比对token 判断是否是企微过来的用户
     * @return 是否是企微SSO请求
     * */
    public static Boolean checkToken(String userName,String token){
        if (StringUtils.isEmpty(userName)||StringUtils.isEmpty(token)){
            return false;
        }else {
            String uToken = wxUserCache.get(userName);
            if (!StringUtils.isEmpty(uToken)){
                if (token.equals(uToken)){
                    // 验证成功，移除token防止被重复使用
                    wxUserCache.remove(userName);
                    return true;
                }else {
                    return false;
                }
            }else {
                return false;
            }
        }
    }

    /**
     * 通过用户名获取用户姓名等公开信息
     * */
    public static JSONObject getWxUserPublicInfo(String userName){
        // 获取用户基础信息
        JSONObject ipJson = JSONUtil.parseObj(HttpRequest.get(String.format(WORK_WX_USER_PUBLIC_INFO,getWorkWxToken(),userName))
                .execute().body());
        return ipJson;
    }


    /**
     * 通过用户ticket获取用户敏感信息
     * */
    public static JSONObject getWxUserDetailInfo(String ticket){
        JSONObject jsonObject = new JSONObject();
        jsonObject.set("user_ticket",ticket);
        // 获取用户敏感信息
        JSONObject userInfo = JSONUtil.parseObj(HttpRequest.post(String.format(WORK_WX_USER_DETAIL_INFO,getWorkWxToken()))
                .body(jsonObject.toString())
                .execute().body());
        return userInfo;
    }

}
