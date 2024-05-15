package com.laigeoffer.pmhub.project.service.file;

import com.laigeoffer.pmhub.base.core.config.PmhubConfig;
import com.laigeoffer.pmhub.base.core.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.base.core.enums.LogTypeEnum;
import com.laigeoffer.pmhub.base.core.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.base.core.utils.file.FileUploadUtils;
import com.laigeoffer.pmhub.base.core.utils.file.MimeTypeUtils;
import com.laigeoffer.pmhub.base.security.utils.SecurityUtils;
import com.laigeoffer.pmhub.project.domain.ProjectFile;
import com.laigeoffer.pmhub.project.domain.vo.project.file.FileVO;
import com.laigeoffer.pmhub.project.domain.vo.project.log.LogVO;
import com.laigeoffer.pmhub.project.mapper.ProjectFileMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectTaskMapper;
import com.laigeoffer.pmhub.project.service.ProjectLogService;
import com.laigeoffer.pmhub.project.utils.ProjectFileUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;

/**
 * @author canghe
 * @date 2023-01-09 09:37
 */
@Service("uploadTaskFileExecutor")
@Slf4j
public class UploadTaskFileExecutor extends UploadAbstractExecutor {

    @Autowired
    private ProjectTaskMapper projectTaskMapper;
    @Autowired
    private ProjectFileMapper projectFileMapper;
    @Autowired
    private ProjectLogService projectLogService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public FileVO upload(LoginUser user, MultipartFile file, String id) throws Exception {
        log.info("任务文件上传的任务id:{}", id);
        String taskPath = ProjectFileUtil.uploadTaskFile(PmhubConfig.getTaskPath(), file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);
        String pn = ProjectFileUtil.getPathName(PmhubConfig.getTaskPath(), file);
        String projectId = projectTaskMapper.selectById(id).getProjectId();
        ProjectFile projectFile = new ProjectFile();
        projectFile.setFileSize(new BigDecimal(String.valueOf(file.getSize())).divide(new BigDecimal("1024"), 2, RoundingMode.HALF_UP));
        projectFile.setFileName(file.getOriginalFilename());
        projectFile.setFileUrl(taskPath);
        projectFile.setUserId(user.getUserId());
        projectFile.setCreatedBy(user.getUsername());
        projectFile.setCreatedTime(new Date());
        projectFile.setUpdatedBy(user.getUsername());
        projectFile.setUpdatedTime(new Date());
        projectFile.setType(ProjectStatusEnum.TASK.getStatusName());
        projectFile.setPtId(id);
        projectFile.setExtension(FileUploadUtils.getExtension(file));
        projectFile.setProjectId(projectId);
        projectFile.setPathName(pn);
        projectFileMapper.insert(projectFile);
        // 添加日志
        LogVO logVO = new LogVO();
        logVO.setLogType(LogTypeEnum.DELIVERABLE.getStatus());
        logVO.setOperateType("uploadTaskFile");
        logVO.setType(ProjectStatusEnum.TASK.getStatusName());
        logVO.setPtId(id);
        logVO.setUserId(SecurityUtils.getUserId());
        logVO.setProjectId(projectId);
        logVO.setContent(taskPath);
        logVO.setCreatedBy(SecurityUtils.getUsername());
        logVO.setCreatedTime(new Date());
        logVO.setUpdatedBy(SecurityUtils.getUsername());
        logVO.setUpdatedTime(new Date());
        projectLogService.run(logVO);
        FileVO fileVO = new FileVO();
        fileVO.setProjectFileId(projectFile.getId());
        fileVO.setFileName(file.getOriginalFilename());
        fileVO.setFileUrl(taskPath);
        return fileVO;
    }
}
