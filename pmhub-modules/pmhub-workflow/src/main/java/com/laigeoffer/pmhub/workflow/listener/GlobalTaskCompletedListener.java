package com.laigeoffer.pmhub.workflow.listener;

import cn.hutool.log.LogFactory;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.laigeoffer.pmhub.workflow.domain.WfTaskMessageDeal;
import com.laigeoffer.pmhub.workflow.mapper.ListenerMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfCopyMapper;
import com.laigeoffer.pmhub.workflow.mapper.WfTaskMessageDealMapper;
import org.flowable.common.engine.api.delegate.event.FlowableEngineEntityEvent;
import org.flowable.engine.delegate.event.AbstractFlowableEngineEventListener;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


/**
 * 创建任务结束事件
 * @author canghe
 */
@Component
public class GlobalTaskCompletedListener extends AbstractFlowableEngineEventListener {

    @Autowired
    WfCopyMapper wfCopyMapper;

    @Autowired
    ListenerMapper listenerMapper;

    @Autowired
    private WfTaskMessageDealMapper wfTaskMessageDealMapper;


    @Override
    protected void taskCompleted(FlowableEngineEntityEvent event) {
        LogFactory.get().info("任务结束------------------------Start---------------------->");

        TaskEntity taskEntity = (TaskEntity)event.getEntity();
        LambdaQueryWrapper<WfTaskMessageDeal> qw = new LambdaQueryWrapper<>();
        qw.eq(WfTaskMessageDeal::getTaskId, taskEntity.getId()).eq(WfTaskMessageDeal::getAssignee, taskEntity.getAssignee());
        wfTaskMessageDealMapper.delete(qw);
        // TODO: 2024.04.25 删除OA
        // 清理审批提醒消息
//        RocketMqUtils.cleanMessage(taskEntity.getId() + "_" + taskEntity.getAssignee());
//        OAUtils.restfulCall2(OAUtils.ALTER_MESSAGE_API, OAUtils.mapToStr(OAUtils.alterCustomMessageSingle(taskEntity.getId() + "_" + taskEntity.getAssignee(), OAMessageStatusEnum.DEAL.getStatus(), wfCopyMapper.selectUserById(Long.valueOf(taskEntity.getAssignee())).getUserName())), OAUtils.ALTER_MESSAGE_API);
        LogFactory.get().info("任务结束------------------------End---------------------->");
    }
}
