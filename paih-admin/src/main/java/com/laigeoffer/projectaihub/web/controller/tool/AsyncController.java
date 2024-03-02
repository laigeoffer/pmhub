package com.laigeoffer.projectaihub.web.controller.tool;

import com.laigeoffer.projectaihub.common.core.controller.BaseController;
import com.laigeoffer.projectaihub.common.core.domain.AjaxResult;
import com.laigeoffer.projectaihub.common.core.page.TableDataInfo;
import com.laigeoffer.projectaihub.system.domain.PaihAsync;
import com.laigeoffer.projectaihub.system.service.IPaihAsyncService;
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
    IPaihAsyncService iPaihAsyncService;


    /**
     * 查询异步任务
     * @param paihAsync
     * @return {@link TableDataInfo}
     */
    @GetMapping("/list")
    public TableDataInfo list(PaihAsync paihAsync) {
        startPage();
        paihAsync.setCreateBy(getUsername());
        return getDataTable(iPaihAsyncService.list(paihAsync));
    }

    /**
     * 删除异步任务
     * @param asyncIds
     * @return {@link TableDataInfo}
     */
    @DeleteMapping("/delete/{asyncIds}")
    public AjaxResult delete(@PathVariable String[] asyncIds) {
        iPaihAsyncService.delete(asyncIds);
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
        iPaihAsyncService.downloadFile(id,getUsername(),response);
    }

}
