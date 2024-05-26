package com.laigeoffer.pmhub.common.exception.user;

/**
 * 用户错误最大次数异常类
 *
 * @author canghe
 */
public class UserPasswordRetryLimitExceedException extends UserException {
    private static final long serialVersionUID = 1L;

    public UserPasswordRetryLimitExceedException(int retryLimitCount, int lockTime) {
        super("user.password.retry.limit.exceed", new Object[]{retryLimitCount, lockTime});
    }
}
