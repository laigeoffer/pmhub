package com.laigeoffer.projectaihub.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.laigeoffer.projectaihub.system.domain.PaihOAuth2Client;
import org.apache.ibatis.annotations.Mapper;

/**
 * OAuth2客户端 数据层
 *
 * @author canghe
 */
@Mapper
public interface PaihOAuth2ClientMapper extends BaseMapper<PaihOAuth2Client> {

}
