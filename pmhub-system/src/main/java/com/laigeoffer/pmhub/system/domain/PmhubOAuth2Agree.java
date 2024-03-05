package com.laigeoffer.pmhub.system.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * OAuth2 用户已统一登陆客户端
 * @author canghe
 * @date 2024/01/08
 */
@Data
@TableName("pmhub_oauth2_agree")
public class PmhubOAuth2Agree {

    String id;

    /**
     * 客户端名称
     */
    Long userId;

    /**
     * 客户端id
     */
    String clientId;

}
