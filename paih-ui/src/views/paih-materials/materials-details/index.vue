<template>
  <div class="app-container" v-loading="loading">
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item prop="materialsName" label="搜索">
          <el-input v-model="searchData.materialsName" placeholder="请输入编码、名称、规格、型号" />
        </el-form-item>
        <el-form-item prop="materialsTypeId" label="类别">
          <treeselect
            v-model="searchData.materialsTypeId"
            :options="searchDataMaterialsTypeOptions"
            :normalizer="normalizer"
            :disable-branch-nodes="false"
            :show-count="true"
            placeholder="请选择"
            noChildrenText="无数据"
            noOptionsText="无数据"
            noResultsText="无数据"
            :flat="true"
          />
        </el-form-item>
        <el-form-item prop="projectId" label="归属项目">
          <el-select v-model="searchData.projectId" filterable placeholder="请选择" :disabled="isProjectInfo">
            <el-option
              v-for="(item, index) in searchDataProjectOptions"
              :key="index"
              :label="item.projectName"
              :value="item.projectId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="materialsState" filterable label="状态">
          <el-select v-model="searchData.materialsState" placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataMaterialsStateOptions"
              :key="index"
              :label="item"
              :value="item"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="time" label="更新时间">
          <el-date-picker
            v-model="searchData.time"
            type="datetimerange"
            value-format="yyyy-MM-dd HH:mm:ss"
            range-separator="至"
            start-placeholder="最早日期"
            end-placeholder="最晚日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button v-if="!isProjectInfo" @click="handleResetForm('searchFormRef')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <!-- toolbar-wrapper 模块 -->
    <el-card shadow="never" class="toolbar-wrapper">
      <el-button
        type="primary"
        @click="
          updateId = undefined
          createDialogVisible = true
          createDialogTitle = '新增'
        "
      >
        新增
      </el-button>
      <el-button type="primary" @click="importDialogVisible = true">导入</el-button>
      <el-button type="primary" @click="handleExport">导出</el-button>
      <el-button type="primary" @click="handleExportBackground">后台导出</el-button>
      <el-button type="danger" @click="handleBatchDelete">批量删除</el-button>
      <el-button type="primary" disabled>修正状态</el-button>
      <el-button type="primary" disabled>修正库存</el-button>
    </el-card>
    <el-card shadow="never">
      <!-- table-wrapper 模块 -->
      <el-table
        class="table-wrapper"
        :data="tableData"
        @row-dblclick="handleRowClick"
        highlight-current-row
        :row-style="{ cursor: 'pointer' }"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column label="编码" prop="id" align="center" />
        <el-table-column label="名称" prop="materialsName" align="center" />
        <el-table-column label="归属项目" prop="projectName" align="center" />
        <el-table-column label="类别" prop="materialsTypeName" align="center" />
        <el-table-column label="型号" prop="model" align="center" />
        <el-table-column label="规格" prop="norms" align="center" />
        <el-table-column label="单位" prop="unit" align="center" />
        <el-table-column label="库存" prop="storehouseCount" align="center" />
        <el-table-column label="采购价（元）" prop="unitPrice" align="center">
          <template slot-scope="scope">
            {{ scope.row.unitPrice ?? "****" }}
          </template>
        </el-table-column>
        <el-table-column label="批号" prop="lotNumberDesc" align="center" />
        <el-table-column label="更新时间" prop="updateTime" align="center" />
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.state === '初始化'" type="info">初始化</el-tag>
            <el-tag v-else-if="scope.row.state === '未出库'">未出库</el-tag>
            <el-tag v-else-if="scope.row.state === '已出库'" type="success">已出库</el-tag>
            <span v-else>{{ scope.row.state }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="150">
          <template slot-scope="scope">
            <el-button type="text" @click="handleInfo(scope.row)">详情</el-button>
            <el-button type="text" @click="handleUpdate(scope.row)">编辑</el-button>
            <el-button type="text" @click="handleDelete(scope.row)" style="color: #f56c6c">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <!-- pager-wrapper 模块 -->
      <div class="pager-wrapper">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :page-sizes="[10, 20, 50, 100, 200]"
          :total="total"
          :page-size="pageSize"
          :current-page="currentPage"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        >
        </el-pagination>
      </div>
    </el-card>
    <!-- 导入对话框模块 -->
    <el-dialog title="导入" :visible.sync="importDialogVisible" width="50%">
      <h3>第一步：下载模板并填写</h3>
      <p>请先下载「物料明细模板」并按照模板填写后再上传。</p>
      <el-button @click="downloadTemplate">下载模板</el-button>
      <h3>第二步：上传填写好的文件</h3>
      <el-upload
        :action="uploadFileUrl"
        :headers="uploadFileHeaders"
        :data="uploadFileData"
        :show-file-list="false"
        :auto-upload="true"
        :before-upload="handleBeforeUpload"
        :on-success="handleUploadSuccess"
        :on-error="handleUploadError"
      >
        <el-button type="primary">上传文件</el-button>
      </el-upload>
    </el-dialog>
    <!-- 新增明细对话框模块 -->
    <CreateDialog
      :visible.sync="createDialogVisible"
      :title="createDialogTitle"
      :editFormData="editFormData"
      :consultRecords="consultRecords"
      :files="files"
      :baseStorehouseCountProp="baseStorehouseCount"
      :billFormDataProp="billFormData"
      :projectOptions="searchDataProjectOptions"
      :materialsTypeOptions="searchDataMaterialsTypeOptions"
      :getTableData="getTableData"
      :updateId="updateId"
      :isProjectInfo="isProjectInfo"
      :projectId="projectData?.projectId"
    />
  </div>
</template>

<script>
import { projectStatus } from "@/utils/projectUtils.js"
import CreateDialog from "./components/CreateDialog.vue"
import {
  getMaterialsListApi,
  deleteMaterialsApi,
  exportBackgroundApi,
  getMaterialsStateListApi,
} from "@/api/paih-materials/materials-details.js"
import { getAllProjectListApi } from "@/api/paih-project/my-project.js"
import { listMaterialsSort } from "@/api/paih-materials/materials-sort.js"
import { getToken } from "@/utils/auth"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"
import { normalizerBySearch } from "./util.js"

export default {
  name: "MaterialsDetails",
  components: { CreateDialog, Treeselect },
  props: {
    // 是否是从项目详情进入到该页面
    isProjectInfo: {
      type: Boolean,
      default: false,
    },
    // 项目基本数据（从项目详情进入时有用）
    projectData: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      loading: false,

      /* search-wrapper 模块 */
      searchData: {
        materialsName: "",
        materialsTypeId: undefined,
        projectId: undefined,
        materialsState: undefined,
        time: [],
      },
      // 搜索板块，需要的下拉框数据
      searchDataMaterialsTypeOptions: [],
      searchDataProjectOptions: [],
      searchDataMaterialsStateOptions: [],

      /* toolbar-wrapper 模块 */

      /* table-wrapper 模块 */
      multipleSelection: [],
      tableData: [],

      /* pager-wrapper 模块 */
      total: 0,
      currentPage: 1,
      pageSize: 10,

      /* 导入对话框 */
      importDialogVisible: false,
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/materials/list/import",
      uploadFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadFileData: {},

      /* 新增明细对话框 */
      updateId: undefined, // 进入编辑对话框的时候，需要给其赋值
      createDialogVisible: false,
      createDialogTitle: "新增",
      // 以下是编辑时需要传递的数据
      editFormData: {},
      consultRecords: [],
      files: [],
      baseStorehouseCount: 0,
      billFormData: {},
    }
  },
  methods: {
    /* search-wrapper 模块 */
    handleSearch() {
      this.currentPage = 1
      this.getTableData()
    },
    handleResetForm(ref) {
      this.$refs[ref].resetFields()
      this.getTableData()
    },
    normalizer(node) {
      return normalizerBySearch(node)
    },

    /* toolbar-wrapper 模块 */
    handleBatchDelete() {
      if (this.multipleSelection.length === 0) return
      const data = []
      for (let i = 0; i < this.multipleSelection.length; i++) {
        data.push(this.multipleSelection[i].id)
      }
      this.$modal
        .confirm(`是否确认删除所选物料？`)
        .then(() => {
          return deleteMaterialsApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("批量删除成功")
          this.getTableData()
          this.multipleSelection = []
        })
        .catch(() => {})
    },
    handleExport() {
      const data = {
        materialsName: this.searchData.materialsName,
        materialsTypeId: this.searchData.materialsTypeId,
        projectId: this.searchData.projectId,
        materialsState: this.searchData.materialsState,
        id: "",
      }
      for (let i = 0; i < this.multipleSelection.length; i++) {
        data.id += this.multipleSelection[i].id + ","
      }
      this.download("/materials/list/export", data, "物料明细.xlsx")
    },

    handleExportBackground(){
      this.$modal
        .confirm(`是否确认创建后台导出任务？`)
        .then(() => {
          return exportBackgroundApi({
                  pageNum: this.currentPage,
                  pageSize: this.pageSize,
                  materialsName: this.searchData.materialsName,
                  materialsTypeId: this.searchData.materialsTypeId,
                  projectId: this.searchData.projectId,
                  updateTime1: this.searchData.time ? this.searchData.time[0] : undefined,
                  updateTime2: this.searchData.time ? this.searchData.time[1] : undefined,
                  materialsState: this.searchData.materialsState,
                })
        })
        .then(() => {
          this.$modal.msgSuccess("创建成功")
          this.$modal.confirm(`任务创建成功，是否查看任务执行状态？`)
                      .then(() => {
                        this.$router.push('/tool/async');
                    })
        })
        .catch(() => {})
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      getMaterialsListApi({
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        materialsName: this.searchData.materialsName,
        materialsTypeId: this.searchData.materialsTypeId,
        projectId: this.searchData.projectId,
        updateTime1: this.searchData.time ? this.searchData.time[0] : undefined,
        updateTime2: this.searchData.time ? this.searchData.time[1] : undefined,
        materialsState: this.searchData.materialsState,
      })
        .then((res) => {
          this.total = res.total
          this.tableData = res.data
        })
        .catch(() => {
          this.tableData = []
        })
        .finally(() => {
          this.loading = false
        })
    },
    handleRowClick(row, column) {
      this.handleUpdate(row)
      this.createDialogTitle = "详情"
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    handleInfo(row) {
      this.handleUpdate(row)
      this.createDialogTitle = "详情"
    },
    handleUpdate(row) {
      this.updateId = row.id
      this.createDialogVisible = true
      this.createDialogTitle = "编辑"
      setTimeout(() => {
        // 赋值操作
        this.editFormData = JSON.parse(
          JSON.stringify({
            materialsName: row.materialsName,
            projectId: row.projectId,
            norms: row.norms,
            model: row.model,
            unit: row.unit,
            unitPrice: row.unitPrice,
            color: row.color,
            weight: row.weight,
            materialsTypeId: row.materialsTypeId,
            qualityGuaranteePeriod: row.qualityGuaranteePeriod,
            lotNumber: row.lotNumber,
            partCode: row.partCode,
            id: row.id,
            newMaterialsCode: row.id,
            remarks: row.remarks,
          })
        )
        this.consultRecords = JSON.parse(JSON.stringify(row.consultRecords))
        this.files = JSON.parse(JSON.stringify(row.files))
        this.baseStorehouseCount = row.baseStorehouseCount
        this.billFormData = JSON.parse(
          JSON.stringify({
            storehouseCount: row.storehouseCount,
            receiveOutNum: row.receiveOutNum,
            borrowOutNum: row.borrowOutNum,
            purchaseOutNum: row.purchaseOutNum,
          })
        )
      }, 0)
    },
    handleDelete(row) {
      const id = row.id
      const name = row.materialsName
      this.$modal
        .confirm(`是否确认删除该物料：${name}？`)
        .then(() => {
          return deleteMaterialsApi([id])
        })
        .then(() => {
          this.$modal.msgSuccess("删除成功")
          this.getTableData()
        })
        .catch(() => {})
    },

    /* pager-wrapper 模块 */
    handleCurrentChange(value) {
      this.currentPage = value
      this.getTableData()
    },
    handleSizeChange(value) {
      this.pageSize = value
      this.getTableData()
    },

    /* 导入对话框 */
    downloadTemplate() {
      this.download("/materials/list/example", {}, "物料明细模板.xlsx")
    },
    handleBeforeUpload(file) {
      // 上传文件之前触发
      this.loading = true
      const isXlsx = file.type === "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      // const isLt50M = file.size / 1024 / 1024 < 50
      // if (!isLt50M) {
      //   this.$message.error("上传文件大小不能超过 50MB!")
      // }
      if (!isXlsx) {
        this.$message.error("只能是 xlsx 格式文件!")
        this.loading = false
      }
      return isXlsx
    },
    handleUploadError() {
      // 上传失败时触发
      this.loading = false
      this.$modal.msgError("上传文件失败")
    },
    handleUploadSuccess(res) {
      // 上传成功时触发
      this.loading = false
      if (res.code === 200) {
        this.$modal.msgSuccess("上传文件成功")
        this.importDialogVisible = false
        this.getTableData()
      } else {
        this.$modal.msgError(res.msg || "上传文件异常")
      }
    },

    /* 新增对话框模块 */
  },
  mounted() {
    // 如果是从项目详情进入该页面，那么需要将项目ID的值固定
    if (this.isProjectInfo) {
      this.searchData.projectId = this.projectData.projectId
    }
    this.getTableData()
    // 查询类别
    listMaterialsSort().then((res) => {
      this.searchDataMaterialsTypeOptions = res.data
    })
    // 查询所有项目下拉框
    getAllProjectListApi().then((res) => {
      this.searchDataProjectOptions = res.data
      projectStatus(this.searchDataProjectOptions)
    })
    // 查询物料状态下拉框
    getMaterialsStateListApi().then((res) => {
      this.searchDataMaterialsStateOptions = res.data
    })
  },
  beforeDestroy() {},
}
</script>

<style scoped lang="scss">
.search-wrapper {
  overflow: visible; // 防止 vue-treeselect 组件被遮挡
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    padding-bottom: 2px;
  }
  .vue-treeselect {
    width: 217px;
  }
}

.toolbar-wrapper {
  margin-bottom: 20px;
}

.table-wrapper {
  margin-bottom: 20px;
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
