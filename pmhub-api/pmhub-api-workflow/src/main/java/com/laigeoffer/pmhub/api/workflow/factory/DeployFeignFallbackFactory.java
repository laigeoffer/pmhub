package com.laigeoffer.pmhub.api.workflow.factory;

import com.laigeoffer.pmhub.api.workflow.DeployFeignService;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.core.core.domain.dto.ApprovalSetDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 用户服务降级处理
 *
 * @author canghe
 */
@Component
public class DeployFeignFallbackFactory implements FallbackFactory<DeployFeignService> {
    private static final Logger log = LoggerFactory.getLogger(DeployFeignFallbackFactory.class);

    @Override
    public DeployFeignService create(Throwable throwable) {
        log.error("流程部署服务调用失败:{}", throwable.getMessage());
        return new DeployFeignService() {
            @Override
            public R<?> updateApprovalSet(ApprovalSetDTO approvalSetDTO, String source) {
                return R.fail("更新审批设置失败:" + throwable.getMessage());
            }

            @Override
            public R<?> updateApprovalSet2(ApprovalSetDTO approvalSetDTO, String source) {
                return R.fail("更新审批设置2失败:" + throwable.getMessage());
            }

            @Override
            public R<?> selectList(List<String> taskId, String source) {
                return R.fail("查询流程部署关联表单信息失败:" + throwable.getMessage());
            }

            @Override
            public R<Boolean> insertOrUpdateApprovalSet(ApprovalSetDTO approvalSetDTO, String source)  {
                return R.fail("添加&更新任务审批设置失败:" + throwable.getMessage());
            }

            @Override
            public R<?> insertApprovalSet(String source) {
                return R.fail("添加任务审批设置失败:" + throwable.getMessage());
            }
        };
    }
}
