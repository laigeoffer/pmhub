//package com.laigeoffer.pmhub.base.core.config;
//
//import com.laigeoffer.pmhub.base.core.constant.Constants;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
///**
// * 通用配置
// *
// * @author canghe
// */
//@Configuration
//public class ResourcesConfig implements WebMvcConfigurer {
//
//    @Override
//    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        /** 本地文件上传路径 */
//        registry.addResourceHandler(Constants.RESOURCE_PREFIX + "/**")
//                .addResourceLocations("file:" + PmhubConfig.getProfile() + "/");
//    }
//
//
//}