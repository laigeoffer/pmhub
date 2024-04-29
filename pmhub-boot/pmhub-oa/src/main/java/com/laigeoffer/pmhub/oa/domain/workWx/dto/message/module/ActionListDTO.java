package com.laigeoffer.pmhub.oa.domain.workWx.dto.message.module;

import lombok.Data;

/**
 * 操作列表，列表长度取值范围为 [1, 3]
 * TODO: 2023/2/27 此类的变量名为匹配微信接口使用按下划命名，后期安排优化
 * @author canghe
 */
@Data
public class ActionListDTO {

    /**
     * 操作的描述文案
     * */
    private String text;


    /**
     * 操作key值，用户点击后，会产生回调事件将本参数作为EventKey返回，回调事件会带上该key值，最长支持1024字节，不可重复
     * */
    private String key;

}
