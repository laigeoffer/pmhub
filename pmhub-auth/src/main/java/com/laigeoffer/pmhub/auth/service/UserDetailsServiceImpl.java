package com.laigeoffer.pmhub.auth.service;

import com.laigeoffer.pmhub.api.system.UserFeignService;
import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
import com.laigeoffer.pmhub.base.core.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.base.core.enums.UserStatus;
import com.laigeoffer.pmhub.base.core.exception.ServiceException;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 用户验证处理
 *
 * @author canghe
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    private static final Logger log = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Resource
    private UserFeignService userService;

    @Autowired
    private SysPasswordService passwordService;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 远程调用用户服务
        AjaxResult userResult = userService.getInfoByUsername(username);
        if (StringUtils.isNull(userResult) || userResult.get(AjaxResult.DATA_TAG) == null) {
            throw new ServiceException("登录用户：" + username + " 不存在");
        }

        LoginUser loginUser = (LoginUser) userResult.get(AjaxResult.DATA_TAG);
        if (StringUtils.isNull(loginUser)) {
            log.info("登录用户：{} 不存在.", username);
            throw new ServiceException("登录用户：" + username + " 不存在");
        } else if (UserStatus.DELETED.getCode().equals(loginUser.getUser().getDelFlag())) {
            log.info("登录用户：{} 已被删除.", username);
            throw new ServiceException("对不起，您的账号：" + username + " 已被删除");
        } else if (UserStatus.DISABLE.getCode().equals(loginUser.getUser().getStatus())) {
            log.info("登录用户：{} 已被停用.", username);
            throw new ServiceException("对不起，您的账号：" + username + " 已停用");
        }

        passwordService.validate(loginUser.getUser());

        return loginUser;
    }

}
