package com.laigeoffer.projectaihub.project.service.file;

import com.laigeoffer.projectaihub.common.core.domain.model.LoginUser;
import com.laigeoffer.projectaihub.project.domain.vo.project.file.FileVO;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author canghe
 * @date 2023-01-03 17:22
 */
public abstract class UploadAbstractExecutor {
    public abstract FileVO upload(LoginUser user, MultipartFile file, String id) throws Exception;
}
