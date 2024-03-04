package com.laigeoffer.projectaihub.project.service.project;

import com.laigeoffer.projectaihub.project.domain.vo.project.ProjectReqVO;
import com.laigeoffer.projectaihub.project.domain.vo.project.ProjectResVO;

import java.util.List;

/**
 * @author canghe
 * @date 2023-01-09 11:41
 */
public abstract class QueryAbstractExecutor {
    public abstract List<ProjectResVO> query(ProjectReqVO projectReqVO);
}
