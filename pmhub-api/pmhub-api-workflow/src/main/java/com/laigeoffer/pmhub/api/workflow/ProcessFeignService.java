package com.laigeoffer.pmhub.api.workflow;

import com.laigeoffer.pmhub.api.workflow.factory.ProcessFeignFallbackFactory;
import com.laigeoffer.pmhub.base.core.constant.ServiceNameConstants;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.dto.ProjectProcessDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * @author canghe
 * @description 流程设计服务
 * @create 2024-04-24-22:38
 */
@FeignClient(contextId = "processFeignService", value = ServiceNameConstants.WORKFLOW_SERVICE, fallbackFactory = ProcessFeignFallbackFactory.class)
public interface ProcessFeignService {

    /**
     * 启动项目发布流程实例
     * @return
     */
    @PostMapping("/process/startProjectProcess")
    R<Integer> startProjectProcess(@RequestBody ProjectProcessDTO request);

    /**
     * 根据流程定义id启动流程实例
     *
     * @param request 流程定义
     */
    @PostMapping("/startTaskProcessByDefId")
    R<Void> startTaskProcessByDefId(@RequestBody ProjectProcessDTO request);
}
