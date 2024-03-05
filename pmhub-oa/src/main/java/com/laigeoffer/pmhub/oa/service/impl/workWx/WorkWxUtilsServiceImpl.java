package com.laigeoffer.pmhub.oa.service.impl.workWx;

import cn.hutool.log.LogFactory;
import com.laigeoffer.pmhub.oa.exception.AesException;
import com.laigeoffer.pmhub.oa.service.OaUtilsService;
import com.laigeoffer.pmhub.oa.utils.AES256Utils;
import org.springframework.stereotype.Service;


/**
 * 企微系统交互工具接口
 * @author canghe
 */
@Service
public class WorkWxUtilsServiceImpl implements OaUtilsService {

    /**
     * 验证回调url
     * @param msgSignature 企业微信加密签名，msg_signature计算结合了企业填写的token、请求中的timestamp、nonce、加密的消息体。签名计算方法参考 消息体签名检验
     * @param timestamp 时间戳。与nonce结合使用，用于防止请求重放攻击。
     * @param nonce 随机数。与timestamp结合使用，用于防止请求重放攻击。
     * @param ciphertext 加密的字符串。需要解密得到消息内容明文
     * @param aesKey aeskey
     * @return 给服务器返回得验证消息
     * */
    @Override
    public String callBackUrlTest(String aesKey, String timestamp, String nonce, String ciphertext, String msgSignature) throws AesException {
        String randMsg = "";
        try {
            randMsg = AES256Utils.decrypt(aesKey,ciphertext);
        }catch (AesException aesException){
            LogFactory.get().error(aesException);
            return aesException.getMessage();
        }
        return randMsg;
    }

}
