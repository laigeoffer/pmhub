package com.laigeoffer.pmhub.auth.controller;

import com.laigeoffer.pmhub.auth.service.SysLoginService;
import com.laigeoffer.pmhub.base.core.annotation.RateLimiter;
import com.laigeoffer.pmhub.base.core.config.redis.RedisService;
import com.laigeoffer.pmhub.base.core.constant.Constants;
import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.model.LoginBody;
import com.laigeoffer.pmhub.base.core.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.base.core.core.domain.model.RegisterBody;
import com.laigeoffer.pmhub.base.core.utils.JwtUtils;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.base.security.auth.AuthUtil;
import com.laigeoffer.pmhub.base.security.service.TokenService;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

import static com.laigeoffer.pmhub.base.core.core.domain.AjaxResult.success;

/**
 * 登录验证
 *
 * @author canghe
 */
@RestController
public class LoginController {


    @Autowired
    private TokenService tokenService;

    @Autowired
    private SysLoginService sysLoginService;

    @Autowired
    private RedisService redisService;

    /**
     * 登录接口，因为登录接口无token，所以不走网关鉴权，且安全级别极高
     * 需要自定义Redis限流逻辑
     * 这里配置了 30 秒内仅允许访问 10 次
     * @param form
     * @return
     */
    @RateLimiter(key = "rate_limit:login", time = 30, count = 10)
    @PostMapping("login")
    public AjaxResult login(@RequestBody LoginBody form) {
        AjaxResult ajax = success();
        // 用户登录
        LoginUser userInfo = sysLoginService.login(form.getUsername(), form.getPassword());
        // 获取登录token
        String token = tokenService.createToken(userInfo);
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }

    @DeleteMapping("logout")
    public R<?> logout(HttpServletRequest request) {
        String token = SecurityUtils.getToken(request);
        if (StringUtils.isNotEmpty(token)) {
            String username = JwtUtils.getUserName(token);
            // 删除用户缓存记录
            AuthUtil.logoutByToken(token);
            // 记录用户退出日志
            sysLoginService.logout(username);
        }
        return R.ok();
    }

    @PostMapping("refresh")
    public R<?> refresh(HttpServletRequest request) {
        LoginUser loginUser = tokenService.getLoginUser(request);
        if (StringUtils.isNotNull(loginUser)) {
            // 刷新令牌有效期
            tokenService.refreshToken(loginUser);
            return R.ok();
        }
        return R.ok();
    }

    @PostMapping("register")
    public R<?> register(@RequestBody RegisterBody registerBody) {
        // 用户注册
        sysLoginService.register(registerBody.getUsername(), registerBody.getPassword());
        return R.ok();
    }


    /**
     * 刷新 redis
     * @return
     */
    @PostMapping("refreshRedis")
    public R<?> refreshRedis() {
        redisService.flushAll();
        return R.ok();
    }

    @RateLimiter(key = "limitTest", time = 10, count = 2)
    @PostMapping(value = "/limitTest")
    public Long limitTest() {
        System.out.println("limitTest");
        return 1L;
    }

}