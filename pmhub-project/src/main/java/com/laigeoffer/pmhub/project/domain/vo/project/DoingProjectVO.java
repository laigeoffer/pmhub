package com.laigeoffer.pmhub.project.domain.vo.project;


import java.math.BigDecimal;

/**
 * @author canghe
 * @date 2022-12-16 15:57
 */

/**
 *
 */
public class DoingProjectVO {
    /**
     * 项目id
     */
    private String projectId;
    /**
     * 项目名
     */
    private String projectName;
    /**
     * 进度
     */
    private BigDecimal process;
    /**
     * 用户id
     */
    private Long userId;
    /**
     * 昵称
     */
    private String nickName;
    /**
     * 封面
     */
    private String cover;
    /**
     * 头像
     */
    private String avatar;

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
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

    public BigDecimal getProcess() {
        return process;
    }

    public void setProcess(BigDecimal process) {
        this.process = process;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
}
