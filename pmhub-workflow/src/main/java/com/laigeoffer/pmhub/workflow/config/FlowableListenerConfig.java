package com.laigeoffer.pmhub.workflow.config;

import com.laigeoffer.pmhub.workflow.listener.*;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEventType;
import org.flowable.common.engine.api.delegate.event.FlowableEventDispatcher;
import org.flowable.spring.SpringProcessEngineConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;


/**
 * @author canghe
 */
@Configuration
public class FlowableListenerConfig implements ApplicationListener<ContextRefreshedEvent> {

    @Autowired
    private SpringProcessEngineConfiguration configuration;

    @Autowired
    private GlobalTaskAssigneeListener globalTaskAssigneeListener;
    @Autowired
    private GlobalTaskCompletedListener globalTaskCompletedListener;
    @Autowired
    private GlobalProcessStartedListener globalProcessStartedListener;
    @Autowired
    private GlobalProcessEndListener globalProcessEndListener;

    @Autowired
    private GlobalProcesstCancelListener globalProcesstCancelListener;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        FlowableEventDispatcher dispatcher = configuration.getEventDispatcher();
        //任务执行人设置全局监听
        dispatcher.addEventListener(globalTaskAssigneeListener, FlowableEngineEventType.TASK_ASSIGNED);

        //任务结束全局监听
        dispatcher.addEventListener(globalTaskCompletedListener, FlowableEngineEventType.TASK_COMPLETED);

        //流程开始全局监听
        dispatcher.addEventListener(globalProcessStartedListener, FlowableEngineEventType.PROCESS_STARTED);

        //流程结束全局监听
        dispatcher.addEventListener(globalProcessEndListener, FlowableEngineEventType.PROCESS_COMPLETED);

        //流程取消全局监听
        dispatcher.addEventListener(globalProcesstCancelListener, FlowableEngineEventType.PROCESS_CANCELLED);
    }

}
