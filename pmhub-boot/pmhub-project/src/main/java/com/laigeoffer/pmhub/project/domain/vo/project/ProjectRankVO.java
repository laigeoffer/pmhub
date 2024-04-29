package com.laigeoffer.pmhub.project.domain.vo.project;

import java.math.BigDecimal;

/**
 * @author canghe
 * @date 2022-12-12 10:00
 */
public class ProjectRankVO extends ProjectVO {
    /**
     * 进度
     */
    private BigDecimal process;
    /**
     * 账号
     */
    private String userName;
    /**
     * 昵称
     */
    private String nickName;

    public BigDecimal getProcess() {
        return process;
    }

    public void setProcess(BigDecimal process) {
        this.process = process;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
}
