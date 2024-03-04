package com.laigeoffer.projectaihub.project.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.laigeoffer.projectaihub.project.domain.ProjectFile;
import com.laigeoffer.projectaihub.project.domain.vo.project.file.ProjectFileReqVO;
import com.laigeoffer.projectaihub.project.domain.vo.project.file.ProjectFileResVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author canghe
 * @date 2022-12-12 14:28
 */
public interface ProjectFileMapper extends BaseMapper<ProjectFile> {

    List<ProjectFileResVO> queryFileList(@Param("data") ProjectFileReqVO projectFileReqVO);
    List<ProjectFileResVO> queryProjectFileList(@Param("data") ProjectFileReqVO projectFileReqVO);
    List<ProjectFileResVO> queryTaskFileList(@Param("data") ProjectFileReqVO projectFileReqVO);
    List<ProjectFileResVO> queryTemplateFileList(@Param("data") ProjectFileReqVO projectFileReqVO);
}
