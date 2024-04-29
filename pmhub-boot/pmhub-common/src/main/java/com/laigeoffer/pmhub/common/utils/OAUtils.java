package com.laigeoffer.pmhub.common.utils;

import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.asymmetric.KeyType;
import cn.hutool.crypto.asymmetric.RSA;
import cn.hutool.http.HttpRequest;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.laigeoffer.pmhub.common.exception.ServiceException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * 泛微微信工具类
 *
 * @author canghe
 */
@Component
@Slf4j
public class OAUtils {

    /**
     * 模拟缓存服务
     */
    private static final Map<String, String> SYSTEM_CACHE = new HashMap<>();

    /**
     * 授权地址
     */
    private static final String OA_AUTHORIZE_URL = "/sso/oauth2.0/authorize?client_id=%s&response_type=code&redirect_uri=%s";
    /**
     * 获取 access_token 接口
     */
    private static final String OA_ACCESS_TOKEN_URL = "/sso/oauth2.0/accessToken?client_id=%s&client_secret=%s&grant_type=%s&code=%s&redirect_uri=%s";
    /**
     * 获取用户信息接口
     */
    private static final String OA_PROFILE_URL = "/sso/oauth2.0/profile?access_token=%s";

    /**
     * 认证退出接口
     */
    private static final String OA_LOGOUT_URL = "/sso/logout?service=%s";

    public static final String USER_API = "/api/hrm/resful/getHrmUserInfoWithPage";
    public static final String REGISTER_API = "/api/ec/dev/auth/regist";
    public static final String TOKEN_API = "/api/ec/dev/auth/applytoken";
    public static final String SEND_MESSAGE_API = "/api/ec/dev/message/sendCustomMessageSingle";
    public static final String ALTER_MESSAGE_API = "/api/ec/dev/message/alterCustomMessageSingle";
    public static final String DELETE_MESSAGE_API = "/api/ec/dev/message/ deleteCustomMessageSingle";



    /**
     * 错误代码的key
     */
    public static final String ERROR_CODE = "code";
    public static final int NUM_0 = 0;
    private static final String NUM_1 = "1";


    /**
     * userid的key
     */
    public static final String USR_ID = "id";



    /**
     * 获取到的凭证，最长为512字节
     */
    private static final String ACCESS_TOKEN = "access_token";
    private static final String GRANT_TYPE = "authorization_code";
    /**
     * 魔法值
     */
    private static final String APP_ID = "appid";
    private static final String CPK = "cpk";
    private static final String SPK = "spk";
    private static final String SECRIT = "secrit";
    private static final String SECRET = "secret";
    private static final int TIME_2000 = 2000;
    private static final String TIME_3600 = "3600";
    private static final String LOCAL_PRIVATE_KEY = "LOCAL_PRIVATE_KEY";
    private static final String LOCAL_PUBLIC_KEY = "LOCAL_PUBLIC_KEY";
    private static final String SERVER_PUBLIC_KEY = "SERVER_PUBLIC_KEY";
    private static final String SERVER_SECRET = "SERVER_SECRET";
    private static final String SERVER_TOKEN = "SERVER_TOKEN";
    private static final String TOKEN = "token";
    private static final String TIME_NAME = "time";
    private static final String SESSION = "skipsession";

    private static final String UTF_8 = "utf-8";


    /**
     * 客户端应用注册ID
     */
    private static String CLIENT_ID = "CLIENT_ID";

    /**
     * ecology系统发放的授权许可证(appid)
     */
    private static String APPID = "APPID";
    private static String CODE = "CODE";

    /**
     * 客户端应用注册密钥
     */
    private static String CLIENT_SECRET = "CLIENT_SECRET";

    /**
     * 认证中心地址
     */
    public static String SERVER_PATH = "";

    @Value("${pmhub.oa.appId}")
    private void setAppId(String appId) {
        OAUtils.APPID = appId;
    }
    @Value("${pmhub.oa.code}")
    private void setCode(String code) {
        OAUtils.CODE = code;
    }


    @Value("${pmhub.oa.clientId}")
    private void setClientId(String clientId) {
        OAUtils.CLIENT_ID = clientId;
    }

    @Value("${pmhub.oa.clientSecret}")
    private void setClientSecret(String clientSecret) {
        OAUtils.CLIENT_SECRET = clientSecret;
    }

