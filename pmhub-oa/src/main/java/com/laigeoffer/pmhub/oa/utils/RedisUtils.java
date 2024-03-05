package com.laigeoffer.pmhub.oa.utils;

import com.laigeoffer.pmhub.common.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

/**
 * @author canghe
 * @date 2023-04-10 11:04
 */
@Slf4j
@Component
public class RedisUtils {

    @Resource
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 赋值一个静态的redis
     */
    public static RedisTemplate<String, Object> redis;

    /**
     * 此注解表示构造时赋值
     */
    @PostConstruct
    public void redisTemplate() {
        redis = this.redisTemplate;
    }


    /**
     * 根据key读取数据
     */
    public static Object get(final String key) {
        if (StringUtils.isBlank(key)) {
            return null;
        }
        try {
            return redis.opsForValue().get(key);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 写入数据
     */
    public static boolean set(final String key, Object value) {
        if (StringUtils.isBlank(key)) {
            return false;
        }
        try {
            redis.opsForValue().set(key, value);
            log.info("存入redis成功，key：{}，value：{}", key, value);
            return true;
        } catch (Exception e) {
            log.error("存入redis失败，key：{}，value：{}", key, value);
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 删除对应的value
     *
     * @param key
     */

    public static void remove(final String key) {
        if (exists(key)) {
            redis.delete(key);
        }
    }

    /**
     * 判断缓存中是否有对应的value
     *
     * @param key
     * @return
     */

    public static boolean exists(final String key) {
        return Boolean.TRUE.equals(redis.hasKey(key));
    }
}
