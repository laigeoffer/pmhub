package com.laigeoffer.pmhub.workflow.listener.strategy;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 监听器抽象类工厂
 * @author canghe
 * @date 2023-01-09 09:25
 */
@Service
public class ListenerFactory {

    private static final Map<String, String> beanNames = new ConcurrentHashMap<>();
    static {
        ListenerTypeEnum[] listenerTypeEnums = ListenerTypeEnum.values();
        for (ListenerTypeEnum listenerTypeEnum : listenerTypeEnums) {
            beanNames.put(listenerTypeEnum.getType(), listenerTypeEnum.getBeanName());
        }
    }

    // 通过 Map 注入，通过 spring bean 的名称作为 key 动态获取对应实例
    @Autowired
    private Map<String, ListenerAbstractExecutor> executorMap;
    // 工厂层执行器
    public void execute(String type, ListenerDTO listenerDTO) {
        String beanName = beanNames.get(type);
        if (StringUtils.isEmpty(beanName)) {
            return;
        }
        // 决定最终走哪个类的执行器
        ListenerAbstractExecutor executor = executorMap.get(beanName);
        if (executor == null) {
            return;
        }
        executor.push2Wx(listenerDTO);
    }
}
