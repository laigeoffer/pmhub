//package com.laigeoffer.pmhub.auth.service;
//
//import com.laigeoffer.pmhub.base.core.config.redis.RedisService;
//import com.laigeoffer.pmhub.base.core.constant.CacheConstants;
//import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
//import com.laigeoffer.pmhub.base.core.exception.user.UserPasswordNotMatchException;
//import com.laigeoffer.pmhub.base.core.exception.user.UserPasswordRetryLimitExceedException;
//import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.security.core.Authentication;
//import org.springframework.stereotype.Component;
//
//import javax.annotation.Resource;
//import java.util.concurrent.TimeUnit;
//
///**
// * 登录密码方法
// *
// * @author canghe
// */
//@Component
//public class SysPasswordService {
//    @Resource
//    private RedisService redisService;
//
//    @Value(value = "${user.password.maxRetryCount}")
//    private int maxRetryCount;
//
//    @Value(value = "${user.password.lockTime}")
//    private int lockTime;
//
//    /**
//     * 登录账户密码错误次数缓存键名
//     *
//     * @param username 用户名
//     * @return 缓存键key
//     */
//    private String getCacheKey(String username) {
//        return CacheConstants.PWD_ERR_CNT_KEY + username;
//    }
//
//    public void validate(SysUser user) {
//        Authentication usernamePasswordAuthenticationToken = AuthenticationContextHolder.getContext();
//        String username = usernamePasswordAuthenticationToken.getName();
//        String password = usernamePasswordAuthenticationToken.getCredentials().toString();
//
//        Integer retryCount = redisService.getCacheObject(getCacheKey(username));
//
//        if (retryCount == null) {
//            retryCount = 0;
//        }
//
//        if (retryCount >= Integer.valueOf(maxRetryCount).intValue()) {
//            // TODO: 2024.05.09 异步登录日志记录
////            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL,
////                    MessageUtils.message("user.password.retry.limit.exceed", maxRetryCount, lockTime)));
//            throw new UserPasswordRetryLimitExceedException(maxRetryCount, lockTime);
//        }
//
//        if (!matches(user, password)) {
//            retryCount = retryCount + 1;
//            // TODO: 2024.05.09 异步登录日志记录
////            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL,
////                    MessageUtils.message("user.password.retry.limit.count", retryCount)));
//            redisService.setCacheObject(getCacheKey(username), retryCount, lockTime, TimeUnit.MINUTES);
//            throw new UserPasswordNotMatchException();
//        } else {
//            clearLoginRecordCache(username);
//        }
//    }
//
//    public boolean matches(SysUser user, String rawPassword) {
//        return SecurityUtils.matchesPassword(rawPassword, user.getPassword());
//    }
//
//    public void clearLoginRecordCache(String loginName) {
//        if (redisService.hasKey(getCacheKey(loginName))) {
//            redisService.deleteObject(getCacheKey(loginName));
//        }
//    }
//}
