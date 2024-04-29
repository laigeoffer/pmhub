package com.laigeoffer.pmhub.auth.controller;

import com.laigeoffer.pmhub.api.system.UserFeignService;
import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
import com.laigeoffer.pmhub.base.core.utils.JsonUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;


/**
 * 登录验证
 *
 * @author canghe
 */
@RestController
@Slf4j
public class LoginController {


//    @Autowired
//    private SysLoginService loginService;

    @Resource
    private UserFeignService userFeignService;

//    @Autowired
//    private ISysMenuService menuService;
//
//
//    @Autowired
//    private SysPermissionService permissionService;






//    /**
//     * 登录方法
//     *
//     * @param loginBody 登录信息
//     * @return 结果
//     */
//    @PostMapping("/login")
//    public AjaxResult login(@RequestBody LoginBody loginBody) {
//        AjaxResult ajax = success();
//        // 生成令牌
//        String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
//                loginBody.getUuid());
//        ajax.put(Constants.TOKEN, token);
//        return ajax;
//    }
//
    /**
     * 获取用户信息
     *
     * @return 用户信息
     */
    @GetMapping("getInfo/{userid}")
    public AjaxResult getInfo(@PathVariable long userid) {
//        SysUser user = SecurityUtils.getLoginUser().getUser();
        AjaxResult userInfo = userFeignService.getInfo(userid);
        log.info(JsonUtils.toJsonString(userInfo));
        return userInfo;
    }
//
//    /**
//     * 获取路由信息
//     *
//     * @return 路由信息
//     */
//    @GetMapping("getRouters")
//    public AjaxResult getRouters() {
//        Long userId = SecurityUtils.getUserId();
//        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
//        return success(menuService.buildMenus(menus));
//    }



}
