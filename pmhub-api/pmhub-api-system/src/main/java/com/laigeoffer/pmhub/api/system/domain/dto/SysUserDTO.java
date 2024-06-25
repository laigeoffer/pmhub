package com.laigeoffer.pmhub.api.system.domain.dto;

import com.laigeoffer.pmhub.base.core.core.domain.BaseEntity;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysDept;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysRole;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

/**
 * @author canghe
 * @description SysUserDTO
 * @create 2024-06-24-16:50
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SysUserDTO extends BaseEntity {
    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 部门ID组
     */
    private List<Long> userIds;

    /**
     * 部门ID
     */
    private Long deptId;

    /**
     * 直属上级
     */
    private String leaderId;

    private List<String> leaderIds;
    private List<String> leaderNames;

    /**
     * 用户账号
     */
    private String userName;

    /**
     * 用户企微id
     */
    private String userWxName;

    /**
     * 用户昵称
     */
    private String nickName;

    /**
     * 用户邮箱
     */
    private String email;

    /**
     * 手机号码
     */
    private String phonenumber;

    /**
     * 用户性别
     */
    private String sex;

    /**
     * 用户头像
     */
    private String avatar;

    /**
     * 密码
     */
    private String password;

    /**
     * 帐号状态（0正常 1停用）
     */
    private String status;

    /**
     */
    private String delFlag;

    /**
     * 最后登录IP
     */
    private String loginIp;

    /**
     * 最后登录时间
     */
    private Date loginDate;

    /**
     * 部门对象
     */

    private SysDept dept;

    /**
     * 角色对象
     */
    private List<SysRole> roles;

    /**
     * 角色组
     */
    private Long[] roleIds;

    /**
     * 岗位组
     */
    private Long[] postIds;

    /**
     * 角色ID
     */
    private Long roleId;

}
