package com.laigeoffer.pmhub.workflow.domain.vo;

import cn.hutool.json.JSONUtil;

/**
 * 代办任务数量提醒
 * @author canghe
 */
public class TodoNumVO {

    /**
     * 微信id
     * */
    String userWxName;

    /**
     * 代办数量
     * */
    Integer num;

    String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserWxName() {
        return userWxName;
    }

    public void setUserWxName(String userWxName) {
        this.userWxName = userWxName;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    @Override
    public String toString(){
        return JSONUtil.toJsonStr(this);
    }
}
