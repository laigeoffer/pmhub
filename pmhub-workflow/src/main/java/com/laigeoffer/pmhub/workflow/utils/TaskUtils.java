package com.laigeoffer.pmhub.workflow.utils;

import cn.hutool.core.util.ObjectUtil;
import com.laigeoffer.pmhub.common.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import com.laigeoffer.pmhub.workflow.common.constant.TaskConstants;
import com.laigeoffer.pmhub.oa.utils.SsoUrlUtils;

import java.util.ArrayList;
import java.util.List;

import static com.laigeoffer.pmhub.oa.utils.wx.MessageUtils.*;

/**
 * 工作流任务工具类
 *
 * @author canghe
 * @createTime 2022/4/24 12:42
 */
public class TaskUtils {

    public static String getUserId() {
        return String.valueOf(SecurityUtils.getUserId());
    }

    /**
     * 获取用户组信息
     *
     * @return candidateGroup
     */
    public static List<String> getCandidateGroup() {
        List<String> list = new ArrayList<>();
        LoginUser user = SecurityUtils.getLoginUser();
        if (ObjectUtil.isNotNull(user)) {
            if (ObjectUtil.isNotEmpty(user.getUser().getRoles())) {
                user.getUser().getRoles().forEach(role -> list.add(TaskConstants.ROLE_GROUP_PREFIX + role.getRoleId()));
            }
            if (ObjectUtil.isNotNull(user.getDeptId())) {
                list.add(TaskConstants.DEPT_GROUP_PREFIX + user.getDeptId());
            }
        }
        return list;
    }

    public static String createSsoUrl(String taskId){
        return SsoUrlUtils.ssoCreate(appid,agentid, host+path+"/pmhub-project/my-task/info?taskId="+ taskId);
    }
}
