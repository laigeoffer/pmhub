package com.laigeoffer.pmhub.common.utils;

import cn.hutool.core.util.ObjectUtil;
import com.laigeoffer.pmhub.common.core.domain.entity.SysRole;
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

    /**
     * 是否为保密信息查看人
     *
     * @return {@link Boolean} true 是 false 否
     */
    public static Boolean isClassifiedInquirer(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        // 判断用户是否已认证
        if (auth.isAuthenticated()) {
            // 如果是超管直接允许
            if (SecurityUtils.getLoginUser().getUser().getUserName().equals("admin")){
                return true;
            }
            // 获取当前用户的所有角色
            for (SysRole authority : SecurityUtils.getLoginUser().getUser().getRoles()) {
                // 检查用户是否拥有目标角色
                if (authority.getRoleKey().equals(SecrecyUtils.ROLE_KEY)) {
                    // 用户拥有目标角色
                    return true;
                }
            }
            return false;
        } else {
            // 用户未认证
            return false;
        }
    }

}
