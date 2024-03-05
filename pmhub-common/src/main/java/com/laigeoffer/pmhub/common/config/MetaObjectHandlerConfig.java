package com.laigeoffer.pmhub.common.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.laigeoffer.pmhub.common.utils.SecurityUtils;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

/**
 * @author canghe
 * @description MetaObjectHandlerConfig
 * @create 2023-11-29-15:12
 */
@Component
public class MetaObjectHandlerConfig implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {


        Object createTime = getFieldValByName("createdTime", metaObject);
        Object updateTime = getFieldValByName("updatedTime", metaObject);
        Object deleted = getFieldValByName("deleted", metaObject);
        Object createdBy = getFieldValByName("createdBy", metaObject);
        Object updatedBy = getFieldValByName("updatedBy", metaObject);

        if (createTime == null) {
            this.strictInsertFill(metaObject, "createTime", LocalDateTime.class, LocalDateTime.now());
        }
        if (updateTime == null) {
            this.strictInsertFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now());
        }
        if (deleted == null) {
            this.strictInsertFill(metaObject, "deleted", Integer.class, 0);
        }
        if (createdBy == null) {
            this.strictInsertFill(metaObject, "createBy", String.class, SecurityUtils.getUsername());
        }
        if (updatedBy == null) {
            this.strictInsertFill(metaObject, "updateBy", String.class, SecurityUtils.getUsername());
        }


    }

    @Override
    public void updateFill(MetaObject metaObject) {
        Object updateTime = getFieldValByName("updatedTime", metaObject);
        Object updatedBy = getFieldValByName("updatedBy", metaObject);

        if (updateTime == null) {
            this.strictInsertFill(metaObject, "updateTime", LocalDateTime.class, LocalDateTime.now());
        }
        if (updatedBy == null) {
            this.strictInsertFill(metaObject, "updateBy", String.class, SecurityUtils.getUsername());
        }
    }
}
