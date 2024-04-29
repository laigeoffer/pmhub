package com.laigeoffer.pmhub.web.controller.system;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.hutool.log.LogFactory;
import com.laigeoffer.pmhub.common.config.PmhubConfig;
import com.laigeoffer.pmhub.common.constant.Constants;
import com.laigeoffer.pmhub.common.core.domain.AjaxResult;
import com.laigeoffer.pmhub.common.core.domain.entity.SysMenu;
import com.laigeoffer.pmhub.common.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.common.core.domain.model.LoginBody;
import com.laigeoffer.pmhub.common.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.common.exception.ServiceException;
import com.laigeoffer.pmhub.common.exception.file.InvalidExtensionException;
import com.laigeoffer.pmhub.common.utils.OAUtils;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import com.laigeoffer.pmhub.common.utils.WorkWxUtil;
import com.laigeoffer.pmhub.common.utils.ZipDownloadUtil;
import com.laigeoffer.pmhub.common.utils.file.FileUploadUtils;
import com.laigeoffer.pmhub.common.utils.file.MimeTypeUtils;
import com.laigeoffer.pmhub.common.utils.oa.dto.OAUserDTO;
import com.laigeoffer.pmhub.framework.web.service.SysLoginService;
import com.laigeoffer.pmhub.framework.web.service.SysPermissionService;
import com.laigeoffer.pmhub.system.domain.PmhubOAuth2;
import com.laigeoffer.pmhub.system.domain.PmhubOAuth2Agree;
import com.laigeoffer.pmhub.system.domain.PmhubOAuth2Token;
import com.laigeoffer.pmhub.system.domain.PmhubOAuth2User;
import com.laigeoffer.pmhub.system.service.IOAuth2Service;
import com.laigeoffer.pmhub.system.service.ISysMenuService;
import com.laigeoffer.pmhub.system.service.ISysUserService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Set;

import static com.laigeoffer.pmhub.common.core.domain.AjaxResult.success;

/**
 * 登录验证
 *
 * @author canghe
 */
@RestController
public class SysLoginController {

    @Autowired
    private ISysUserService userService;

    @Autowired
    private SysLoginService loginService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private IOAuth2Service ioAuth2Service;

    @Autowired
    private SysPermissionService permissionService;

    @Value("${pmhub.workWx.host}")
    String host;

    @Value("${pmhub.workWx.corpid}")
    String corpid;

    @Value("${pmhub.workWx.agentid}")
    String agentid;

    @Value("${pmhub.workWx.path}")
    String path;




