package com.laigeoffer.pmhub.api.workflow;

import com.laigeoffer.pmhub.api.workflow.factory.ProcessFeignFallbackFactory;
import com.laigeoffer.pmhub.base.core.constant.SecurityConstants;
import com.laigeoffer.pmhub.base.core.constant.ServiceNameConstants;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.dto.ApprovalSetDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

/**
 * @author canghe
 * @description 流程部署服务
 * @create 2024-04-24-22:38
 */
@FeignClient(contextId = "deployFeignService", value = ServiceNameConstants.WORKFLOW_SERVICE, fallbackFactory = ProcessFeignFallbackFactory.class)
public interface DeployFeignService {

    /**
     * 更新审批设置
     * @param approvalSetDTO
     * @return
     */
    @PostMapping("/workflow/deploy/updateApprovalSet")
    R<?> updateApprovalSet(ApprovalSetDTO approvalSetDTO, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);


    /**
     * 更新审批设置2
     * @param approvalSetDTO
     * @return
     */
    @PostMapping("/workflow/deploy/updateApprovalSet")
    R<?> updateApprovalSet2(ApprovalSetDTO approvalSetDTO, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);


    /**
     * 查询流程部署关联表单信息
     * @param taskId
     * @return
     */
    @GetMapping("/workflow/deploy/selectList")
    R<?> selectList(List<String> taskId, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);

    /**
     * 添加&更新审批设置
     * @param approvalSetDTO
     * @return
     */
    @PostMapping("/workflow/deploy/insertOrUpdateApprovalSet")
    R<Boolean> insertOrUpdateApprovalSet(ApprovalSetDTO approvalSetDTO, @RequestHeader(SecurityConstants.FROM_SOURCE) String source);


    /**
     * 添加审批设置
     * @return
     */
    @PostMapping("/workflow/deploy/insertApprovalSet")
    public R<?> insertApprovalSet(@RequestHeader(SecurityConstants.FROM_SOURCE) String source);
}
