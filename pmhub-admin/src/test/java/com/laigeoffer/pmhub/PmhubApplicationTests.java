package com.laigeoffer.pmhub;

import cn.hutool.core.codec.Base64;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import cn.hutool.log.LogFactory;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.laigeoffer.pmhub.common.core.domain.entity.SysUser;
import com.laigeoffer.pmhub.common.core.domain.model.LoginUser;
import com.laigeoffer.pmhub.common.core.redis.RedisCache;
import com.laigeoffer.pmhub.oa.domain.workWx.WxResult;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.ProcessRemindDTO;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.notice.TaskOverdueRemindDTO;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.notice.TaskOvertimeRemindDTO;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.message.body.template.update.ProcessWxMessageStateUpdateDTO;
import com.laigeoffer.pmhub.oa.enums.wx.ButtonStateEnum;
import com.laigeoffer.pmhub.workflow.mapper.ListenerMapper;
import com.laigeoffer.pmhub.workflow.utils.TaskUtils;
import com.laigeoffer.pmhub.framework.web.service.SysLoginService;
import com.laigeoffer.pmhub.framework.web.service.SysPermissionService;
import com.laigeoffer.pmhub.framework.web.service.TokenService;
import com.laigeoffer.pmhub.system.domain.PmhubAsync;
import com.laigeoffer.pmhub.system.mapper.SysUserMapper;
import com.laigeoffer.pmhub.system.service.IPmhubAsyncService;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import com.laigeoffer.pmhub.oa.utils.wx.MessageUtils;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.security.KeyPair;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @author canghe
 * @date 2022-12-13 10:29
 */
@SpringBootTest(classes = PmhubApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class PmhubApplicationTests {

    @Autowired
    ListenerMapper listenerMapper;

    @Test
    public void test(){

        ProcessRemindDTO processRemindDTO = new ProcessRemindDTO();
        List<String> userIds = new ArrayList<>();
        userIds.add("ZouDingYun");
        processRemindDTO.setUserIds(userIds);
        processRemindDTO.setTitle("电梯项目开工申请");
        processRemindDTO.setRemarks("去年申请的珠穆朗玛峰电梯建设项目开工申请");
        processRemindDTO.setProcessType("项目");
        processRemindDTO.setCreateUserName("邹大爷");
        processRemindDTO.setDetailUrl("http://baidu.com");
        processRemindDTO.setPanelUrl("http://47.109.46.103:5006/");
        WxResult wxResult =  MessageUtils.sendMessage(processRemindDTO.toWxMessage());

        LogFactory.get().info(JSONUtil.toJsonStr(wxResult));


    }

    @Test
    public void test2(){


        ProcessWxMessageStateUpdateDTO processWxMessageStateUpdateDTO = new ProcessWxMessageStateUpdateDTO();
        processWxMessageStateUpdateDTO.setAtall(1);
        processWxMessageStateUpdateDTO.setResponse_code("LbmV0j9s8-JbyRzeA13YwdUpLlcI3NxdFaFrn4uIh14");
        processWxMessageStateUpdateDTO.getButton().setReplace_name(ButtonStateEnum.OVERTIME);

        WxResult wxResult =  MessageUtils.updateMessage(processWxMessageStateUpdateDTO);
        LogFactory.get().info(JSONUtil.toJsonStr(wxResult));


    }



    @Test
    public void test5(){
        Integer a  = 10;
        LogFactory.get().info((a--) +"  《《《《《《《《《《《《《《《《《《《");

    }


    @Test
    public void test55() throws JsonProcessingException {

        // 即将逾期提醒
        ProcessRemindDTO taskOverdueRemindDTO = new ProcessRemindDTO();



        ObjectMapper objectMapper = new ObjectMapper();

        String str = objectMapper.writeValueAsString(taskOverdueRemindDTO);
        // 反序列化JSON字符串为对象，并判断对象类型
        JsonNode jsonNode = objectMapper.readTree(str);
        String type = jsonNode.get("type").asText();

        LogFactory.get().info(">>>>>>>>>>>>>>>>>>>>>>>>>"+type);
    }

    @Test
    public void test6(){

        String taskId = "0e246991cd2ff593725e1010794e5a65";

        // 即将逾期提醒
        TaskOverdueRemindDTO taskOverdueRemindDTO = new TaskOverdueRemindDTO();
        // 设置发送用户
        taskOverdueRemindDTO.setUserIds(new ArrayList<String>(){{add("ZouDingYun");}});
        // 设置任务详情页
        taskOverdueRemindDTO.setDetailUrl(TaskUtils.createSsoUrl(taskId));
        // 设置任务名称
        taskOverdueRemindDTO.setTaskName("占领白宫");
        // 设置任务剩余天数
        taskOverdueRemindDTO.setNum(10);
        RocketMqUtils.push2Wx(taskOverdueRemindDTO);


        // 即将已逾期提醒
        TaskOvertimeRemindDTO taskOvertimeRemindDTO = new TaskOvertimeRemindDTO();
        // 设置发送用户
        taskOvertimeRemindDTO.setUserIds(new ArrayList<String>(){{add("ZouDingYun");}});
        // 设置任务详情页
        taskOvertimeRemindDTO.setDetailUrl(TaskUtils.createSsoUrl(taskId));
        // 设置任务名称
        taskOvertimeRemindDTO.setTaskName("占领白宫");
        RocketMqUtils.push2Wx(taskOvertimeRemindDTO);


    }


    @Test
    public void testSecure(){
        JSONObject jsonObject = new JSONObject();
        jsonObject.set("dsada","");
        int a = 0;


        String text = "我是一段测试aaaa";

        KeyPair pair = SecureUtil.generateKeyPair("SM2");
        byte[] privateKey = pair.getPrivate().getEncoded();
        byte[] publicKey = pair.getPublic().getEncoded();

        String privateKeyEncode = Base64.encode(privateKey);
        String publicKeyEncode = Base64.encode(publicKey);

        LogFactory.get().info(">>>>>>>>>>>>>>>>>>privateKeyEncode:"+privateKeyEncode);
        LogFactory.get().info(">>>>>>>>>>>>>>>>>>publicKeyEncode:"+publicKeyEncode);
    }


    @Autowired
    private RedisCache redisCache;

    @Autowired
    private SysLoginService sysLoginService;

    @Autowired
    SysUserMapper sysUserMapper;

    @Autowired
    private SysPermissionService permissionService;

    @Autowired
    TokenService tokenService;

    @Test
    public void testCache(){
        LoginUser loginUser = new LoginUser();
        SysUser user = sysUserMapper.selectUserById(129L);
        tokenService.updateToken(new LoginUser(user.getUserId()
                , user.getDeptId()
                , user
                , permissionService.getMenuPermission(user)));
    }

    @Autowired
    IPmhubAsyncService iPmhubAsyncService;
    @Test
    public void testAddAysnc(){
        LogFactory.get().info(iPmhubAsyncService.addAsyncJob("Ces","下载任务","canghe").getAsyncLog());
    }

    @Test
    public void testUpdateAysnc(){
        PmhubAsync async = new PmhubAsync();
        async.setId("74d12ecb-90ba-46f7-887d-ea203c12917a");
        async.setAsyncStatus(1);
        async.setFinishTime(new Date());
        iPmhubAsyncService.updateAsyncJob(async);
    }



}
