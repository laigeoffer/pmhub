package com.laigeoffer.pmhub.project.job;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.laigeoffer.pmhub.base.core.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.base.core.enums.ProjectTaskStatusEnum;
import com.laigeoffer.pmhub.project.domain.ProjectTask;
import com.laigeoffer.pmhub.project.domain.ProjectTaskNotify;
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
 * 任务已逾期提醒
 *
 * @author canghe
 * @date 2023-03-16 09:04
 */
@Component
@Slf4j
public class TaskOverdueWeekNotifyJob {

    @Autowired
    private ProjectTaskNotifyMapper projectTaskNotifyMapper;
    @Autowired
    private ProjectTaskMapper projectTaskMapper;

    @Scheduled(cron = "0 0 10 ? * MON")
    @Transactional(rollbackFor = Exception.class)
    public void taskNotify() {
        LambdaQueryWrapper<ProjectTaskNotify> qw = new LambdaQueryWrapper<>();
        qw.eq(ProjectTaskNotify::getOverdue, 1);
        List<ProjectTaskNotify> projectTaskNotifies = projectTaskNotifyMapper.selectList(qw);
        LocalDate localDate = LocalDate.now();
        projectTaskNotifies.forEach(projectTaskNotify -> {
            if (ProjectStatusEnum.PAUSE.getStatus().equals(projectTaskMapper.queryProjectStatus(projectTaskNotify.getProjectId()))) {
                return;
            }
            LambdaQueryWrapper<ProjectTask> qw2 = new LambdaQueryWrapper<>();
            qw2.eq(ProjectTask::getId, projectTaskNotify.getTaskId()).eq(ProjectTask::getDeleted, 0);
            ProjectTask projectTask = projectTaskMapper.selectOne(qw2);
            if (projectTask != null && projectTask.getCloseTime() != null) {
                LocalDate closeDate = projectTask.getCloseTime().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                if (ChronoUnit.DAYS.between(localDate, closeDate) < 0L) {
                    if (!ProjectTaskStatusEnum.FINISHED.getStatus().equals(projectTask.getExecuteStatus())) {
                        log.info("已逾期任务每周重复提醒开始, 用户id:{}, 企微id:{}, 任务id:{}", projectTaskNotify.getUserId(), projectTaskNotify.getUserWxName(), projectTaskNotify.getTaskId());
//                        // 进行逾期任务消息提醒
//                        TaskOvertimeRemindDTO taskOvertimeRemindDTO = new TaskOvertimeRemindDTO();
//                        // 设置发送用户
//                        taskOvertimeRemindDTO.setUserIds(Collections.singletonList(projectTaskNotify.getUserWxName()));
//                        // 设置任务详情页
//                        String url = SsoUrlUtils.ssoCreate(appid, agentid, host + path + ssoPath + URLEncoder.encode(host + "/pmhub-project/my-task/info?taskId=" + projectTaskNotify.getTaskId()));
//                        taskOvertimeRemindDTO.setDetailUrl(url);
//                        // 设置任务名称
//                        taskOvertimeRemindDTO.setTaskName(projectTaskNotify.getTaskName());
//                        taskOvertimeRemindDTO.setOaTitle("任务已逾期提醒");
//                        taskOvertimeRemindDTO.setOaContext("您的任务【" + projectTaskNotify.getTaskName() + "】已经逾期，请及时处理！");
//                        taskOvertimeRemindDTO.setUserName(projectTaskMapper.queryUserName(projectTaskNotify.getUserId().longValue()));
//                        taskOvertimeRemindDTO.setLinkUrl(OAUtils.ssoCreate(host + "/pmhub-project/my-task/info?taskId=" + projectTaskNotify.getTaskId()));
//                        RocketMqUtils.push2Wx(taskOvertimeRemindDTO);
//                        log.info("已逾期任务每周重复提醒结束");
                    }
                }
            }
        });


    }
}
