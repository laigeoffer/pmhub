package com.laigeoffer.pmhub.project.domain.vo.project.stage;

/**
 * @author canghe
 * @date 2022-12-19 16:42
 */
public class ProjectStageVO {
    /**
     * 阶段id
     */
    private String stageId;
    /**
     * 项目id
     */
    private String projectId;
    /**
     * 阶段编号
     */
    private Integer stageCode;
    /**
     * 阶段名
     */
    private String stageName;

    public String getStageId() {
        return stageId;
    }

    public void setStageId(String stageId) {
        this.stageId = stageId;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public Integer getStageCode() {
        return stageCode;
    }

    public void setStageCode(Integer stageCode) {
        this.stageCode = stageCode;
    }

    public String getStageName() {
        return stageName;
    }

    public void setStageName(String stageName) {
        this.stageName = stageName;
    }
}
