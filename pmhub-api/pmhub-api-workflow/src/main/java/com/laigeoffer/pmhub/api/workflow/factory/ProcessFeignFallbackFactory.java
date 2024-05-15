package com.laigeoffer.pmhub.api.workflow.factory;

import com.laigeoffer.pmhub.api.workflow.ProcessFeignService;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * 用户服务降级处理
 *
 * @author ruoyi
 */
@Component
public class ProcessFeignFallbackFactory implements FallbackFactory<ProcessFeignService>
{
    private static final Logger log = LoggerFactory.getLogger(ProcessFeignFallbackFactory.class);

    @Override
    public ProcessFeignService create(Throwable throwable)
    {
        log.error("流程设计服务调用失败:{}", throwable.getMessage());
        return new ProcessFeignService()
        {


            @Override
            public R<Integer> startProjectProcess(String projectId, String procDefId, String url, Map<String, Object> variables) {
                return R.fail("开启项目流程失败:" + throwable.getMessage());
            }

            @Override
            public R<Void> startTaskProcessByDefId(String taskId, String processDefId, String url, Map<String, Object> variables) {
                return R.fail("根据流程定义id启动流程实例失败:" + throwable.getMessage());
            }
        };
    }
}
