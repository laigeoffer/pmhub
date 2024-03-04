package com.laigeoffer.projectaihub.project.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.projectaihub.project.domain.ProjectLog;
import com.laigeoffer.projectaihub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.projectaihub.project.domain.vo.project.log.LogVO;
import com.laigeoffer.projectaihub.project.domain.vo.project.log.ProjectLogVO;

/**
 * @author canghe
 * @date 2022-12-21 11:40
 */
public interface ProjectLogService extends IService<ProjectLog> {
    void run(LogVO logVO);

    PageInfo<ProjectLogVO> list(ProjectVO projectVO);
}
