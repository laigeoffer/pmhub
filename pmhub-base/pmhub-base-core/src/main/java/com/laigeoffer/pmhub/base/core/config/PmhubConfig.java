package com.laigeoffer.pmhub.base.core.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 读取项目相关配置
 *
 * @author canghe
 */
@Component
@ConfigurationProperties(prefix = "pmhub")
public class PmhubConfig {
    /**
     * 上传路径
     */
    private static String profile;
    /**
     * 获取地址开关
     */
    private static boolean addressEnabled;
    /**
     * 验证码类型
     */
    private static String captchaType;
    /**
     * 项目名称
     */
    private String name;
    /**
     * 版本
     */
    private String version;
    /**
     * 版权年份
     */
    private String copyrightYear;
    /**
     * 实例演示开关
     */
    private boolean demoEnabled;

    public static String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        PmhubConfig.profile = profile;
    }

    public static boolean isAddressEnabled() {
        return addressEnabled;
    }

    public void setAddressEnabled(boolean addressEnabled) {
        PmhubConfig.addressEnabled = addressEnabled;
    }

    public static String getCaptchaType() {
        return captchaType;
    }

    public void setCaptchaType(String captchaType) {
        PmhubConfig.captchaType = captchaType;
    }

    /**
     * 获取导入上传路径
     */
    public static String getImportPath() {
        return getProfile() + "/import";
    }

    /**
     * 获取头像上传路径
     */
    public static String getAvatarPath() {
        return getProfile() + "/avatar";
    }
    /**
     * 获取项目文件上传路径
     */
    public static String getProjectPath() {
        return getProfile() + "/project";
    }
    /**
     * 获取项目封面上传路径
     */
    public static String getProjectCoverPath() {
        return getProfile() + "/cover";
    }
    /**
     * 获取项目封面上传路径
     */
    public static String getTemplatePath() {
        return getProfile() + "/template";
    }
    /**
     * 获取任务文件上传路径
     */
    public static String getTaskPath() {
        return getProfile() + "/task";
    }

    /**
     * 获取下载路径
     */
    public static String getDownloadPath() {
        return getProfile() + "/download/";
    }

    /**
     * 获取上传路径
     */
    public static String getUploadPath() {
        return getProfile() + "/upload";
    }

    /**
     * 获取上传路径
     */
    public static String getExportMaterialsPath() {
        return getProfile() + "/export/materials";
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getCopyrightYear() {
        return copyrightYear;
    }

    public void setCopyrightYear(String copyrightYear) {
        this.copyrightYear = copyrightYear;
    }

    public boolean isDemoEnabled() {
        return demoEnabled;
    }

    public void setDemoEnabled(boolean demoEnabled) {
        this.demoEnabled = demoEnabled;
    }
}
