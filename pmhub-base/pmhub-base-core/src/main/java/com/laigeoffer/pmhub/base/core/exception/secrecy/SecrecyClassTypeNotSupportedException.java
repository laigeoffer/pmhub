package com.laigeoffer.pmhub.base.core.exception.secrecy;

/**
 * 不支持的的保密类
 *
 * @author canghe
 * @date 2023/07/19
 */
public class SecrecyClassTypeNotSupportedException extends RuntimeException {

    /**
     * 保密类的类型
     */
    private final Class<?> objClass;

    /**
     * 处理类的类型
     */
    private final Class<?> calcClass;

    /**
     * 错误消息
     */
    private final String message = "无法处理类 %s,请提前在 %s 中定义处理方法";

    public SecrecyClassTypeNotSupportedException(Class<?> objClass, Class<?> calcClass) {
        this.objClass = objClass;
        this.calcClass = calcClass;
    }

    @Override
    public String getMessage() {
        return String.format(message,objClass,calcClass);
    }

}
