package com.laigeoffer.pmhub.system;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * @author canghe
 * @description 系统模块
 * @create 2024-04-24-15:29
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
@EnableDiscoveryClient
//@ComponentScan(basePackages = {"com.laigeoffer.pmhub"})
@ComponentScan(basePackages = {
        "com.laigeoffer.pmhub.**.mapper", // 默认的应用包mapper路径
        "com.laigeoffer.pmhub.**.config", // jar 包中的配置类路径
        "com.laigeoffer.pmhub.system" ,// 直接指定 properties 包
        "com.laigeoffer.pmhub.base.redis",
        "com.laigeoffer.pmhub.base.security",
})
@EnableAspectJAutoProxy // 开启 AspectJ 自动代理
@EnableAsync
public class PmHubSystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubSystemApplication.class, args);
    }
}