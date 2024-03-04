package com.laigeoffer.projectaihub.project.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.laigeoffer.projectaihub.project.domain.ProjectStage;
import com.laigeoffer.projectaihub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.projectaihub.project.domain.vo.project.stage.ProjectStageVO;

import java.util.List;

/**
 * @author canghe
 * @date 2022-12-19 16:37
 */
public interface ProjectStageService extends IService<ProjectStage> {
    List<ProjectStageVO> list(ProjectVO projectVO);
    void delete(ProjectStageVO projectStageVO);
    void add(ProjectStageVO projectStageVO);
    void edit(ProjectStageVO projectStageVO);
    boolean selectTaskByStageId(String stageId);
}
