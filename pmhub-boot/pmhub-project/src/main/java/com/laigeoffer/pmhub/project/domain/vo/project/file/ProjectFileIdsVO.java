package com.laigeoffer.pmhub.project.domain.vo.project.file;

import java.util.List;

/**
 * @author canghe
 * @date 2022-12-16 10:34
 */
public class ProjectFileIdsVO {
    /**
     * 项目id
     */
    private String projectId;
    /**
     * 下载内容
     */
    private List<FileVO> fileVOList;

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public List<FileVO> getFileVOList() {
        return fileVOList;
    }

    public void setFileVOList(List<FileVO> fileVOList) {
        this.fileVOList = fileVOList;
    }
}
