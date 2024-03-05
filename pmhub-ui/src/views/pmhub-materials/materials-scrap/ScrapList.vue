<template>
  <div class="app-container" v-loading="loading">
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item prop="searchValue" label="搜索">
          <el-input v-model="searchData.searchValue" placeholder="物料编码、物料名称" />
        </el-form-item>
        <el-form-item prop="id" label="单号">
          <el-input v-model="searchData.id" placeholder="请输入" />
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
        <el-form-item prop="resolution" label="处理意见">
          <el-select v-model="searchData.resolution" placeholder="请选择">
            <el-option label="待定" value="待定"></el-option>
            <el-option label="留用" value="留用"></el-option>
            <el-option label="报废" value="报废"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="dangerous" label="是否危废">
          <el-select v-model="searchData.dangerous" placeholder="请选择">
            <el-option label="待定" value="待定"></el-option>
            <el-option label="是" value="是"></el-option>
            <el-option label="否" value="否"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="reason" label="呆滞原因">
          <el-select v-model="searchData.reason" placeholder="请选择">
            <el-option label="借用" value="借用"></el-option>
            <el-option label="滞留" value="滞留"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="principalId" label="责任人">
          <el-select v-model="searchData.principalId" filterable placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataPrincipalOptions"
              :key="index"
              :label="item.nickName"
              :value="item.userId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="approvedName" label="审批状态">
          <el-select v-model="searchData.approvedName" placeholder="请选择">
            <el-option v-for="(item, index) in searchDataStateOptions" :key="index" :label="item" :value="item">
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
    <el-card shadow="never" class="toolbar-wrapper">
      <el-button type="primary" @click="handleExport">导出</el-button>
      <!-- <el-button type="primary" @click="handleSetScrapTime">报废区间设置</el-button> -->
      <el-button type="warning" @click="handleSetApproval">审批设置</el-button>
      <el-button type="success" @click="handleBulkApproval">批量审批</el-button>
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
        <el-table-column label="单号" prop="id" align="center" />
        <el-table-column label="名称" prop="materialsName" align="center" />
        <el-table-column label="物料编码" prop="materialsId" align="center" />
        <el-table-column label="归属项目" prop="projectName" align="center" />
        <el-table-column label="类别" prop="materialsTypeName" align="center" />
        <el-table-column label="供应商" prop="supplierName" align="center" />
        <el-table-column label="入库时间" prop="intoTime" align="center" />
        <el-table-column label="入库数量" prop="intoNumber" align="center" />
        <el-table-column label="单位" prop="unit" align="center" />
        <el-table-column label="库存" prop="materialsCount" align="center" />
        <el-table-column align="center" width="90">
          <template slot="header">
            <span>
              呆滞原因
              <el-tooltip>
                <div slot="content">
                  滞留：本批物料库存剩余数量不为 0
                  <br />
                  借用：本批物料库存剩余数量为 0，但有借出物料未归还
                </div>
                <i class="el-icon-question" style="font-size: 14px" />
              </el-tooltip>
            </span>
          </template>
          <template slot-scope="scope">
            <div v-if="scope.row.reason === '借用'">
              <i class="el-icon-chat-dot-round" />
              <span> 借用</span>
            </div>
            <div v-else-if="scope.row.reason === '滞留'">
              <i class="el-icon-time" />
              <span> 滞留</span>
            </div>
            <span v-else>{{ scope.row.reason }}</span>
          </template>
        </el-table-column>
        <el-table-column label="单价" prop="unitPrice" align="center">
          <template slot-scope="scope">
            {{ scope.row.unitPrice ?? "****" }}
          </template>
        </el-table-column>
        <el-table-column label="总价" prop="totalRate" align="center">
          <template slot-scope="scope">
            {{ scope.row.totalRate ?? "****" }}
          </template>
        </el-table-column>
        <el-table-column label="处理意见" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.resolution === '待定'" type="info">待定</el-tag>
            <el-tag v-else-if="scope.row.resolution === '留用'">留用</el-tag>
            <el-tag v-else-if="scope.row.resolution === '报废'" type="danger">报废</el-tag>
            <span v-else>{{ scope.row.resolution }}</span>
          </template>
        </el-table-column>
        <el-table-column label="是否危废" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.dangerous === '待定'" type="info">待定</el-tag>
            <el-tag v-else-if="scope.row.dangerous === '是'" type="danger">是</el-tag>
            <el-tag v-else-if="scope.row.dangerous === '否'" type="success">否</el-tag>
            <span v-else>{{ scope.row.dangerous }}</span>
          </template>
        </el-table-column>
        <el-table-column label="责任人" prop="principalName" align="center" />
        <el-table-column label="审批状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.approvedName === '未审核'" type="info">未审核</el-tag>
            <el-tag v-else-if="scope.row.approvedName === '审核中'">审核中</el-tag>
            <el-tag v-else-if="scope.row.approvedName === '已审核'" type="success">已审核</el-tag>
            <span v-else>{{ scope.row.approvedName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="250" fixed="right">
          <template slot-scope="scope">
            <!-- <el-button type="text" @click="handleInfo(scope.row)" disabled>详情</el-button> -->
            <el-button type="text" @click="handleSelectPrincipal(scope.row)">责任人</el-button>
            <el-dropdown @command="(command) => handleOpinion(command, scope.row)">
              <el-button type="text">处理意见</el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="留用">留用</el-dropdown-item>
                <el-dropdown-item command="报废">报废</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
            <el-dropdown @command="(command) => handleScrap(command, scope.row)">
              <el-button type="text" :disabled="scope.row.resolution !== '报废'">是否危废</el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="是">是</el-dropdown-item>
                <el-dropdown-item command="否">否</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
            <el-dropdown @command="(command) => handleCommand(command, scope.row)">
              <el-button type="text" icon="el-icon-d-arrow-right">更多</el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="approval">审批</el-dropdown-item>
                <el-dropdown-item command="approvalProgress">审批进度</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
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
    <!-- 选择负责人对话框 -->
    <SelectUser :visible.sync="selectPrincipalDialogVisible" :radio="true" @change="handleChangePrincipal" />
    <!-- 审批设置对话框 -->
    <SetApprovalDialog
      :visible.sync="setApprovalDialogVisible"
      :workFlowable="workFlowable"
      :getTableData="getTableData"
      :approvalSetApi="approvalSetApi"
    />
    <!-- 发起审批对话框 -->
    <Start
      :visible.sync="startDialogVisible"
      :ids="ids"
      :workFlowable="workFlowable"
      :getTableData="getTableData"
      :startProcessApi="startProcessApi"
      :info="info"
      :infos="infos"
    />
  </div>
</template>

<script>
import { projectStatus } from "@/utils/projectUtils.js"
import {
  getMaterialsUselessListApi,
  updateMaterialsUselessPrincipalApi,
  updateMaterialsUselessOpinionApi,
  approvalSetApi,
  startProcessApi,
  ciphertextSum,
} from "@/api/pmhub-materials/materials-scrap.js"
import { listMaterialsSort } from "@/api/pmhub-materials/materials-sort.js"
import { getAllProjectListApi } from "@/api/pmhub-project/my-project.js"
import { queryMemberApi } from "@/api/pmhub-project/my-project.js"
import { getApprovalSetApi, getOrderState } from "@/api/public/public.js"
import SetApprovalDialog from "@/components/Approval/SetApprovalDialog.vue"
import Start from "./components/Start.vue"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"
import SelectUser from "@/components/SelectUser/index.vue"
import Big from "big.js"

export default {
  name: "ScrapList",
  components: { SetApprovalDialog, Start, Treeselect, SelectUser },
  data() {
    return {
      loading: false,

      /* search-wrapper 模块 */
      searchData: {
        searchValue: "",
        id: "",
        materialsTypeId: undefined,
        projectId: undefined,
        resolution: undefined,
        dangerous: undefined,
        reason: undefined,
        principalId: undefined,
        approvedName: undefined,
      },
      // 下拉框数据
      searchDataProjectOptions: [],
      searchDataMaterialsTypeOptions: [],
      searchDataPrincipalOptions: [],
      searchDataStateOptions: [],

      /* toolbar-wrapper 模块 */
      // 暂无变量

      /* table-wrapper 模块 */
      multipleSelection: [],
      tableData: [],

      /* pager-wrapper 模块 */
      total: 0,
      currentPage: 1,
      pageSize: 10,

      /** 选择负责人对话框 */
      trackingId: undefined,
      selectPrincipalDialogVisible: false,

      /** 审批设置对话框 */
      setApprovalDialogVisible: false,
      workFlowable: {},
      approvalSetApi,

      /** 发起审批对话框 */
      startDialogVisible: false,
      ids: "",
      startProcessApi,
      info: {},
      infos: {},
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
      if (node.materialsTypeSon && !node.materialsTypeSon.length) {
        delete node.materialsTypeSon
      }
      return {
        id: node.id,
        label: node.materialsTypeName,
        children: node.materialsTypeSon,
      }
    },

    /* toolbar-wrapper 模块 */
    handleExport() {
      const text = this.multipleSelection.length === 0 ? "全量呆滞物料列表.xlsx" : "呆滞物料列表.xlsx"
      const data = { ids: "" }
      for (let i = 0; i < this.multipleSelection.length; i++) {
        data.ids += this.multipleSelection[i].id + ","
      }
      this.download("/materials-useless/export", data, text)
    },
    handleSetScrapTime() {},
    async handleSetApproval() {
      await this.getApprovalSet()
      this.setApprovalDialogVisible = true
    },
    async getApprovalSet() {
      // 查询审批设置数据
      const res = await getApprovalSetApi("USELESS_OUT")
      this.workFlowable = res.data
    },
    async handleBulkApproval() {
      await this.getApprovalSet()
      const approved = this.workFlowable?.approved
      if (approved === undefined || approved === "1") {
        this.$modal.msgWarning("请先去审批设置页面绑定审批流程")
        return
      }
      if (this.multipleSelection.length <= 1) {
        this.$modal.msgWarning("至少勾选两条单据")
        return
      }
      const totalRateCiphertextArr = []
      const ids = []
      const infos = {
        materialsName: "",
        materialsCount: 0,
        totalRate: undefined,
        totalRateCiphertext: undefined,
      }
      for (let i = 0; i < this.multipleSelection.length; i++) {
        const item = this.multipleSelection[i]
        totalRateCiphertextArr.push(item.secrecyMaps?.totalRate)
        ids.push(item.id)
        infos.materialsName += item.materialsName + ","
        infos.materialsCount = new Big(infos.materialsCount).plus(item.materialsCount).toString()
      }
      ciphertextSum(totalRateCiphertextArr).then((res) => {
        infos.totalRate = res.data.displayValue
        infos.totalRateCiphertext = res.data.value
        this.ids = ids.toString()
        this.infos = infos
        this.startDialogVisible = true
      })
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      getMaterialsUselessListApi({
        ...this.searchData,
        pageNum: this.currentPage,
        pageSize: this.pageSize,
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
      this.handleInfo(row)
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    handleInfo(row) {},
    handleSelectPrincipal(row) {
      this.currentRow = row
      this.trackingId = row.id
      this.selectPrincipalDialogVisible = true
    },
    // 处理意见
    handleOpinion(val, row) {
      row.resolution = val
      updateMaterialsUselessOpinionApi(row).then(() => {
        this.$modal.msgSuccess("设置成功")
        this.getTableData()
      })
    },
    // 是否危废
    handleScrap(val, row) {
      row.dangerous = val
      updateMaterialsUselessOpinionApi(row).then(() => {
        this.$modal.msgSuccess("设置成功")
        this.getTableData()
      })
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
      this.ids = row.id
      this.info = row
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

    /* pager-wrapper 模块 */
    handleCurrentChange(value) {
      this.currentPage = value
      this.getTableData()
    },
    handleSizeChange(value) {
      this.pageSize = value
      this.getTableData()
    },

    /** 选择负责人对话框 */
    handleChangePrincipal(res) {
      updateMaterialsUselessPrincipalApi({
        id: this.trackingId,
        principalId: res.userId[0],
      }).then(() => {
        this.$modal.msgSuccess("设置成功")
        this.currentRow.principalId = Number(res.userId[0])
        this.currentRow.principalName = res.nickName[0]
        updateMaterialsUselessOpinionApi(this.currentRow).then(() => {
          this.getTableData()
        })
      })
    },
  },
  mounted() {
    this.getApprovalSet()
    this.getTableData()
    // 查询类别
    listMaterialsSort().then((res) => {
      this.searchDataMaterialsTypeOptions = res.data
    })
    // 查询所有项目下拉框
    getAllProjectListApi().then((res) => {
      this.searchDataProjectOptions = res.data
      //处理已暂停的项目状态
      projectStatus(this.searchDataProjectOptions)
    })
    // 查询所有人
    queryMemberApi().then((res) => {
      this.searchDataPrincipalOptions = res.data
    })
    // 查询审批状态下拉框
    getOrderState().then((res) => {
      this.searchDataStateOptions = res.data
    })
  },
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
  .el-dropdown {
    .el-button {
      margin-left: 5px; // 防止切换处理意见时，按钮间距变化
    }
  }
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
