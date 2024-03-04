package com.laigeoffer.pmhub.project.domain.vo.project.log;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author canghe
 * @date 2022-12-22 14:58
 */
public class FieldUtils {
    /**
     * 获取变更内容
     * @param <T>
     * @param newBean 更改前的Bean
     * @param oldBean 更改后的Bean
     * @return
     */
    public static <T> List<LogDataVO> getChangedFields(T newBean, T oldBean){
        List<LogDataVO> data = new ArrayList<>(10);
        Field[] fields = newBean.getClass().getDeclaredFields();
        List<LogContentVO> list = new ArrayList<>();
        for(Field field : fields) {
            LogDataVO logDataVO = new LogDataVO();
            field.setAccessible(true);
            if (field.isAnnotationPresent(ForUpdate.class)) {
                switch (field.getName()) {
                    case "userId":
                        logDataVO.setRemark("更新了执行人");
                        break;
                    case "taskName":
                        logDataVO.setRemark("更新了任务名称");
                        break;
                    case "executeStatus":
                        logDataVO.setRemark("更新了执行状态");
                        break;
                    case "status":
                        logDataVO.setRemark("更新了任务状态");
                        break;
                    case "taskPriority":
                        logDataVO.setRemark("更新了任务优先级");
                        break;
                    case "beginTime":
                        logDataVO.setRemark("更新了开始时间");
                        break;
                    case "endTime":
                        logDataVO.setRemark("更新了结束时间");
                        break;
                    case "closeTime":
                        logDataVO.setRemark("更新了截止时间");
                        break;
                    case "description":
                        logDataVO.setRemark("更新了描述");
                        break;
                    case "taskProcess":
                        logDataVO.setRemark("更新了任务进度");
                        break;
                }
                try {
                    Object newValue = field.get(newBean);
                    Object oldValue = field.get(oldBean);
                    if(!Objects.equals(newValue, oldValue)) {
                        LogContentVO logContentVO = new LogContentVO();
                        logContentVO.setField(field.getName());
                        logContentVO.setFieldName(field.getAnnotation(ForUpdate.class).fieldName());
                        logContentVO.setOldValue(oldValue.toString());
                        logContentVO.setNewValue(newValue.toString());
                        list.add(logContentVO);
                        logDataVO.setLogContentVOList(list);
                        data.add(logDataVO);
                    }
                } catch (Exception e) {

                }
            }
        }
        return data;
    }
}
