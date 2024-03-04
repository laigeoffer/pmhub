package com.laigeoffer.pmhub.project.domain.vo.project;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author canghe
 * @date 2022-12-15 15:53
 */
public class ProjectResVO {
    /**
     * 项目id
     */
    private String projectId;
    /**
     * 项目编码
     */
    private String projectCode;
    /**
     * 项目名
     */
    private String projectName;
    /**
     * 阶段代码
     */
    private Integer stageCode;
    /**
     * 阶段名
     */
    private String stageName;
    /**
     * 状态
     */
    private Integer status;
    private String statusName;
    /**
     * 类型
     */
    private Integer projectType;
    private String projectTypeName;
    /**
     * 发布状态
     */
    private Integer published;
    private String publishedName;
    /**
     * 进度
     */
    private BigDecimal projectProcess;
    /**
     * 用户id
     */
    private Long userId;
    private String nickName;
    /**
     * 开始时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date closeBeginTime;
    /**
     * 结束时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date closeEndTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createdTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updatedTime;
    /**
     * 描述
     */
    private String description;
    /**
     * 封面
     */
    private String cover;
    private Boolean collected;
    /**
     * 是否开启前缀
     */
    private Integer openPrefix;
    private String prefix;
    /**
     * 是否开启前缀
     */
    private Integer autoUpdateProcess;
    /**
     * 是否开启任务私有
     */
    private Integer openTaskPrivate;
    /**
     * 是否开启消息提醒
     */
    private Integer msgNotify;

    private Integer notifyDay;

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getProjectCode() {
        return projectCode;
    }

    public void setProjectCode(String projectCode) {
        this.projectCode = projectCode;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
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

    public Integer getProjectType() {
        return projectType;
    }

    public void setProjectType(Integer projectType) {
        this.projectType = projectType;
    }

    public String getProjectTypeName() {
        return projectTypeName;
    }

    public void setProjectTypeName(String projectTypeName) {
        this.projectTypeName = projectTypeName;
    }

    public Integer getPublished() {
        return published;
    }

    public void setPublished(Integer published) {
        this.published = published;
    }

    public String getPublishedName() {
        return publishedName;
    }

    public void setPublishedName(String publishedName) {
        this.publishedName = publishedName;
    }

    public BigDecimal getProjectProcess() {
        return projectProcess;
    }

    public void setProjectProcess(BigDecimal projectProcess) {
        this.projectProcess = projectProcess;
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

    public Date getCloseBeginTime() {
        return closeBeginTime;
    }

    public void setCloseBeginTime(Date closeBeginTime) {
        this.closeBeginTime = closeBeginTime;
    }

    public Date getCloseEndTime() {
        return closeEndTime;
    }

    public void setCloseEndTime(Date closeEndTime) {
        this.closeEndTime = closeEndTime;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public Date getUpdatedTime() {
        return updatedTime;
    }

    public void setUpdatedTime(Date updatedTime) {
        this.updatedTime = updatedTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public Boolean getCollected() {
        return collected;
    }

    public void setCollected(Boolean collected) {
        this.collected = collected;
    }

    public Integer getOpenPrefix() {
        return openPrefix;
    }

    public void setOpenPrefix(Integer openPrefix) {
        this.openPrefix = openPrefix;
    }

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public Integer getAutoUpdateProcess() {
        return autoUpdateProcess;
    }

    public void setAutoUpdateProcess(Integer autoUpdateProcess) {
        this.autoUpdateProcess = autoUpdateProcess;
    }

    public Integer getOpenTaskPrivate() {
        return openTaskPrivate;
    }

    public void setOpenTaskPrivate(Integer openTaskPrivate) {
        this.openTaskPrivate = openTaskPrivate;
    }

    public Integer getMsgNotify() {
        return msgNotify;
    }

    public void setMsgNotify(Integer msgNotify) {
        this.msgNotify = msgNotify;
    }

    public Integer getNotifyDay() {
        return notifyDay;
    }

    public void setNotifyDay(Integer notifyDay) {
        this.notifyDay = notifyDay;
    }
}
