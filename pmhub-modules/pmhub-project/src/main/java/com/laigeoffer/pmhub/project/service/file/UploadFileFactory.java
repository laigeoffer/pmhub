package com.laigeoffer.pmhub.project.service.file;

import com.laigeoffer.pmhub.base.core.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.project.domain.vo.project.file.FileVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author canghe
 * @date 2023-01-09 09:25
 */
@Service
public class UploadFileFactory {

    private static final Map<String, String> beanNames = new ConcurrentHashMap<>();
    static {
        UploadTypeEnum[] uploadTypeEnums = UploadTypeEnum.values();
        for (UploadTypeEnum uploadTypeEnum : uploadTypeEnums) {
            beanNames.put(uploadTypeEnum.getType(), uploadTypeEnum.getBeanName());
        }
    }

    // 通过 Map 注入，通过 spring bean 的名称作为 key 动态获取对应实例
    @Autowired
    private Map<String, UploadAbstractExecutor> executorMap;
    // 工厂层执行器
    public FileVO execute(String type, LoginUser user, MultipartFile file, String id) throws Exception {
        String beanName = beanNames.get(type);
        if (StringUtils.isEmpty(beanName)) {
            return null;
        }
        // 决定最终走哪个类的执行器
        UploadAbstractExecutor executor = executorMap.get(beanName);
        if (executor == null) {
            return null;
        }
        return executor.upload(user, file, id);
    }
}
