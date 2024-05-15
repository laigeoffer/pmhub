package com.laigeoffer.pmhub.api.workflow;

import com.laigeoffer.pmhub.api.workflow.factory.ProcessFeignFallbackFactory;
import com.laigeoffer.pmhub.base.core.constant.ServiceNameConstants;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

/**
 * @author canghe
 * @description 流程设计服务
 * @create 2024-04-24-22:38
 */
@FeignClient(contextId = "processFeignService", value = ServiceNameConstants.WORKFLOW_SERVICE, fallbackFactory = ProcessFeignFallbackFactory.class)
public interface ProcessFeignService {

    /**
     * 启动项目发布流程实例
     * @param projectId
     * @param procDefId
     * @param url
     * @param variables
     * @return
     */
    @PostMapping("/process/startProjectProcess")
    R<Integer> startProjectProcess(String projectId, String procDefId, String url, Map<String, Object> variables);

    /**
     * 根据流程定义id启动流程实例
     *
     * @param processDefId 流程定义id
     * @param variables 变量集合,json对象
     */
    @PostMapping("/startTaskApprove/{taskId}/{processDefId}")
    public R<Void> startTaskProcessByDefId(@PathVariable(value = "taskId") String taskId, @PathVariable(value = "processDefId") String processDefId, @RequestParam("url") String url, @RequestBody Map<String, Object> variables);
}
