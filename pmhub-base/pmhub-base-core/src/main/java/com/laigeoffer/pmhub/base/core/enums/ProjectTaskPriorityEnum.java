package com.laigeoffer.pmhub.base.core.enums;

/**
 * @author canghe
 * @date 2022-12-19 17:04
 */
public enum ProjectTaskPriorityEnum {

    STAGE_0(0, "最高"),
    STAGE_1(1, "较高"),
    STAGE_2(2, "普通"),
    STAGE_3(3, "较低"),
    STAGE_4(4, "最低");
    private final Integer status;
    private final String statusName;

    ProjectTaskPriorityEnum(Integer status, String statusName) {
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
        for (ProjectTaskPriorityEnum value : ProjectTaskPriorityEnum.values()) {
            if (value.getStatus().equals(status)) {
                return value.getStatusName();
            }
        }
        return null;
    }
}
