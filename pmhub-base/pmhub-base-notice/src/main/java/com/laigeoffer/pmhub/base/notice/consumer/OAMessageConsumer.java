package com.laigeoffer.pmhub.base.notice.consumer;

import cn.hutool.json.JSONUtil;
import cn.hutool.log.LogFactory;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.laigeoffer.pmhub.base.core.config.redis.RedisService;
import com.laigeoffer.pmhub.base.notice.domain.dto.*;
import com.laigeoffer.pmhub.base.notice.domain.entity.WxResult;
import com.laigeoffer.pmhub.base.notice.utils.MessageUtils;
import com.laigeoffer.pmhub.base.notice.utils.RocketMqUtils;
import org.apache.rocketmq.client.apis.ClientConfiguration;
import org.apache.rocketmq.client.apis.ClientException;
import org.apache.rocketmq.client.apis.ClientServiceProvider;
import org.apache.rocketmq.client.apis.consumer.ConsumeResult;
import org.apache.rocketmq.client.apis.consumer.FilterExpression;
import org.apache.rocketmq.client.apis.consumer.FilterExpressionType;
import org.apache.rocketmq.client.apis.consumer.PushConsumer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Collections;

/**
 * message消费者
 *
 * @author canghe
 * @date 2023/07/21
 */
@Component
public class OAMessageConsumer implements CommandLineRunner {


    /**
     * 微信topic
     * */
    @Value("${pmhub.rocketMQ.topic.wxMessage}")
    private String WX_TOPIC;


    /**
     * 服务器地址
     * */
    @Value("${pmhub.rocketMQ.addr}")
    private String addr;



    /**
     * 消费组
     * */
    @Value("${pmhub.rocketMQ.group.wxMessage}")
    private String WX_CONSUMER_GROUP;

    @Resource
    private RedisService redisService;


    /**
     * 运行注册监听器
     *
     * @param args 参数
     * @throws Exception 异常
     */
    @Override
    public void run(String... args) throws Exception {
        final ClientServiceProvider provider = ClientServiceProvider.loadService();
        ClientConfiguration clientConfiguration = ClientConfiguration.newBuilder()
                .setEndpoints(addr)
                .build();

        // 初始化PushConsumer，需要绑定消费者分组ConsumerGroup、通信参数以及订阅关系。
        try {
            FilterExpression wxFilterExpression = new FilterExpression(RocketMqUtils.mqTag, FilterExpressionType.TAG);

            PushConsumer pushConsumer = provider.newPushConsumerBuilder()
                    .setClientConfiguration(clientConfiguration)
                    // 设置消费者分组。
                    .setConsumerGroup(WX_CONSUMER_GROUP)
                    // 设置预绑定的订阅关系。
                    .setSubscriptionExpressions(Collections.singletonMap(WX_TOPIC, wxFilterExpression))
                    // 设置消费监听器。
                    .setMessageListener(messageView -> {
                        // 处理消息并返回消费结果。
                        LogFactory.get().info("Consume message successfully, messageId={}", messageView.getMessageId());


                        try {
                            Charset charset = StandardCharsets.UTF_8;
                            String json = charset.decode(messageView.getBody()).toString();

                            ObjectMapper objectMapper = new ObjectMapper();
                            JsonNode jsonNode = objectMapper.readTree(json);
                            String type = jsonNode.get("type").asText();
                            LogFactory.get().info(">>>>>>>>>>>>>>>>>>>>消息类型："+type);
                            switch (type){
                                case "任务审批提醒":
                                    ProcessRemindDTO processRemindDTO = JSONUtil.toBean(json, ProcessRemindDTO.class);
                                    // 消息幂等性校验（查询redis中同一个 taskId 和 Assignee 是否重复消费）
                                    if (redisService.hasKey(processRemindDTO.getTaskId() + "_" + processRemindDTO.getAssignee())) {
                                        LogFactory.get().info("消息重复消费，instanceId：{}, taskId：{}"+processRemindDTO.getInstId(), processRemindDTO.getTaskId());
                                        return ConsumeResult.FAILURE;
                                    }

                                    // 发送消息
                                    WxResult wxResult =  MessageUtils.sendMessage(processRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO = new MessageDataDTO();
                                    messageDataDTO.setMsgCode(wxResult.getResponse_code());
                                    messageDataDTO.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO.setWxUserName(processRemindDTO.getWxUserName());
                                    redisService.setCacheObject(processRemindDTO.getTaskId() + "_" + processRemindDTO.getAssignee(), messageDataDTO);
                                    LogFactory.get().info("新增消息instanceId：{}, taskId：{}"+processRemindDTO.getInstId(), processRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult));
                                    break;
                                 case "审批流结束回执":
                                    // 消息回执
                                    ProcessReturnDTO processReturnDTO = JSONUtil.toBean(json, ProcessReturnDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(processReturnDTO.toWxMessage())));
                                    break;
                                case "待办提醒":
                                    // 待办提醒
                                    TodoRemindDTO todoRemindDTO = JSONUtil.toBean(json, TodoRemindDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(todoRemindDTO.toWxMessage())));
                                    break;
                                case "任务逾期提醒":
                                    // 任务逾期提醒
                                    TaskOverdueRemindDTO taskOverdueRemindDTO = JSONUtil.toBean(json, TaskOverdueRemindDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(taskOverdueRemindDTO.toWxMessage())));
                                    break;
                                case "任务已逾期提醒":
                                    // 任务逾期提醒
                                    TaskOvertimeRemindDTO taskOvertimeRemindDTO = JSONUtil.toBean(json, TaskOvertimeRemindDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(taskOvertimeRemindDTO.toWxMessage())));
                                    break;
                                case "任务指派提醒":
                                    // 任务指派提醒
                                    TaskAssignRemindDTO taskAssignRemindDTO = JSONUtil.toBean(json, TaskAssignRemindDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(taskAssignRemindDTO.toWxMessage())));
                                    break;
                                default:
                                    break;
                            }
                        }catch (Exception ex){
                            LogFactory.get().error("未知的微信审批提醒消息：");
                            LogFactory.get().error(ex);
                            return ConsumeResult.SUCCESS;
                        }
                        return ConsumeResult.SUCCESS;
                    })
                    .build();
            LogFactory.get().info("企微通知消息RocketMQ通道已建立，TOPIC:"+WX_TOPIC);
        } catch (ClientException e) {
            LogFactory.get().error(e);
        }
    }

}
