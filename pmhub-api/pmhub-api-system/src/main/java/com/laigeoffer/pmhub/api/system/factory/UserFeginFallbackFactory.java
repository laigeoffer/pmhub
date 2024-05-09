package com.laigeoffer.pmhub.api.system.factory;

import com.laigeoffer.pmhub.api.system.UserFeignService;
import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

/**
 * 用户服务降级处理
 *
 * @author ruoyi
 */
@Component
public class UserFeginFallbackFactory implements FallbackFactory<UserFeignService>
{
    private static final Logger log = LoggerFactory.getLogger(UserFeginFallbackFactory.class);

    @Override
    public UserFeignService create(Throwable throwable)
    {
        log.error("用户服务调用失败:{}", throwable.getMessage());
        return new UserFeignService()
        {
            @Override
            public AjaxResult getInfo(Long userId, String source) {
                return AjaxResult.error("获取用户失败:" + throwable.getMessage());
            }

            @Override
            public AjaxResult getInfoByUsername(String username) {
                return AjaxResult.error("获取用户失败:" + throwable.getMessage());
            }

        };
    }
}
