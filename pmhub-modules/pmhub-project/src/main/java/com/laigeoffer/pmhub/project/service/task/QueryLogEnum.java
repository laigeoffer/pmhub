package com.laigeoffer.pmhub.project.service.task;

/**
 * @author canghe
 * @date 2023-01-09 16:24
 */
public enum QueryLogEnum {
    ALL(-1, "queryAllLogExecutor"),
    TRENDS(1, "queryTrendsLogExecutor"),
    DELIVERABLE(2, "queryDeliverableLogExecutor"),
    COMMENT(3, "queryCommentLogExecutor");
    private final Integer type;
    private final String beanName;

    QueryLogEnum(Integer type, String beanName) {
        this.type = type;
        this.beanName = beanName;
    }

    public Integer getType() {
        return type;
    }

    public String getBeanName() {
        return beanName;
    }
}
