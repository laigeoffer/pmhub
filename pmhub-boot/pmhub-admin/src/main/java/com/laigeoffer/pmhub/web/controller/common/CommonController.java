package com.laigeoffer.pmhub.web.controller.common;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.laigeoffer.pmhub.common.config.PmhubConfig;
import com.laigeoffer.pmhub.common.constant.Constants;
import com.laigeoffer.pmhub.common.core.domain.AjaxResult;
import com.laigeoffer.pmhub.common.utils.SecrecyUtils;
import com.laigeoffer.pmhub.common.utils.StringUtils;
import com.laigeoffer.pmhub.common.utils.UserMessageUtils;
import com.laigeoffer.pmhub.common.utils.file.FileUploadUtils;
import com.laigeoffer.pmhub.common.utils.file.FileUtils;
import com.laigeoffer.pmhub.framework.config.ServerConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import static com.laigeoffer.pmhub.common.utils.SecrecyUtils.*;

/**
 * 通用请求处理
 *
 * @author canghe
 */
@RestController
@RequestMapping("/common")
public class CommonController {
    private static final Logger log = LoggerFactory.getLogger(CommonController.class);
    private static final String FILE_DELIMETER = ",";
    @Autowired
    private ServerConfig serverConfig;

    /**
     * 私钥
     */
    @Value("${pmhub.secrecy.privateKey}")
    String privateKey;

    /**
     * 公钥
     */
    @Value("${pmhub.secrecy.publicKey}")
    String publicKey;

    /**
     * 通用下载请求
     *
     * @param fileName 文件名称
     * @param delete   是否删除
     */
    @GetMapping("/download")
    public void fileDownload(String fileName, Boolean delete, HttpServletResponse response, HttpServletRequest request) {
        try {
            if (!FileUtils.checkAllowDownload(fileName)) {
                throw new Exception(StringUtils.format("文件名称({})非法，不允许下载。 ", fileName));
            }
            String realFileName = System.currentTimeMillis() + fileName.substring(fileName.indexOf("_") + 1);
            String filePath = PmhubConfig.getDownloadPath() + fileName;

            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, realFileName);
            FileUtils.writeBytes(filePath, response);
            if (delete) {
                FileUtils.deleteFile(filePath);
            }
        } catch (Exception e) {
            log.error("下载文件失败", e);
        }
    }

    /**
     * 通用上传请求（单个）
     */
    @PostMapping("/upload")
    public AjaxResult uploadFile(MultipartFile file) throws Exception {
        try {
            // 上传文件路径
            String filePath = PmhubConfig.getUploadPath();
            // 上传并返回新文件名称
            String fileName = FileUploadUtils.upload(filePath, file);
            String url = serverConfig.getUrl() + fileName;
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", fileName);
            ajax.put("newFileName", FileUtils.getName(fileName));
            ajax.put("originalFilename", file.getOriginalFilename());
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 通用上传请求（多个）
     */
    @PostMapping("/uploads")
    public AjaxResult uploadFiles(List<MultipartFile> files) throws Exception {
        try {
            // 上传文件路径
            String filePath = PmhubConfig.getUploadPath();
            List<String> urls = new ArrayList<String>();
            List<String> fileNames = new ArrayList<String>();
            List<String> newFileNames = new ArrayList<String>();
            List<String> originalFilenames = new ArrayList<String>();
            for (MultipartFile file : files) {
                // 上传并返回新文件名称
                String fileName = FileUploadUtils.upload(filePath, file);
                String url = serverConfig.getUrl() + fileName;
                urls.add(url);
                fileNames.add(fileName);
                newFileNames.add(FileUtils.getName(fileName));
                originalFilenames.add(file.getOriginalFilename());
            }
            AjaxResult ajax = AjaxResult.success();
            ajax.put("urls", StringUtils.join(urls, FILE_DELIMETER));
            ajax.put("fileNames", StringUtils.join(fileNames, FILE_DELIMETER));
            ajax.put("newFileNames", StringUtils.join(newFileNames, FILE_DELIMETER));
            ajax.put("originalFilenames", StringUtils.join(originalFilenames, FILE_DELIMETER));
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 本地资源通用下载
     */
    @GetMapping("/download/resource")
    public void resourceDownload(String resource, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            if (!FileUtils.checkAllowDownload(resource)) {
                throw new Exception(StringUtils.format("资源文件({})非法，不允许下载。 ", resource));
            }
            // 本地资源路径
            String localPath = PmhubConfig.getProfile();
            // 数据库资源地址
            String downloadPath = localPath + StringUtils.substringAfter(resource, Constants.RESOURCE_PREFIX);
            // 下载名称
            String downloadName = StringUtils.substringAfterLast(downloadPath, "/");
            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, downloadName);
            //Files.copy(FileSystems.getDefault().getPath(downloadPath),response.getOutputStream());
            FileUtils.writeBytes(downloadPath, response);
        } catch (Exception e) {
            log.error("下载文件失败", e);
        }
    }




    /**
     * 解密
     *
     * @param encryptStrObj 加密str obj
     * @return {@link AjaxResult}
     */
    @PostMapping("/decrypt")
    public AjaxResult decrypt(@RequestBody JSONObject encryptStrObj){
        String encryptStr = encryptStrObj.getStr(PARAM_VALUE_KEY);
        if (ObjectUtil.isNotEmpty(encryptStr)){
            if (UserMessageUtils.isClassifiedInquirer()){
                String decryptStr = new String(SecrecyUtils.decrypt(encryptStr));
                if(JSONUtil.isTypeJSON(decryptStr)){
                    return AjaxResult.success("查询成功",reduction(JSONUtil.parseObj(decryptStr)));
                }else {
                    return AjaxResult.success("查询成功",decryptStr);
                }
            }else {
                return AjaxResult.success("查询成功","****");
            }
        }
        return AjaxResult.error("加密字符未找到！");
    }


    /**
     * 密文求和
     *
     * @param encryptStrs 需要求和的密文
     * @return {@link AjaxResult}
     */
    @PostMapping("/ciphertextSum")
    public AjaxResult ciphertextSum(@RequestBody List<String> encryptStrs){
        if (ObjectUtil.isNotEmpty(encryptStrs)){
            BigDecimal sum = new BigDecimal(0);
            for (String encryptStr:encryptStrs){
                sum = sum.add(new BigDecimal(reduction(JSONUtil.parseObj(new String(SecrecyUtils.decrypt(encryptStr)))).toString()));
            }
            JSONObject re = new JSONObject();
            // 判断是否可以看到加密信息
            if (UserMessageUtils.isClassifiedInquirer()){
                re.set(DISPLAY_VALUE,sum.stripTrailingZeros().toPlainString());
            }else {
                re.set(DISPLAY_VALUE,"****");
            }
            // 返回求和的密文
            re.set(VALUE_KEY, SecrecyUtils.calcEncode(sum.stripTrailingZeros().toPlainString()));
            return AjaxResult.success(re);
        }
        return AjaxResult.error("求和数据不能为空！");
    }
}
