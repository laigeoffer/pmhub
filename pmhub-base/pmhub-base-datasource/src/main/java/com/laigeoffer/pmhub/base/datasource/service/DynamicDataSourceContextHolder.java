package com.laigeoffer.pmhub.base.datasource.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Stack;

/**
 * 数据源切换处理
 *
 * @author canghe
 */
public class DynamicDataSourceContextHolder {
    public static final Logger log = LoggerFactory.getLogger(DynamicDataSourceContextHolder.class);

    /**
     * 使用ThreadLocal维护变量，ThreadLocal为每个使用该变量的线程提供独立的变量副本，
     * 所以每一个线程都可以独立地改变自己的副本，而不会影响其它线程所对应的副本。
     */
    private static final ThreadLocal<Stack<String>> CONTEXT_HOLDER = new ThreadLocal<>();

    /**
     * 获得数据源的变量
     */
    public static String getDataSourceType() {
        if (CONTEXT_HOLDER.get() == null || CONTEXT_HOLDER.get().empty()) {
            return null;
        }
        return CONTEXT_HOLDER.get().lastElement();
    }

    /**
     * 设置数据源的变量
     */
    public static void setDataSourceType(String dsType) {
        if (CONTEXT_HOLDER.get() == null) {
            CONTEXT_HOLDER.set(new Stack<>());
        }
        CONTEXT_HOLDER.get().push(dsType);
        log.debug("切换到{}数据源, 当前累积深度为{}", dsType, CONTEXT_HOLDER.get().size());
    }

    /**
     * 清空数据源变量
     */
    public static void clearDataSourceType() {
        Stack<String> dsStack = CONTEXT_HOLDER.get();
        String dsType = dsStack.pop();
        log.debug("退出数据源{}, 当前数据源为{}, 当前累积深度为{}", dsType, dsStack.empty() ? "default" : dsStack.lastElement(), dsStack.size());
        if (dsStack.empty()) {
            CONTEXT_HOLDER.remove();
        }
    }
}
