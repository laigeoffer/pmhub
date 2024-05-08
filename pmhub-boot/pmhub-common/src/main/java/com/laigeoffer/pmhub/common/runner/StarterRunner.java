package com.laigeoffer.pmhub.common.runner;


import cn.hutool.core.date.DateUtil;
import cn.hutool.log.LogFactory;
import com.laigeoffer.pmhub.common.utils.WxBotUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 * 服务启动后调用
 * @author canghe
 */
@Component
public class StarterRunner implements CommandLineRunner {

    @Value("${spring.profiles.active}")
    String activeStr;

    @Value("${pmhub.workWx.robert-url}")
    String robert_url;

    @Override
    public void run(String... args) throws Exception {
        LogFactory.get().info("启动完成，发送企微机器人通知");
        String message = String.format("PmHub系统【%s】分支服务已于： %s 启动完成！",activeStr, DateUtil.now());
        // 屏蔽local
        if (!"local".equals(activeStr)){
            WxBotUtils.sendMessage(message,robert_url);
        }
        LogFactory.get().info(message);
    }
}
