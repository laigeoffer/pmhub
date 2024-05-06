package com.laigeoffer.pmhub.gen;

import com.laigeoffer.pmhub.base.security.annotation.EnableCustomConfig;
import com.laigeoffer.pmhub.base.security.annotation.EnablePmFeignClients;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author canghe
 * @description 代码生成
 * @create 2024-04-25-14:18
 */
@EnableCustomConfig
@EnablePmFeignClients
@SpringBootApplication
public class PmHubGenApplication {
    public static void main(String[] args) {
        SpringApplication.run(PmHubGenApplication.class, args);
    }
}