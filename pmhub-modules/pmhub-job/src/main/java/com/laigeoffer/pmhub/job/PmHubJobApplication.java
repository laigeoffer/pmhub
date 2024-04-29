package com.laigeoffer.pmhub.job;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

/**
 * @author canghe
 * @description 定时任务
 * @create 2024-04-25-15:13
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
@ComponentScan(basePackages = {
        "com.laigeoffer.pmhub.**.mapper", // 默认的应用包mapper路径
        "com.laigeoffer.pmhub.**.config", // jar 包中的配置类路径
        "com.laigeoffer.pmhub.job" // 直接指定包
})
public class PmHubJobApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubJobApplication.class, args);
    }
}