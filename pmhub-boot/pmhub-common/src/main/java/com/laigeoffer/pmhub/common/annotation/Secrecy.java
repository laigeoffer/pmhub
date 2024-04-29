package com.laigeoffer.pmhub.common.annotation;


import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


/**
 * 字段保密
 * 对需要加密的对象中的字段，为其加上此注解即可实现按权限自动加解密，当对象作为 @SecrecyFunc 注解修饰的方法的返回值时
 * 被修饰的字段会根据用户是否有权限自动选择显示原文还是置空（只能修饰能被置空的字段，如果字段不能置空，如int bool等，则会抛出异常）
 * 当对象中定义了有 @SecrecyMap 修饰的Map<String,String> 字段时，会自动将被 @Secrecy 修饰的字段值的密文放入到此map中
 * 可调用系统解密接口传入此密文进行解密
 *
 * @author canghe
 * @date 2023/07/17
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Secrecy {

}
