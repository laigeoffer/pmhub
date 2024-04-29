package com.laigeoffer.pmhub.common.utils;

import cn.hutool.core.codec.Base64;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.crypto.SmUtil;
import cn.hutool.crypto.asymmetric.KeyType;
import cn.hutool.crypto.asymmetric.SM2;
import cn.hutool.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;

/**
 * 保密工具类
 *
 * @author canghe
 * @date 2023/07/19
 */
@Component
public class SecrecyUtils {

    /**
     * 可看敏感信息的用户角色权限字符串
     */
    public static final String ROLE_KEY = "CLASSIFIED_INQUIRER";

    /**
     * 数据键名
     */
    public static final String VALUE_KEY = "value";


    /**
     * 混淆体键名
     */
    public static final String SALT_KEY = "t";

    /**
     * 传参数据键名
     */
    public static final String PARAM_VALUE_KEY = "encryptStr";

    /**
     * 返回时用户显示信息的字段名
     */
    public static final String DISPLAY_VALUE = "displayValue";



    /**
     * 私钥
     */
    private static String privateKey;
    @Value("${pmhub.secrecy.privateKey}")
    private void setPrivateKey(String privateKey) {
        SecrecyUtils.privateKey = privateKey;
    }



    /**
     * 公钥
     */
    private static String publicKey;
    @Value("${pmhub.secrecy.publicKey}")
    private void setPublicKey(String publicKey) {
        SecrecyUtils.publicKey = publicKey;
    }



    /**
     * 还原数据类型
     *
     * @param jsonObject 解密后的标准json对象
     * @return {@link Object}
     */
    public static Object reduction(JSONObject jsonObject){
        if (ObjectUtil.isEmpty(jsonObject.get(VALUE_KEY))){
            return null;
        }
        // 如果是数字，去除多余0
        if (jsonObject.get(VALUE_KEY) instanceof Number) {
            return new BigDecimal(jsonObject.getStr(VALUE_KEY)).stripTrailingZeros().toPlainString();
        } else {
            return jsonObject.get(VALUE_KEY);
        }
    }

    /**
     * 国密sm2加解密器
     */
    private static SM2 sm2 = null;

    /**
     * 加密
     *
     * @param value 明文数据
     * @return {@link String} 密文
     */
    public static String calcEncode(Object value){
        // 初始化加密器
        if (ObjectUtil.isEmpty(sm2)){
            sm2 = SmUtil.sm2(privateKey, publicKey);
        }
        // 密文包装体
        JSONObject jsonObject = new JSONObject();
        jsonObject.set(VALUE_KEY,value);
        // 将当前时间作为盐
        jsonObject.set(SALT_KEY,System.currentTimeMillis());
        // 先进行国密SM2加密，然后转为Base64字符串
        return Base64.encode(sm2.encrypt(jsonObject.toString(), StandardCharsets.UTF_8, KeyType.PublicKey));
    }

    /**
     * 解密
     *
     * @param encryptStr 加密str
     * @return {@link byte[]}
     */
    public static byte[] decrypt(String encryptStr){
        // 初始化加密器
        if (ObjectUtil.isEmpty(sm2)){
            sm2 = SmUtil.sm2(privateKey, publicKey);
        }
        return sm2.decrypt(Base64.decode(encryptStr),KeyType.PrivateKey);
    }


}
