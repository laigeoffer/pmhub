package com.laigeoffer.pmhub.gen;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

/**
 * @author canghe
 * @description 代码生成
 * @create 2024-04-25-14:18
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
@ComponentScan(basePackages = {
        "com.laigeoffer.pmhub.**.mapper", // 默认的应用包mapper路径
        "com.laigeoffer.pmhub.**.config", // jar 包中的配置类路径
        "com.laigeoffer.pmhub.gen" // 直接指定包
})
public class PmHubGenApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubGenApplication.class, args);
    }
}