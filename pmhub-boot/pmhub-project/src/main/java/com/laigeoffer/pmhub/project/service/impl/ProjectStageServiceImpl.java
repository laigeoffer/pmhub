package com.laigeoffer.pmhub.project.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.laigeoffer.pmhub.common.exception.ServiceException;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import com.laigeoffer.pmhub.project.domain.vo.project.stage.ProjectStageVO;
import com.laigeoffer.pmhub.project.domain.ProjectStage;
import com.laigeoffer.pmhub.project.domain.ProjectTask;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.mapper.ProjectStageMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectTaskMapper;
import com.laigeoffer.pmhub.project.service.ProjectStageService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * @author canghe
 * @date 2022-12-19 16:38
 */
@Service
public class ProjectStageServiceImpl extends ServiceImpl<ProjectStageMapper, ProjectStage> implements ProjectStageService {
    @Autowired
    private ProjectStageMapper projectStageMapper;
    @Autowired
    private ProjectTaskMapper projectTaskMapper;
    @Override
    public List<ProjectStageVO> list(ProjectVO projectVO) {
        List<ProjectStageVO> list = new ArrayList<>(10);
        LambdaQueryWrapper<ProjectStage> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectStage::getProjectId, projectVO.getProjectId()).orderByAsc(ProjectStage::getStageCode);
        List<ProjectStage> projectStages = projectStageMapper.selectList(queryWrapper);
        if (CollectionUtils.isNotEmpty(projectStages)) {
            projectStages.forEach(a -> {
                ProjectStageVO projectStageVO = new ProjectStageVO();
                projectStageVO.setProjectId(a.getProjectId());
                projectStageVO.setStageId(a.getId());
                projectStageVO.setStageCode(a.getStageCode());
                projectStageVO.setStageName(a.getStageName());
                list.add(projectStageVO);
            });
        }
        return list;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(ProjectStageVO projectStageVO) {
        LambdaQueryWrapper<ProjectTask> qw = new LambdaQueryWrapper<>();
        qw.eq(ProjectTask::getProjectStageId, projectStageVO.getStageId());
        Long count = projectTaskMapper.selectCount(qw);
        if (count > 0) {
            throw new ServiceException("该阶段下存在任务，不允许删除");
        }
        projectStageMapper.deleteById(projectStageVO.getStageId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(ProjectStageVO projectStageVO) {
        ProjectStage projectStage = new ProjectStage();
        projectStage.setProjectId(projectStageVO.getProjectId());
        LambdaQueryWrapper<ProjectStage> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ProjectStage::getProjectId, projectStageVO.getProjectId());
        List<ProjectStage> projectStages = projectStageMapper.selectList(queryWrapper);
        if (CollectionUtils.isNotEmpty(projectStages)) {
            ProjectStage ps = projectStages.stream().max(Comparator.comparing(ProjectStage::getStageCode)).get();
            projectStage.setStageCode(ps.getStageCode() + 1);
        }
        projectStage.setStageName(projectStageVO.getStageName());
        projectStage.setCreatedBy(SecurityUtils.getUsername());
        projectStage.setCreatedTime(new Date());
        projectStage.setUpdatedBy(SecurityUtils.getUsername());
        projectStage.setUpdatedTime(new Date());
        projectStageMapper.insert(projectStage);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void edit(ProjectStageVO projectStageVO) {
        ProjectStage projectStage = projectStageMapper.selectById(projectStageVO.getStageId());
        projectStage.setStageName(projectStageVO.getStageName());
        projectStage.setUpdatedBy(SecurityUtils.getUsername());
        projectStage.setUpdatedTime(new Date());
        projectStageMapper.updateById(projectStage);
    }

    @Override
    public boolean selectTaskByStageId(String stageId) {
        // 判断该阶段下是否存在任务
        LambdaQueryWrapper<ProjectTask> qw = new LambdaQueryWrapper<>();
        qw.eq(ProjectTask::getProjectStageId, stageId);
        return projectTaskMapper.selectCount(qw) > 0;
    }
}
