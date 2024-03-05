package com.laigeoffer.pmhub.oa.oa.consumer;

import cn.hutool.json.JSONUtil;
import cn.hutool.log.LogFactory;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.laigeoffer.pmhub.common.utils.OAUtils;
import com.laigeoffer.pmhub.oa.domain.workWx.WxResult;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.*;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.action.*;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.notice.TaskAssignRemindDTO;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.notice.TaskOverdueRemindDTO;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.notice.TaskOvertimeRemindDTO;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.notice.TodoRemindDTO;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.body.result.ProcessReturnDTO;
import com.laigeoffer.pmhub.oa.utils.MessageDataDTO;
import com.laigeoffer.pmhub.oa.utils.RedisUtils;
import com.laigeoffer.pmhub.oa.utils.RocketMqUtils;
import com.laigeoffer.pmhub.oa.utils.wx.MessageUtils;
import org.apache.rocketmq.client.apis.ClientConfiguration;
import org.apache.rocketmq.client.apis.ClientException;
import org.apache.rocketmq.client.apis.ClientServiceProvider;
import org.apache.rocketmq.client.apis.consumer.ConsumeResult;
import org.apache.rocketmq.client.apis.consumer.FilterExpression;
import org.apache.rocketmq.client.apis.consumer.FilterExpressionType;
import org.apache.rocketmq.client.apis.consumer.PushConsumer;
import org.springframework.boot.CommandLineRunner;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Collections;

/**
 * OA message消费者
 *
 * @author canghe
 * @date 2023/07/21
 */
//@Component
public class OAMessageConsumer implements CommandLineRunner {


    /**
     * 微信topic
     * */
//    @Value("${pmhub.rocketMQ.topic.wxMessage}")
    private String WX_TOPIC;


    /**
     * 服务器地址
     * */
//    @Value("${pmhub.rocketMQ.addr}")
    private String addr;



