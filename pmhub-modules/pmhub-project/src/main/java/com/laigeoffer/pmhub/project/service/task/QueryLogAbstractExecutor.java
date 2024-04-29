package com.laigeoffer.pmhub.project.service.task;

import com.laigeoffer.pmhub.project.domain.vo.project.log.ProjectLogVO;

import java.util.List;

/**
 * @author canghe
 * @date 2023-01-09 16:21
 */
public abstract class QueryLogAbstractExecutor {

    public abstract List<ProjectLogVO> query(String taskId);
}
