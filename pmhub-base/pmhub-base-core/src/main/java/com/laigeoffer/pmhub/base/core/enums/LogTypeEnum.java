package com.laigeoffer.pmhub.base.core.enums;

/**
 * @author canghe
 * @date 2022-12-22 17:24
 */
public enum LogTypeEnum {

    TRENDS(1, "动态"),
    DELIVERABLE(2, "交付物"),
    COMMENT(3, "评论");
    private final Integer status;
    private final String statusName;

    LogTypeEnum(Integer status, String statusName) {
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
        for (LogTypeEnum value : LogTypeEnum.values()) {
            if (value.getStatus().equals(status)) {
                return value.getStatusName();
            }
        }
        return null;
    }
}
