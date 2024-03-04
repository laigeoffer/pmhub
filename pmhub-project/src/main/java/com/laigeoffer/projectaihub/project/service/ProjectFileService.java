package com.laigeoffer.projectaihub.project.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;
import com.laigeoffer.projectaihub.project.domain.ProjectFile;
import com.laigeoffer.projectaihub.project.domain.vo.project.file.ProjectFileIdsVO;
import com.laigeoffer.projectaihub.project.domain.vo.project.file.ProjectFileReqVO;
import com.laigeoffer.projectaihub.project.domain.vo.project.file.ProjectFileResVO;

import java.io.IOException;
import java.util.List;

/**
 * @author canghe
 * @date 2022-12-16 09:24
 */
public interface ProjectFileService extends IService<ProjectFile> {

    PageInfo<ProjectFileResVO> queryFileList(ProjectFileReqVO projectFileReqVO);

    void deleteFileList(ProjectFileIdsVO projectFileIdsVO);

    void rename(ProjectFileReqVO projectFileReqVO);

    void batchDownload(String totalZip, List<String> paths) throws IOException;
}
