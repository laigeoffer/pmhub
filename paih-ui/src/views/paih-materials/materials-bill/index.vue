<template>
  <div class="app-container" v-loading="loading">
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper" v-if="!isMaterialsDetails">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item prop="searchValue" label="搜索">
          <el-input v-model="searchData.searchValue" placeholder="请输入编码、名称、规格、型号" />
        </el-form-item>
        <el-form-item prop="storehouseId" label="仓库">
          <el-select v-model="searchData.storehouseId" filterable placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataStorehouseOptions"
              :key="index"
              :label="item.storeName"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="projectId" label="归属项目">
          <el-select v-model="searchData.projectId" filterable placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataProjectOptions"
              :key="index"
              :label="item.projectName"
              :value="item.projectId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="supplierId" label="供应商">
          <el-select v-model="searchData.supplierId" filterable placeholder="请选择">
            <el-option
              v-for="(item, index) in supplierOptions"
              :key="index"
              :label="item.providerName"
              :value="item.id"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="orderTypeId" label="单据类型">
          <el-select v-model="searchData.orderTypeId" placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataOrderTypeOptions"
              :key="index"
              :label="item.orderTypeName"
              :value="item.orderTypeId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="time" label="业务时间">
          <el-date-picker
            v-model="searchData.time"
            type="datetimerange"
            value-format="yyyy-MM-dd HH:mm:ss"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item prop="recordsId" label="单据编号">
          <el-input v-model="searchData.recordsId" placeholder="请输入" />
        </el-form-item>
        <el-form-item prop="state" label="审批状态">
          <el-select v-model="searchData.state" placeholder="请选择">
            <el-option v-for="(item, index) in searchDataStateOptions" :key="index" :label="item" :value="item">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="operatorId" label="操作员">
          <el-select v-model="searchData.operatorId" filterable placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataOreratorOptions"
              :key="index"
              :label="item.nickName"
              :value="item.userId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="handleResetForm('searchFormRef')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <!-- toolbar-wrapper 模块 -->
    <el-card shadow="never" class="toolbar-wrapper" v-if="!isMaterialsDetails">
      <el-button type="primary" @click="importDialogVisible = true">导入</el-button>
      <el-button type="primary" @click="handleExport">导出</el-button>
    </el-card>
    <el-card shadow="never">
      <!-- table-wrapper 模块 -->
      <el-table class="table-wrapper" :data="tableData" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" v-if="!isMaterialsDetails" />
        <el-table-column label="业务时间" prop="orderTime" align="center" />
        <el-table-column label="单据类型" prop="orderTypeName" align="center" />
        <el-table-column label="单据编号" prop="recordsId" align="center" />
        <el-table-column label="仓库" prop="storehouseName" align="center" />
        <el-table-column label="借用预计归还" prop="returnTime" align="center" v-if="isMaterialsDetails" />
        <el-table-column label="物料名称" prop="materialsName" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="物料编码" prop="materialsId" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="供应商" prop="supplierName" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="归属项目" prop="projectName" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="类别" prop="materialsTypeName" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="规格" prop="norms" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="型号" prop="model" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="单位" prop="unit" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="责任人" prop="principalName" align="center" />
        <el-table-column label="入库数量" prop="intoNumber" align="center" />
        <el-table-column label="入库金额" prop="intoTotalPay" align="center" v-if="!isMaterialsDetails">
          <template slot-scope="scope">
            {{ scope.row.intoTotalPay ?? (scope.row.secrecyMaps?.intoTotalPay ? "****" : "") }}
          </template>
        </el-table-column>
        <el-table-column label="出库数量" prop="takeOutNumber" align="center" />
        <el-table-column label="出库金额" prop="takeOutTotalPay" align="center" v-if="!isMaterialsDetails">
          <template slot-scope="scope">
            {{ scope.row.takeOutTotalPay ?? (scope.row.secrecyMaps?.takeOutTotalPay ? "****" : "") }}
          </template>
        </el-table-column>
        <el-table-column label="库存" prop="storehouseCount" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="操作员" prop="operatorName" align="center" v-if="!isMaterialsDetails" />
        <el-table-column label="状态" align="center" v-if="!isMaterialsDetails">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.state === '未审核'" type="info">未审核</el-tag>
            <el-tag v-else-if="scope.row.state === '审核中'">审核中</el-tag>
            <el-tag v-else-if="scope.row.state === '已审核'" type="success">已审核</el-tag>
            <span v-else>{{ scope.row.state }}</span>
          </template>
        </el-table-column>
      </el-table>
      <!-- pager-wrapper 模块 -->
      <div class="pager-wrapper">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :page-sizes="[10, 20, 50]"
          :total="total"
          :page-size="pageSize"
          :current-page="currentPage"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        >
        </el-pagination>
      </div>
    </el-card>
    <!-- 导入对话框 -->
    <el-dialog title="导入" :visible.sync="importDialogVisible" width="50%">
      <h3>第一步：下载模板</h3>
      <el-button @click="downloadTemplate">下载</el-button>
      <h3>第二步：上传</h3>
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
        <el-button type="primary">导入</el-button>
      </el-upload>
    </el-dialog>
  </div>