    /**
     * 消费组
     * */
//    @Value("${pmhub.rocketMQ.topic.consumerGroup}")
    private String WX_CONSUMER_GROUP;


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
                                    WxResult wxResult =  MessageUtils.sendMessage(processRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO = new MessageDataDTO();
                                    messageDataDTO.setMsgCode(wxResult.getResponse_code());
                                    messageDataDTO.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO.setWxUserName(processRemindDTO.getWxUserName());
                                    RedisUtils.set(processRemindDTO.getTaskId() + "_" + processRemindDTO.getAssignee(), messageDataDTO);
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(processRemindDTO.getUserName(), processRemindDTO.getOaTitle()
                                            , processRemindDTO.getOaContext(), processRemindDTO.getLinkUrl(), processRemindDTO.getTaskId() + "_" + processRemindDTO.getAssignee())), OAUtils.SEND_MESSAGE_API);
                                    LogFactory.get().info("新增消息instanceId：{}, taskId：{}"+processRemindDTO.getInstId(), processRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult));
                                    break;
                                case "采购入库审批提醒":
                                    InboundRemindDTO inboundRemindDTO = JSONUtil.toBean(json, InboundRemindDTO.class);
                                    WxResult wxResult2 =  MessageUtils.sendMessage(inboundRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO2 = new MessageDataDTO();
                                    messageDataDTO2.setMsgCode(wxResult2.getResponse_code());
                                    messageDataDTO2.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO2.setWxUserName(inboundRemindDTO.getWxUserName());
                                    RedisUtils.set(inboundRemindDTO.getTaskId() + "_" + inboundRemindDTO.getAssignee(), messageDataDTO2);
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(inboundRemindDTO.getUserName(), inboundRemindDTO.getOaTitle()
                                            , inboundRemindDTO.getOaContext(), inboundRemindDTO.getLinkUrl(), inboundRemindDTO.getTaskId() + "_" + inboundRemindDTO.getAssignee())), OAUtils.SEND_MESSAGE_API);
                                    LogFactory.get().info("新增采购入库消息instanceId：{}, taskId：{}" + inboundRemindDTO.getInstId(), inboundRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult2));
                                    break;
                                case "采购退货出库审批提醒":
                                    OutboundRemindDTO outboundRemindDTO = JSONUtil.toBean(json, OutboundRemindDTO.class);
                                    WxResult wxResult3 =  MessageUtils.sendMessage(outboundRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO3 = new MessageDataDTO();
                                    messageDataDTO3.setMsgCode(wxResult3.getResponse_code());
                                    messageDataDTO3.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO3.setWxUserName(outboundRemindDTO.getWxUserName());
                                    RedisUtils.set(outboundRemindDTO.getTaskId() + "_" + outboundRemindDTO.getAssignee(), messageDataDTO3);
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(outboundRemindDTO.getUserName(), outboundRemindDTO.getOaTitle()
                                            , outboundRemindDTO.getOaContext(), outboundRemindDTO.getLinkUrl(), outboundRemindDTO.getTaskId() + "_" + outboundRemindDTO.getAssignee())), OAUtils.SEND_MESSAGE_API);
                                    LogFactory.get().info("新增采购退货出库消息instanceId：{}, taskId：{}" + outboundRemindDTO.getInstId(), outboundRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult3));
                                    break;
                                case "其他入库审批提醒":
                                    OtherIntoRemindDTO otherIntoRemindDTO = JSONUtil.toBean(json, OtherIntoRemindDTO.class);
                                    WxResult wxResult4 =  MessageUtils.sendMessage(otherIntoRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO4 = new MessageDataDTO();
                                    messageDataDTO4.setMsgCode(wxResult4.getResponse_code());
                                    messageDataDTO4.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO4.setWxUserName(otherIntoRemindDTO.getWxUserName());
                                    RedisUtils.set(otherIntoRemindDTO.getTaskId() + "_" + otherIntoRemindDTO.getAssignee(), messageDataDTO4);
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(otherIntoRemindDTO.getUserName(), otherIntoRemindDTO.getOaTitle()
                                            , otherIntoRemindDTO.getOaContext(), otherIntoRemindDTO.getLinkUrl(), otherIntoRemindDTO.getTaskId() + "_" + otherIntoRemindDTO.getAssignee())), OAUtils.SEND_MESSAGE_API);
                                    LogFactory.get().info("新增其他入库消息instanceId：{}, taskId：{}" + otherIntoRemindDTO.getInstId(), otherIntoRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult4));
                                    break;
                                case "其他出库审批提醒":
                                    OtherOutRemindDTO otherOutRemindDTO = JSONUtil.toBean(json, OtherOutRemindDTO.class);
                                    WxResult wxResult5 =  MessageUtils.sendMessage(otherOutRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO5 = new MessageDataDTO();
                                    messageDataDTO5.setMsgCode(wxResult5.getResponse_code());
                                    messageDataDTO5.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO5.setWxUserName(otherOutRemindDTO.getWxUserName());
                                    RedisUtils.set(otherOutRemindDTO.getTaskId() + "_" + otherOutRemindDTO.getAssignee(), messageDataDTO5);
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(otherOutRemindDTO.getUserName(), otherOutRemindDTO.getOaTitle()
                                            , otherOutRemindDTO.getOaContext(), otherOutRemindDTO.getLinkUrl(), otherOutRemindDTO.getTaskId() + "_" + otherOutRemindDTO.getAssignee())), OAUtils.SEND_MESSAGE_API);
                                    LogFactory.get().info("新增其他出库出库消息instanceId：{}, taskId：{}" + otherOutRemindDTO.getInstId(), otherOutRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult5));
                                    break;
                                case "归还入库审批提醒":
                                    ReturnIntoRemindDTO returnIntoRemindDTO = JSONUtil.toBean(json, ReturnIntoRemindDTO.class);
                                    WxResult wxResult6 =  MessageUtils.sendMessage(returnIntoRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO6 = new MessageDataDTO();
                                    messageDataDTO6.setMsgCode(wxResult6.getResponse_code());
                                    messageDataDTO6.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO6.setWxUserName(returnIntoRemindDTO.getWxUserName());
                                    RedisUtils.set(returnIntoRemindDTO.getTaskId() + "_" + returnIntoRemindDTO.getAssignee(), messageDataDTO6);
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(returnIntoRemindDTO.getUserName(), returnIntoRemindDTO.getOaTitle()
                                            , returnIntoRemindDTO.getOaContext(), returnIntoRemindDTO.getLinkUrl(), returnIntoRemindDTO.getTaskId() + "_" + returnIntoRemindDTO.getAssignee())), OAUtils.SEND_MESSAGE_API);
                                    LogFactory.get().info("新增归还入库消息instanceId：{}, taskId：{}" + returnIntoRemindDTO.getInstId(), returnIntoRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult6));
                                    break;
                                case "供应商审批提醒":
                                    ProviderRemindDTO providerRemindDTO = JSONUtil.toBean(json, ProviderRemindDTO.class);
                                    WxResult wxResult7 =  MessageUtils.sendMessage(providerRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO7 = new MessageDataDTO();
                                    messageDataDTO7.setMsgCode(wxResult7.getResponse_code());
                                    messageDataDTO7.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO7.setWxUserName(providerRemindDTO.getWxUserName());
                                    RedisUtils.set(providerRemindDTO.getTaskId() + "_" + providerRemindDTO.getAssignee(), messageDataDTO7);
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(providerRemindDTO.getUserName(), providerRemindDTO.getOaTitle()
                                            , providerRemindDTO.getOaContext(), providerRemindDTO.getLinkUrl(), providerRemindDTO.getTaskId() + "_" + providerRemindDTO.getAssignee())), OAUtils.SEND_MESSAGE_API);
                                    LogFactory.get().info("新增采购管理消息instanceId：{}, taskId：{}" + providerRemindDTO.getInstId(), providerRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult7));
                                    break;
                                case "物料报废审批提醒":
                                    ScrappedOutRemindDTO scrappedOutRemindDTO = JSONUtil.toBean(json, ScrappedOutRemindDTO.class);
                                    WxResult wxResult8 =  MessageUtils.sendMessage(scrappedOutRemindDTO.toWxMessage());

                                    // 信息发送成功,保存message
                                    // cleanMessage(processRemindDTO.getInstId());
                                    MessageDataDTO messageDataDTO8 = new MessageDataDTO();
                                    messageDataDTO8.setMsgCode(wxResult8.getResponse_code());
                                    messageDataDTO8.setMsgTime(System.currentTimeMillis());
                                    messageDataDTO8.setWxUserName(scrappedOutRemindDTO.getWxUserName());
                                    RedisUtils.set(scrappedOutRemindDTO.getTaskId() + "_" + scrappedOutRemindDTO.getAssignee(), messageDataDTO8);
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(scrappedOutRemindDTO.getUserName(), scrappedOutRemindDTO.getOaTitle()
                                            , scrappedOutRemindDTO.getOaContext(), scrappedOutRemindDTO.getLinkUrl(), scrappedOutRemindDTO.getTaskId() + "_" + scrappedOutRemindDTO.getAssignee())), OAUtils.SEND_MESSAGE_API);
                                    LogFactory.get().info("新增物料报废消息instanceId：{}, taskId：{}" + scrappedOutRemindDTO.getInstId(), scrappedOutRemindDTO.getTaskId());
                                    LogFactory.get().info(JSONUtil.toJsonStr(wxResult8));
                                    break;
                                case "审批流结束回执":
                                    // 消息回执
                                    ProcessReturnDTO processReturnDTO = JSONUtil.toBean(json, ProcessReturnDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(processReturnDTO.toWxMessage())));
                                    // 发送消息至泛微
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(processReturnDTO.getUserName(), processReturnDTO.getOaTitle()
                                            , processReturnDTO.getOaContext(), processReturnDTO.getLinkUrl(), null)), OAUtils.SEND_MESSAGE_API);
                                    break;
                                case "待办提醒":
                                    // 待办提醒
                                    TodoRemindDTO todoRemindDTO = JSONUtil.toBean(json, TodoRemindDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(todoRemindDTO.toWxMessage())));
                                    // 发送消息至泛微
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(todoRemindDTO.getUserName(), todoRemindDTO.getOaTitle()
                                            , todoRemindDTO.getOaContext(), todoRemindDTO.getLinkUrl(), null)), OAUtils.SEND_MESSAGE_API);

                                    break;
                                case "任务逾期提醒":
                                    // 任务逾期提醒
                                    TaskOverdueRemindDTO taskOverdueRemindDTO = JSONUtil.toBean(json, TaskOverdueRemindDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(taskOverdueRemindDTO.toWxMessage())));
                                    // 发送消息至泛微
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(taskOverdueRemindDTO.getUserName(), taskOverdueRemindDTO.getOaTitle()
                                            , taskOverdueRemindDTO.getOaContext(), taskOverdueRemindDTO.getLinkUrl(), null)), OAUtils.SEND_MESSAGE_API);
                                    break;
                                case "任务已逾期提醒":
                                    // 任务逾期提醒
                                    TaskOvertimeRemindDTO taskOvertimeRemindDTO = JSONUtil.toBean(json, TaskOvertimeRemindDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(taskOvertimeRemindDTO.toWxMessage())));
                                    // 发送消息至泛微
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(taskOvertimeRemindDTO.getUserName(), taskOvertimeRemindDTO.getOaTitle()
                                            , taskOvertimeRemindDTO.getOaContext(), taskOvertimeRemindDTO.getLinkUrl(), null)), OAUtils.SEND_MESSAGE_API);
                                    break;
                                case "任务指派提醒":
                                    // 任务指派提醒
                                    TaskAssignRemindDTO taskAssignRemindDTO = JSONUtil.toBean(json, TaskAssignRemindDTO.class);
                                    LogFactory.get().info(JSONUtil.toJsonStr(MessageUtils.sendMessage(taskAssignRemindDTO.toWxMessage())));
                                    // 发送消息至泛微
                                    OAUtils.restfulCall2(OAUtils.SEND_MESSAGE_API, OAUtils.mapToStr(OAUtils.sendCustomMessageSingle(taskAssignRemindDTO.getUserName(), taskAssignRemindDTO.getOaTitle()
                                            , taskAssignRemindDTO.getOaContext(), taskAssignRemindDTO.getLinkUrl(), null)), OAUtils.SEND_MESSAGE_API);
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
