package com.laigeoffer.pmhub.project.domain.vo.project.log;

import java.lang.annotation.*;

/**
 * @author canghe
 * @date 2022-12-22 14:57
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ForUpdate {
    String fieldName() default "";
}