</template>

<script>
import { projectStatus } from "@/utils/projectUtils.js"
import { queryMemberApi } from "@/api/paih-project/my-project.js"
import { getAllProviderListApi } from "@/api/paih-purchase/provider-manage.js"
import { getToken } from "@/utils/auth"
import { getMaterialsRecordsListApi, getOrderTypeListApi } from "@/api/paih-materials/materials-bill.js"
import { getAllProjectListApi } from "@/api/paih-project/my-project.js"
import { getAllStorehouseListApi } from "@/api/paih-storehouse/store-manage.js"
import { getOrderState } from "@/api/public/public.js"

export default {
  name: "MaterialsBill",
  components: {},
  props: {
    // 是否是从物料明细进入到该页面
    isMaterialsDetails: {
      type: Boolean,
      default: false,
    },
    // 物料编码（从物料明细进入到该页面时需要传递该参数）
    id: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      loading: false,

      /* search-wrapper 模块 */
      searchData: {
        searchValue: undefined,
        storehouseId: undefined,
        projectId: undefined,
        orderTypeId: undefined,
        time: [],
        recordsId: undefined,
        state: undefined,
        supplierId: undefined,
        operatorId: undefined,
      },
      // 搜索板块，需要的下拉框数据
      searchDataStorehouseOptions: [],
      searchDataProjectOptions: [],
      searchDataOrderTypeOptions: [],
      searchDataStateOptions: [],
      supplierOptions: [],
      searchDataOreratorOptions: [],

      /* toolbar-wrapper 模块 */

      /* table-wrapper 模块 */
      tableData: [],
      multipleSelection: [],

      /* pager-wrapper 模块 */
      total: 0,
      currentPage: 1,
      pageSize: 10,

      /* 交付物模块 */
      taskFileList: [],
      importDialogVisible: false,
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/materials-records/import",
      uploadFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadFileData: {},
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

    /* toolbar-wrapper 模块 */
    handleExport() {
      const data = {
        searchValue: this.searchData.searchValue,
        storehouseId: this.searchData.storehouseId,
        projectId: this.searchData.projectId,
        orderTypeId: this.searchData.orderTypeId,
        startTime: this.searchData.time ? this.searchData.time[0] : undefined,
        endTime: this.searchData.time ? this.searchData.time[1] : undefined,
        recordsId: this.searchData.recordsId,
        id: "",
      }
      for (let i = 0; i < this.multipleSelection.length; i++) {
        data.id += this.multipleSelection[i].id + ","
      }
      this.download("/materials-records/list/export", data, "物料台账.xlsx")
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      getMaterialsRecordsListApi({
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        searchValue: this.searchData.searchValue,
        storehouseId: this.searchData.storehouseId,
        projectId: this.searchData.projectId,
        orderTypeId: this.searchData.orderTypeId,
        startTime: this.searchData.time ? this.searchData.time[0] : undefined,
        endTime: this.searchData.time ? this.searchData.time[1] : undefined,
        recordsId: this.searchData.recordsId,
        state: this.searchData.state,
        supplierId: this.searchData.supplierId,
        operatorId: this.searchData.operatorId,
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
    handleSelectionChange(val) {
      this.multipleSelection = val
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

    /* 导入模块 */
    downloadTemplate() {
      this.download("/materials-records/example", {}, "物料台账导入模板.xlsx")
    },
    handleBeforeUpload(file) {
      // 上传文件之前触发
      this.$modal.loading("上传文件中...")
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
    handleUploadSuccess(res) {
      // 上传成功时触发
      this.$modal.closeLoading()
      if (res.code === 200) {
        this.$modal.msgSuccess("上传文件成功")
        this.importTaskFileDialogVisible = false
        this.getTaskFileList()
      } else {
        this.$modal.msgError(res.msg || "上传文件异常")
      }
    },
  },
  mounted() {
    this.searchData.searchValue = this.id
    this.getTableData()
    // 如果从物料明细进入到该页面，则不需要调用下面几个接口
    if (!this.isMaterialsDetails) {
      // 查询所有项目下拉框
      getAllProjectListApi().then((res) => {
        this.searchDataProjectOptions = res.data
        projectStatus(this.searchDataProjectOptions)
      })
      // 查询所有供应商下拉框
      getAllProviderListApi().then((res) => {
        this.supplierOptions = res.data
      })
      // 查询所有仓库下拉框
      getAllStorehouseListApi().then((res) => {
        this.searchDataStorehouseOptions = res.data
      })
      // 查询单据类型下拉框
      getOrderTypeListApi().then((res) => {
        this.searchDataOrderTypeOptions = res.data
      })
      // 查询审批状态下拉框
      getOrderState().then((res) => {
        this.searchDataStateOptions = res.data
      })
      // 查询所有人
      queryMemberApi().then((res) => {
        this.searchDataOreratorOptions = res.data
      })
    }
  },
  beforeDestroy() {},
}
</script>

<style scoped lang="scss">
.search-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    padding-bottom: 2px;
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
