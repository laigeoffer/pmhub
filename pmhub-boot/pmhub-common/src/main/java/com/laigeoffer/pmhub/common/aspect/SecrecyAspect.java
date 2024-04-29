package com.laigeoffer.pmhub.common.aspect;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.log.LogFactory;
import com.laigeoffer.pmhub.common.annotation.Secrecy;
import com.laigeoffer.pmhub.common.annotation.SecrecyFunc;
import com.laigeoffer.pmhub.common.annotation.SecrecyMap;
import com.laigeoffer.pmhub.common.exception.secrecy.SecrecyClassTypeNotSupportedException;
import com.laigeoffer.pmhub.common.exception.secrecy.SecrecyFieldTypeErrorException;
import com.laigeoffer.pmhub.common.utils.SecrecyUtils;
import com.laigeoffer.pmhub.common.utils.UserMessageUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;


import java.lang.reflect.Field;
import java.util.*;

/**
 * 保密切面类
 *
 * @author canghe
 * @date 2023/07/17
 */
@Aspect
@Component
public class SecrecyAspect {

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

    @Pointcut("@annotation(secrecyFunc)")
    public void methodAnnotatedWithSecrecyFunc(SecrecyFunc secrecyFunc) {
    }

    /**
     * 处理对象中的保密字段
     *
     * @param joinPoint   连接点
     * @param secrecyFunc 保密函数
     * @param result      结果
     * @return {@link Object}
     * @throws Throwable throwable
     */
    @AfterReturning(value = "methodAnnotatedWithSecrecyFunc(secrecyFunc)", returning = "result", argNames = "joinPoint,secrecyFunc,result")
    public Object maskSecrecyFields(JoinPoint joinPoint, SecrecyFunc secrecyFunc, Object result) throws Throwable {
        if (result == null) {
            return null;
        }else {
            Set<Object> visited = new HashSet<>();
            maskFields(result, visited);
        }
        return result;
    }

    /**
     * 加密类型初选
     *
     * @param obj     需加密的对象
     * @param visited 递归辅助记录
     * @throws IllegalAccessException 非法访问异常
     */
    private void maskFields(Object obj, Set<Object> visited) throws IllegalAccessException {
        if (obj == null || visited.contains(obj)) {
            return;
        }

        // 处理需要加密的类
        if (obj instanceof Collection || obj instanceof Map || isCustomObjectField(obj)){
            encryption(obj, visited);
        }else {
            throw new SecrecyClassTypeNotSupportedException(obj.getClass(),this.getClass());
        }
    }

    /**
     * 信息加密前进行选择和分析
     *
     * @param obj     需加密的对象
     * @param visited 递归辅助记录
     */
    private void encryption(Object obj, Set<Object> visited) throws IllegalAccessException {
        visited.add(obj);
        // 判断是否为集合
        if (obj instanceof Collection){
            try {
                Collection list = (Collection)obj;
                // 创建迭代器对象
                Iterator ite = list.iterator();
                // hasNext作为条件
                while (ite.hasNext()) {
                    // 递归处理非标记字段的子属性
                    encryption(ite.next(), visited);
                }
            }catch (Exception ex){
                LogFactory.get().error(ex);
            }
            return;
        }
        // 判断是否额为Map
        if (obj instanceof Map){
            try {
                Map map = (Map)obj;
                // 创建迭代器对象
                Iterator<Map.Entry<Object,Object>> iterator = map.entrySet().iterator();
                // hasNext作为条件
                while (iterator.hasNext()) {
                    Map.Entry<Object,Object> entry = iterator.next();
                    // 递归处理非标记字段的子属性
                    encryption(entry.getValue(), visited);
                }
            }catch (Exception ex){
                LogFactory.get().error(ex);
            }
            return;
        }
        // 普通对象处理
        Class<?> objClass = obj.getClass();
        Field[] fields = objClass.getDeclaredFields();
        Map<String,String> sMap = new HashMap<>();
        for (Field field : fields) {
            if (field.isAnnotationPresent(Secrecy.class)) {
                // 如果当前字段为敏感字段，则进行加密操作
                field.setAccessible(true);
                // 如果敏感数据不为空则进行加密处理
                if (ObjectUtil.isNotEmpty(field.get(obj))){
                    // 写入映射关系
                    sMap.put(field.getName(),calcEncode(field.get(obj)));
                    // 如果没有权限就隐藏掉原始数据
                    if (!UserMessageUtils.isClassifiedInquirer()){
                        try {
                            field.set(obj, null);
                        }catch (Exception ex){
                            throw new SecrecyFieldTypeErrorException(objClass,field, ex.getMessage());
                        }
                    }
                }
            } else if (field.isAnnotationPresent(SecrecyMap.class)){
                // 如果当前字段为映射表，则映射密文
                field.setAccessible(true);
                if (field.getType().equals(Map.class)) {
                    // 将对应表赋值
                    field.set(obj, sMap);
                }
            } else {
                // 啥也不是则判断是否为自定义的类或集合，是则下钻进行检查
                field.setAccessible(true);
                Object fieldValue = field.get(obj);
                if (fieldValue != null && isCustomObjectField(fieldValue)) {
                    // 递归处理非标记字段的子属性
                    encryption(fieldValue, visited);
                }
            }
        }
    }


    /**
     * 加密
     *
     * @param value 明文数据
     * @return {@link String} 密文
     */
    private String calcEncode(Object value){
        // 先进行国密SM2加密，然后转为Base64字符串
        return SecrecyUtils.calcEncode(value);
    }

    /**
     * 是自定义对象字段（非自定义对象就不递归加密了）
     *
     * @param obj 对象判断
     * @return boolean 是 否
     */
    private static boolean isCustomObjectField(Object obj) {

        //判断是否是集合类型
        if (obj instanceof Collection || obj instanceof Map) {
            return true;
        }

        // 判断是否为自定义类型
        Class<?> fieldType = obj.getClass();
        return !fieldType.isPrimitive() && !fieldType.isArray() && !fieldType.getName().startsWith("java.");
    }

}
