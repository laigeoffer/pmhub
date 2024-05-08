package com.laigeoffer.pmhub.common.runner;


import cn.hutool.core.date.DateUtil;
import cn.hutool.log.LogFactory;
import com.laigeoffer.pmhub.common.utils.WxBotUtils;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

/**
 * 服务退出时调用
 * @author canghe
 */
@Configuration
public class ExitRunner implements DisposableBean {

    @Value("${spring.profiles.active}")
    String activeStr;
    @Value("${pmhub.workWx.robert-url}")
    String robert_url;

    @Override
    public void destroy() throws Exception {
        LogFactory.get().info("开始关闭，发送企微机器人通知");
        String message = String.format("PmHub系统【%s】开始关闭！ %s ",activeStr, DateUtil.now());
        // 屏蔽local
        if (!"local".equals(activeStr)){
            WxBotUtils.sendMessage(message,robert_url);
        }
        LogFactory.get().info(message);
    }
}
