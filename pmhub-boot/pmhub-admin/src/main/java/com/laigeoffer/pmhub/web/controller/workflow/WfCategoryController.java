package com.laigeoffer.pmhub.web.controller.workflow;

import com.laigeoffer.pmhub.common.annotation.Log;
import com.laigeoffer.pmhub.common.annotation.RepeatSubmit;
import com.laigeoffer.pmhub.common.constant.UserConstants;
import com.laigeoffer.pmhub.common.core.controller.BaseController;
import com.laigeoffer.pmhub.common.core.domain.PageQuery;
import com.laigeoffer.pmhub.common.core.domain.R;
import com.laigeoffer.pmhub.common.core.page.Table2DataInfo;
import com.laigeoffer.pmhub.common.core.validate.AddGroup;
import com.laigeoffer.pmhub.common.core.validate.EditGroup;
import com.laigeoffer.pmhub.common.core.validate.QueryGroup;
import com.laigeoffer.pmhub.common.enums.BusinessType;
import com.laigeoffer.pmhub.common.utils.poi.ExcelUtil;
import com.laigeoffer.pmhub.workflow.domain.bo.WfCategoryBo;
import com.laigeoffer.pmhub.workflow.domain.vo.WfCategoryVo;
import com.laigeoffer.pmhub.workflow.service.IWfCategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Arrays;
import java.util.List;

/**
 * 流程分类Controller
 *
 * @author canghe
 * @createTime 2022/3/10 00:12
 */
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/workflow/category")
public class WfCategoryController extends BaseController {

    private final IWfCategoryService categoryService;

    /**
     * 查询流程分类列表
     */
    @PreAuthorize("@ss.hasPermi('workflow:category:list')")
    @GetMapping("/list")
    public Table2DataInfo<WfCategoryVo> list(@Validated(QueryGroup.class) WfCategoryBo bo, PageQuery pageQuery) {
        return categoryService.queryPageList(bo, pageQuery);
    }

    /**
     * 查询全部的流程分类列表
     */
    @PreAuthorize("@ss.hasPermi('workflow:category:listAll')")
    @GetMapping("/listAll")
    public R<List<WfCategoryVo>> listAll(@Validated(QueryGroup.class) WfCategoryBo bo) {
        return R.ok(categoryService.queryList(bo));
    }

    /**
     * 导出流程分类列表
     */
    @PreAuthorize("@ss.hasPermi('workflow:category:export')")
    @Log(title = "流程分类", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(@Validated WfCategoryBo bo, HttpServletResponse response) {
        List<WfCategoryVo> list = categoryService.queryList(bo);
        ExcelUtil.exportExcel2(list, "流程分类", WfCategoryVo.class, response);
    }

    /**
     * 获取流程分类详细信息
     * @param categoryId 分类主键
     */
    @PreAuthorize("@ss.hasPermi('workflow:category:query')")
    @GetMapping("/{categoryId}")
    public R<WfCategoryVo> getInfo(@NotNull(message = "主键不能为空") @PathVariable("categoryId") Long categoryId) {
        return R.ok(categoryService.queryById(categoryId));
    }

    /**
     * 新增流程分类
     */
    @PreAuthorize("@ss.hasPermi('workflow:category:add')")
    @Log(title = "流程分类", businessType = BusinessType.INSERT)
    @RepeatSubmit()
    @PostMapping()
    public R<Void> add(@Validated(AddGroup.class) @RequestBody WfCategoryBo categoryBo) {
        if (UserConstants.NOT_UNIQUE.equals(categoryService.checkCategoryCodeUnique(categoryBo.getCode()))) {
            return R.fail("新增流程分类'" + categoryBo.getCategoryName() + "'失败，流程编码已存在");
        }
        return toAjax2(categoryService.insertCategory(categoryBo));
    }

    /**
     * 修改流程分类
     */
    @PreAuthorize("@ss.hasPermi('workflow:category:edit')")
    @Log(title = "流程分类", businessType = BusinessType.UPDATE)
    @RepeatSubmit()
    @PutMapping()
    public R<Void> edit(@Validated(EditGroup.class) @RequestBody WfCategoryBo categoryBo) {
        if (UserConstants.NOT_UNIQUE.equals(categoryService.checkCategoryCodeUnique(categoryBo.getCode()))) {
            return R.fail("修改流程分类'" + categoryBo.getCategoryName() + "'失败，流程编码已存在");
        }
        return toAjax2(categoryService.updateCategory(categoryBo));
    }

    /**
     * 删除流程分类
     * @param categoryIds 分类主键串
     */
    @PreAuthorize("@ss.hasPermi('workflow:category:remove')")
    @Log(title = "流程分类" , businessType = BusinessType.DELETE)
    @DeleteMapping("/{categoryIds}")
    public R<Void> remove(@NotEmpty(message = "主键不能为空") @PathVariable Long[] categoryIds) {
        return toAjax2(categoryService.deleteWithValidByIds(Arrays.asList(categoryIds), true));
    }
}
