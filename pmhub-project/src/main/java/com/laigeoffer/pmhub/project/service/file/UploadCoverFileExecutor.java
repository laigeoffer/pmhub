package com.laigeoffer.pmhub.project.service.file;

import com.laigeoffer.pmhub.common.config.PmhubConfig;
import com.laigeoffer.pmhub.common.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.common.exception.ServiceException;
import com.laigeoffer.pmhub.common.utils.file.FileUploadUtils;
import com.laigeoffer.pmhub.common.utils.file.MimeTypeUtils;
import com.laigeoffer.pmhub.project.domain.vo.project.file.FileVO;
import com.laigeoffer.pmhub.project.mapper.ProjectMapper;
import com.laigeoffer.pmhub.project.domain.Project;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author canghe
 * @date 2023-01-09 09:37
 */
@Service("uploadCoverFileExecutor")
@Slf4j
public class UploadCoverFileExecutor extends UploadAbstractExecutor {
    @Autowired
    private ProjectMapper projectMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public FileVO upload(LoginUser user, MultipartFile file, String id) throws Exception {
        log.info("封面上传的项目id:{}", id);
        String coverPath = FileUploadUtils.uploadProjectFile(PmhubConfig.getProjectCoverPath(), file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);
        if (StringUtils.isBlank(coverPath)) {
            throw new ServiceException("上传文件异常，请联系管理员");
        }
        Project project = projectMapper.selectById(id);
        project.setCover(coverPath);
        projectMapper.updateById(project);
        FileVO fileVO = new FileVO();
        fileVO.setFileUrl(coverPath);
        fileVO.setFileName(file.getOriginalFilename());
        return fileVO;
    }
}
