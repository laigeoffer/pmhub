package com.laigeoffer.pmhub.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * @author canghe
 * @description 认证授权中心
 * @create 2024-04-23-15:00
 */
//@EnableRyFeignClients todo
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
public class PmHubAuthApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubAuthApplication.class, args);
    }
}