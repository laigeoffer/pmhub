package com.laigeoffer.pmhub.project.service.project;

/**
 * @author canghe
 * @date 2023-01-09 11:37
 */
public enum QueryProjectEnum {

    MY("my", "queryMyProjectExecutor"),
    COLLECT("collect", "queryMyCollectProjectExecutor"),
    RECYCLE("recycle", "queryRecycleProjectExecutor");
    private final String type;
    private final String beanName;

    QueryProjectEnum(String type, String beanName) {
        this.type = type;
        this.beanName = beanName;
    }

    public String getType() {
        return type;
    }

    public String getBeanName() {
        return beanName;
    }
}
