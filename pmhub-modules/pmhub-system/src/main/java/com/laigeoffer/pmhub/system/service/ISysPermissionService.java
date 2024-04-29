package com.laigeoffer.pmhub.system.service;

import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;

import java.util.Set;

/**
 * @author canghe
 * @description 权限信息-服务层
 * @create 2024-04-24-22:13
 */
public interface ISysPermissionService {

    /**
     * 获取角色数据权限
     *
     * @param user 用户信息
     * @return 角色权限信息
     */
    Set<String> getRolePermission(SysUser user);


    /**
     * 获取菜单数据权限
     *
     * @param user 用户信息
     * @return 菜单权限信息
     */
    Set<String> getMenuPermission(SysUser user);

}
