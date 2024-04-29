package com.laigeoffer.pmhub.project.domain.vo.project.file;

/**
 * @author canghe
 * @date 2022-12-16 10:56
 */
public class FileVO {
    /**
     * 文件id
     */
    private String projectFileId;
    /**
     * 文件地址
     */
    private String fileUrl;
    /**
     * 文件名
     */
    private String fileName;

    public String getProjectFileId() {
        return projectFileId;
    }

    public void setProjectFileId(String projectFileId) {
        this.projectFileId = projectFileId;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
