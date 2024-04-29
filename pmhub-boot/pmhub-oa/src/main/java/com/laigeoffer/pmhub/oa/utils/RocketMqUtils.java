package com.laigeoffer.pmhub.oa.utils;

import cn.hutool.core.util.IdUtil;
import cn.hutool.json.JSONUtil;
import cn.hutool.log.LogFactory;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.laigeoffer.pmhub.oa.utils.wx.MessageUtils;
import com.laigeoffer.pmhub.oa.domain.workWx.WxResult;
import com.laigeoffer.pmhub.oa.enums.wx.ButtonStateEnum;
import com.laigeoffer.pmhub.oa.domain.workWx.dto.message.body.template.update.ProcessWxMessageStateUpdateDTO;
import org.apache.rocketmq.client.apis.ClientConfiguration;
import org.apache.rocketmq.client.apis.ClientConfigurationBuilder;
import org.apache.rocketmq.client.apis.ClientException;
import org.apache.rocketmq.client.apis.ClientServiceProvider;
import org.apache.rocketmq.client.apis.message.Message;
import org.apache.rocketmq.client.apis.producer.Producer;
import org.apache.rocketmq.client.apis.producer.SendReceipt;

import java.io.IOException;

/**
 * RocketMQ连接工具
 * @author canghe
 */
//@Component
public class RocketMqUtils {


    /**
     * 连接地址
     * */
    private static String addr;


    /**
     * 微信topic
     * */
    private static String WX_TOPIC;

//    @Value("${pmhub.rocketMQ.addr}")
    private void setAddr(String addr) {
        RocketMqUtils.addr = addr;
    }
//    @Value("${pmhub.rocketMQ.topic.wxMessage}")
    public void setWxTopic(String wxMessage) {
        WX_TOPIC = wxMessage;
    }

    /**
     * rocketmq 消息Tag
     * */
    public final static String mqTag = "WX_MASSAGE";









    /**
     * 推送到微信topic
     * */
    public static void push2Wx(com.laigeoffer.pmhub.oa.domain.workWx.Message ob){

        try {

            String key = IdUtil.simpleUUID();
            ObjectMapper objectMapper = new ObjectMapper();
            // 接入点地址，需要设置成Proxy的地址和端口列表，一般是xxx:8081;xxx:8081。
            String endpoint = addr;
            // 消息发送的目标Topic名称，需要提前创建。
            String topic = WX_TOPIC;
            ClientServiceProvider provider = ClientServiceProvider.loadService();
            ClientConfigurationBuilder builder = ClientConfiguration.newBuilder().setEndpoints(endpoint);
            ClientConfiguration configuration = builder.build();
            // 初始化Producer时需要设置通信配置以及预绑定的Topic。
            Producer producer = provider.newProducerBuilder()
                    .setTopics(topic)
                    .setClientConfiguration(configuration)
                    .build();
            // 普通消息发送。
            Message message = provider.newMessageBuilder()
                    .setTopic(topic)
                    // 设置消息索引键，可根据关键字精确查找某条消息。
                    .setKeys(key)
                    // 设置消息Tag，用于消费端根据指定Tag过滤消息。
                    .setTag(mqTag)
                    // 消息体。
                    .setBody(objectMapper.writeValueAsString(ob).getBytes())
                    .build();

            // 发送消息，需要关注发送结果，并捕获失败等异常。
            SendReceipt sendReceipt = producer.send(message);
            LogFactory.get().info("Send message successfully, messageId={}", sendReceipt.getMessageId());

            producer.close();
        } catch (ClientException | IOException e) {
            LogFactory.get().error("推送微信消息时发生错误：", e);
        }

    }


    public static void cleanMessage(String instId){
        LogFactory.get().info("清理消息：" + instId);
        try {
            // 清理消息
            MessageDataDTO messageDataDTO = (MessageDataDTO) RedisUtils.get(instId);
            if (messageDataDTO != null) {
                ProcessWxMessageStateUpdateDTO processWxMessageStateUpdateDTO = new ProcessWxMessageStateUpdateDTO();
                processWxMessageStateUpdateDTO.setAtall(1);
                processWxMessageStateUpdateDTO.setResponse_code(messageDataDTO.getMsgCode());
                processWxMessageStateUpdateDTO.getButton().setReplace_name(ButtonStateEnum.FINISH);
                WxResult wxResult =  MessageUtils.updateMessage(processWxMessageStateUpdateDTO);
                LogFactory.get().info(JSONUtil.toJsonStr(wxResult));
                RedisUtils.remove(instId);
                LogFactory.get().info("消息存在");
            }
        } catch (Exception ex){
            LogFactory.get().info("消息不存在");
        }
    }



}
