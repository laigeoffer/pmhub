//package com.laigeoffer.pmhub.auth.controller;
//
//import com.laigeoffer.pmhub.auth.service.SysRegisterService;
//import com.laigeoffer.pmhub.base.core.core.controller.BaseController;
//import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
//import com.laigeoffer.pmhub.base.core.core.domain.model.RegisterBody;
//import com.laigeoffer.pmhub.base.core.utils.StringUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RestController;
//
///**
// * 注册验证
// *
// * @author canghe
// */
//@RestController
//public class SysRegisterController extends BaseController {
//    @Autowired
//    private SysRegisterService registerService;
//
////    @Autowired
////    private ISysConfigService configService;
//
//    @PostMapping("/register")
//    public AjaxResult register(@RequestBody RegisterBody user) {
////        if (!("true".equals(configService.selectConfigByKey("sys.account.registerUser")))) {
////            return error("当前系统没有开启注册功能！");
////        }
//        String msg = registerService.register(user);
//        return StringUtils.isEmpty(msg) ? success() : error(msg);
//    }
//}
