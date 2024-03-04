package com.laigeoffer.projectaihub.system.service.impl;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.laigeoffer.projectaihub.common.core.domain.entity.SysUser;
import com.laigeoffer.projectaihub.common.core.redis.RedisCache;
import com.laigeoffer.projectaihub.system.domain.PaihOAuth2Agree;
import com.laigeoffer.projectaihub.system.domain.PaihOAuth2Client;
import com.laigeoffer.projectaihub.system.domain.PaihOAuth2User;
import com.laigeoffer.projectaihub.system.mapper.PaihOAuth2AgreeMapper;
import com.laigeoffer.projectaihub.system.mapper.PaihOAuth2ClientMapper;
import com.laigeoffer.projectaihub.system.service.IOAuth2Service;
import com.laigeoffer.projectaihub.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
public class OAuth2ServiceImpl implements IOAuth2Service {

    @Autowired
    private PaihOAuth2AgreeMapper paihOAuth2AgreeMapper;

    @Autowired
    private PaihOAuth2ClientMapper paihOAuth2ClientMapper;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private ISysUserService iSysUserService;

    /**
     * redis中code作为key的前缀
     */
    private static final String CODE_TITLE = "auth2_code:";

    /**
     * redis中token作为key的前缀
     */
    private static final String TOKEN_TITLE = "auth2_token:";


    /**
     * 是否已被用户授权登录
     *
     * @param userId   用户id
     * @param clientId 客户端id
     * @return {@link Boolean}
     */
    @Override
    public Boolean isAgree(Long userId, String clientId) {

        QueryWrapper<PaihOAuth2Agree> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.eq("client_id", clientId);

        // 数据库中如果有这个授权就返回true
        long count = paihOAuth2AgreeMapper.selectCount(queryWrapper);
        return count > 0;
    }

    /**
     * 允许授权登录
     *
     * @param userId   用户id
     * @param clientId 客户端id
     */
    @Override
    public void agree(Long userId, String clientId) {
        if (ObjectUtil.isNotEmpty(clientId)){
            PaihOAuth2Agree paihOAuth2Agree = new PaihOAuth2Agree();
            paihOAuth2Agree.setId(IdUtil.fastUUID());

            paihOAuth2Agree.setClientId(clientId);
            paihOAuth2Agree.setUserId(userId);

            paihOAuth2AgreeMapper.insert(paihOAuth2Agree);
        }else {
            throw new RuntimeException("ClientID can not null!");
        }
    }

    /**
     * 创建用于授权的用户code
     *
     * @param userId 用户id
     * @return {@link String}
     */
    @Override
    public String createCode(Long userId) {
        String code = IdUtil.simpleUUID();
        // 授权码1分钟过期
        redisCache.setCacheObject(CODE_TITLE+code,userId,1, TimeUnit.MINUTES);
        return code;
    }

    /**
     * 创建用于授权的用户token
     *
     * @param code 用户code
     * @return {@link String}
     */
    @Override
    public String createToken(String code) {
        Long userId = redisCache.getCacheObject(CODE_TITLE+code);
        // 清除code
        redisCache.deleteObject(CODE_TITLE+code);
        if (ObjectUtil.isNotEmpty(userId)){
            String token = IdUtil.randomUUID();
            // token 15分钟过期
            redisCache.setCacheObject(TOKEN_TITLE+token,userId,15, TimeUnit.MINUTES);
            return token;
        }else {
            return null;
        }
    }

    /**
     * 更加token获取用户信息
     * @param token token
     * @return {@link PaihOAuth2User}
     */
    @Override
    public PaihOAuth2User getUser(String token){
        Long userId = redisCache.getCacheObject(TOKEN_TITLE+token);
        if (ObjectUtil.isNotEmpty(userId)){
            SysUser sysUser = iSysUserService.selectUserById(userId);
            PaihOAuth2User paihOAuth2User = new PaihOAuth2User();
            paihOAuth2User.setSub(sysUser.getUserName());
            paihOAuth2User.setName(sysUser.getNickName());
            paihOAuth2User.setPreferred_username(sysUser.getUserName());
            paihOAuth2User.setEmail(sysUser.getEmail());
            paihOAuth2User.setUpdated_at(sysUser.getCreateTime().toString());
            return paihOAuth2User;
        }else {
            return null;
        }
    }

    /**
     * 获取客户端logo
     *
     * @param clientId clientId
     * @return {@link PaihOAuth2User}
     */
    @Override
    public PaihOAuth2Client getClientInfo(String clientId) {

        QueryWrapper<PaihOAuth2Client> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("client_id", clientId);
        PaihOAuth2Client paihOAuth2Client =  paihOAuth2ClientMapper.selectOne(queryWrapper);
        if (ObjectUtil.isNotEmpty(paihOAuth2Client)){
            paihOAuth2Client.setClientSecret(null);
        }
        return paihOAuth2Client;
    }

    /**
     * 验证客户端的Secret
     *
     * @param clientId
     * @param clientSecret
     * @return {@link Boolean}
     */
    @Override
    public Boolean checkClientSecret(String clientId, String clientSecret) {

        QueryWrapper<PaihOAuth2Client> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("client_id", clientId);
        return paihOAuth2ClientMapper.selectOne(queryWrapper).getClientSecret().equals(clientSecret);

    }
}
