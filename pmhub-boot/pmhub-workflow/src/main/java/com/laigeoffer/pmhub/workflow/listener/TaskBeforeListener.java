package com.laigeoffer.pmhub.workflow.listener;

import org.flowable.common.engine.api.delegate.event.FlowableEvent;
import org.flowable.common.engine.api.delegate.event.FlowableEventListener;
import org.flowable.common.engine.impl.cfg.TransactionState;
import org.flowable.identitylink.api.IdentityLink;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.springframework.stereotype.Component;
import org.flowable.common.engine.impl.event.FlowableEntityEventImpl;

import java.util.Set;

@Component
public class TaskBeforeListener implements FlowableEventListener {

    @Override
    public void onEvent(FlowableEvent flowableEvent) {
        TaskEntity taskEntity = (TaskEntity) ((FlowableEntityEventImpl) flowableEvent).getEntity();
        // TODO 获取到了taskEntity 自己做每个节点的前置操作
        //获取审批候选人
        Set<IdentityLink> candidates = taskEntity.getCandidates();
        //流程名称
        String currentProcess = taskEntity.getName();
        for (IdentityLink candidate : candidates) {
            // TODO 执行业务逻辑：系统通知该候选人
        }
        //如果上面的候选组没人，就执行下面这句。指定通知这个人
        if(candidates.size()==0){
            // TODO 执行业务逻辑：系统通知指定分配人员
        }

    }

    @Override
    public boolean isFailOnException() {
        return false;
    }

    @Override
    public boolean isFireOnTransactionLifecycleEvent() {
        return false;
    }

    @Override
    public String getOnTransaction() {
        //事务提交后触发
        return TransactionState.COMMITTED.name();
    }


}
