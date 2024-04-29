package com.laigeoffer.pmhub.workflow.enums;


import com.laigeoffer.pmhub.base.core.enums.OAMessageStatusEnum;

/**
 * 任务完成时的状态
 * @author canghe
 */
public enum TaskCompletedStateEnum {

    /**
     * 通过
     * */
    PASS("已通过"),

    /**
     * 退回
     * */
    RETURN("已退回"),

    /**
     * 驳回
     * */
    REJECT("已驳回"),

    /**
     * 委派
     * */
    APPOINT("已委派"),

    /**
     * 转办
     * */
    TRANSFER("已转办"),

    /**
     * 终止
     * */
    STOP("已终止"),

    /**
     * 撤回
     * */
    RECALL("已撤回");


    private String desc;

    TaskCompletedStateEnum(String desc) {
        this.desc = desc;
    }

    @Override
    public String toString(){
        return desc;
    }

    public static TaskCompletedStateEnum getTaskCompletedStateEnum(int code){
        switch (code){
            case 1:
                return TaskCompletedStateEnum.PASS;
            case 2:
                return TaskCompletedStateEnum.RETURN;
            case 3:
                return TaskCompletedStateEnum.REJECT;
            case 4:
                return TaskCompletedStateEnum.APPOINT;
            case 5:
                return TaskCompletedStateEnum.TRANSFER;
            case 6:
                return TaskCompletedStateEnum.STOP;
            case 7:
                return TaskCompletedStateEnum.RECALL;
            default:
                return null;
        }
    }

    public static String getStatusByStatusName(String status) {
        switch (status) {
            case "已通过":
                return OAMessageStatusEnum.AGREE.getStatus();
            case "已驳回":
                return OAMessageStatusEnum.REJECT.getStatus();
            default:
                return OAMessageStatusEnum.DEAL.getStatus();
        }
    }
}
