package com.laigeoffer.pmhub.file;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * @author canghe
 * @description 文件服务
 * @create 2024-04-25-16:42
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
public class PmHubFileApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubFileApplication.class, args);
    }
}