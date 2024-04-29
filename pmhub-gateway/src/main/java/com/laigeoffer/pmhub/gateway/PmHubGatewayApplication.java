package com.laigeoffer.pmhub.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * @author canghe
 * @description 网关启动程序
 * @create 2024-04-19-17:15
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
@EnableDiscoveryClient
public class PmHubGatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubGatewayApplication.class, args);
    }
}