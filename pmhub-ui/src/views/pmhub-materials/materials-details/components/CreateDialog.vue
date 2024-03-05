<template>
  <div>
    <el-dialog :title="title" :visible.sync="visible" width="65%" :before-close="handleClose" @open="handleOpen">
      <el-tabs v-model="tabActiveName">
        <el-tab-pane label="基本信息" name="基本信息">
          <el-form
            ref="formRef"
            :rules="rules"
            :model="formData"
            label-width="150px"
            label-position="top"
            :disabled="title === '详情'"
          >
            <el-row>
              <el-col :span="6">
                <el-form-item prop="materialsName" label="名称">
                  <el-input v-model="formData.materialsName" placeholder="请输入" style="width: 217px" />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="projectId" label="所属项目">
                  <el-select v-model="formData.projectId" filterable placeholder="请选择" :disabled="isProjectInfo">
                    <el-option
                      v-for="(item, index) in projectOptions"
                      :key="index"
                      :label="item.projectName"
                      :value="item.projectId"
                      :disabled="item.disabled"
                    >
                    </el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="model" label="型号">
                  <el-input v-model="formData.model" placeholder="请输入" style="width: 217px" />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="norms" label="规格">
                  <el-input v-model="formData.norms" placeholder="请输入" style="width: 217px" />
                </el-form-item>
              </el-col>
            </el-row>
            <el-row>
              <el-col :span="6">
                <el-form-item prop="unit" label="单位">
                  <el-input v-model="formData.unit" placeholder="请输入" style="width: 217px" />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="unitPrice" label="采购价(元)">
                  <el-input-number
                    v-model="formData.unitPrice"
                    :min="0"
                    :placeholder="formData.unitPrice ? formData.unitPrice.toString() : '****'"
                  />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="color" label="颜色">
                  <el-input v-model="formData.color" placeholder="请输入" style="width: 217px" />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="weight" label="基础重量(kg)">
                  <el-input-number v-model="formData.weight" :min="0" placeholder="请输入" />
                </el-form-item>
              </el-col>
            </el-row>
            <el-row>
              <el-col :span="6">
                <el-form-item prop="materialsTypeId" label="类别">
                  <template slot="label">
                    <span>类别</span>
                    <el-tooltip content="请移步至物料管理-物料类别，添加物料类别">
                      <i class="el-icon-question" style="margin-left: 5px" />
                    </el-tooltip>
                  </template>
                  <div style="display: flex">
                    <treeselect
                      style="width: 217px"
                      v-model="formData.materialsTypeId"
                      :options="materialsTypeOptions"
                      :normalizer="normalizer"
                      :disable-branch-nodes="false"
                      :show-count="true"
                      placeholder="请选择"
                      :disabled="title === '详情' || title === '编辑'"
                      noChildrenText="无数据"
                      noOptionsText="无数据"
                      noResultsText="无数据"
                      :flat="true"
                      @select="changeMaterialsTypeId"
                    />
                    <router-link to="/pmhub-materials/materials-sort">
                      <el-button type="text" style="margin-left: 10px">去添加</el-button>
                    </router-link>
                  </div>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="qualityGuaranteePeriod" label="保质期(天)">
                  <el-input-number v-model="formData.qualityGuaranteePeriod" :min="0" placeholder="请输入" />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="lotNumber" label="有无批号">
                  <el-select v-model="formData.lotNumber" placeholder="请选择">
                    <el-option
                      v-for="(item, index) in lotNumberOptions"
                      :key="index"
                      :label="item.label"
                      :value="item.value"
                    >
                    </el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="partCode" label="零件编码">
                  <el-input v-model="formData.partCode" placeholder="请输入" style="width: 217px" />
                </el-form-item>
              </el-col>
            </el-row>
            <el-row>
              <el-col :span="6">
                <el-form-item prop="id" label="物料编码">
                  <template slot="label">
                    <span>物料编码</span>
                    <el-tooltip>
                      <div slot="content">
                        物料编码默认根据公司确定的物料编码规则进行自动编码，<br />您只需选择对应物料类别即可。
                      </div>
                      <i class="el-icon-question" style="margin-left: 5px" />
                    </el-tooltip>
                  </template>
                  <el-input
                    v-if="title === '编辑'"
                    v-model="formData.newMaterialsCode"
                    placeholder="请输入"
                    style="width: 217px"
                    :disabled="true"
                  />
                  <el-input v-else v-model="formData.id" placeholder="请输入" style="width: 217px" :disabled="true" />
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item prop="remarks" label="备注">
                  <el-input
                    v-model="formData.remarks"
                    type="textarea"
                    :rows="1"
                    placeholder="请输入"
                    style="width: 217px"
                  />
                </el-form-item>
              </el-col>
            </el-row>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="询价记录" name="询价记录">
          <el-button type="primary" @click="createPriceRecordsDrawerVisible = true" v-if="title !== '详情'">
            新增询价记录
          </el-button>
          <el-table class="table-wrapper" :data="tableData">
            <el-table-column label="询价时间" prop="consultTime" align="center" />
            <el-table-column label="供应商名" prop="supplierName" align="center" />
            <el-table-column label="型号" prop="model" align="center" />
            <el-table-column label="规格" prop="norms" align="center" />
            <el-table-column label="报价" prop="unitPrice" align="center">
              <template slot-scope="scope">
                {{ scope.row.unitPrice ?? (scope.row.secrecyMaps?.unitPrice ? "****" : "") }}
              </template>
            </el-table-column>
            <el-table-column label="税率(%)" prop="taxRate" align="center" />
            <el-table-column label="链接地址" align="center">
              <template slot-scope="scope">
                <el-link v-if="validURL(scope.row.shopUrl)" type="primary" :href="scope.row.shopUrl" target="_blank">
                  点击跳转
                </el-link>
                <span v-else>{{ scope.row.shopUrl }}</span>
              </template>
            </el-table-column>
            <el-table-column :label="tableLastLabel" align="center" width="150" v-if="title !== '详情'">
              <template slot-scope="scope">
                <el-button type="text" @click="handleUpdate(scope.row, scope.$index)">编辑</el-button>
                <el-button type="text" @click="handleDelete(scope.row, scope.$index)" style="color: #f56c6c">
                  删除
                </el-button>
              </template>
            </el-table-column>
          </el-table>
          <!-- 抽屉 -->
          <el-drawer
            title="询价记录"
            :append-to-body="true"
            :visible.sync="createPriceRecordsDrawerVisible"
            @close="closePriceRecordsDrawer"
          >
            <el-form
              ref="priceRecordsFormRef"
              :rules="priceRecordsRules"
              :model="priceRecordsFormData"
              label-width="100px"
              label-position="right"
            >
              <el-form-item prop="consultTime" label="询价时间">
                <el-date-picker
                  v-model="priceRecordsFormData.consultTime"
                  type="datetime"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  placeholder="选择日期时间"
                >
                </el-date-picker>
              </el-form-item>
              <el-form-item prop="supplierId" label="供应商名">
                <el-select v-model="priceRecordsFormData.supplierId" filterable placeholder="请选择">
                  <el-option
                    v-for="(item, index) in supplierOptions"
                    :key="index"
                    :label="item.providerName"
                    :value="item.id"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item prop="model" label="型号">
                <el-input v-model="priceRecordsFormData.model" placeholder="请输入" />
              </el-form-item>
              <el-form-item prop="norms" label="规格">
                <el-input v-model="priceRecordsFormData.norms" placeholder="请输入" />
              </el-form-item>
              <el-form-item prop="unitPrice" label="报价">
                <el-input-number v-model="priceRecordsFormData.unitPrice" :min="0" placeholder="请输入" />
              </el-form-item>
              <el-form-item prop="taxRate" label="税率">
                <el-input-number v-model="priceRecordsFormData.taxRate" :min="0" placeholder="请输入" />
              </el-form-item>
              <el-form-item prop="shopUrl" label="物料链接地址">
                <el-input v-model="priceRecordsFormData.shopUrl" placeholder="请输入" />
              </el-form-item>
              <el-form-item>
                <el-button @click="createPriceRecordsDrawerVisible = false">取消</el-button>
                <el-button type="primary" @click="handleCreatePriceRecords">确认</el-button>
              </el-form-item>
            </el-form>
          </el-drawer>
        </el-tab-pane>
        <el-tab-pane label="附件" name="附件">
          <!-- <el-form :inline="true" ref="fileFormRef">
            <el-form-item prop="searchFileName" label="文件名">
              <el-input v-model="searchFileName" placeholder="请输入" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="handleFileSearch">查询</el-button>
              <el-button @click="searchFileName = ''">重置</el-button>
            </el-form-item>
          </el-form> -->
          <div class="file-toolbar-wrapper">
            <el-upload
              v-if="title !== '详情'"
              :action="uploadFileUrl"
              :headers="uploadFileHeaders"
              :data="uploadFileData"
              :show-file-list="false"
              :auto-upload="true"
              :before-upload="handleBeforeUpload"
              :on-success="handleUploadSuccess"
              :on-error="handleUploadError"
            >
              <el-button type="primary">上传</el-button>
            </el-upload>
            <el-button v-if="updateId !== undefined" type="primary" @click="handleBatchDownloads">批量下载</el-button>
          </div>
          <el-table class="table-wrapper" :data="fileTableData" @selection-change="handleFileSelectionChange">
            <el-table-column type="selection" width="55" />
            <el-table-column type="index" width="55" label="序号" />
            <el-table-column label="文件名" prop="fileName" align="center" />
            <el-table-column label="文件大小" prop="fileSizeDesc" align="center" />
            <el-table-column label="上传时间" prop="updateTime" align="center" />
            <el-table-column label="操作" align="center" width="210">
              <template slot-scope="scope">
                <el-button v-if="updateId !== undefined" type="text" @click="handleFileDownload(scope.row)">
                  下载
                </el-button>
                <!-- <el-button v-if="updateId !== undefined" type="text" @click="handleFileRename(scope.row)" disabled>
                  重命名
                </el-button> -->
                <el-button
                  v-if="title !== '详情'"
                  type="text"
                  @click="handleFileDelete(scope.row, scope.$index)"
                  style="color: #f56c6c"
                >
                  删除
                </el-button>
              </template>
            </el-table-column>
          </el-table>
        </el-tab-pane>
        <el-tab-pane label="物料台账" name="物料台账">
          <template v-if="title === '详情'">
            <el-form
              :model="billFormData"
              label-width="80px"
              label-position="right"
              :disabled="true"
              style="margin-top: 20px"
            >
              <el-row>
                <el-col :span="6">
                  <el-form-item prop="storehouseCount" label="现有库存">
                    <el-input v-model="billFormData.storehouseCount" placeholder="请输入" />
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item prop="receiveOutNum" label="被领用">
                    <el-input v-model="billFormData.receiveOutNum" placeholder="请输入" />
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item prop="borrowOutNum" label="被借用">
                    <el-input v-model="billFormData.borrowOutNum" placeholder="请输入" />
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item prop="purchaseOutNum" label="退货">
                    <el-input v-model="billFormData.purchaseOutNum" placeholder="请输入" />
                  </el-form-item>
                </el-col>
              </el-row>
            </el-form>
            <MaterialsBill :isMaterialsDetails="true" :id="updateId" :key="updateId" />
          </template>
          <template v-else>
            <el-form :inline="true">
              <el-form-item label="期初库存">
                <el-input-number v-model="baseStorehouseCount" :min="0" />
              </el-form-item>
            </el-form>
            <p>提示：如有期初库存，请输入期初库存</p>
          </template>
        </el-tab-pane>
      </el-tabs>
      <template slot="footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="handleCreate" v-if="title !== '详情'">保 存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { getAllProviderListApi } from "@/api/pmhub-purchase/provider-manage.js"
