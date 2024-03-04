package com.laigeoffer.projectaihub.project.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.laigeoffer.projectaihub.common.utils.SecurityUtils;
import com.laigeoffer.projectaihub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.projectaihub.project.domain.ProjectCollection;
import com.laigeoffer.projectaihub.project.mapper.ProjectCollectionMapper;
import com.laigeoffer.projectaihub.project.service.ProjectCollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * @author canghe
 * @date 2022-12-15 16:35
 */
@Service
public class ProjectCollectionServiceImpl extends ServiceImpl<ProjectCollectionMapper, ProjectCollection> implements ProjectCollectionService {

    @Autowired
    private ProjectCollectionMapper projectCollectionMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int collectProject(ProjectVO projectVO) {
        ProjectCollection projectCollection = new ProjectCollection();
        projectCollection.setProjectId(projectVO.getProjectId());
        projectCollection.setUserId(SecurityUtils.getUserId());
        projectCollection.setCreatedBy(SecurityUtils.getUsername());
        projectCollection.setCreatedTime(new Date());
        projectCollection.setUpdatedBy(SecurityUtils.getUsername());
        projectCollection.setUpdatedTime(new Date());
        return projectCollectionMapper.insert(projectCollection);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int cancelCollectProject(ProjectVO projectVO) {
        LambdaQueryWrapper<ProjectCollection> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectCollection::getProjectId, projectVO.getProjectId()).eq(ProjectCollection::getUserId, SecurityUtils.getUserId());
        return projectCollectionMapper.delete(queryWrapper);
    }
}
