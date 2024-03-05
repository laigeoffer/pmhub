package com.laigeoffer.pmhub.workflow.listener.strategy;

/**
 * @author canghe
 * @date 2023-07-11 09:25
 */
public enum ListenerTypeEnum {

    PROJECT("project", "projectListenerExecutor"),
    TASK("task", "taskListenerExecutor"),
    PURCHASE_INTO("PURCHASE_INTO", "purchaseIntoListenerExecutor"),
    PURCHASE_OUT("PURCHASE_OUT", "purchaseOutListenerExecutor"),
    OTHER_INTO("OTHER_INTO", "otherIntoListenerExecutor"),
    OTHER_OUT("OTHER_OUT", "otherOutListenerExecutor"),
    RETURN_INTO("RETURN_INTO", "returnIntoListenerExecutor"),
    SUPPLIER_APPROVAL("SUPPLIER_APPROVAL", "supplierApprovalListenerExecutor"),
    SCRAPPED_OUT("USELESS_OUT", "scrappedOutListenerExecutor");
    private final String type;
    private final String beanName;
    ListenerTypeEnum(String type, String beanName) {
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
