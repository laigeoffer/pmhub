package com.laigeoffer.pmhub.base.core.utils;

import cn.hutool.core.util.ObjectUtil;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysRole;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * 用户信息获取
 * @author canghe
 */
public class UserMessageUtils {

    /**
     * 获取当前用户名
     * @return 用户名
     * */
    public static String getUserName (){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (ObjectUtil.isNotEmpty(auth)){
            return auth.getName();
        }else {
            return "NPC";
        }
    }



}
