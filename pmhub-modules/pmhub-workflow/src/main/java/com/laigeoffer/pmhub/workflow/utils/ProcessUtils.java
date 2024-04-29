package com.laigeoffer.pmhub.workflow.utils;

import com.laigeoffer.pmhub.base.core.utils.DateUtils;
import com.laigeoffer.pmhub.base.core.utils.StringUtils;
import com.laigeoffer.pmhub.workflow.core.domain.ProcessQuery;
import org.flowable.common.engine.api.query.Query;
import org.flowable.common.engine.impl.db.SuspensionState;
import org.flowable.engine.history.HistoricProcessInstanceQuery;
import org.flowable.engine.repository.ProcessDefinitionQuery;
import org.flowable.task.api.TaskQuery;
import org.flowable.task.api.history.HistoricTaskInstanceQuery;

import java.util.Map;

/**
 * 流程工具类
 *
 * @author canghe
 * @since 2022/12/11 03:35
 */
public class ProcessUtils {


    /**
     * 任务详情url的key
     * */
    public static final String TASK_DETAIL_URL_KEY = "taskDetailUrl";

    public static final String LEADER_LIST = "startUserLeaderList";
    public static final String APPROVAL_TYPE = "approval_type";
    public static final String TASK_APPROVAL_TYPE = "task";
    public static final String PROJECT_APPROVAL_TYPE = "project";
    public static final String PURCHASE_INTO_APPROVAL_TYPE = "PURCHASE_INTO";
    public static final String PURCHASE_OUT_APPROVAL_TYPE = "PURCHASE_OUT";
    public static final String OTHER_INTO_APPROVAL_TYPE = "OTHER_INTO";
    public static final String OTHER_OUT_APPROVAL_TYPE = "OTHER_OUT";
    public static final String RETURN_INTO_APPROVAL_TYPE = "RETURN_INTO";
    public static final String SUPPLIER_APPROVAL_TYPE = "SUPPLIER_APPROVAL";
    public static final String SCRAPPED_OUT_APPROVAL_TYPE = "USELESS_OUT";

    public static void buildProcessSearch(Query<?, ?> query, ProcessQuery process) {
        if (query instanceof ProcessDefinitionQuery) {
            buildProcessDefinitionSearch((ProcessDefinitionQuery) query, process);
        } else if (query instanceof TaskQuery) {
            buildTaskSearch((TaskQuery) query, process);
        } else if (query instanceof HistoricTaskInstanceQuery) {
            buildHistoricTaskInstanceSearch((HistoricTaskInstanceQuery) query, process);
        } else if (query instanceof HistoricProcessInstanceQuery) {
            buildHistoricProcessInstanceSearch((HistoricProcessInstanceQuery) query, process);
        }
    }

    /**
     * 构建流程定义搜索
     */
    public static void buildProcessDefinitionSearch(ProcessDefinitionQuery query, ProcessQuery process) {
        // 流程标识
        if (StringUtils.isNotBlank(process.getProcessKey())) {
            query.processDefinitionKeyLike("%" + process.getProcessKey() + "%");
        }
        // 流程名称
        if (StringUtils.isNotBlank(process.getProcessName())) {
            query.processDefinitionNameLike("%" + process.getProcessName() + "%");
        }
        // 流程分类
        if (StringUtils.isNotBlank(process.getCategory())) {
            query.processDefinitionCategory(process.getCategory());
        }
        // 流程状态
        if (StringUtils.isNotBlank(process.getState())) {
            if (SuspensionState.ACTIVE.toString().equals(process.getState())) {
                query.active();
            } else if (SuspensionState.SUSPENDED.toString().equals(process.getState())) {
                query.suspended();
            }
        }
    }

    /**
     * 构建任务搜索
     */
    public static void buildTaskSearch(TaskQuery query, ProcessQuery process) {
        Map<String, Object> params = process.getParams();
        if (StringUtils.isNotBlank(process.getProcessKey())) {
            query.processDefinitionKeyLike("%" + process.getProcessKey() + "%");
        }
        if (StringUtils.isNotBlank(process.getProcessName())) {
            query.processDefinitionNameLike("%" + process.getProcessName() + "%");
        }
        if (params.get("beginTime") != null && params.get("endTime") != null) {
            query.taskCreatedAfter(DateUtils.parseDate(params.get("beginTime")));
            query.taskCreatedBefore(DateUtils.parseDate(params.get("endTime")));
        }
    }

    private static void buildHistoricTaskInstanceSearch(HistoricTaskInstanceQuery query, ProcessQuery process) {
        Map<String, Object> params = process.getParams();
        if (StringUtils.isNotBlank(process.getProcessKey())) {
            query.processDefinitionKeyLike("%" + process.getProcessKey() + "%");
        }
        if (StringUtils.isNotBlank(process.getProcessName())) {
            query.processDefinitionNameLike("%" + process.getProcessName() + "%");
        }
        if (params.get("beginTime") != null && params.get("endTime") != null) {
            query.taskCompletedAfter(DateUtils.parseDate(params.get("beginTime")));
            query.taskCompletedBefore(DateUtils.parseDate(params.get("endTime")));
        }
    }

    /**
     * 构建历史流程实例搜索
     */
    public static void buildHistoricProcessInstanceSearch(HistoricProcessInstanceQuery query, ProcessQuery process) {
        Map<String, Object> params = process.getParams();
        // 流程标识
        if (StringUtils.isNotBlank(process.getProcessKey())) {
            query.processDefinitionKey(process.getProcessKey());
        }
        // 流程名称
        if (StringUtils.isNotBlank(process.getProcessName())) {
            query.processDefinitionName(process.getProcessName());
        }
        // 流程名称
        if (StringUtils.isNotBlank(process.getCategory())) {
            query.processDefinitionCategory(process.getCategory());
        }
        if (params.get("beginTime") != null && params.get("endTime") != null) {
            query.startedAfter(DateUtils.parseDate(params.get("beginTime")));
            query.startedBefore(DateUtils.parseDate(params.get("endTime")));
        }
    }

}
