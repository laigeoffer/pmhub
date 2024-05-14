package com.laigeoffer.pmhub.api.system;

import com.laigeoffer.pmhub.api.system.factory.UserFeginFallbackFactory;
import com.laigeoffer.pmhub.base.core.constant.SecurityConstants;
import com.laigeoffer.pmhub.base.core.constant.ServiceNameConstants;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.core.domain.model.LoginUser;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

/**
 * @author canghe
 * @description 用户服务
 * @create 2024-04-24-22:38
 */
@FeignClient(contextId = "userFeignService", value = ServiceNameConstants.SYSTEM_SERVICE, fallbackFactory = UserFeginFallbackFactory.class)
public interface UserFeignService {


    /**
     * 根据用户名获取当前用户信息
     */
    @GetMapping("/user/info/{username}")
    R<LoginUser> info(@PathVariable("username") String username, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    /**
     * 注册用户信息
     *
     * @param sysUser 用户信息
     * @param source 请求来源
     * @return 结果
     */
    @PostMapping("/user/register")
    R<Boolean> registerUserInfo(@RequestBody SysUser sysUser, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);
}