import { createMaterialsApi, updateMaterialsApi, getCodeByTypeApi } from "@/api/pmhub-materials/materials-details.js"
import { getToken } from "@/utils/auth"
import { parseTime } from "@/utils/ruoyi"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"
import { normalizer } from "../util.js"
import MaterialsBill from "@/views/pmhub-materials/materials-bill/index.vue"
import { validURL } from "@/utils/validate"

export default {
  name: "AddPeopleDialog",
  components: { Treeselect, MaterialsBill },
  props: {
    visible: {
      type: Boolean,
      default: false,
    },
    title: {
      type: String,
      required: true,
    },
    // 编辑时的起始数据
    editFormData: {
      type: Object,
      required: false,
    },
    consultRecords: {
      type: Array,
      required: false,
    },
    files: {
      type: Array,
      required: false,
    },
    baseStorehouseCountProp: {
      type: Number,
      required: false,
    },
    billFormDataProp: {
      type: Object,
      required: false,
    },
    // 所有项目下拉框
    projectOptions: {
      type: Array,
      required: true,
    },
    // 所有类别下拉框
    materialsTypeOptions: {
      type: Array,
      required: true,
    },
    // 重新获取表格数据
    getTableData: {
      type: Function,
      required: true,
    },
    // 进入编辑模式的时候，需要给其赋值
    updateId: {
      type: String,
      default: undefined,
    },
    // 是否是从项目详情进入到该页面
    isProjectInfo: {
      type: Boolean,
      default: false,
    },
    // 项目 ID（从 "从项目详情进入到该页面" 时需要传递）
    projectId: {
      type: String,
      default: "",
    },
  },
  watch: {
    editFormData: function () {
      this.formData = this.editFormData
      this.tableData = this.consultRecords
      this.fileTableData = this.files
      this.baseStorehouseCount = this.baseStorehouseCountProp
      this.billFormData = this.billFormDataProp
    },
  },
  data() {
    return {
      tabActiveName: "基本信息",

      /** 基本信息 */
      formData: {
        materialsName: "",
        projectId: undefined,
        model: "",
        norms: "",
        unit: "",
        unitPrice: 0,
        color: "",
        weight: 0,
        materialsTypeId: undefined,
        qualityGuaranteePeriod: 0,
        lotNumber: undefined,
        partCode: "",
        id: "",
        newMaterialsCode: "", // 编辑时才有该字段
        remarks: "",
      },
      // 批号下拉框
      lotNumberOptions: [
        {
          label: "有",
          value: true,
        },
        {
          label: "无",
          value: false,
        },
      ],
      rules: {
        materialsName: [{ required: true, message: "必填", trigger: "change" }],
        materialsTypeId: [{ required: true, message: "必填", trigger: "change" }],
      },

      /* 询价记录 */
      updateIndex: undefined,
      createPriceRecordsDrawerVisible: false,
      tableLastLabel: "操作",
      tableData: [],
      priceRecordsFormData: {
        consultTime: "",
        supplierId: undefined,
        supplierName: "",
        model: "",
        norms: "",
        unitPrice: 0,
        taxRate: "",
        shopUrl: "",
      },
      // 供应商下拉框
      supplierOptions: [],
      priceRecordsRules: {
        supplierId: [{ required: true, message: "必填", trigger: "change" }],
      },

      /* 附件 */
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/public/upload",
      uploadFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadFileData: {},
      // searchFileName: "",
      fileMultipleSelection: [],
      fileTableData: [],

      /* 物料台账 */
      baseStorehouseCount: 0,
      billFormData: {
        // 这是数据只在详情中展示，不用做编辑
        storehouseCount: 0,
        receiveOutNum: 0,
        borrowOutNum: 0,
        purchaseOutNum: 0,
      },
    }
  },
  methods: {
    /** 基本信息 */
    handleResetForm(ref) {
      this.$refs[ref].resetFields()
    },
    normalizer(node) {
      return normalizer(node)
    },
    changeMaterialsTypeId(node) {
      getCodeByTypeApi(node.id).then((res) => {
        if (this.title === "编辑") {
          this.formData.newMaterialsCode = res.data
        } else {
          this.formData.id = res.data
        }
      })
    },
    handleCreate() {
      this.$refs["formRef"].validate((valid) => {
        if (valid) {
          // 格式化附件数据为接口需要的格式
          const files = []
          for (let i = 0; i < this.fileTableData.length; i++) {
            files.push({ fileId: this.fileTableData[i].fileId })
          }
          if (this.updateId === undefined) {
            // 新增
            createMaterialsApi({
              ...this.formData,
              consultRecords: this.tableData,
              files,
              baseStorehouseCount: this.baseStorehouseCount,
            }).then((res) => {
              this.$modal.msgSuccess("保存成功")
              this.$emit("update:visible", false)
              this.getTableData()
            })
          } else {
            // 编辑
            updateMaterialsApi({
              id: this.updateId,
              ...this.formData,
              consultRecords: this.tableData,
              files,
              baseStorehouseCount: this.baseStorehouseCount,
            }).then((res) => {
              this.$modal.msgSuccess("编辑成功")
              this.$emit("update:visible", false)
              this.getTableData()
            })
          }
        } else {
          return false
        }
      })
      this.handleClose()
    },
    handleClose() {
      this.handleResetForm("formRef")
      this.$emit("update:visible", false)
      this.tableData = []
      this.fileTableData = []
      this.baseStorehouseCount = 0
    },
    handleOpen() {
      if (this.isProjectInfo) {
        this.formData.projectId = this.projectId
      }
    },

    /* 询价记录 */
    handleCreatePriceRecords() {
      this.$refs["priceRecordsFormRef"].validate((valid) => {
        if (valid) {
          const data = JSON.parse(JSON.stringify(this.priceRecordsFormData))
          if (this.updateIndex === undefined) {
            // 新增
            data.supplierName = this.getSupplierNameBySupplierId(data.supplierId)
            this.tableData.push(data)
          } else {
            // 编辑
            data.supplierName = this.getSupplierNameBySupplierId(data.supplierId)
            this.tableData.splice(this.updateIndex, 1, data)
          }
          this.createPriceRecordsDrawerVisible = false
        } else {
          return false
        }
      })
    },
    // 根据 id 获取供应商名字
    getSupplierNameBySupplierId(id) {
      let name = ""
      for (let i = 0; i < this.supplierOptions.length; i++) {
        if (id === this.supplierOptions[i].id) {
          name = this.supplierOptions[i].providerName
          return name
        }
      }
    },
    handleUpdate(row, index) {
      this.updateIndex = index
      this.createPriceRecordsDrawerVisible = true
      setTimeout(() => {
        // 赋值操作
        this.priceRecordsFormData = JSON.parse(JSON.stringify(row))
      }, 0)
    },
    handleDelete(row, index) {
      this.$modal
        .confirm(`是否确认删除该记录？`)
        .then(() => {
          this.tableData.splice(index, 1)
        })
        .catch(() => {})
    },
    closePriceRecordsDrawer() {
      this.handleResetForm("priceRecordsFormRef")
      this.updateIndex = undefined
    },
    validURL(url) {
      return validURL(url)
    },

    /* 附件 */
    // handleFileSearch() {
    //   this.getFileList()
    // },
    handleBeforeUpload(file) {
      // 上传文件之前触发
      this.$modal.loading("上传中...")
      const isLt50M = file.size / 1024 / 1024 < 50
      if (!isLt50M) {
        this.$message.error("上传文件大小不能超过 50MB!")
        this.$modal.closeLoading()
      }
      return isLt50M
    },
    handleUploadError() {
      // 上传失败时触发
      this.$modal.closeLoading()
      this.$modal.msgError("上传文件失败")
    },
    handleUploadSuccess(res, file, fileList) {
      // 上传成功时触发
      this.$modal.closeLoading()
      if (res.code === 200) {
        this.$modal.msgSuccess("上传文件成功")
        this.fileTableData.push({
          fileName: res.data.fileName,
          fileSizeDesc: res.data.fileSizeDesc,
          updateTime: parseTime(new Date()),
          fileId: res.data.fileId,
        })
      } else {
        this.$modal.msgError(res.msg || "上传文件异常")
      }
    },
    // getFileList() {
    //   getFileListApi(this.searchFileName)
    //     .then((res) => {
    //       this.total = res.total
    //       this.fileTableData = res.data
    //     })
    //     .catch(() => {
    //       this.fileTableData = [{ fileName: "test.doc" }]
    //     })
    // },
    handleFileSelectionChange(val) {
      this.fileMultipleSelection = val
    },
    handleFileDownload(row) {
      this.download(
        "/public/download-post",
        {
          fileIds: row.fileId,
        },
        row.fileName
      )
    },
    handleBatchDownloads() {
      if (this.fileMultipleSelection.length === 0) return
      const data = {
        fileIds: "",
      }
      for (let i = 0; i < this.fileMultipleSelection.length; i++) {
        data.fileIds += this.fileMultipleSelection[i].fileId + ","
      }
      this.download("/public/download-post", data, "批量下载.zip")
    },
    handleFileRename(row) {},
    handleFileDelete(row, index) {
      this.$modal
        .confirm(`是否确认删除文件？`)
        .then(() => {
          this.fileTableData.splice(index, 1)
        })
        .catch(() => {})
    },
  },
  mounted() {
    // 查询所有供应商下拉框
    getAllProviderListApi().then((res) => {
      this.supplierOptions = res.data
    })
  },
}
</script>

<style scoped lang="scss">
::v-deep .el-dialog {
  .el-tabs__content {
    // overflow: visible; // 防止 vue-treeselect 组件被遮挡
    height: 400px;
    overflow: auto; // 也能防止 vue-treeselect 组件被遮挡
  }
}

.table-wrapper {
  margin: 20px 0;
}

.file-toolbar-wrapper {
  display: flex;
  ::v-deep .el-upload {
    margin-right: 10px;
  }
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}

::v-deep .el-drawer__body {
  padding: 0 20px;
}
</style>
