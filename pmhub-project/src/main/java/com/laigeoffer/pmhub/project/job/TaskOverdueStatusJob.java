package com.laigeoffer.pmhub.project.job;

import com.laigeoffer.pmhub.common.enums.ProjectStatusEnum;
import com.laigeoffer.pmhub.common.enums.ProjectTaskStatusEnum;
import com.laigeoffer.pmhub.project.domain.ProjectTask;
import com.laigeoffer.pmhub.project.mapper.ProjectTaskMapper;
import com.laigeoffer.pmhub.project.domain.vo.project.task.TaskNotifyDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Objects;


/**
 * 任务已逾期提醒
 *
 * @author canghe
 * @date 2023-03-16 09:04
 */
@Component
@Slf4j
public class TaskOverdueStatusJob {

    @Autowired
    private ProjectTaskMapper projectTaskMapper;

    @Scheduled(cron = "0 0 1 * * ?")
    @Transactional(rollbackFor = Exception.class)
    public void taskNotify() {
        List<TaskNotifyDTO> tasks = projectTaskMapper.queryTaskNotifyJob2();
        LocalDate localDate = LocalDate.now();
        tasks.stream().filter(taskNotifyDTO -> taskNotifyDTO.getCloseTime() != null)
                .forEach(taskNotifyDTO -> {
                    if (ProjectStatusEnum.PAUSE.getStatus().equals(taskNotifyDTO.getStatus())) {
                        return;
                    }
                    LocalDate closeDate = taskNotifyDTO.getCloseTime().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                    if (ChronoUnit.DAYS.between(localDate, closeDate) < 0L) {
                        log.info("已逾期任务修改任务状态开始, 任务id:{}", taskNotifyDTO.getTaskId());
                        ProjectTask projectTask = projectTaskMapper.selectById(taskNotifyDTO.getTaskId());
                        if (Objects.equals(ProjectTaskStatusEnum.NO_STARTED.getStatus(), projectTask.getStatus())) {
                            projectTask.setStatus(ProjectTaskStatusEnum.OVERDUE.getStatus());
                            projectTaskMapper.updateById(projectTask);
                        }
                        log.info("已逾期任务修改任务状态结束");

                    }
                });

    }
}
