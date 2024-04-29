package com.laigeoffer.pmhub.base.core.enums;

/**
 * @author canghe
 * @date 2022-12-14 17:09
 */
public enum ApprovalEnum {
    NO_STARTED("未审核", "0"),
    DOING("审核中", "1"),
    FINISHED("已审核", "2");
    private final String status;
    private final String statusName;

    ApprovalEnum(String status, String statusName) {
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
        for (ApprovalEnum value : ApprovalEnum.values()) {
            if (value.getStatus().equals(status)) {
                return value.getStatusName();
            }
        }
        return null;
    }

}
