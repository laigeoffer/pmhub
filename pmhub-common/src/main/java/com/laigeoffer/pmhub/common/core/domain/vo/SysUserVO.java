package com.laigeoffer.pmhub.common.core.domain.vo;

import com.laigeoffer.pmhub.common.annotation.Excel;
import com.laigeoffer.pmhub.common.core.domain.entity.SysUser;

/**
 * 用户对象 sys_user
 *
 * @author canghe
 */
public class SysUserVO extends SysUser {

    /**
     * 是否绑定企微
     */
    @Excel(name = "企微状态")
    private String userWxNameState;

    public String getUserWxNameState() {
        return userWxNameState;
    }

    public void setUserWxNameState(String userWxNameState) {
        this.userWxNameState = userWxNameState;
    }
}
