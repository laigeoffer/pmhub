package com.laigeoffer.pmhub.project.service.task;

import com.laigeoffer.pmhub.project.domain.vo.project.log.ProjectLogVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author canghe
 * @date 2023-01-09 16:22
 */
@Service
public class QueryTaskLogFactory {
    private static final Map<Integer, String> beanNames = new ConcurrentHashMap<>();
    static {
        QueryLogEnum[] queryLogEnums = QueryLogEnum.values();
        for (QueryLogEnum queryLogEnum : queryLogEnums) {
            beanNames.put(queryLogEnum.getType(), queryLogEnum.getBeanName());
        }
    }

    // 通过 Map 注入，通过 META-INF.spring bean 的名称作为 key 动态获取对应实例
    @Autowired
    private Map<String, QueryLogAbstractExecutor> executorMap;
    // 工厂层执行器
    public List<ProjectLogVO> execute(Integer type, String taskId) {
        String beanName = beanNames.get(type);
        if (StringUtils.isEmpty(beanName)) {
            return null;
        }
        // 决定最终走哪个类的执行器
        QueryLogAbstractExecutor executor = executorMap.get(beanName);
        if (executor == null) {
            return null;
        }
        return executor.query(taskId);
    }
}
