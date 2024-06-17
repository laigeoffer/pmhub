package com.laigeoffer.pmhub.base.security.annotation;

import com.laigeoffer.pmhub.base.security.aspect.DistributedLockAspect;
import org.springframework.context.annotation.Import;

import java.lang.annotation.*;

/**
 * @author canghe
 * @description EnableDistributedLock 元注解，开启分布式锁功能
 * @create 2024-06-17-10:56
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Import({DistributedLockAspect.class})
public @interface EnableDistributedLock {
}
