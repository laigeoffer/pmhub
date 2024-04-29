package com.laigeoffer.pmhub.project.domain.vo.project;

import java.util.List;

/**
 * @author canghe
 * @date 2022-12-12 10:27
 */
public class ProjectVO {
    /**
     * 页码
     */
    private Integer pageNum;
    /**
     * 页数
     */
    private Integer pageSize;
    /**
     * 项目id
     */
    private String projectId;
    /**
     * 项目名
     */
    private String projectName;
    /**
     * 封面
     */
    private String cover;
    /**
     * 用户id
     */
    private List<Long> userIdList;

    private Integer status;
    private String statusName;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

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

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public List<Long> getUserIdList() {
        return userIdList;
    }

    public void setUserIdList(List<Long> userIdList) {
        this.userIdList = userIdList;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }
}
