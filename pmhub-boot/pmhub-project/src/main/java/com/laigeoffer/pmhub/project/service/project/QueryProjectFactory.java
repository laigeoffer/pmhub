package com.laigeoffer.pmhub.project.service.project;

import com.laigeoffer.pmhub.project.domain.vo.project.ProjectReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectResVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author canghe
 * @date 2023-01-09 14:10
 */
@Service
public class QueryProjectFactory {

    private static final Map<String, String> beanNames = new ConcurrentHashMap<>();
    static {
        QueryProjectEnum[] queryProjectEnums = QueryProjectEnum.values();
        for (QueryProjectEnum queryProjectEnum : queryProjectEnums) {
            beanNames.put(queryProjectEnum.getType(), queryProjectEnum.getBeanName());
        }
    }

    // 通过 Map 注入，通过 META-INF.spring bean 的名称作为 key 动态获取对应实例
    @Autowired
    private Map<String, QueryAbstractExecutor> executorMap;
    // 工厂层执行器
    public List<ProjectResVO> execute(ProjectReqVO projectReqVO) {
        String beanName = beanNames.get(projectReqVO.getType());
        if (StringUtils.isEmpty(beanName)) {
            return null;
        }
        // 决定最终走哪个类的执行器
        QueryAbstractExecutor executor = executorMap.get(beanName);
        if (executor == null) {
            return null;
        }
        return executor.query(projectReqVO);
    }
}
