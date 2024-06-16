package com.laigeoffer.pmhub.job;

import com.laigeoffer.pmhub.base.security.annotation.EnableCustomConfig;
import com.laigeoffer.pmhub.base.security.annotation.EnablePmFeignClients;
import com.laigeoffer.pmhub.base.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author canghe
 * @description 定时任务
 * @create 2024-04-25-15:13
 */
@EnableCustomConfig
@EnablePmFeignClients
@EnableCustomSwagger2
@SpringBootApplication
public class PmHubJobApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubJobApplication.class, args);
    }
}