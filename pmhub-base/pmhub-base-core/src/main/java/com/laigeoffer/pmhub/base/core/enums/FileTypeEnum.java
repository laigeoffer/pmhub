package com.laigeoffer.pmhub.base.core.enums;

/**
 * @author canghe
 * @date 2022-12-23 15:22
 */
public enum FileTypeEnum {

    P("project", "项目"),
    T("task", "任务"),
    M("materials", "物料");

    private final String status;
    private final String statusName;

    FileTypeEnum(String status, String statusName) {
        this.status = status;
        this.statusName = statusName;
    }

    public String getStatus() {
        return status;
    }

    public String getStatusName() {
        return statusName;
    }

    public static String getStatusNameByStatus(String status) {
        for (FileTypeEnum value : FileTypeEnum.values()) {
            if (value.getStatus().equals(status)) {
                return value.getStatusName();
            }
        }
        return null;
    }
}
