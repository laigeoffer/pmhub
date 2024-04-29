package com.laigeoffer.pmhub.workflow.handler;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import com.laigeoffer.pmhub.workflow.common.constant.ProcessConstants;
import com.laigeoffer.pmhub.workflow.mapper.WfCopyMapper;
import lombok.AllArgsConstructor;
import org.flowable.bpmn.model.FlowElement;
import org.flowable.bpmn.model.UserTask;
import org.flowable.engine.delegate.DelegateExecution;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 多实例处理类
 *
 * @author canghe
 */
@AllArgsConstructor
@Component("multiInstanceHandler")
public class MultiInstanceHandler {

    @Autowired
    private WfCopyMapper wfCopyMapper;

    public HashSet<String> getUserIds(DelegateExecution execution) {
        HashSet<String> candidateUserIds = new LinkedHashSet<>();
        FlowElement flowElement = execution.getCurrentFlowElement();
        if (ObjectUtil.isNotEmpty(flowElement) && flowElement instanceof UserTask) {
            UserTask userTask = (UserTask) flowElement;
            String dataType = userTask.getAttributeValue(ProcessConstants.NAMASPASE, ProcessConstants.PROCESS_CUSTOM_DATA_TYPE);
            if ("USERS".equals(dataType) && CollUtil.isNotEmpty(userTask.getCandidateUsers())) {
                candidateUserIds.addAll(userTask.getCandidateUsers());
            } else if (CollUtil.isNotEmpty(userTask.getCandidateGroups())) {
                List<String> groups = userTask.getCandidateGroups()
                    .stream().map(item -> item.substring(4)).collect(Collectors.toList());
                if ("ROLES".equals(dataType)) {
                    groups.forEach(item -> {
                        List<String> userIds = wfCopyMapper.selectUserIdsByRoleId(Long.parseLong(item))
                            .stream().map(String::valueOf).collect(Collectors.toList());
                        candidateUserIds.addAll(userIds);
                    });
                } else if ("DEPTS".equals(dataType)) {
                    List<String> userIds = wfCopyMapper.selectUserIds(groups)
                        .stream().map(String::valueOf).collect(Collectors.toList());
                    candidateUserIds.addAll(userIds);
                }
            }
        }
        return candidateUserIds;
    }
}
