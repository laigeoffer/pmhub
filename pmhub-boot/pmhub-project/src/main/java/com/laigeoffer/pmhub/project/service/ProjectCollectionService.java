package com.laigeoffer.pmhub.project.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.ProjectCollection;

/**
 * @author canghe
 * @date 2022-12-15 16:34
 */
public interface ProjectCollectionService extends IService<ProjectCollection> {

    /**
     * 收藏项目
     * @param projectVO
     * @return
     */
    int collectProject(ProjectVO projectVO);
    /**
     * 取消收藏项目
     * @param projectVO
     * @return
     */
    int cancelCollectProject(ProjectVO projectVO);

}
