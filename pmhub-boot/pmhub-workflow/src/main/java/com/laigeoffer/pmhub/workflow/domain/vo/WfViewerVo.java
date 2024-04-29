package com.laigeoffer.pmhub.workflow.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

/**
 * 任务追踪视图对象
 *
 * @author canghe
 * @createTime 2022/1/8 19:42
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ExcelIgnoreUnannotated
public class WfViewerVo {

    /**
     * 获取流程实例的历史节点（去重）
     */
    private Set<String> finishedTaskSet;

    /**
     * 已完成
     */
    private Set<String> finishedSequenceFlowSet;

    /**
     * 获取流程实例当前正在待办的节点（去重）
     */
    private Set<String> unfinishedTaskSet;

    /**
     * 已拒绝
     */
    private Set<String> rejectedTaskSet;
}
