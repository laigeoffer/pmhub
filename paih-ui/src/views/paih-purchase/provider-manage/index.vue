<template>
  <div class="app-container">
    <el-card shadow="never" class="search-wrapper">
      <el-form :model="queryParams" ref="queryForm" :inline="true">
        <el-form-item label="名称" prop="providerName">
          <el-input v-model="queryParams.providerName" placeholder="请输入" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item label="手机号码" prop="providerPhone">
          <el-input v-model="queryParams.providerPhone" placeholder="请输入" @keyup.enter.native="handleQuery" />
        </el-form-item>

        <el-form-item label="联系电话" prop="providerTell">
          <el-input v-model="queryParams.providerTell" placeholder="请输入" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item prop="state" label="审批状态">
          <el-select v-model="queryParams.state" clearable placeholder="请选择">
            <el-option label="正式" value="1"> </el-option>
            <el-option label="试用" value="0"> </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleQuery">查询</el-button>
          <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card shadow="never" class="toolbar-wrapper">
      <el-button type="primary" icon="el-icon-plus" @click="handleAdd">新增</el-button>
      <el-button type="primary" icon="el-icon-upload2" @click="handleImport">导入</el-button>
      <el-button type="primary" icon="el-icon-download" @click="handleExport">导出</el-button>
      <el-button type="danger" :disabled="multiple" @click="handleBatchDelete">批量删除</el-button>
      <el-button type="warning" @click="handleSetApproval">审批设置</el-button>
    </el-card>

    <el-table
      v-loading="loading"
      :data="providermanageList"
      @row-dblclick="handleRowClick"
      highlight-current-row
      :row-style="{ cursor: 'pointer' }"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" align="center" prop="providerEncoding" />
      <el-table-column label="名称" align="center" prop="providerName" />
      <el-table-column label="联系人" align="center" prop="providerCharger" />
      <el-table-column label="手机号码" align="center" prop="providerPhone" />
      <el-table-column label="联系电话" align="center" prop="providerTell" />
      <el-table-column label="电子邮箱" align="center" prop="providerEmail" />
      <el-table-column label="期初应付" align="center" prop="earlypay" />
      <el-table-column label="期末应付" align="center" prop="endpay" />
      <el-table-column label="税率（%）" align="center" prop="rate" />
      <el-table-column label="排序" align="center" prop="providerOrder" />
      <el-table-column label="状态" align="center" prop="providerStatus">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.providerStatus == 0" type="info">试用</el-tag>
          <el-tag v-else-if="scope.row.providerStatus == 1" type="success">正式</el-tag>
          <span v-else>未知状态</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="170">
        <template slot-scope="scope">
          <el-button type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)">编辑</el-button>
          <el-button type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" style="color: #f56c6c">
            删除
          </el-button>
          <el-dropdown @command="(command) => handleCommand(command, scope.row)">
            <el-button type="text" icon="el-icon-d-arrow-right">更多</el-button>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="approval">审批</el-dropdown-item>
              <el-dropdown-item command="approvalProgress">审批进度</el-dropdown-item>
              <el-dropdown-item command="returnProbation">转为试用</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      background
      :page-sizes="[10, 50, 100, 200]"
      layout="total, prev, pager, next,sizes, jumper"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    >
    </pagination>

    <!-- 添加或修改供应商管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="名称" prop="providerName">
              <el-input v-model="form.providerName" placeholder="请输入名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系人" prop="providerCharger">
              <el-input v-model="form.providerCharger" placeholder="请输入联系人" />
            </el-form-item>
          </el-col>
        </el-row>

   
        <el-row>
          <el-col :span="12">
                <el-form-item prop="providerCategoryId" label="类别">
                  <template slot="label">
                    <span>类别</span>
                    <el-tooltip content="请移步至采购管理-供应商类别，添加对应类别">
                      <i class="el-icon-question" style="margin-left: 5px" />
                    </el-tooltip>
                  </template>
                  <div style="display: flex">
                    <treeselect
                      style="width: 217px"
                      v-model="form.providerCategoryId"
                      :options="providerTypeOptions"
                      :normalizer="normalizer"
                      :disable-branch-nodes="false"
                      :show-count="true"
                      placeholder="请选择"
                      :disabled="title === '详情'"
                      noChildrenText="无数据"
                      noOptionsText="无数据"
                      noResultsText="无数据"
                      :flat="true"
                      @select="changeProviderTypeId"
                    />
                    <router-link to="/paih-purchase/provider-sort">
                      <el-button type="text" style="margin-left: 10px">去添加</el-button>
                    </router-link>
                  </div>
                </el-form-item>
          </el-col>

          <el-col :span="12">
            <el-form-item prop="providerEncoding" label="供应商编码">
                  <template slot="label">
                    <span>编码</span>
                    <el-tooltip>
                      <div slot="content">
                        供应商编码默认根据公司确定的物料编码规则进行自动编码，<br />您只需选择对应供应商类别即可。
                      </div>
                      <i class="el-icon-question" style="margin-left: 5px" />
                    </el-tooltip>
                  </template>
                  <el-input
                    v-if="title === '编辑'"
                    v-model="form.providerEncoding"
                    placeholder="请输入"
                    :disabled="true"
                  />
                  <el-input v-else v-model="form.providerEncoding" placeholder="请输入"  :disabled="true" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="手机号码" prop="providerPhone">
              <el-input v-model="form.providerPhone" placeholder="请输入手机号码" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系电话" prop="providerTell">
              <el-input v-model="form.providerTell" placeholder="请输入联系电话" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="电子邮件" prop="providerEmail">
              <el-input v-model="form.providerEmail" placeholder="请输入电子邮件" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="传真" prop="providerFax">
              <el-input v-model="form.providerFax" placeholder="请输入传真" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="期初应付" prop="earlypay">
              <el-input v-model="form.earlypay" placeholder="请输入期初应付" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="期末应付" prop="endpay">
              <el-input v-model="form.endpay" placeholder="请输入期末应付" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="纳税人识别号" prop="endPay">
              <el-input v-model="form.tin" placeholder="请输入纳税人识别号" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="税率（%）" prop="rate">
              <el-input v-model="form.rate" placeholder="请输入税率" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="开户行" prop="bank">
              <el-input v-model="form.providerBank" placeholder="请输入开户行" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="账号" prop="providerAccount">
              <el-input v-model="form.providerAccount" placeholder="请输入账号" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="地址" prop="providerAddress">
              <el-input v-model="form.providerAddress" placeholder="请输入地址" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="排序" prop="providerOrder">
              <el-input v-model="form.providerOrder" placeholder="请输入排序" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="24">
            <el-form-item label="备注" prop="providerNote">
              <el-input
                v-model="form.providerNote"
                placeholder="请输入备注"
                type="textarea"
                :autosize="{ minRows: 2 }"
              />
            </el-form-item>
          </el-col>
        </el-row>

        


      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 供应商商导入对话框 -->
    <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" append-to-body>
      <el-upload
        ref="upload"
        :limit="1"
        accept=".xlsx, .xls"
        :headers="upload.headers"
        :action="upload.url + '?updateSupport=' + upload.updateSupport"
        :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress"
        :on-success="handleFileSuccess"
        :auto-upload="false"
        drag
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <div class="el-upload__tip text-center" slot="tip">
          <div class="el-upload__tip" slot="tip">
            <el-checkbox v-model="upload.updateSupport" />
            是否更新已经存在的用户数据
          </div>
          <span>仅允许导入 xls、xlsx 格式文件 </span>
          <el-link
            type="primary"
            :underline="false"
            style="font-size: 12px; vertical-align: baseline"
            @click="importTemplate"
          >
            下载模板
          </el-link>
        </div>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFileForm">确 定</el-button>
        <el-button @click="upload.open = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 任务设置对话框 -->
    <SetApprovalDialog
      :visible.sync="setApprovalDialogVisible"
      :workFlowable="workFlowable"
      :getTableData="getList"
      :approvalSetApi="approvalSetApi"
    />
    <!-- 发起审批对话框 -->
    <Start
      :visible.sync="startDialogVisible"
      :id="id"
      :workFlowable="workFlowable"
      :getTableData="getList"
      :startProcessApi="startProcessApi"
      :info="info"
    />
  </div>
