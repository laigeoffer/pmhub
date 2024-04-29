package com.laigeoffer.pmhub.project;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

/**
 * @author canghe
 * @description 项目管理模块
 * @create 2024-04-25-17:23
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
@ComponentScan(basePackages = {
        "com.laigeoffer.pmhub.**.mapper", // 默认的应用包mapper路径
        "com.laigeoffer.pmhub.**.config", // jar 包中的配置类路径
        "com.laigeoffer.pmhub.project" // 直接指定包
})
public class PmHubProjectApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubProjectApplication.class, args);
    }
}