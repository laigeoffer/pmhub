<template>
  <div class="app-container" v-loading="loading">
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item label="单据类型">
          <el-input placeholder="采购退货出库" disabled />
        </el-form-item>
        <el-form-item prop="id" label="单据编号">
          <el-input v-model="searchData.id" placeholder="请输入" />
        </el-form-item>
        <el-form-item prop="materialsName" label="物料信息">
          <el-input v-model="searchData.materialsName" placeholder="请输入编码、名称、规格、型号等" />
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
        <el-form-item prop="state" label="审批状态">
          <el-select v-model="searchData.state" placeholder="请选择">
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
      <el-button type="primary" @click=";(createDialogVisible = true), (diaTitle = '新增')">新增</el-button>
      <el-button type="danger" @click="handleBatchDelete">批量删除</el-button>
      <el-button type="warning" @click="handleSetApproval">审批设置</el-button>
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
        <el-table-column label="单据编号" prop="id" align="center" />
        <el-table-column label="物料名称" prop="materialsName" align="center" />
        <el-table-column label="供应商" prop="supplierName" align="center" />
        <el-table-column label="出库数量" prop="totalCount" align="center" />
        <el-table-column label="操作员" prop="operatorName" align="center" />
        <el-table-column label="归属项目" prop="projectName" align="center" />
        <el-table-column label="入库单据编号" align="center">
          <template slot-scope="scope">
            <el-link type="primary" @click="goToLink(scope.row.linkRecordsId)">
              {{ scope.row.linkRecordsId }}
            </el-link>
          </template>
        </el-table-column>
        <el-table-column label="金额合计" prop="totalPrice" align="center">
          <template slot-scope="scope">
            {{ scope.row.totalPrice ?? "****" }}
          </template>
        </el-table-column>
        <el-table-column label="出库类型" prop="changeRecordTypeDesc" align="center" />
        <el-table-column label="出库时间" prop="takeOutTime" align="center" />
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.state === '未审核'" type="info">未审核</el-tag>
            <el-tag v-else-if="scope.row.state === '审核中'">审核中</el-tag>
            <el-tag v-else-if="scope.row.state === '已审核'" type="success">已审核</el-tag>
            <span v-else>{{ scope.row.state }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="150">
          <template slot-scope="scope">
            <el-button v-if="scope.row.state == '未审核'" type="text" @click="handleUpdate(scope.row)">编辑</el-button>
            <el-button v-else type="text" @click="handleUpdate(scope.row)">查看</el-button>

            <el-button
              type="text"
              @click="handleDelete(scope.row)"
              :disabled="scope.row.state != '未审核'"
              :style="scope.row.state !== '未审核' ? 'color: #c0c4cc' : 'color: #f56c6c'"
            >
              删除
            </el-button>
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

    <!-- 新增退货单 -->
    <el-dialog title="搜索单号" :visible.sync="openSearchMaterialPaper" width="65%">
      <el-form :model="searchStoreOrderForm" :inline="true" ref="orderFormRef">
        <el-form-item label="单据编号">
          <el-input
            v-model="searchStoreOrderForm.orderId"
            placeholder="请输入完整的单据编号"
            clearable
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="物料信息">
          <el-select
            v-model="searchStoreOrderForm.materialsId"
            filterable
            clearable
            remote
            :remote-method="remoteMethod"
            :loading="loading"
          >
            <el-option
              v-for="(item2, index2) in materialsOptions"
              :key="index2"
              :label="item2.materialsName"
              :value="item2.id"
            >
              <el-tooltip effect="light" placement="right">
                <div slot="content">型号：{{ item2.model }}&nbsp;&nbsp;规格：{{ item2.norms }}</div>
                <span>{{ item2.materialsName }}</span>
              </el-tooltip>
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="findStoreOrder">查询</el-button>
          <el-tooltip content="双击选择入库单">
            <i class="el-icon-question" style="margin-left: 10px; font-size: 18px" />
          </el-tooltip>
        </el-form-item>
      </el-form>
      <!-- 展示已有单号 -->
      <el-table
        class="table-wrapper"
        :data="storeOrderData"
        highlight-current-row
        @row-dblclick="storeOrderRowClick"
        @cell-mouse-enter="inRow"
        @cell-mouse-leave="outRow"
      >
        <el-table-column label="单据编号" align="center" width="100">
          <template slot-scope="scope">
            <el-popover trigger="manual" placement="left" v-model="showBoolean[scope.$index]">
              <div :key="item.id" v-for="item in scope.row.materials">
                <p>
                  物料：{{ item.materialsName }}
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 批次数量：
                  {{ Math.abs(item.totalCount) }}
                </p>
              </div>
              <div slot="reference">
                <el-tag size="normal">{{ scope.row.id }}</el-tag>
              </div>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="物料名称" prop="materialsName" align="center" width="200" />
        <el-table-column label="供应商" prop="supplierName" align="center" />
        <el-table-column label="入库数量" prop="intoNumber" align="center" />
        <el-table-column label="操作员" prop="operatorName" align="center" />
        <el-table-column label="归属项目" prop="projectName" align="center" width="300" />
        <el-table-column label="入库时间" prop="intoTime" align="center" />
        <el-table-column label="金额合计" align="center">
          <template slot-scope="scope">
            {{ scope.row.totalPrice ?? "****" }}
          </template>
        </el-table-column>
        <el-table-column label="付款" align="center">
          <template slot-scope="scope">
            {{ scope.row.totalPay ?? "****" }}
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.state === '未审核'" type="info">未审核</el-tag>
            <el-tag v-else-if="scope.row.state === '审核中'">审核中</el-tag>
            <el-tag v-else-if="scope.row.state === '已审核'" type="success">已审核</el-tag>
            <span v-else>{{ scope.row.state }}</span>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        background
        layout="total, sizes, prev, pager, next, jumper"
        :page-sizes="[5, 10]"
        :total="inStorePaperTotal"
        :page-size="inStorePaperPageSize"
        :current-page="inStorePaperCurrentPage"
        @size-change="handleInStorePaperSizeChange"
        @current-change="handleInStorePaperCurrentChange"
      >
      </el-pagination>
    </el-dialog>

    <!-- 单据详情 -->
    <el-dialog :before-close="handleClose" :title="diaTitle" :visible.sync="createDialogVisible" width="90%">
      <el-form
        ref="formRef"
        :rules="rules"
        :model="formData"
        label-width="150px"
        label-position="top"
        :disabled="diaTitle == '查看'"
      >
        <el-row :gutter="20">
          <el-col :span="3">
            <el-form-item prop="selectOrder" label="查询入库单号" v-if="updateId === undefined">
              <el-button @click="openInStorePaper">点击选择单号</el-button>
              <el-tooltip content="请先选择入库单号">
                <i class="el-icon-question" style="margin-left: 10px; font-size: 18px" />
              </el-tooltip>
            </el-form-item>
          </el-col>
          <el-col :span="3">
            <el-form-item label="单据类型">
              <el-input value="采购退货出库" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="3">
            <el-form-item label="关联单号" prop="linkRecordsId">
              <el-input placeholder="请选择物料单号" disabled v-model="formData.linkRecordsId" />
            </el-form-item>
          </el-col>
          <el-col :span="3">
            <el-form-item prop="projectName" label="归属项目">
              <el-input disabled v-model="formData.projectName" />
            </el-form-item>
          </el-col>
          <el-col :span="3">
            <el-form-item prop="supplierName" label="供应商">
              <el-input v-model="formData.supplierName" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="3">
            <el-form-item prop="storehouseName" label="发货仓库">
              <el-input v-model="formData.storehouseName" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="3">
            <el-form-item prop="takeOutTime" label="出库时间">
              <el-date-picker
                v-model="formData.takeOutTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="选择日期"
              >
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item prop="materials" label="出库明细">
          <el-table ref="detailTable" :data="formData.materials">
            <el-table-column label="物料编码" prop="materialsId"></el-table-column>
            <el-table-column label="物料类别" prop="materialsTypeName"></el-table-column>
            <el-table-column label="物料名称" prop="materialsName"></el-table-column>
            <el-table-column label="规格" prop="norms"></el-table-column>
            <el-table-column label="型号" prop="model"></el-table-column>
            <el-table-column label="单位" prop="unit"></el-table-column>
            <el-table-column label="单价">
              <template slot-scope="scope">
                {{ scope.row.unitPrice ?? "****" }}
              </template>
            </el-table-column>
            <el-table-column label="库存数量" prop="storehouseCount"></el-table-column>
            <el-table-column label="批次数量" prop="totalCount"></el-table-column>
            <el-table-column label="数量" prop="count" width="250">
              <template slot-scope="scope">
                <el-input-number @change="materialNumChange(scope)" v-model="scope.row.count" :min="0" />
              </template>
            </el-table-column>
            <el-table-column label="金额">
              <template slot-scope="scope">
                {{ scope.row?.unitPrice !== undefined ? (scope.row?.unitPrice * scope.row.count).toFixed(2) : "****" }}
              </template>
            </el-table-column>
            <el-table-column label="税率" prop="taxRate"></el-table-column>
            <el-table-column label="备注" prop="remarks"></el-table-column>
            <el-table-column fixed="right" label="操作" width="100">
              <template slot-scope="scope">
                <el-button
                  type="danger"
                  icon="el-icon-delete"
                  :disabled="formData.materials.length < 2"
                  circle
                  size="mini"
                  @click="deleteItem(scope)"
                />
              </template>
            </el-table-column>
          </el-table>
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="3">
            <el-form-item prop="totalPrice" label="金额合计">
              <el-input v-model="formData.totalPrice" disabled />
            </el-form-item>
          </el-col>
          <el-col :span="4">
            <el-form-item prop="reason" label="退货说明">
              <el-input v-model="formData.reason" type="textarea" :rows="1" placeholder="请输入相关说明" />
            </el-form-item>
          </el-col>
          <el-col :span="4">
            <el-form-item prop="remarks" label="备注">
              <el-input v-model="formData.remarks" type="textarea" :rows="1" placeholder="请输入" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item prop="files" label="附件">
          <el-upload
            :action="uploadFileUrl"
            :headers="uploadFileHeaders"
            :data="uploadFileData"
            :show-file-list="true"
            :auto-upload="true"
            :file-list="fileList"
            :before-upload="handleBeforeUpload"
            :on-success="handleUploadSuccess"
            :on-error="handleUploadError"
            :on-remove="handleUploadRemove"
            :on-preview="handleUploadPreview"
          >
            <div slot="tip" v-if="fileList.length > 0">单击可下载附件</div>
            <el-button type="text">上传</el-button>
          </el-upload>
        </el-form-item>
      </el-form>
      <template slot="footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button v-show="diaTitle != '查看'" type="primary" @click="handleCreate">确 定</el-button>
      </template>
    </el-dialog>

    <!-- 任务设置对话框 -->
    <SetApprovalDialog
      :visible.sync="setApprovalDialogVisible"
      :workFlowable="workFlowable"
      :getTableData="getTableData"
      :approvalSetApi="approvalSetApi"
    />
    <!-- 发起审批对话框 -->
    <Start
      :visible.sync="startDialogVisible"
      :id="id"
      :workFlowable="workFlowable"
      :getTableData="getTableData"
      :startProcessApi="startProcessApi"
      :info="info"
    />
  </div>
</template>

<script>
import { projectStatus } from "@/utils/projectUtils.js"
import {
  getPurchaseCancelListApi,
  deletePurchaseCancelApi,
  createPurchaseCancelApi,
  updatePurchaseCancelApi,
  approvalSetApi,
  startProcessApi,
} from "@/api/paih-purchase/purchase-return-outbound.js"
import { getMaterialsListApi } from "@/api/paih-materials/materials-details.js"
import { getStoreOrder, getTotalCount } from "@/api/public/public.js"
import { getAllProjectListApi } from "@/api/paih-project/my-project.js"
import { getOrderState } from "@/api/public/public.js"
import { getToken } from "@/utils/auth"
import { parseTime } from "@/utils/ruoyi"
import { getApprovalSetApi } from "@/api/public/public.js"

import SetApprovalDialog from "@/components/Approval/SetApprovalDialog.vue"
import Start from "@/components/Approval/Start.vue"

export default {
  name: "PurchaseReturnOutbound",
  components: { SetApprovalDialog, Start },
  data() {
    return {
      loading: false,
      materialsOptions: [],
      /* search-wrapper 模块 */
      searchData: {
        id: undefined,
        materialsName: undefined,
        projectId: undefined,
        state: undefined,
      },
      // 搜索板块，归属项目需要的下拉框数据
      searchDataProjectOptions: [],
      // 搜索板块，审批状态需要的下拉框数据
      searchDataStateOptions: [],
      //控制物料弹出框是否显示
      showBoolean: [false, false, false, false, false, false, false, false, false, false],

      /* 新增编辑退货单  */
      //控制搜索单号弹出框
      diaTitle: "新增",
      openSearchMaterialPaper: false,
      // 入库单号搜索表单
      searchStoreOrderForm: {
        orderType: "PURCHASE_OUT",
        orderId: undefined,
        materialsId: undefined,
        materialsName: undefined,
      },
      // 入库单数据
      storeOrderData: [],
      // 入库单分页数据
      inStorePaperTotal: 0,
      inStorePaperCurrentPage: 1,
      inStorePaperPageSize: 5,

      /* toolbar-wrapper 模块 */

      /* table-wrapper 模块 */
      multipleSelection: [],
      tableData: [],

      // 采购出库单分页数据
      total: 0,
      currentPage: 1,
      pageSize: 10,

      /* 对话框 */
      updateId: undefined, // 进入编辑对话框的时候，需要给其赋值
      createDialogVisible: false,
      formData: {
        id: "",
        linkRecordsId: "",
        supplierId: undefined,
        projectId: undefined,
        storehouseId: undefined,
        takeOutTime: parseTime(new Date(), "{y}-{m}-{d}"),
        materials: [],
        totalPrice: "****",
        reason: "",
        remarks: "",
        returnIntro: "", //退货说明
        files: [], // 保存附件 ID
        projectName: "",
        supplierName: "",
        storehouseName: "",
      },
      // 附件上传
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/public/upload",
      uploadFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadFileData: {},
      fileList: [],

      /** 任务设置对话框 */
      setApprovalDialogVisible: false,
      workFlowable: {},
      approvalSetApi,

      /** 发起审批对话框 */
      startDialogVisible: false,
      id: "",
      startProcessApi,
      info: {},

      // 表单验证规则
      rules: {
        takeOutTime: [{ required: true, message: "必填", trigger: "change" }],
        materials: [{ required: true, message: "必填", trigger: "change" }],
        reason: [{ required: true, message: "必填", trigger: "change" }],
      },
    }
  },
  watch: {},
  methods: {
    remoteMethod(query) {
      if (query !== "") {
        this.loading = true
        // 查询物料下拉框数据
        getMaterialsListApi({
          pageNum: 1,
          pageSize: 50,
          materialsName: query,
        }).then((res) => {
          this.loading = false
          this.materialsOptions = res.data
        })
      } else {
        this.materialsOptions = []
      }
    },
    /* search-wrapper 模块 */
    handleSearch() {
      this.currentPage = 1
      this.getTableData()
    },

    // 重置数据
    handleResetForm(ref) {
      this.$refs[ref].resetFields()
      this.getTableData()
    },

    // 打开入库订单的回调
    openInStorePaper() {
      this.findStoreOrder()
      this.openSearchMaterialPaper = true
    },
    /* // 搜索已经入库的物料单 */
    findStoreOrder() {
      getStoreOrder({
        pageNum: this.inStorePaperCurrentPage,
        pageSize: this.inStorePaperPageSize,
        ...this.searchStoreOrderForm,
      }).then((res) => {
        this.storeOrderData = res.data
        this.inStorePaperTotal = res.total
      })
    },

    // 鼠标移动离开到某一行,显示泡泡提示框
    inRow(row) {
      let index = this.storeOrderData.indexOf(row)
      this.$set(this.showBoolean, index, true)
    },
    outRow(row) {
      this.$set(this.showBoolean, this.storeOrderData.indexOf(row), false)
    },

    // 入库订单的分页
    handleInStorePaperSizeChange(val) {
      this.inStorePaperPageSize = val
      this.findStoreOrder()
    },
    handleInStorePaperCurrentChange(val) {
      this.inStorePaperCurrentPage = val
      this.findStoreOrder()
    },

    // 当物料数量发生变化时计算总量
    materialNumChange(val) {
      this.formData.totalPrice = 0
      const materials = this.formData.materials
      for (let i = 0; i < materials.length; i++) {
        const count = materials[i].count
        const unitPrice = materials[i].unitPrice
        if (unitPrice === undefined) {
          this.formData.totalPrice = "****"
          break
        }
        if (count > 0 && unitPrice) {
          this.formData.totalPrice += Number((unitPrice * count).toFixed(2))
          // 保留两位小数，可以简单防止一些 JS 进行二进制加法时发生的误差
          this.formData.totalPrice = Number(this.formData.totalPrice.toFixed(2))
        }
      }
    },

    // 选择入库单获取物料详情
    storeOrderRowClick(row) {
      Object.keys(this.formData).forEach((key) => {
        if (key.toString() != "files" && key.toString() != "takeOutTime" && key.toString() != "remarks") {
          this.formData[key] = row[key]
        }
      })
      this.materialNumChange()
      this.formData.linkRecordsId = row.id
      this.openSearchMaterialPaper = false
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
          return deletePurchaseCancelApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("批量删除成功")
          this.getTableData()
          this.multipleSelection = []
        })
        .catch(() => {})
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
      this.id = row.id
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

    async handleSetApproval() {
      await this.getApprovalSet()
      this.setApprovalDialogVisible = true
    },
    async getApprovalSet() {
      // 查询审批设置数据
      const res = await getApprovalSetApi("PURCHASE_OUT")
      this.workFlowable = res.data
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      getPurchaseCancelListApi({
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        id: this.searchData.id,
        materialsName: this.searchData.materialsName,
        projectId: this.searchData.projectId,
        state: this.searchData.state,
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
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    goToLink(id) {
      // 跳转到采购入库
      window.open(`/paih-purchase/purchase-inbound?id=${id}`)
    },

    handleUpdate(row) {
      this.diaTitle = "编辑"
      if (row.state != "未审核") {
        this.diaTitle = "查看"
      }
      //提供updateId值做新增或者编辑的判断
      this.updateId = row.id
      this.createDialogVisible = true
      // 赋值操作
      Object.keys(this.formData).forEach((key) => {
        if (key.toString() != "files") {
          this.formData[key] = row[key]
        }
      })
      this.materialNumChange()
      //根据关联单的物料信息确定单据详情中的数量
      getTotalCount({ recordId: row.linkRecordsId }).then((res) => {
        let materials = res.data
        this.formData.materials.forEach((item) => {
          materials.find((m) => {
            if (m.materialsId == item.materialsId) {
              item.totalCount = m.totalCount
            }
          })
        })
      })

      // 处理附件
      this.fileList = []
      for (let i = 0; i < row.files.length; i++) {
        const item = row.files[i]
        this.formData.files.push({ fileId: item.fileId })
        this.fileList.push({
          name: item.fileName,
          url: "",
          response: {
            data: {
              fileId: item.fileId,
            },
          },
        })
      }
    },

    // 删除物料
    handleDelete(row) {
      const id = row.id
      const name = row.materialsName
      this.$modal
        .confirm(`是否确认删除该物料：${name}？`)
        .then(() => {
          return deletePurchaseCancelApi([id])
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

    deleteItem(scope) {
      // 删除明细
      this.formData.materials.splice(scope.$index, 1)
      this.materialNumChange()
    },

    handleCreate() {
      this.$refs["formRef"].validate((valid) => {
        if (valid) {
          if (this.updateId === undefined) {
            createPurchaseCancelApi(this.formData).then(() => {
              this.$modal.msgSuccess("新增成功")
              this.handleClose()
            })
          } else {
            updatePurchaseCancelApi({
              id: this.updateId,
              ...this.formData,
            }).then(() => {
              this.$modal.msgSuccess("编辑成功")
              this.handleClose()
            })
          }
        } else {
          return false
        }
      })
    },

    // 取消后的回调
    handleClose() {
      this.handleResetForm("formRef")
      this.createDialogVisible = false
      this.updateId = undefined
      this.fileList = []
    },

    // 上传文件之前触发
    handleBeforeUpload(file) {
      this.loading = true
      const isLt50M = file.size / 1024 / 1024 < 50
      if (!isLt50M) {
        this.$message.error("上传文件大小不能超过 50MB!")
        this.loading = false
      }
      return isLt50M
    },

    // 上传失败时触发
    handleUploadError() {
      this.loading = false
      this.$modal.msgError("上传文件失败")
    },

    // 上传成功时触发
    handleUploadSuccess(res) {
      this.loading = false
      if (res.code === 200) {
        this.$modal.msgSuccess("上传文件成功")
        this.formData.files.push({ fileId: res.data.fileId })
      } else {
        this.$modal.msgError(res.msg || "上传文件异常")
      }
    },
    handleUploadRemove(file, fileList) {
      // 移除附件
      for (let i = 0; i < this.formData.files.length; i++) {
        // 由于拿不到下标 index，所以循环匹配 ID 即可
        if (this.formData.files[i].fileId === file?.response?.data?.fileId) {
          this.formData.files.splice(i, 1)
          return
        }
      }
    },
    handleUploadPreview(file) {
      // 下载附件
      this.download(
        "/public/download-post",
        {
          fileIds: file.response.data.fileId,
        },
        file.name
      )
    },
  },
  mounted() {
    this.getApprovalSet()
    this.getTableData()
    // 查询所有项目下拉框
    getAllProjectListApi().then((res) => {
      this.searchDataProjectOptions = res.data
      //处理已暂停的项目状态
      projectStatus(this.searchDataProjectOptions)
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
