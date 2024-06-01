package com.laigeoffer.pmhub.base.security.interceptor;

import com.laigeoffer.pmhub.base.core.constant.Constants;
import com.laigeoffer.pmhub.base.core.constant.SecurityConstants;
import com.laigeoffer.pmhub.base.core.context.SecurityContextHolder;
import com.laigeoffer.pmhub.base.core.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.base.core.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.base.core.utils.ServletUtils;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.base.security.auth.AuthUtil;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.AsyncHandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashSet;
import java.util.Set;

/**
 * 自定义请求头拦截器，将Header数据封装到线程变量中方便获取
 * 注意：此拦截器会同时验证当前用户有效期自动刷新有效期
 *
 * @author canghe
 */
public class HeaderInterceptor implements AsyncHandlerInterceptor {

    // 需要免登录的路径集合
    private static final Set<String> EXEMPTED_PATHS = new HashSet<>();

    static {
        // 在这里添加所有需要免登录默认展示首页的的路径
        EXEMPTED_PATHS.add("/system/user/getInfo");
        EXEMPTED_PATHS.add("/project/statistics");
        EXEMPTED_PATHS.add("/project/doing");
        EXEMPTED_PATHS.add("/project/queryMyTaskList");
        EXEMPTED_PATHS.add("/project/select");
        EXEMPTED_PATHS.add("/system/menu/getRouters");

    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        SecurityContextHolder.setUserId(ServletUtils.getHeader(request, SecurityConstants.DETAILS_USER_ID));
        SecurityContextHolder.setUserName(ServletUtils.getHeader(request, SecurityConstants.DETAILS_USERNAME));
        SecurityContextHolder.setUserKey(ServletUtils.getHeader(request, SecurityConstants.USER_KEY));

        String token = SecurityUtils.getToken();
        if (StringUtils.isNotEmpty(token)) {
            LoginUser loginUser = AuthUtil.getLoginUser(token);
            if (StringUtils.isNotNull(loginUser)) {
                AuthUtil.verifyLoginUserExpire(loginUser);
                SecurityContextHolder.set(SecurityConstants.LOGIN_USER, loginUser);
            }
        } else {
            // 首页免登场景展示
            // 检查请求路径是否匹配特定路径
            String requestURI = request.getRequestURI();
            if (isExemptedPath(requestURI)) {
                // 创建一个默认的 LoginUser 对象
                LoginUser defaultLoginUser = createDefaultLoginUser();
                SecurityContextHolder.set(SecurityConstants.LOGIN_USER, defaultLoginUser);
            }
        }
        return true;
    }

    // 判断请求路径是否匹配特定路径
    private boolean isExemptedPath(String requestURI) {
        // 你可以根据需要调整特定路径的匹配逻辑
        return EXEMPTED_PATHS.stream().anyMatch(requestURI::startsWith);
    }

    // 创建一个默认的 LoginUser 对象
    private LoginUser createDefaultLoginUser() {
        LoginUser defaultLoginUser = new LoginUser();
        defaultLoginUser.setUserId(173L);  // 设置默认的用户ID
        defaultLoginUser.setUsername(Constants.DEMO_ACCOUNT);  // 设置默认的用户名

        SysUser demoSysUser = new SysUser();
        demoSysUser.setUserId(173L);
        demoSysUser.setUserName(Constants.DEMO_ACCOUNT);
        demoSysUser.setDeptId(100L);
        demoSysUser.setStatus("0");

        defaultLoginUser.setUser(demoSysUser);
        // 设置其他必要的默认属性
        return defaultLoginUser;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        SecurityContextHolder.remove();
    }
}
