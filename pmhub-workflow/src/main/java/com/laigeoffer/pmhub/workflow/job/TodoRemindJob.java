package com.laigeoffer.pmhub.workflow.job;

import com.laigeoffer.pmhub.common.utils.OAUtils;
import com.laigeoffer.pmhub.workflow.domain.vo.TodoNumVO;
import com.laigeoffer.pmhub.workflow.service.IListenerService;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.notice.TodoRemindDTO;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import com.laigeoffer.pmhub.oa.utils.SsoUrlUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import static com.laigeoffer.pmhub.oa.utils.SsoUrlUtils.ssoPath;
import static com.laigeoffer.pmhub.oa.utils.wx.MessageUtils.*;

/**
 * 代办提醒任务
 * @author canghe
 */
@Component
public class TodoRemindJob {

    @Autowired
    IListenerService listenerService;

    private static final String URL= "/work/todo";

    @Scheduled(cron ="0 0 9 1/2 * ?")
    public void sayWord() {

        List<TodoNumVO> todoNumVOList = listenerService.getTodoNumList();
        for (TodoNumVO todoNumVO:todoNumVOList){
            TodoRemindDTO todoRemindDTO = new TodoRemindDTO();
            String detailUrl =  SsoUrlUtils.ssoCreate(appid,agentid, host+path+ssoPath+ URLEncoder.encode(host+URL));
            todoRemindDTO.setDetailUrl(detailUrl);
            List<String> uids = new ArrayList<>();
            uids.add(todoNumVO.getUserWxName());
            todoRemindDTO.setUserIds(uids);
            todoRemindDTO.setNum(todoNumVO.getNum());
            todoRemindDTO.setOaTitle("待办任务提醒");
            todoRemindDTO.setOaContext("您目前还有【" + todoNumVO.getNum() + "】个审批请求未处理，请及时处理");
            todoRemindDTO.setUserName(todoNumVO.getUserName());
            todoRemindDTO.setLinkUrl(OAUtils.ssoCreate(host + URL));
            RocketMqUtils.push2Wx(todoRemindDTO);
        }
    }
}
