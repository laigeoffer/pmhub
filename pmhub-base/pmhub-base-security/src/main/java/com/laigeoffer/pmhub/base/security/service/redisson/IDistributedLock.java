package com.laigeoffer.pmhub.base.security.service.redisson;

import com.laigeoffer.pmhub.base.security.pojo.ILock;

import java.util.concurrent.TimeUnit;

/**
 * @author canghe
 * @description IDistributedLock 分布式锁接口
 * @create 2024-06-17-10:23
 */
public interface IDistributedLock {
    /**
     * 获取锁，默认30秒失效，失败一直等待直到获取锁
     *
     * @param key 锁的key
     * @return 锁对象
     */
    ILock lock(String key);

    /**
     * 获取锁,失败一直等待直到获取锁
     *
     * @param key      锁的key
     * @param lockTime 加锁的时间，超过这个时间后锁便自动解锁； 如果lockTime为-1，则保持锁定直到显式解锁
     * @param unit     {@code lockTime} 参数的时间单位
     * @param fair     是否公平锁
     * @return 锁对象
     */
    ILock lock(String key, long lockTime, TimeUnit unit, boolean fair);

    /**
     * 尝试获取锁，30秒获取不到超时异常，锁默认30秒失效
     *
     * @param key     锁的key
     * @param tryTime 获取锁的最大尝试时间
     * @return
     * @throws Exception
     */
    ILock tryLock(String key, long tryTime) throws Exception;

    /**
     * 尝试获取锁，获取不到超时异常
     *
     * @param key      锁的key
     * @param tryTime  获取锁的最大尝试时间
     * @param lockTime 加锁的时间
     * @param unit     {@code tryTime @code lockTime} 参数的时间单位
     * @param fair     是否公平锁
     * @return
     * @throws Exception
     */
    ILock tryLock(String key, long tryTime, long lockTime, TimeUnit unit, boolean fair) throws Exception;

    /**
     * 解锁
     *
     * @param lock
     * @throws Exception
     */
    void unLock(Object lock);


    /**
     * 释放锁
     *
     * @param lock
     * @throws Exception
     */
    default void unLock(ILock lock) {
        if (lock != null) {
            unLock(lock.getLock());
        }
    }


}
