<template>
  <div>
    <el-dialog title="审批设置" :visible.sync="visible" width="1200px" :before-close="handleClose" @open="handleOpen">
      <el-tabs tab-position="left" v-model="tabActiveName">
        <el-tab-pane label="审批设置" name="审批设置">
          <el-card shadow="never">
            <el-radio-group v-model="isApproval">
              <el-radio :label="false">无需审批</el-radio>
              <el-radio :label="true">需要审批</el-radio>
            </el-radio-group>
          </el-card>
          <el-card shadow="never" v-show="isApproval">
            <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
              <el-form-item label="流程标识" prop="processKey">
                <el-input
                  v-model="queryParams.processKey"
                  placeholder="请输入流程标识"
                  clearable
                  size="small"
                  @keyup.enter.native="handleQuery"
                />
              </el-form-item>
              <el-form-item label="流程名称" prop="processName">
                <el-input
                  v-model="queryParams.processName"
                  placeholder="请输入流程名称"
                  clearable
                  size="small"
                  @keyup.enter.native="handleQuery"
                />
              </el-form-item>
              <el-form-item label="流程分类" prop="category">
                <el-select v-model="queryParams.category" clearable filterable placeholder="请选择" size="small">
                  <el-option
                    v-for="item in categoryOptions"
                    :key="item.categoryId"
                    :label="item.categoryName"
                    :value="item.code"
                  >
                  </el-option>
                </el-select>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
              </el-form-item>
            </el-form>
            <el-table fit :data="processList">
              <el-table-column label="序号" type="index" width="50"></el-table-column>
              <el-table-column label="流程标识" align="center" prop="processKey" :show-overflow-tooltip="true" />
              <el-table-column label="流程名称" align="center" :show-overflow-tooltip="true">
                <template slot-scope="scope">
                  <el-button type="text" @click="handleProcessView(scope.row)">
                    <span>{{ scope.row.processName }}</span>
                  </el-button>
                </template>
              </el-table-column>
              <el-table-column label="流程分类" align="center" prop="categoryName" :formatter="categoryFormat" />
              <el-table-column label="流程版本" align="center">
                <template slot-scope="scope">
                  <el-tag size="medium">v{{ scope.row.version }}</el-tag>
                </template>
              </el-table-column>
              <el-table-column label="状态" align="center">
                <template slot-scope="scope">
                  <el-tag type="success" v-if="!scope.row.suspended">激活</el-tag>
                  <el-tag type="warning" v-if="scope.row.suspended">挂起</el-tag>
                </template>
              </el-table-column>
              <el-table-column label="部署时间" align="center" prop="deploymentTime" width="180" />
              <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
                <template slot-scope="scope">
                  <el-radio
                    :value="taskDefinitionId"
                    :label="scope.row.definitionId"
                    @input="changeTaskDefinitionId(scope.row)"
                  >
                    {{ taskDefinitionId === scope.row.definitionId ? "已绑定" : "未绑定" }}
                  </el-radio>
                </template>
              </el-table-column>
            </el-table>
            <pagination
              v-show="total > 0"
              :total="total"
              :page.sync="queryParams.pageNum"
              :limit.sync="queryParams.pageSize"
              @pagination="getList"
            />
            <!-- 流程图 -->
            <el-dialog :title="processView.title" :visible.sync="processView.open" width="70%" append-to-body>
              <process-viewer
                :key="`designer-${processView.index}`"
                :xml="processView.xmlData"
                :style="{ height: '400px' }"
              />
            </el-dialog>
          </el-card>
        </el-tab-pane>
      </el-tabs>
      <template slot="footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="handleCreate">确 定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { listProcess, getBpmnXml } from "@/api/workflow/process"
import { listAllCategory } from "@/api/workflow/category"
import ProcessViewer from "@/components/ProcessViewer"

export default {
  name: "SetApprovalDialog",
  components: {
    ProcessViewer,
  },
  props: {
    visible: {
      type: Boolean,
      default: false,
    },
    // 后端返回的审批设置数据
    workFlowable: {
      type: Object,
    },
    // 重新获取任务列表数据
    getTableData: {
      type: Function,
    },
    // 接口
    approvalSetApi: {
      type: Function,
      required: true,
    },
  },
  watch: {},
  data() {
    return {
      tabActiveName: "审批设置",

      /** 审批设置模块 */
      isApproval: false, // 是否需要审批
      taskDefinitionId: "", // 绑定的流程 id
      taskDeploymentId: "", // 绑定的部署 id
      taskApprovalName: "", // 绑定的流程名
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        processKey: undefined,
        processName: undefined,
        category: undefined,
      },
      // 总条数
      total: 0,
      categoryOptions: [],
      // 流程定义表格数据
      processList: [],
      processView: {
        title: "",
        open: false,
        index: undefined,
        xmlData: "",
      },
    }
  },
  methods: {
    handleCreate() {
      if (this.isApproval && this.taskDefinitionId === "") {
        this.$modal.msgWarning("请绑定流程")
        return
      }
      this.approvalSetApi({
        approved: this.isApproval ? "0" : "1",
        definitionId: this.isApproval ? this.taskDefinitionId : "",
        deploymentId: this.isApproval ? this.taskDeploymentId : "",
      }).then(() => {
        this.$modal.msgSuccess("设置成功")
        this.getTableData()
      })
      this.handleClose()
    },
    handleClose() {
      this.queryParams.pageNum = 1
      this.$emit("update:visible", false)
    },
    handleOpen() {
      // 获取所有的分类
      this.getCategoryList()
      // 获取所有的流程定义
      this.getList()
      // 回显以前的审批设置
      this.isApproval = this.workFlowable?.approved === "0" ? true : false
      this.taskDefinitionId = this.workFlowable?.definitionId ?? ""
      this.taskDeploymentId = this.workFlowable?.deploymentId ?? ""
    },

    /** 审批设置模块 */
    // 查询流程分类列表
    getCategoryList() {
      listAllCategory().then((response) => (this.categoryOptions = response.data))
    },
    // 查询流程定义列表
    getList() {
      this.$modal.loading("获取数据中...")
      listProcess(this.queryParams)
        .then((response) => {
          this.processList = response.rows
          this.total = response.total
        })
        .finally(() => {
          this.$modal.closeLoading()
        })
    },
    // 搜索按钮操作
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    // 重置按钮操作
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 查看流程图
    handleProcessView(row) {
      let definitionId = row.definitionId
      this.processView.title = "流程图"
      this.processView.index = definitionId
      // 发送请求，获取xml
      getBpmnXml(definitionId).then((res) => {
        this.processView.xmlData = res.data
      })
      this.processView.open = true
    },
    categoryFormat(row, column) {
      return this.categoryOptions.find((k) => k.code === row.category)?.categoryName ?? ""
    },
    // 改变绑定的流程
    changeTaskDefinitionId(row) {
      this.taskDefinitionId = row.definitionId
      this.taskDeploymentId = row.deploymentId
      this.taskApprovalName = row.processName
    },
  },
  mounted() {},
}
</script>

<style scoped lang="scss">
::v-deep .el-dialog {
  .el-tabs__content {
    height: 600px;
    overflow: auto;
  }
}

.el-card {
  margin-bottom: 10px;
}
</style>
