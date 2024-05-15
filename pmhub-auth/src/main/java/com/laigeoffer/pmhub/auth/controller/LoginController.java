package com.laigeoffer.pmhub.auth.controller;

import com.laigeoffer.pmhub.auth.service.SysLoginService;
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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

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

    @PostMapping("login")
    public R<?> login(@RequestBody LoginBody form) {
        // 用户登录
        LoginUser userInfo = sysLoginService.login(form.getUsername(), form.getPassword());
        // 获取登录token
        return R.ok(tokenService.createToken(userInfo));
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


}