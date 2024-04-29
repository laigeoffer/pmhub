package com.laigeoffer.pmhub.common.enums;

/**
 * @author canghe
 * @date 2022-12-15 17:04
 */
public enum ProjectStatusEnum {
    NO_STARTED(0, "未开始"),
    DOING(1, "进行中"),
    OVERDUE(3, "已逾期"),
    ARCHIVED(2, "已归档"),
    PAUSE(4, "已暂停"),
    PROJECT(99, "project"),
    TASK(100, "task"),
    TEMPLATE(101, "template");
    private final Integer status;
    private final String statusName;

    ProjectStatusEnum(Integer status, String statusName) {
        this.status = status;
        this.statusName = statusName;
    }

    public Integer getStatus() {
        return status;
    }

    public String getStatusName() {
        return statusName;
    }

    public static String getStatusNameByStatus(Integer status) {
        for (ProjectStatusEnum value : ProjectStatusEnum.values()) {
            if (value.getStatus().equals(status)) {
                return value.getStatusName();
            }
        }
        return null;
    }
}

