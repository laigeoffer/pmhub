package com.laigeoffer.pmhub.project.controller;

import com.laigeoffer.pmhub.base.core.annotation.Anonymous;
import com.laigeoffer.pmhub.base.core.config.PmhubConfig;
import com.laigeoffer.pmhub.base.core.core.domain.AjaxResult;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.base.core.utils.uuid.Seq;
import com.laigeoffer.pmhub.base.security.annotation.RequiresPermissions;
import com.laigeoffer.pmhub.base.core.utils.file.FileUtils;
import com.laigeoffer.pmhub.project.domain.ProjectFile;
import com.laigeoffer.pmhub.project.domain.vo.project.file.ProjectFileIdsVO;
import com.laigeoffer.pmhub.project.domain.vo.project.file.ProjectFileReqVO;
import com.laigeoffer.pmhub.project.service.ProjectFileService;
import com.laigeoffer.pmhub.project.service.file.UploadFileFactory;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static com.laigeoffer.pmhub.base.core.core.domain.AjaxResult.error;
import static com.laigeoffer.pmhub.base.security.utils.SecurityUtils.getLoginUser;


/**
 * @author canghe
 * @date 2022-12-15 17:36
 */
@Slf4j
@RestController
@RequestMapping("/project/file")
public class ProjectFileController {

    @Autowired
    private ProjectFileService projectFileService;

    @Autowired
    private UploadFileFactory uploadFileFactory;

    /**
     * 文件列表
     *
     * @param projectReqVO
     * @return
     */
    @PostMapping("/list")
    @RequiresPermissions("project:file:queryFileList')")
    public AjaxResult queryFileList(@RequestBody ProjectFileReqVO projectReqVO) {
        return AjaxResult.success(projectFileService.queryFileList(projectReqVO));
    }

    /**
     * 文件上传
     *
     * @param file
     * @param id
     * @param type
     * @return
     * @throws Exception
     */
    @PostMapping("/upload")
    public AjaxResult upload(@RequestParam("file") MultipartFile file, @RequestParam("id") String id, @RequestParam("type") String type) throws Exception {
        if (!file.isEmpty()) {
            return AjaxResult.success(uploadFileFactory.execute(type, getLoginUser(), file, id));
        }
        return error("上传文件异常，请联系管理员");
    }

    @PostMapping("/rename")
    @RequiresPermissions("project:file:rename")
    public AjaxResult rename(@RequestBody ProjectFileReqVO projectFileReqVO) {
        projectFileService.rename(projectFileReqVO);
        return AjaxResult.success();
    }

    /**
     * 批量删除文件
     *
     * @param projectFileIdsVO
     * @return
     */
    @PostMapping("/delete")
    @RequiresPermissions("project:file:delete")
    public AjaxResult deleteFileList(@RequestBody ProjectFileIdsVO projectFileIdsVO) {
        projectFileService.deleteFileList(projectFileIdsVO);
        return AjaxResult.success();
    }

    /**
     * 下载文件
     *
     * @param fileUrl
     * @param projectFileId
     * @param response
     */
    @PostMapping("/download")
    @Anonymous
    public void downloadFile(@RequestParam("fileUrl") String fileUrl, @RequestParam("projectFileId") String projectFileId, HttpServletResponse response) {
        try {
            if (!FileUtils.checkAllowDownload(fileUrl)) {
                throw new Exception(StringUtils.format("文件名称({})非法，不允许下载", fileUrl));
            }
            String realFileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);
            ProjectFile projectFile = projectFileService.getById(projectFileId);

            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            FileUtils.setAttachmentResponseHeader(response, realFileName);
            FileUtils.writeBytes(projectFile.getPathName(), response);
        } catch (Exception e) {
            log.error("下载文件失败", e);
        }
    }

    /**
     * 批量下载文件
     *
     * @param projectFileIds
     * @return
     */
    @PostMapping("/batchDownload")
    @Anonymous
    public AjaxResult downloadFileList(@RequestParam("projectFileIds") String projectFileIds, HttpServletResponse response) {

        // Linux版创建临时zip,总存放压缩文件  AcasConfig.getProfile()= D:/data/uploadPath/tmp.zip
        String totalZip = PmhubConfig.getProfile() + "/tmp.zip";
        if (CollectionUtils.isEmpty(Arrays.asList(projectFileIds.split(",")))) {
            return error("未选择需要批量下载的文件");
        }
        List<ProjectFile> projectFiles = projectFileService.listByIds(Arrays.asList(projectFileIds.split(",")));
        List<String> pathNames = projectFiles.stream().map(ProjectFile::getPathName).collect(Collectors.toList());
        try {
            // 调用 Service 层方法
            projectFileService.batchDownload(totalZip, pathNames);

            // 设置Content-Disposition响应头，控制浏览器弹出保存框，若没有此句浏览器会直接打开并显示文件
            // 中文名要进行URLEncoder.encode编码，否则客户端能下载但名字会乱码
            String orderDocuments = Seq.getId() + ".zip";
            String filenames = URLEncoder.encode(orderDocuments, "UTF-8");
            response.setHeader("Content-disposition", "attachment;filename=" + filenames + ";" + "filename*=utf-8''" + filenames);
            //该流不可以手动关闭,手动关闭下载会出问题,下载完成后会自动关闭
            ServletOutputStream outputStream = response.getOutputStream();
            FileInputStream inputStream = new FileInputStream(totalZip);
            // 如果是SpringBoot框架,在这个路径 需要org.apache.tomcat.util.http.fileupload.IOUtils产品否则，需要自主引入apache的 commons-io依赖
            // copy方法为文件复制,在这里直接实现了下载效果
            IOUtils.copy(inputStream, outputStream);
            inputStream.close();
        } catch (Exception e) {
            return error("下载异常");
        }

        return AjaxResult.success("下载完成");
    }

}
