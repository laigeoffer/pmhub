package com.laigeoffer.pmhub.base.core.core.domain.dto;

/**
 * @author canghe
 * @date 2023-02-28 09:13
 */
public class ApprovalSetDTO {

    private String approved;
    private String definitionId;
    private String taskId;
    private String deploymentId;
    private String projectId;

    private String extraId;

    private String type;


    // 构造函数
    public ApprovalSetDTO(String extraId, String type, String approved, String definitionId, String deploymentId) {
        this.extraId = extraId;
        this.type = type;
        this.approved = approved;
        this.definitionId = definitionId;
        this.deploymentId = deploymentId;
    }

    public String getExtraId() {
        return extraId;
    }

    public void setExtraId(String extraId) {
        this.extraId = extraId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getApproved() {
        return approved;
    }

    public void setApproved(String approved) {
        this.approved = approved;
    }

    public String getDefinitionId() {
        return definitionId;
    }

    public void setDefinitionId(String definitionId) {
        this.definitionId = definitionId;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public String getDeploymentId() {
        return deploymentId;
    }

    public void setDeploymentId(String deploymentId) {
        this.deploymentId = deploymentId;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }
}