</template>

<script>
import {
  getProviderManage,
  listProviderManage,
  addProviderManage,
  updateProviderManage,
  delProviderManage,
  approvalSetApi,
  startProcessApi,
  returnProviderProbation,
  getCodeByType,
} from "@/api/paih-purchase/provider-manage.js"
import { listProviderSort } from "@/api/paih-purchase/provider-sort.js"
import { getApprovalSetApi } from "@/api/public/public.js"
import { getToken } from "@/utils/auth"
import SetApprovalDialog from "@/components/Approval/SetApprovalDialog.vue"
import Start from "@/components/Approval/Start.vue"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"
import { normalizer } from "./util.js"

export default {
  name: "ProviderManage",
  components: { Treeselect, SetApprovalDialog, Start },


  data() {
    return {
      // 遮罩层
      loading: false,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 总条数
      total: 0,
      // 仓库管理表格数据
      providermanageList: [{ providerId: 1, providerName: 1, providerCharger: 1 }],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        providerName: null,
        state: null,
        providerPhone: null,
        providerTell: null,
      },
      // 表单参数
      form: {},
      // 采购导入参数
      upload: {
        // 是否显示弹出层（采购导入）
        open: false,
        // 弹出层标题（采购导入）
        title: "",
        // 是否禁用上传
        isUploading: false,
        // 是否更新已经存在的用户数据
        updateSupport: 0,
        // 设置上传的请求头部
        headers: { Authorization: "Bearer " + getToken() },
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + "/paih-purchase/providerManage/importData",
      },
      // 表单校验
      rules: {
        providerName: [
          {
            required: true,
            message: "供应商名称不能为空",
            trigger: "blur",
          },
        ],
        providerCategoryId: [
          {
            required: true,
            message: "供应商类别不能为空",
            trigger: "blur",
          },
        ],
      },

      /** 任务设置对话框 */
      setApprovalDialogVisible: false,
      workFlowable: {},
      approvalSetApi,

      /** 发起审批对话框 */
      startDialogVisible: false,
      id: "",
      startProcessApi,
      info: {},

      // 供应商分类下拉框
      providerTypeOptions: [],
    }
  },
  created() {
    this.getList()
  },
  mounted() {
    this.getApprovalSet()

    // 查询类别
    listProviderSort().then((res) => {
      this.providerTypeOptions = res.data
    })
    
  },
  methods: {
    /** 查询供应商列表 */
    getList() {
      this.loading = true
      listProviderManage(this.queryParams)
        .then((response) => {
          this.providermanageList = response.rows
          this.total = response.total
        })
        .finally(() => {
          this.loading = false
        })
    },

    normalizer(node) {
      return normalizer(node)
    },

    // 选择供应商分类
    changeProviderTypeId(node) {
      // 编辑状态下，判断分类是否有改变，没有改变则不调用接口
      if (this.title === "编辑" && this.form.providerCategoryId === node.id) {
        return
      }

      getCodeByType(node.id).then((res) => {
        this.form.providerEncoding = res.data
      })
    },
   



    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        providerId: null,
        providerName: null,
        providerAddress: null,
        providerCharger: null,
        providerOrder: null,
        providerNote: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        providerCategoryId: null,
        providerEncoding: null,
        // newProviderEncoding: null,//编辑时才有该字段
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.loading = true
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleRowClick(row, column) {
      this.handleUpdate(row)
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "新增"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      this.open = true
      getProviderManage(id).then((response) => {
        this.form = response.data
        // 如果providerCategoryid为空字符串，需要将其设置为null
        if (this.form.providerCategoryId === "") {
          this.form.providerCategoryId = null
        }
        this.open = true
        this.title = "编辑"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          if (this.form.id != undefined) {
            updateProviderManage(this.form).then((response) => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addProviderManage(this.form).then((response) => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row, ids) {
      const providerIds = row.id || ids
      this.$modal
        .confirm(`是否确认删除编号为 ${row.providerEncoding} 的数据项？`)
        .then(function () {
          return delProviderManage(providerIds)
        })
        .then(() => {
          this.getList()
          this.$modal.msgSuccess("删除成功")
        })
        .catch(() => {})
    },

    /*  导入按钮操作 */
    handleImport() {
      this.upload.title = "供应商导入"
      this.upload.open = true
    },

    /** 下载模板操作 */
    importTemplate() {
      this.download("paih-purchase/providerManage/importTemplate", {}, `provider_template_${new Date().getTime()}.xlsx`)
    },
    // 文件上传中处理
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true
    },
    // 文件上传成功处理
    handleFileSuccess(response, file, fileList) {
      this.upload.open = false
      this.upload.isUploading = false
      this.$refs.upload.clearFiles()
      this.$alert(
        "<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" +
          response.msg +
          "</div>",
        "导入结果",
        { dangerouslyUseHTMLString: true }
      )
      this.getList()
    },

    // 提交上传文件
    submitFileForm() {
      this.$refs.upload.submit()
    },

    /* 导出按钮 */
    handleExport() {
      let exportIds = this.ids.length != 0 ? this.ids : ""
      this.download(
        "/paih-purchase/providerManage/export",
        { ids: exportIds.toString() },
        `provider_${new Date().getTime()}.xlsx`
      )
    },

    handleBatchDelete() {
      this.handleDelete("", this.ids)
    },

    async handleSetApproval() {
      await this.getApprovalSet()
      this.setApprovalDialogVisible = true
    },

    async getApprovalSet() {
      // 查询审批设置数据
      const res = await getApprovalSetApi("SUPPLIER_APPROVAL")
      this.workFlowable = res.data
    },

    // 更多
    handleCommand(command, row) {
      switch (command) {
        case "approval":
          this.handleApproved(row)
          break
        case "approvalProgress":
          this.handleApprovalProgress(row)
          break
        case "returnProbation":
          if (row.providerStatus == 0) {
            this.$modal.msgWarning("只有正式的供应商可以转为试用！")
            break
          }
          this.$modal
            .confirm(`是否将编号为 ${row.id} 的供应商转为试用？`)
            .then(function () {
              return returnProviderProbation(row.id)
            })
            .then(() => {
              this.getList()
              this.$modal.msgSuccess("更新成功")
            })
          break
        default:
          break
      }
    },
    async handleApproved(row) {
      await this.getApprovalSet()
      const approved = this.workFlowable?.approved
      if (approved === undefined || approved === "1") {
        this.$modal.msgWarning("请先去审批设置页面绑定审批流程")
        return
      }
      this.id = row.id
      this.info = row
      this.info.id = row.providerEncoding
      this.startDialogVisible = true
    },
    handleApprovalProgress(row) {
      const approved = row.workFlowable?.approved
      const procInsId = row.workFlowable?.procInsId
      if (approved === undefined || approved === "1" || procInsId === undefined || procInsId === "") {
        this.$modal.msgWarning("请先发起一个审批流程")
        return
      }
      this.$router.push({
        path: "/workflow/process/detail/" + row.workFlowable?.procInsId,
        query: {
          definitionId: row.workFlowable?.definitionId,
          deployId: row.workFlowable?.deploymentId,
          taskId: row.workFlowable?.taskId,
          finished: false,
        },
      })
    },
  },
}
</script>

<style lang="scss" scoped>
::v-deep .el-dialog {
  .el-tabs__content {
    // overflow: visible; // 防止 vue-treeselect 组件被遮挡
    height: 400px;
    overflow: auto; // 也能防止 vue-treeselect 组件被遮挡
  }
}
.search-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    padding-bottom: 2px;
  }
}

.toolbar-wrapper {
  margin-bottom: 20px;
}
</style>
