package com.laigeoffer.pmhub.workflow.controller;

import cn.hutool.core.util.ObjectUtil;
import com.laigeoffer.pmhub.base.core.core.domain.R;
import com.laigeoffer.pmhub.base.security.annotation.RequiresPermissions;
import com.laigeoffer.pmhub.workflow.domain.bo.WfTaskBo;
import com.laigeoffer.pmhub.workflow.service.IWfTaskService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * 工作流任务管理
 *
 * @author canghe
 * @createTime 2022/3/10 00:12
 */
@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/workflow/task")
public class WfTaskController {

    private final IWfTaskService flowTaskService;

    /**
     * 取消申请
     */
    @PostMapping(value = "/stopProcess")
    @RequiresPermissions("workflow:process:cancel")
    public R stopProcess(@RequestBody WfTaskBo bo) {
        flowTaskService.stopProcess(bo);
        return R.ok();
    }

    /**
     * 撤回流程
     */
    @PostMapping(value = "/revokeProcess")
    @RequiresPermissions("workflow:process:revoke")
    public R revokeProcess(@RequestBody WfTaskBo bo) {
        flowTaskService.revokeProcess(bo);
        return R.ok();
    }

    /**
     * 获取流程变量
     * @param taskId 流程任务Id
     */
    @GetMapping(value = "/processVariables/{taskId}")
    @RequiresPermissions("workflow:process:query")
    public R processVariables(@PathVariable(value = "taskId") String taskId) {
        return R.ok(flowTaskService.getProcessVariables(taskId));
    }

    /**
     * 审批任务
     */
    @PostMapping(value = "/complete")
    @RequiresPermissions("workflow:process:approval")
    public R complete(@RequestBody WfTaskBo bo) {
        flowTaskService.complete(bo);
        return R.ok();
    }

    /**
     * 拒绝任务
     */
    @PostMapping(value = "/reject")
    @RequiresPermissions("workflow:process:approval")
    public R taskReject(@RequestBody WfTaskBo taskBo) {
        flowTaskService.taskReject(taskBo);
        return R.ok();
    }

    /**
     * 退回任务
     */
    @PostMapping(value = "/return")
    @RequiresPermissions("orkflow:process:approval")
    public R taskReturn(@RequestBody WfTaskBo bo) {
        flowTaskService.taskReturn(bo);
        return R.ok();
    }

    /**
     * 获取所有可回退的节点
     */
    @PostMapping(value = "/returnList")
    @RequiresPermissions("workflow:process:query")
    public R findReturnTaskList(@RequestBody WfTaskBo bo) {
        return R.ok(flowTaskService.findReturnTaskList(bo));
    }

    /**
     * 删除任务
     */
    @DeleteMapping(value = "/delete")
    @RequiresPermissions("orkflow:process:approval")
    public R delete(@RequestBody WfTaskBo bo) {
        flowTaskService.deleteTask(bo);
        return R.ok();
    }

    /**
     * 认领/签收任务
     */
    @PostMapping(value = "/claim")
    @RequiresPermissions("workflow:process:claim")
    public R claim(@RequestBody WfTaskBo bo) {
        flowTaskService.claim(bo);
        return R.ok();
    }

    /**
     * 取消认领/签收任务
     */
    @PostMapping(value = "/unClaim")
    @RequiresPermissions("workflow:process:claim")
    public R unClaim(@RequestBody WfTaskBo bo) {
        flowTaskService.unClaim(bo);
        return R.ok();
    }

    /**
     * 委派任务
     */
    @PostMapping(value = "/delegate")
    @RequiresPermissions("workflow:process:approval")
    public R delegate(@RequestBody WfTaskBo bo) {
        if (ObjectUtil.hasNull(bo.getTaskId(), bo.getUserId())) {
            return R.fail("参数错误！");
        }
        flowTaskService.delegateTask(bo);
        return R.ok();
    }

    /**
     * 转办任务
     */
    @PostMapping(value = "/transfer")
    @RequiresPermissions("workflow:process:approval")
    public R transfer(@RequestBody WfTaskBo bo) {
        if (ObjectUtil.hasNull(bo.getTaskId(), bo.getUserId())) {
            return R.fail("参数错误！");
        }
        flowTaskService.transferTask(bo);
        return R.ok();
    }

    /**
     * 生成流程图
     *
     * @param processId 任务ID
     */
    @RequestMapping("/diagram/{processId}")
    public void genProcessDiagram(HttpServletResponse response,
                                  @PathVariable("processId") String processId) {
        InputStream inputStream = flowTaskService.diagram(processId);
        OutputStream os = null;
        BufferedImage image = null;
        try {
            image = ImageIO.read(inputStream);
            response.setContentType("image/png");
            os = response.getOutputStream();
            if (image != null) {
                ImageIO.write(image, "png", os);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
