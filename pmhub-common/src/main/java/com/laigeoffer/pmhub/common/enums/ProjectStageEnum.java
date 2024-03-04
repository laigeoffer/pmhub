package com.laigeoffer.pmhub.common.enums;

/**
 * @author canghe
 * @date 2022-12-19 17:04
 */
public enum ProjectStageEnum {

    STAGE_0(0, "项目立项阶段"),
    STAGE_1(1, "研发设计输入阶段"),
    STAGE_2(2, "研发实施阶段"),
    STAGE_3(3, "交付验收阶段"),
    STAGE_4(4, "新产品导出阶段");
    private final Integer status;
    private final String statusName;

    ProjectStageEnum(Integer status, String statusName) {
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
        for (ProjectStageEnum value : ProjectStageEnum.values()) {
            if (value.getStatus().equals(status)) {
                return value.getStatusName();
            }
        }
        return null;
    }
}