    /**
     * 登录方法
     *
     * @param loginBody 登录信息
     * @return 结果
     */
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginBody loginBody) {
        AjaxResult ajax = success();
        // 生成令牌
        String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
                loginBody.getUuid());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }

    /**
     * 获取用户信息
     *
     * @return 用户信息
     */
    @GetMapping("getInfo")
    public AjaxResult getInfo() {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        AjaxResult ajax = success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        return ajax;
    }

    /**
     * 获取路由信息
     *
     * @return 路由信息
     */
    @GetMapping("getRouters")
    public AjaxResult getRouters() {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return success(menuService.buildMenus(menus));
    }

    /**
     * 企微单点登录跳转链接
     */
    @GetMapping("/sso/wx")
    public AjaxResult ssoForWorkWx(@RequestParam("code") String code,@RequestParam("url") String url,HttpServletResponse response){

        try {
            LogFactory.get().info(">>>>>>> code = "+code);
            JSONObject reJson = WorkWxUtil.getWxUserBaseInfo(code);
            LogFactory.get().info(">>>>>>> wxRe = "+reJson.toString());

            // 读取企微用户信息出错
            if(reJson.getInt(WorkWxUtil.ERR_CODE_KEY_NAME)!=0){
                return AjaxResult.error(reJson.getStr(WorkWxUtil.ERR_MSG_KEY_NAME));
            }

            // 微信用户名
            String wxUserName = reJson.getStr(WorkWxUtil.USR_ID_KEY);
            LogFactory.get().info(">>>>>>> wxUserName = "+wxUserName);
            SysUser user = userService.selectUserByWxName(wxUserName);

            // 用户未绑定平台账号
            if (ObjectUtil.isEmpty(user)){

                JSONObject rePublicJson = WorkWxUtil.getWxUserPublicInfo(wxUserName);
                // 用户真实姓名
                String wxUserNickName = rePublicJson.getStr(WorkWxUtil.USR_NICK_KEY);
                // 用户敏感信息授权
                String wxUserTicket = reJson.getStr(WorkWxUtil.USR_TICKET_KEY);
                // 获取敏感信息
                JSONObject reDetailJson = WorkWxUtil.getWxUserDetailInfo(wxUserTicket);
                // 用户手机
                String wxUserMobile = reDetailJson.getStr(WorkWxUtil.USR_MOBILE_KEY);
                // 用户头像地址
                String wxUserAvatar = reDetailJson.getStr(WorkWxUtil.USR_AVATAR_KEY);
                // 用户邮箱
                String wxUserEmail = reDetailJson.getStr(WorkWxUtil.USR_EMAIL_KEY);


                // 用户信息写入cookie
                SysUser sysUser = new SysUser();
                sysUser.setUserName(wxUserName);
                sysUser.setNickName(wxUserNickName);
                sysUser.setPhonenumber(wxUserMobile);
                sysUser.setEmail(wxUserEmail);
                Cookie infoCookie = new Cookie("user_info", URLEncoder.encode(JSONUtil.toJsonStr(sysUser),"utf-8"));

                // 用户头像地址写入cookie
                Cookie avatarUrlCookie = new Cookie(WorkWxUtil.USR_AVATAR_KEY,wxUserAvatar);
                // 单点登录临时token写入cookie
                Cookie tmpTokenCookie = new Cookie(WorkWxUtil.USR_TOKEN_KEY,reJson.getStr(WorkWxUtil.USR_TOKEN_KEY));
                infoCookie.setPath("/");
                avatarUrlCookie.setPath("/");
                tmpTokenCookie.setPath("/");
                response.addCookie(infoCookie);
                response.addCookie(avatarUrlCookie);
                response.addCookie(tmpTokenCookie);
                response.sendRedirect(WorkWxUtil.getServerPath()+"/binding/index.html");

                return success();
            }else {
                try {
                    ObjectUtil.isNotEmpty(SecurityUtils.getLoginUser().getUserId());
                }catch (Exception ex){
                    LogFactory.get().info(">>>>>>> user = "+ JSONUtil.toJsonStr(user));
                    Cookie cookie = new Cookie("Admin-Token"
                            ,loginService.loginSso(new LoginUser(user.getUserId()
                            , user.getDeptId()
                            , user
                            , permissionService.getMenuPermission(user))));
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
                response.sendRedirect(url);
                return success();
            }
        }catch (Exception ex){
            LogFactory.get().error(ex);
            return AjaxResult.error(ex.getMessage());
        }
    }

    /**
     * 泛微单点登录跳转链接
     */
    @GetMapping("/sso/oa")
    public AjaxResult ssoForOA(@RequestParam("ticket") String code, @RequestParam("url") String url, HttpServletResponse response) {

        try {
            LogFactory.get().info(">>>>>>> OA code = " + code);
            // 获取 token
            String oaAccessToken = OAUtils.getOaAccessToken(code, OAUtils.ssoCreateLogin(OAUtils.host + OAUtils.path2 + OAUtils.ssoPath,  OAUtils.host));

            // 泛微用户名
            String id = OAUtils.getOAUserInfo(oaAccessToken);
            LogFactory.get().info(">>>>>>> OAUserName = " + id);
            SysUser user = userService.selectUserByUserName(id);

            // 用户未绑定平台账号
            if (ObjectUtil.isEmpty(user)) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.set("loginid", id);
                JSONObject jsonObject2 = new JSONObject();
                jsonObject2.set("params", jsonObject);
                JSONObject data = OAUtils.restfulCall2(OAUtils.USER_API, jsonObject2.toString(), null);
                if ("1".equals(data.getStr(OAUtils.ERROR_CODE))) {
                    List<OAUserDTO> oaUsers = JSONUtil.toList(data.getJSONObject("data").getJSONArray("dataList"), OAUserDTO.class);
                    if (CollectionUtils.isNotEmpty(oaUsers)) {
                        // 用户信息写入cookie
                        SysUser sysUser = new SysUser();
                        sysUser.setUserName(oaUsers.get(0).getLoginid());
                        sysUser.setNickName(oaUsers.get(0).getLastname());
                        sysUser.setPhonenumber(oaUsers.get(0).getMobile());
                        sysUser.setEmail(oaUsers.get(0).getEmail());
                        sysUser.setPassword(SecurityUtils.encryptPassword("123456"));
                        Cookie infoCookie = new Cookie("oa_user_info", URLEncoder.encode(JSONUtil.toJsonStr(sysUser),"utf-8"));
                        infoCookie.setPath("/");
                        response.addCookie(infoCookie);
                        response.sendRedirect(WorkWxUtil.getServerPath() + "/oaBinding/index.html");
                        return success();
                    }
                    return AjaxResult.error("调用泛微查询人员信息接口未查询到人员");
                } else {
                    throw new ServiceException("调用泛微查询人员信息接口异常");
                }

            } else {
                try {
                    ObjectUtil.isNotEmpty(SecurityUtils.getLoginUser().getUserId());
                } catch (Exception ex) {
                    LogFactory.get().info(">>>>>>> user = "+ JSONUtil.toJsonStr(user));
                    Cookie cookie = new Cookie("Admin-Token"
                            ,loginService.loginSso(new LoginUser(user.getUserId()
                            , user.getDeptId()
                            , user
                            , permissionService.getMenuPermission(user))));
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
                response.sendRedirect(url);
                return success();
            }
        } catch (Exception ex) {
            LogFactory.get().error(ex);
            return AjaxResult.error(ex.getMessage());
        }
    }
    /**
     * 企微新增用户
     * */
    @GetMapping("/sso/wx/create")
    public AjaxResult ssoForWorkWxCreate(@CookieValue(name = "user_info") String userInfo
            ,@CookieValue(name = WorkWxUtil.USR_AVATAR_KEY) String avatarUrl
            ,@CookieValue(name = "tmp_token") String tmpToken
            ,HttpServletResponse response){


        try {
            // cookie解码
            SysUser sysUser = JSONUtil.toBean(URLDecoder.decode(userInfo,"utf-8"),SysUser.class);
            sysUser.setPassword(IdUtil.simpleUUID());
            sysUser.setUserWxName(sysUser.getUserName());
            sysUser.setRemark("企业微信快捷新增用户");
            // 判断用户是否是企微过来的请求
            if (!WorkWxUtil.checkToken(sysUser.getUserName(),tmpToken)){
                return AjaxResult.error("请从企业微信打开此链接！");
            }
            sysUser.setCreateBy("企业微信");

            // 下载头像
            String avatarName = IdUtil.simpleUUID()+".png";
            File avatarFile =  FileUtil.file(ZipDownloadUtil.FILE_PATH +avatarName);
            HttpUtil.downloadFile(avatarUrl, avatarFile);

            int re = userService.insertUser(sysUser);
            if (re>0){
                // 上传用户头像
                String avatar = FileUploadUtils.upload(PmhubConfig.getAvatarPath(), FileUploadUtils.getMultipartFile(avatarFile), MimeTypeUtils.IMAGE_EXTENSION);
                userService.updateUserAvatar(sysUser.getUserName(), avatar);
                sysUser.setAvatar(avatar);

                // 用户新增成功，自动登录
                Cookie cookie = new Cookie("Admin-Token"
                        ,loginService.loginSso(new LoginUser(sysUser.getUserId()
                        , sysUser.getDeptId()
                        , sysUser
                        , permissionService.getMenuPermission(sysUser))));
                cookie.setPath("/");
                response.addCookie(cookie);
                // 自动跳转
                response.sendRedirect("/");
                return success();
            }else {
                return AjaxResult.error("新增失败，请关闭此页面，联系管理员协助创建用户！");
            }

        } catch (UnsupportedEncodingException e) {
            LogFactory.get().error(e);
            return AjaxResult.error(e.getMessage());
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (InvalidExtensionException e) {
            throw new RuntimeException(e);
        }

    }


    /**
     * 企微绑定老用户
     * */
    @PostMapping("/sso/wx/binding")
    public AjaxResult ssoForWorkWxCreate(@RequestBody LoginBody loginBody,@CookieValue(name = "user_info") String userInfo,HttpServletResponse response){
        // cookie解码
        try {
            SysUser tmpUser = JSONUtil.toBean(URLDecoder.decode(userInfo,"utf-8"),SysUser.class);

            String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
                    loginBody.getUuid());


            SysUser bindingUser = userService.selectUserByUserName(loginBody.getUsername());
            bindingUser.setUserWxName(tmpUser.getUserName());
            userService.updateUser(bindingUser);

            // 用户新增成功，自动登录
            Cookie cookie = new Cookie("Admin-Token",token);
            cookie.setPath("/");
            response.addCookie(cookie);
            return success();

        } catch (UnsupportedEncodingException e) {
            LogFactory.get().error(e);
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 泛微新增用户
     * */
    @GetMapping("/sso/oa/create")
    public AjaxResult ssoForOACreate(@CookieValue(name = "oa_user_info") String userInfo, HttpServletResponse response) {

        try {
            // cookie 解码
            SysUser sysUser = JSONUtil.toBean(URLDecoder.decode(userInfo, "utf-8"), SysUser.class);
            sysUser.setRemark("泛微快捷新增用户");
            sysUser.setCreateBy("泛微");
            sysUser.setCreateTime(new Date());

            int re = userService.insertUser(sysUser);
            if (re > 0) {
                // 用户新增成功，自动登录
                Cookie cookie = new Cookie("Admin-Token"
                        ,loginService.loginSso(new LoginUser(sysUser.getUserId()
                        , sysUser.getDeptId()
                        , sysUser
                        , permissionService.getMenuPermission(sysUser))));
                cookie.setPath("/");
                response.addCookie(cookie);
                // 自动跳转
                response.sendRedirect("/");
                return success();
            }else {
                return AjaxResult.error("新增失败，请关闭此页面，联系管理员协助创建用户！");
            }

        } catch (UnsupportedEncodingException e) {
            LogFactory.get().error(e);
            return AjaxResult.error(e.getMessage());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }


    /**
     * 企微扫码登录
     * */
    @GetMapping("/sso/wx/loginWithWx")
    public AjaxResult loginWithWx(HttpServletResponse response) throws IOException {
        String url = "https://login.work.weixin.qq.com/wwlogin/sso/login/?appid="
                        +corpid
                        +"&state=STATE&agentid="
                        +agentid
                        +"&redirect_uri="
                        + URLEncoder.encode(host+path+"/sso/wx?url="+URLEncoder.encode(host,CharsetUtil.UTF_8),CharsetUtil.UTF_8);
        try {
            response.sendRedirect(url);
            return success();
        }catch (Exception ex){
            ex.printStackTrace();
            return AjaxResult.error(ex.getMessage());
        }
    }

    /**
     * OAuth2 标准协议:授权端点
     *
     * 用途：此端点用于处理资源所有者（即用户）的认证，并获得其对客户端应用程序的授权。当客户端需要用户的授权时，它会将用户重定向到这个端点。
     * 操作：用户在此端点登录并授予客户端所请求的权限（如访问用户的邮箱、资料等）。通常，这个过程会展示一个授权页面，让用户选择是否授权。
     * 响应：如果用户授权，授权服务器通常会将用户重定向回客户端应用程序，并附上一个授权码（在授权码流程中）或令牌（在隐式流程中）。
     *
     * @param pmhubOAuth2 OAurth2 参数
     * */
    @GetMapping("/sso/oauth2/authorize")
    public AjaxResult oauth2Authorize(HttpServletRequest request, PmhubOAuth2 pmhubOAuth2) throws IOException {
        // 判断用户是否已经授权本应用获取用户信息进行单点登录
        if (ioAuth2Service.isAgree(SecurityUtils.getUserId(), pmhubOAuth2.getClient_id())) {
            // 用户已授权，重定向到授权页面并附带code
            String redirectUrl = pmhubOAuth2.getAuthorizeRedirectUrl(ioAuth2Service.createCode(SecurityUtils.getUserId()));
            return success(redirectUrl);
        } else {
            // 用户未授权，构建授权URL
            String requestUrl = request.getRequestURL().toString();
            // 检查url是否带参数，有就附带到授权页面去
            String[] urlParts = requestUrl.split(PmhubOAuth2.SPLIT_STR);
            String url = urlParts.length > 1 ? PmhubOAuth2.AUTHORIZE_URL + urlParts[1] : PmhubOAuth2.AUTHORIZE_URL;
            return success(url);
        }
    }


    /**
     * 允许授权进行单点登录
     *
     * @param pmhubOAuth2Agree 包含clientid 对此id的应用进行授权
     * @return {@link AjaxResult}
     */
    @PostMapping("/sso/oauth2/agree")
    public AjaxResult oauth2Agree(@RequestBody PmhubOAuth2Agree pmhubOAuth2Agree) {
        ioAuth2Service.agree(SecurityUtils.getUserId(), pmhubOAuth2Agree.getClientId());
        return success();
    }


    /**
     * OAuth2 标准协议:令牌端点
     *
     * 用途：此端点用于交换授权码（authorization code）以获取访问令牌（access token）。它也用于刷新访问令牌。
     * 操作：在授权码流程中，客户端应用程序使用用户从授权端点获取的授权码，向令牌端点发起请求以交换访问令牌。请求通常需要包含客户端的认证信息。
     * 响应：令牌端点返回一个包含访问令牌和其他相关信息（如令牌类型、过期时间、刷新令牌等）的JSON响应。
     *
     * @param pmhubOAuth2 OAurth2 参数
     * */
    @PostMapping("/sso/oauth2/accessToken")
    public JSONObject oauth2accessToken(PmhubOAuth2 pmhubOAuth2) throws IOException {
        // 鉴定client_id 和 client_secret 通过后返货token
        if (ioAuth2Service.checkClientSecret(pmhubOAuth2.getClient_id(), pmhubOAuth2.getClient_secret())){
            PmhubOAuth2Token pmhubOAuth2Token = new PmhubOAuth2Token();
            String token = ioAuth2Service.createToken(pmhubOAuth2.getCode());
            if (ObjectUtil.isNotEmpty(token)){
                pmhubOAuth2Token.setAccess_token(token);
                return JSONUtil.parseObj(pmhubOAuth2Token);
            }else {
                return new JSONObject("error","Code is invalid or expired");
            }
        }else {
            return new JSONObject("error","Secret is invalid or expired");
        }

    }

    /**
     * OAuth2 标准协议:资源服务器端点
     *
     * 返回用户的个人资料信息，如姓名、电子邮件地址、头像 URL、位置等。
     * 这些信息的具体内容取决于用户授权给客户端应用程序的权限（即 OAuth 2.0 的 scope）
     * */
    @GetMapping("/sso/oauth2/user")
    public JSONObject oauth2user(HttpServletRequest request) throws IOException {
        String token = request.getHeader("Authorization");
        token = token.replace("Bearer ","");
        //TOKEN 鉴权与用户信息返回
        PmhubOAuth2User user = ioAuth2Service.getUser(token);
        if (ObjectUtil.isNotEmpty(user)){
            return JSONUtil.parseObj(user);
        }else {
            return new JSONObject("error","token is invalid or expired");
        }

    }


    /**
     * 获取被授权站点的图标
     * */
    @GetMapping("/sso/oauth2/client")
    public AjaxResult oauth2clientPicture(HttpServletRequest request) {
        return success(ioAuth2Service.getClientInfo(request.getParameter("client_id")));
    }
}
