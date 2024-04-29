package com.laigeoffer.pmhub.common.enums;

/**
 * @author canghe
 * @date 2022-12-15 17:04
 */
public enum OAMessageStatusEnum {
    NO_DEAL("0", "待处理"),
    DEAL("1", "已处理"),
    AGREE("2", "已同意"),
    REJECT("3", "已拒绝"),
    DELETE("27", "已删除"),
    PAUSE("34", "已暂停"),
    CANCEL("35", "已撤销");
    private final String status;
    private final String statusName;

    OAMessageStatusEnum(String status, String statusName) {
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
        for (OAMessageStatusEnum value : OAMessageStatusEnum.values()) {
            if (value.getStatus().equals(status)) {
                return value.getStatusName();
            }
        }
        return null;
    }
}

