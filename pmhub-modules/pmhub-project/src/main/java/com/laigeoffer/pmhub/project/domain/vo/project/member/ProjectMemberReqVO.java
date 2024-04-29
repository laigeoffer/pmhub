package com.laigeoffer.pmhub.project.domain.vo.project.member;

/**
 * @author canghe
 * @date 2022-12-13 09:34
 */
public class ProjectMemberReqVO {
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
     * 关键词
     */
    private String keyword;

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

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }
}
