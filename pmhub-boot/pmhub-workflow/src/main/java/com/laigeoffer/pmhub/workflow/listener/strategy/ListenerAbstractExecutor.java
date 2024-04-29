package com.laigeoffer.pmhub.workflow.listener.strategy;

/**
 * 抽象类监听执行器
 * @author canghe
 * @date 2023-07-11 09:35
 */
public abstract class ListenerAbstractExecutor {
    public abstract void push2Wx(ListenerDTO listenerDTO);
}
