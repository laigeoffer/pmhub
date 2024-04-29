package com.laigeoffer.pmhub.project.domain.vo.project;

/**
 * @author canghe
 * @date 2022-12-09 17:18
 */
public class ProjectReqVO {
    /**
     * 页码
     */
    private Integer pageNum;
    /**
     * 页数
     */
    private Integer pageSize;
    /**
     * recycle collect archive my
     */

    private String type;
    /**
     * 项目id
     */
    private String projectId;
    /**
     * 关键词
     */
    private String keyword;
    /**
     * 阶段编码
     */
    private Integer stageCode;
    /**
     * 状态
     */
    private Integer status;
    /**
     * 是否发布
     */
    private Integer published;
    /**
     * 开始时间
     */
    private String closeBeginTime;
    /**
     * 结束时间
     */
    private String closeEndTime;
    /**
     * 项目类型
     */
    private Integer projectType;

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Integer getStageCode() {
        return stageCode;
    }

    public void setStageCode(Integer stageCode) {
        this.stageCode = stageCode;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getPublished() {
        return published;
    }

    public void setPublished(Integer published) {
        this.published = published;
    }

    public String getCloseBeginTime() {
        return closeBeginTime;
    }

    public void setCloseBeginTime(String closeBeginTime) {
        this.closeBeginTime = closeBeginTime;
    }

    public String getCloseEndTime() {
        return closeEndTime;
    }

    public void setCloseEndTime(String closeEndTime) {
        this.closeEndTime = closeEndTime;
    }

    public Integer getProjectType() {
        return projectType;
    }

    public void setProjectType(Integer projectType) {
        this.projectType = projectType;
    }
}
