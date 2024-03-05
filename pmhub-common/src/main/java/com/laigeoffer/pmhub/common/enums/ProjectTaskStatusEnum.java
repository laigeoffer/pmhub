package com.laigeoffer.pmhub.common.enums;

/**
 * @author canghe
 * @date 2022-12-14 17:09
 */
public enum ProjectTaskStatusEnum {
    NO_STARTED(0, "未开始"),
    DOING(1, "进行中"),
    FINISHED(2, "已完成"),
    OVERDUE(3, "已逾期"),
    NO_CLAIMED(4, "待认领");
    private final Integer status;
    private final String statusName;

    ProjectTaskStatusEnum(Integer status, String statusName) {
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
        for (ProjectTaskStatusEnum value : ProjectTaskStatusEnum.values()) {
            if (value.getStatus().equals(status)) {
                return value.getStatusName();
            }
        }
        return null;
    }

}