    /**
     * 泛微地址
     */
    @Value("${pmhub.oa.path}")
    private void setServerPath(String path) {
        SERVER_PATH = path;
    }

    public static String getServerPath() {
        return SERVER_PATH;
    }

    /**
     * pmhub平台 host
     * */
    public static String host;
    @Value("${pmhub.oa.host}")
    private void setHost(String host) {
        OAUtils.host = host;
    }

    /**
     * pmhub平台 path2
     * */
    public static String path2;
    @Value("${pmhub.oa.path2}")
    private void setPath2(String path2) {
        OAUtils.path2 = path2;
    }

    public static final String ssoPath = "/sso/oa?url=";

    public static String ssoCreate(String target) {

        String redirectUri = "";

        try {
            redirectUri = URLEncoder.encode(String.format(SERVER_PATH + OA_AUTHORIZE_URL, CLIENT_ID, URLEncoder.encode(host + path2 + ssoPath, UTF_8) + URLEncoder.encode(URLEncoder.encode(target, UTF_8), UTF_8)), UTF_8);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return redirectUri;

    }

    public static String ssoCreateLogin(String target, String target2) {

        String redirectUri = "";

        try {
            redirectUri = URLEncoder.encode(target, UTF_8) + URLEncoder.encode(URLEncoder.encode(target2, UTF_8), UTF_8);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return redirectUri;

    }

    /**
     * 获取access_token接口
     */
    public static String getOaAccessToken(String code, String redirectUri) {

        JSONObject jsonObject = JSONUtil.parseObj(HttpRequest.post(String.format(SERVER_PATH + OA_ACCESS_TOKEN_URL, CLIENT_ID, CLIENT_SECRET, GRANT_TYPE, code, redirectUri))
                .execute().body());

        if (jsonObject.getInt(ERROR_CODE) != NUM_0) {
            throw new ServiceException("调用泛微 OA 获取 access_token 接口失败");
        }
        return jsonObject.getStr(ACCESS_TOKEN);
    }


    /**
     * 获取用户信息接口
     */
    public static String getOAUserInfo(String accessToken) {

        // 获取用户信息
        JSONObject jsonObject = JSONUtil.parseObj(HttpRequest.get(String.format(SERVER_PATH + OA_PROFILE_URL, accessToken))
                .execute().body());
        if (jsonObject.getInt(ERROR_CODE) != NUM_0) {
            throw new ServiceException("调用泛微 OA 获取用户信息接口失败");
        }
        return jsonObject.getStr(USR_ID);
    }


    /**
     * 认证退出接口
     */
    public static JSONObject logout(String service) {
        // 获取用户基础信息
        JSONObject ipJson = JSONUtil.parseObj(HttpRequest.get(String.format(SERVER_PATH + OA_LOGOUT_URL, service))
                .execute().body());
        return ipJson;
    }

    /**
     * 第一步：
     * <p>
     * 调用ecology注册接口,根据appid进行注册,将返回服务端公钥和Secret信息
     */
    public static void testRegist(String address) {

        //获取当前系统RSA加密的公钥
        RSA rsa = new RSA();
        String publicKey = rsa.getPublicKeyBase64();
        String privateKey = rsa.getPrivateKeyBase64();

        // 客户端RSA私钥
        SYSTEM_CACHE.put(LOCAL_PRIVATE_KEY, privateKey);
        // 客户端RSA公钥
        SYSTEM_CACHE.put(LOCAL_PUBLIC_KEY, publicKey);

        //调用ECOLOGY系统接口进行注册
        String data = HttpRequest.post(address + REGISTER_API)
                .header(APP_ID, APPID)
                .header(CPK, publicKey)
                .timeout(TIME_2000)
                .execute().body();

        Map<String, Object> datas = JSONUtil.parseObj(data);

        //ECOLOGY返回的系统公钥
        SYSTEM_CACHE.put(SERVER_PUBLIC_KEY, StrUtil.nullToEmpty((String) datas.get(SPK)));
        //ECOLOGY返回的系统密钥
        SYSTEM_CACHE.put(SERVER_SECRET, StrUtil.nullToEmpty((String) datas.get(SECRIT)));
    }
    public static Map<String, Object> testRegist2(String address) {

        //获取当前系统RSA加密的公钥
        RSA rsa = new RSA();
        String publicKey = rsa.getPublicKeyBase64();

        //调用ECOLOGY系统接口进行注册
        String data = HttpRequest.post(address + REGISTER_API)
                .header(APP_ID, APPID)
                .header(CPK, publicKey)
                .timeout(TIME_2000)
                .execute().body();

        return JSONUtil.parseObj(data);
    }

    /**
     * 第二步：
     * <p>
     * 通过第一步中注册系统返回信息进行获取token信息
     */
    public static Map<String, Object> testGetoken(String address) {
        // 从系统缓存或者数据库中获取ECOLOGY系统公钥和Secret信息
        String secret = SYSTEM_CACHE.get(SERVER_SECRET);
        String spk = SYSTEM_CACHE.get(SERVER_PUBLIC_KEY);

        // 如果为空,说明还未进行注册,调用注册接口进行注册认证与数据更新
        if (Objects.isNull(secret) || Objects.isNull(spk)) {
            testRegist(address);
            // 重新获取最新ECOLOGY系统公钥和Secret信息
            secret = SYSTEM_CACHE.get(SERVER_SECRET);
            spk = SYSTEM_CACHE.get(SERVER_PUBLIC_KEY);
        }

        // 公钥加密,所以RSA对象私钥为null
        RSA rsa = new RSA(null, spk);
        //对秘钥进行加密传输，防止篡改数据
        String encryptSecret = rsa.encryptBase64(secret, CharsetUtil.CHARSET_UTF_8, KeyType.PublicKey);

        //调用ECOLOGY系统接口进行注册
        String data = HttpRequest.post(address + TOKEN_API)
                .header(APP_ID, APPID)
                .header(SECRET, encryptSecret)
                .header(TIME_NAME, TIME_3600)
                .execute().body();

        Map<String, Object> datas = JSONUtil.parseObj(data);

        //ECOLOGY返回的token
        // TODO 为Token缓存设置过期时间
        SYSTEM_CACHE.put(SERVER_TOKEN, StrUtil.nullToEmpty((String) datas.get(TOKEN)));

        return datas;
    }

    public static String testGetToken(String address) {

        Map<String, Object> map = testRegist2(address);

        // 公钥加密,所以RSA对象私钥为null
        RSA rsa = new RSA(null, StrUtil.nullToEmpty((String) map.get(SPK)));
        //对秘钥进行加密传输，防止篡改数据
        String encryptSecret = rsa.encryptBase64(StrUtil.nullToEmpty((String) map.get(SECRIT)), CharsetUtil.CHARSET_UTF_8, KeyType.PublicKey);

        //调用ECOLOGY系统接口进行注册
        String data = HttpRequest.post(address + TOKEN_API)
                .header(APP_ID, APPID)
                .header(SECRET, encryptSecret)
                .header(TIME_NAME, TIME_3600)
                .execute().body();

        Map<String, Object> datas = JSONUtil.parseObj(data);

        //ECOLOGY返回的token
        return StrUtil.nullToEmpty((String) datas.get(TOKEN));
    }
    /**
     * 第三步：
     * <p>
     * 调用ecology系统的rest接口，请求头部带上token和用户标识认证信息
     *
     * @param api        rest api 接口地址(该测试代码仅支持GET请求)
     * @param jsonParams 请求参数json串
     *                   <p>
     *                   注意：ECOLOGY系统所有POST接口调用请求头请设置 "Content-Type","application/x-www-form-urlencoded; charset=utf-8"
     */
    public static JSONObject restfulCall(String api, String jsonParams, String type) {
        log.info("调用泛微接口：{},{},{}", api, jsonParams, type);

        // ECOLOGY 返回的 token
        String token = SYSTEM_CACHE.get(SERVER_TOKEN);
        if (StrUtil.isEmpty(token)) {
            token = (String) testGetoken(SERVER_PATH).get(TOKEN);
        }

        String spk = SYSTEM_CACHE.get(SERVER_PUBLIC_KEY);
        // 封装请求头参数
        RSA rsa = new RSA(null, spk);

        // 调用 ECOLOGY 系统接口
        if (StringUtils.isNotBlank(type)) {
            return JSONUtil.parseObj(HttpRequest.post(SERVER_PATH + api + jsonParams)
                    .header(APP_ID, APPID)
                    .header(TOKEN, token)
                    .header(SESSION, NUM_1)
                    .execute().body());
        }
        JSONObject jsonObject = JSONUtil.parseObj(HttpRequest.post(SERVER_PATH + api)
                .header(APP_ID, APPID)
                .header(TOKEN, token)
                .header(SESSION, NUM_1)
                .body(jsonParams)
                .execute().body());
        log.info("调用泛微查询人员信息返回：{}", jsonObject);
        return jsonObject;
    }

    public static JSONObject restfulCall2(String api, String jsonParams, String type) {
        log.info("调用泛微接口：{},{},{}", api, jsonParams, type);

        // ECOLOGY 返回的 token
        String token = testGetToken(SERVER_PATH);

        // 调用 ECOLOGY 系统接口
        if (StringUtils.isNotBlank(type)) {
            return JSONUtil.parseObj(HttpRequest.post(SERVER_PATH + api + jsonParams)
                    .header(APP_ID, APPID)
                    .header(TOKEN, token)
                    .header(SESSION, NUM_1)
                    .execute().body());
        }
        JSONObject jsonObject = JSONUtil.parseObj(HttpRequest.post(SERVER_PATH + api)
                .header(APP_ID, APPID)
                .header(TOKEN, token)
                .header(SESSION, NUM_1)
                .body(jsonParams)
                .execute().body());
        log.info("调用泛微查询返回：{}", jsonObject);
        return jsonObject;
    }

    /**
     * 将 Map 转换成字符串参数，用于 POST GET 请求
     *
     * @param map
     * @return
     */
    public static String mapToStr(Map<String, String> map) {
        StringBuilder stringBuilder = new StringBuilder();
        if (map != null) {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                stringBuilder.append(entry.getKey());
                if (entry.getValue() != null)
                    stringBuilder.append("=").append(entry.getValue());
                stringBuilder.append("&");
            }
        }
        if (stringBuilder.length() > 0)
            return "?" + stringBuilder.substring(0, stringBuilder.length() - 1);
        return null;
    }

    /**
     * 发送消息，参数封装
     * @return
     */
    public static Map<String,String> sendCustomMessageSingle(String loginId, String title, String context, String redirectUri, String businessId) {

        Map<String, String> map = new HashMap<>();

        // 消息来源,新建消息来源获取code 请查看文档第四大点补充
        map.put("code", CODE);
        //接收人登录名
        map.put("loginIdList", loginId);
        //creater的值 创建人OA系统id / 创建人登录名 / 创建人编号 / 创建人姓名（对应接收人所传入的形式）
        map.put("creater", "1");
        map.put("title", title);
        map.put("context", context);
        map.put("linkUrl", redirectUri);
        map.put("linkMobileUrl", redirectUri);
        //消息来源code +“|”+业务id  消息需要打上已处理标记
        if (StringUtils.isNotBlank(businessId)) {
            map.put("targetId", CODE + "|" + businessId);
        }

        return map;
    }

    /**
     * 将消息打上已处理标记，参数封装
     * @return
     */
    public static Map<String,String> alterCustomMessageSingle(String businessId, String state, String loginId) {

        Map<String, String> map = new HashMap<>();
        //修改消息状态时所依据的条件，在消息发送时也需要插入，字符串拼接方式为业务id前加消息来源的“code|"
        map.put("targetId", CODE + "|" + businessId);
        //待处理 0 已处理 1 已同意 2 已拒绝 3 已删除 27 已暂停 34 已撤销 35
        map.put("bizState", state);
        map.put("loginIdList", loginId);

        return map;
    }


    /**
     * 删除消息，参数封装
     * @return
     */
    public static Map<String,String> deleteCustomMessageSingle(Long userId, String state, String loginId) {

        Map<String, String> map = new HashMap<>();
        //修改消息状态时所依据的条件，在消息发送时也需要插入，字符串拼接方式为业务id前加消息来源的“code|"
        map.put("targetId", CODE + "|" + userId);
        //待处理 0 已处理 1 已同意 2 已拒绝 3 已删除 27 已暂停 34 已撤销 35
        map.put("bizState", state);
        map.put("loginIdList", loginId);

        return map;
    }


}


