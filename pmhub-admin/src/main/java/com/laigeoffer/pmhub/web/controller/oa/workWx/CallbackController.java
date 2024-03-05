package com.laigeoffer.pmhub.web.controller.oa.workWx;

import cn.hutool.log.LogFactory;
import com.laigeoffer.pmhub.oa.exception.AesException;
import com.laigeoffer.pmhub.oa.service.OaUtilsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;


/**
 * @ddescription 企微回调
 * @date 2023年2月23日
 * @author canghe
 */

@RestController
@RequestMapping("/oa/workWx")
public class CallbackController {


    @Value("${pmhub.workWx.aeskey}")
    private String aesKey;

    @Autowired
    private OaUtilsService oaUtilsService;

    /**
     * 验证回调
     * @param msgSignature 企业微信加密签名，msg_signature计算结合了企业填写的token、请求中的timestamp、nonce、加密的消息体。签名计算方法参考 消息体签名检验
     * @param timestamp 时间戳。与nonce结合使用，用于防止请求重放攻击。
     * @param nonce 随机数。与timestamp结合使用，用于防止请求重放攻击。
     * @param echoStr 加密的字符串。需要解密得到消息内容明文，解密后有random、msg_len、msg、receiveid四个字段，其中msg即为消息内容明文
     * @return
     */
    @GetMapping
    public String checkUrl(@RequestParam(value="msg_signature")String msgSignature
            , @RequestParam(value="timestamp")String timestamp
            , @RequestParam(value="nonce")String nonce
            , @RequestParam(value="echostr")String echoStr
    ){
        try {
            return oaUtilsService.callBackUrlTest(aesKey,timestamp,nonce,echoStr,msgSignature);
        }catch (AesException aesException){
            LogFactory.get().error(aesException);
            return aesException.getMessage();
        }
    }

    /**
     * 验证回调
     * @param msgSignature 企业微信加密签名，msg_signature计算结合了企业填写的token、请求中的timestamp、nonce、加密的消息体。签名计算方法参考 消息体签名检验
     * @param timestamp 时间戳。与nonce结合使用，用于防止请求重放攻击。
     * @param nonce 随机数。与timestamp结合使用，用于防止请求重放攻击。
     * @param encrypt 加密的字符串。需要解密得到消息内容明文，解密后有random、msg_len、msg、receiveid四个字段，其中msg即为消息内容明文
     * @return
     */
    @PostMapping
    public String callBack(@RequestParam(value="msg_signature")String msgSignature
            , @RequestParam(value="timestamp")String timestamp
            , @RequestParam(value="nonce")String nonce
            , @RequestParam(value="Encrypt")String encrypt
            , HttpServletResponse response
    ){
        response.setStatus(200);
        return "";
    }
}
