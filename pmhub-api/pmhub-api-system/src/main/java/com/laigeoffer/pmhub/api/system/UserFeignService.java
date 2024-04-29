package com.laigeoffer.pmhub.api.system;

import com.laigeoffer.pmhub.api.system.factory.UserFeginFallbackFactory;
import com.laigeoffer.pmhub.base.core.constant.ServiceNameConstants;
import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * @author canghe
 * @description 用户服务
 * @create 2024-04-24-22:38
 */
@FeignClient(contextId = "userFeignService", value = ServiceNameConstants.SYSTEM_SERVICE, fallbackFactory = UserFeginFallbackFactory.class)
public interface UserFeignService {

    /**
     * 根据用户编号获取详细信息
     */
    @GetMapping(value = {"/", "/{userId}"})
    AjaxResult getInfo(@PathVariable(value = "userId", required = false) Long userId) ;
}
