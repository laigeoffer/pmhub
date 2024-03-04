package com.laigeoffer.pmhub.web.controller.workflow;

import com.laigeoffer.pmhub.common.core.controller.BaseController;
import com.laigeoffer.pmhub.common.core.domain.PageQuery;
import com.laigeoffer.pmhub.common.core.domain.R;
import com.laigeoffer.pmhub.common.core.page.Table2DataInfo;
import com.laigeoffer.pmhub.common.utils.JsonUtils;
import com.laigeoffer.pmhub.workflow.core.domain.ProcessQuery;
import com.laigeoffer.pmhub.workflow.domain.vo.WfDeployVo;
import com.laigeoffer.pmhub.workflow.domain.vo.WfFormVo;
import com.laigeoffer.pmhub.workflow.service.IWfDeployFormService;
import com.laigeoffer.pmhub.workflow.service.IWfDeployService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Objects;

/**
 * 流程部署
 *
 * @author canghe
 * @createTime 2022/3/24 20:57
 */
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/workflow/deploy")
public class WfDeployController extends BaseController {

    private final IWfDeployService deployService;
    private final IWfDeployFormService deployFormService;

    /**
     * 查询流程部署列表
     */
    @PreAuthorize("@ss.hasPermi('workflow:deploy:list')")
    @GetMapping("/list")
    public Table2DataInfo<WfDeployVo> list(ProcessQuery processQuery, PageQuery pageQuery) {
        return deployService.queryPageList(processQuery, pageQuery);
    }

    /**
     * 查询流程部署版本列表
     */
    @PreAuthorize("@ss.hasPermi('workflow:deploy:list')")
    @GetMapping("/publishList")
    public Table2DataInfo<WfDeployVo> publishList(@RequestParam String processKey, PageQuery pageQuery) {
        return deployService.queryPublishList(processKey, pageQuery);
    }

    /**
     * 激活或挂起流程
     *
     * @param state 状态（active:激活 suspended:挂起）
     * @param definitionId 流程定义ID
     */
    @PreAuthorize("@ss.hasPermi('workflow:deploy:state')")
    @PutMapping(value = "/changeState")
    public R<Void> changeState(@RequestParam String state, @RequestParam String definitionId) {
        deployService.updateState(definitionId, state);
        return R.ok();
    }

    /**
     * 读取xml文件
     * @param definitionId 流程定义ID
     * @return
     */
    @PreAuthorize("@ss.hasPermi('workflow:deploy:query')")
    @GetMapping("/bpmnXml/{definitionId}")
    public R<String> getBpmnXml(@PathVariable(value = "definitionId") String definitionId) {
        return R.ok(null, deployService.queryBpmnXmlById(definitionId));
    }

//    /**
//     * 删除流程模型
//     * @param deployIds 流程部署ids
//     */
//    @PreAuthorize("@ss.hasPermi('workflow:deploy:remove')")
//    @Log(title = "删除流程部署", businessType = BusinessType.DELETE)
//    @DeleteMapping("/{deployIds}")
//    public R<String> remove(@NotEmpty(message = "主键不能为空") @PathVariable String[] deployIds) {
//        deployService.deleteByIds(Arrays.asList(deployIds));
//        return R.ok();
//    }

    /**
     * 查询流程部署关联表单信息
     *
     * @param deployId 流程部署id
     */
    @GetMapping("/form/{deployId}")
    public R<?> start(@PathVariable(value = "deployId") String deployId) {
        WfFormVo formVo = deployFormService.selectDeployFormByDeployId(deployId);
        if (Objects.isNull(formVo)) {
            return R.fail("请先配置流程表单");
        }
        return R.ok(JsonUtils.parseObject(formVo.getContent(), Map.class));
    }

    /**
     * 查询各类型下的审批设置
     *
     * @param type 审批类型
     */
    @GetMapping("/refApproval/{type}")
    public R<?> findApprovalByType(@PathVariable(value = "type") String type, @RequestParam(value = "taskId", required = false) String taskId) {
        return R.ok(deployService.queryApprovalSet(type, taskId));
    }

}
