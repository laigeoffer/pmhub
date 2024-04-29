package com.laigeoffer.pmhub.system;

import com.laigeoffer.pmhub.base.security.annotation.EnableCustomConfig;
import com.laigeoffer.pmhub.base.security.annotation.EnablePmFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * @author canghe
 * @description 系统模块
 * @create 2024-04-24-15:29
 */
@EnableCustomConfig
//@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
//@EnableDiscoveryClient
@EnablePmFeignClients
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
//@ComponentScan(basePackages = {
//        "com.laigeoffer.pmhub.**.mapper", // 默认的应用包mapper路径
//        "com.laigeoffer.pmhub.**.config", // jar 包中的配置类路径
//        "com.laigeoffer.pmhub.system" ,// 直接指定 properties 包
//        "com.laigeoffer.pmhub.base.redis",
//        "com.laigeoffer.pmhub.base.security",
//})
//@ComponentScan(basePackages = {
//        "com.laigeoffer.pmhub.**.mapper", // 默认的应用包mapper路径
//        "com.laigeoffer.pmhub.system" // 直接指定 properties 包
//})
public class PmHubSystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubSystemApplication.class, args);
    }
}