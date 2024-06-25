package com.laigeoffer.pmhub.api.system.factory;

import com.laigeoffer.pmhub.api.system.UserFeignService;
import com.laigeoffer.pmhub.api.system.domain.dto.SysUserDTO;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.base.core.core.domain.vo.SysUserVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 用户服务降级处理
 *
 * @author canghe
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
            public R<LoginUser> info(String username, String source) {
                return R.fail("根据用户名获取用户失败:" + throwable.getMessage());
            }

            @Override
            public R<LoginUser> getInfoByUserId(Long userId, String source) {
                return R.fail("根据userId获取用户失败:" + throwable.getMessage());
            }

            @Override
            public R<List<SysUserVO>> listOfInner(SysUserDTO sysUserDTO, String source) {
                return R.fail("根据调教获取用户列表失败:" + throwable.getMessage());
            }

            @Override
            public R<Boolean> registerUserInfo(SysUser sysUser, String source) {
                return R.fail("注册用户失败:" + throwable.getMessage());
            }

        };
    }
}
