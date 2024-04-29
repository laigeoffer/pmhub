package com.laigeoffer.pmhub.workflow.job;

import com.laigeoffer.pmhub.workflow.domain.vo.TodoNumVO;
import com.laigeoffer.pmhub.workflow.service.IListenerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

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
            // TODO: 2024.04.25 企微通知暂时关闭

//            TodoRemindDTO todoRemindDTO = new TodoRemindDTO();
//            String detailUrl =  SsoUrlUtils.ssoCreate(appid,agentid, host+path+ssoPath+ URLEncoder.encode(host+URL));
//            todoRemindDTO.setDetailUrl(detailUrl);
//            List<String> uids = new ArrayList<>();
//            uids.add(todoNumVO.getUserWxName());
//            todoRemindDTO.setUserIds(uids);
//            todoRemindDTO.setNum(todoNumVO.getNum());
//            todoRemindDTO.setOaTitle("待办任务提醒");
//            todoRemindDTO.setOaContext("您目前还有【" + todoNumVO.getNum() + "】个审批请求未处理，请及时处理");
//            todoRemindDTO.setUserName(todoNumVO.getUserName());
//            todoRemindDTO.setLinkUrl(OAUtils.ssoCreate(host + URL));
//            RocketMqUtils.push2Wx(todoRemindDTO);
        }
    }
}
