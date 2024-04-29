package com.laigeoffer.pmhub.project.job;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.laigeoffer.pmhub.base.core.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.project.domain.ProjectTaskNotify;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskNotifyDTO;
import com.laigeoffer.pmhub.project.mapper.ProjectTaskMapper;
import com.laigeoffer.pmhub.project.mapper.ProjectTaskNotifyMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;


/**
 * 任务待逾期提醒
 *
 * @author canghe
 * @date 2023-03-16 09:04
 */
@Component
@Slf4j
public class TaskNotifyJob {

    @Autowired
    private ProjectTaskMapper projectTaskMapper;
    @Autowired
    private ProjectTaskNotifyMapper projectTaskNotifyMapper;

    @Scheduled(cron = "0 0 9 * * ?")
    @Transactional(rollbackFor = Exception.class)
    public void taskNotify() {
        List<TaskNotifyDTO> tasks = projectTaskMapper.queryTaskNotifyJob();
        // 当前时间
        LocalDate localDate = LocalDate.now();
        tasks.stream().filter(taskNotifyDTO -> StringUtils.isNotBlank(taskNotifyDTO.getUserWxName()) && taskNotifyDTO.getCloseTime() != null)
                .forEach(taskNotifyDTO -> {
                    if (ProjectStatusEnum.PAUSE.getStatus().equals(taskNotifyDTO.getStatus())) {
                        return;
                    }
                    LocalDate closeDate = taskNotifyDTO.getCloseTime().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                    if (ChronoUnit.DAYS.between(localDate, closeDate) == taskNotifyDTO.getNotifyDay()) {
                        log.info("待逾期任务提醒开始, 用户id:{}, 企微id:{}, 任务id:{}", taskNotifyDTO.getUserId(), taskNotifyDTO.getUserWxName(), taskNotifyDTO.getTaskId());
                        // 进行待逾期消息提醒
                        // TODO: 2024.04.25 暂时注释掉逾期任务提醒功能
//                        TaskOverdueRemindDTO taskOverdueRemindDTO = new TaskOverdueRemindDTO();
//                        // 设置任务名称
//                        taskOverdueRemindDTO.setTaskName(taskNotifyDTO.getTaskName());
//                        // 设置通知用户id
//                        taskOverdueRemindDTO.setUserIds(Collections.singletonList(taskNotifyDTO.getUserWxName()));
//                        // 设置天数
//                        taskOverdueRemindDTO.setNum(taskNotifyDTO.getNotifyDay());
//                        // 设置任务详情地址
//                        String url = SsoUrlUtils.ssoCreate(appid, agentid, host + path + ssoPath + URLEncoder.encode(host + "/pmhub-project/my-task/info?taskId=" + taskNotifyDTO.getTaskId()));
//                        taskOverdueRemindDTO.setDetailUrl(url);
//                        taskOverdueRemindDTO.setOaTitle("任务即将逾期提醒");
//                        taskOverdueRemindDTO.setOaContext("您的任务【" + taskNotifyDTO.getTaskName() + "】还有【" + taskNotifyDTO.getNotifyDay() + "】天到期，请及时处理！");
//                        taskOverdueRemindDTO.setUserName(taskNotifyDTO.getUserName());
//                        taskOverdueRemindDTO.setLinkUrl(OAUtils.ssoCreate(host + "/pmhub-project/my-task/info?taskId=" + taskNotifyDTO.getTaskId()));
//                        RocketMqUtils.push2Wx(taskOverdueRemindDTO);
                        // 进行查询 如果数据库不存在记录 则就插入记录
                        LambdaQueryWrapper<ProjectTaskNotify> qw = Wrappers.lambdaQuery(ProjectTaskNotify.class).eq(ProjectTaskNotify::getTaskId, taskNotifyDTO.getTaskId()).eq(ProjectTaskNotify::getOverdue, 0);
                        if (projectTaskNotifyMapper.selectOne(qw) == null) {
                            // 插入记录
                            ProjectTaskNotify projectTaskNotify = new ProjectTaskNotify();
                            projectTaskNotify.setProjectId(taskNotifyDTO.getProjectId());
                            projectTaskNotify.setTaskId(taskNotifyDTO.getTaskId());
                            projectTaskNotify.setOverdue(0);
                            projectTaskNotify.setUserId(taskNotifyDTO.getUserId());
                            projectTaskNotify.setUserWxName(taskNotifyDTO.getUserWxName());
                            projectTaskNotify.setCloseTime(taskNotifyDTO.getCloseTime());
                            projectTaskNotify.setTaskName(taskNotifyDTO.getTaskName());
                            projectTaskNotifyMapper.insert(projectTaskNotify);
                        }
                        log.info("待逾期任务提醒结束");
                    }

                });
    }

}
