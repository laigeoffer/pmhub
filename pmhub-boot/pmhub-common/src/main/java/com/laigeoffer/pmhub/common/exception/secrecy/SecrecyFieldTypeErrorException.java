package com.laigeoffer.pmhub.common.exception.secrecy;

import java.lang.reflect.Field;

/**
 * 保密字段类型异常
 *
 * @author canghe
 * @date 2023/07/19
 */
public class SecrecyFieldTypeErrorException extends RuntimeException {

    /**
     * 保密类的类型
     */
    private final Class<?> objClass;

    /**
     * 异常的字段
     */
    private final Field field;

    /**
     * 错误消息
     */
    private final String message;

    public SecrecyFieldTypeErrorException(Class<?> objClass, Field field) {
        this.objClass = objClass;
        this.field = field;
        this.message = "类型无法置空";
    }

    public SecrecyFieldTypeErrorException(Class<?> objClass, Field field, String message) {
        this.objClass = objClass;
        this.field = field;
        this.message = message;
    }

    @Override
    public String getMessage() {
        return String.format("类 %s 的敏感字段 %s 必须是一个可以设置为NULL的类型，当前类型为：%s [%s]",objClass,field.getName(),field.getType(),message);
    }

}
