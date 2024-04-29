package com.laigeoffer.pmhub.system.service;

import com.laigeoffer.pmhub.system.domain.PmhubOAuth2Client;
import com.laigeoffer.pmhub.system.domain.PmhubOAuth2User;

/**
 * OAuth2 服务器
 * @author canghe
 * @date 2024/01/09
 */
public interface IOAuth2Service {

    /**
     * 是否已被用户授权登录
     * @param userId 用户id
     * @param clientId 客户端id
     * @return {@link Boolean} 是否已授权
     */
    Boolean isAgree (Long userId,String clientId);


    /**
     * 允许授权登录
     * @param userId 用户id
     * @param clientId 客户端id
     */
    void agree (Long userId,String clientId);

    /**
     * 创建用于授权的用户code
     * @param userId 用户id
     * @return {@link String}
     */
    String createCode(Long userId);

    /**
     * 创建用于授权的用户token
     * @param code 用户code
     * @return {@link String}
     */
    String createToken(String code);


    /**
     * 更加token获取用户信息
     * @param token token
     * @return {@link PmhubOAuth2User}
     */
    public PmhubOAuth2User getUser(String token);


    /**
     * 获取客户端logo
     * @param clientId clientId
     * @return {@link PmhubOAuth2User}
     */
    public PmhubOAuth2Client getClientInfo(String clientId);


    /**
     * 验证客户端的Secret
     *
     * @param clientId
     * @param clientSecret
     * @return {@link Boolean}
     */
    public Boolean checkClientSecret(String clientId,String clientSecret);

}
