package com.laigeoffer.pmhub.web.controller.tool;

import com.laigeoffer.pmhub.common.core.controller.BaseController;
import com.laigeoffer.pmhub.common.core.domain.AjaxResult;
import com.laigeoffer.pmhub.common.core.page.TableDataInfo;
import com.laigeoffer.pmhub.system.domain.PmhubAsync;
import com.laigeoffer.pmhub.system.service.IPmhubAsyncService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;

/**
 * swagger 接口
 *
 * @author canghe
 */
@RestController
@RequestMapping("/tool/async")
public class AsyncController extends BaseController {

    @Autowired
    IPmhubAsyncService iPmhubAsyncService;


    /**
     * 查询异步任务
     * @param pmhubAsync
     * @return {@link TableDataInfo}
     */
    @GetMapping("/list")
    public TableDataInfo list(PmhubAsync pmhubAsync) {
        startPage();
        pmhubAsync.setCreateBy(getUsername());
        return getDataTable(iPmhubAsyncService.list(pmhubAsync));
    }

    /**
     * 删除异步任务
     * @param asyncIds
     * @return {@link TableDataInfo}
     */
    @DeleteMapping("/delete/{asyncIds}")
    public AjaxResult delete(@PathVariable String[] asyncIds) {
        iPmhubAsyncService.delete(asyncIds);
        return AjaxResult.success("success");
    }

    /**
     * 下载附件
     *
     * @param id       包含任务id
     * @param response HttpServletResponse
     */
    @PostMapping("/download")
    public void downloadPost(String id, HttpServletResponse response) {
        iPmhubAsyncService.downloadFile(id,getUsername(),response);
    }

}
