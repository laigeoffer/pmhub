package com.laigeoffer.pmhub.project.service.project;

import com.alibaba.fastjson2.JSON;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectResVO;
import com.laigeoffer.pmhub.project.mapper.ProjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author canghe
 * @date 2023-01-09 11:47
 */
@Slf4j
@Service("queryMyCollectProjectExecutor")
public class QueryMyCollectProjectExecutor extends QueryAbstractExecutor {
    @Autowired
    private ProjectMapper projectMapper;

    @Override
    public List<ProjectResVO> query(ProjectReqVO projectReqVO) {
        log.info("查询我收藏的项目入参:{}", JSON.toJSONString(projectReqVO));
        return projectMapper.selectMyCollectProjectList(projectReqVO, SecurityUtils.getUserId());
    }
}
