package com.laigeoffer.pmhub.workflow.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 流程实例关联表单对象 sys_instance_form
 *
 * @author canghe
 * @createTime 2022/3/7 22:07
 */
@Data
@TableName("pmhub_wf_deploy_form")
public class WfDeployForm {
    private static final long serialVersionUID = 1L;

    /**
     * 流程部署主键
     */
    @TableId(value = "deploy_id")
    private String deployId;

    /**
     * 表单Key
     */
    private String formKey;

    /**
     * 节点Key
     */
    private String nodeKey;

    /**
     * 表单名称
     */
    private String formName;

    /**
     * 节点名称
     */
    private String nodeName;

    /**
     * 表单内容
     */
    private String content;
}
