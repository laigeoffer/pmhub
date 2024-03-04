package com.laigeoffer.pmhub.project.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectReqVO;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectResVO;
import com.laigeoffer.pmhub.project.domain.vo.project.ProjectVO;
import com.laigeoffer.pmhub.project.domain.Project;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author canghe
 * @date 2022-12-12 14:27
 */
public interface ProjectMapper extends BaseMapper<Project> {

    List<ProjectVO> queryMyProjectList(@Param("userId") Long userId);

    List<ProjectResVO> recycleProjectList();
    ProjectResVO detail(@Param("projectId") String projectId);

    List<ProjectResVO> selectMyProjectList(@Param("data") ProjectReqVO projectReqVO, @Param("userId") Long userId);
    List<ProjectResVO> selectMyCollectProjectList(@Param("data") ProjectReqVO projectReqVO, @Param("userId") Long userId);
}
