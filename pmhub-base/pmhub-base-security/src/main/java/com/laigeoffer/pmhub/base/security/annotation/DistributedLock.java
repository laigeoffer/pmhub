package com.laigeoffer.pmhub.base.security.annotation;

import java.lang.annotation.*;
import java.util.concurrent.TimeUnit;

/**
 * @author canghe
 * @description DistributedLock 分布式锁注解
 * @create 2024-06-17-10:16
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface DistributedLock {

    /**
     * 保证业务接口的key的唯一性，否则失去了分布式锁的意义 锁key
     * 支持使用spEl表达式
     */
    String key();

    /**
     * 保证业务接口的key的唯一性，否则失去了分布式锁的意义 锁key 前缀
     */
    String keyPrefix() default "";

    /**
     * 是否在等待时间内获取锁，如果在等待时间内无法获取到锁，则返回失败
     */
    boolean tryLok() default false;

    /**
     * 获取锁的最大尝试时间 ，会尝试tryTime时间获取锁，在该时间内获取成功则返回，否则抛出获取锁超时异常，tryLok=true时，该值必须大于0。
     *
     */
    long tryTime() default 0;

    /**
     * 加锁的时间，超过这个时间后锁便自动解锁
     */
    long lockTime() default 30;

    /**
     * tryTime 和 lockTime的时间单位
     */
    TimeUnit unit() default TimeUnit.SECONDS;

    /**
     * 是否公平锁，false:非公平锁，true:公平锁
     */
    boolean fair() default false;
}
