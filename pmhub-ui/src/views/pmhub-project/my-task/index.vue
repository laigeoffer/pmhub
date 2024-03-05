<template>
  <div class="app-container" v-loading="loading">
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item prop="taskName" label="任务名">
          <el-input v-model="searchData.taskName" placeholder="请输入" />
        </el-form-item>
        <el-form-item prop="projectId" label="所属项目">
          <el-select
            v-model="searchData.projectId"
            placeholder="请选择"
            @change="changeSearchProject"
            :disabled="isProjectInfo"
            filterable
          >
            <el-option
              v-for="(item, index) in [{ projectName: '全部项目', projectId: undefined }, ...projectOptions]"
              :key="index"
              :label="item.projectName"
              :value="item.projectId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="stageCode" label="所属阶段">
          <el-select
            v-model="searchData.stageCode"
            placeholder="先选择所属项目"
            :disabled="searchData.projectId === undefined"
          >
            <el-option
              v-for="(item, index) in stageCodeOptions"
              :key="index"
              :label="item.stageName"
              :value="item.stageCode"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="executor" label="执行人">
          <el-input v-model="searchData.executor" placeholder="请输入" />
        </el-form-item>
        <el-form-item prop="createdBy" label="创建人">
          <el-input v-model="searchData.createdBy" placeholder="请输入" />
        </el-form-item>
        <el-form-item prop="executeStatus" label="执行状态">
          <el-select v-model="searchData.executeStatus" placeholder="请选择">
            <el-option
              v-for="(item, index) in executeStatusOptions"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="status" label="任务状态">
          <el-select v-model="searchData.status" placeholder="请选择">
            <el-option v-for="(item, index) in statusOptions" :key="index" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="taskPriority" label="优先级">
          <el-select v-model="searchData.taskPriority" placeholder="请选择">
            <el-option
              v-for="(item, index) in [{ label: '全部优先级', value: undefined }, ...taskPriorityOptions]"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button v-if="!isProjectInfo" @click="handleResetForm('searchFormRef')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <!-- toolbar-wrapper 模块 -->
    <el-card shadow="never" class="toolbar-wrapper">
      <div>
        <el-button type="danger" @click="handleBatchDelete">批量删除</el-button>
        <el-button type="primary" disabled>审批</el-button>
        <el-button type="primary" @click="importTaskDialogVisible = true">导入任务</el-button>
        <el-button type="primary" @click="exportTask">导出任务</el-button>
      </div>
      <el-button type="primary" @click="createTaskDialogVisible = true">新建任务</el-button>
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
        <el-table-column type="selection" width="55"> </el-table-column>
        <el-table-column label="任务名" prop="taskName" align="center" />
        <el-table-column label="所属项目" prop="projectName" align="center" />
        <el-table-column label="所属阶段" prop="stageName" align="center" />
        <el-table-column label="执行人" prop="executor" align="center" />
        <el-table-column label="执行状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.executeStatusName === '未开始'" type="info">未开始</el-tag>
            <el-tag v-else-if="scope.row.executeStatusName === '进行中'">进行中</el-tag>
            <el-tag v-else-if="scope.row.executeStatusName === '已完成'" type="success">已完成</el-tag>
            <span v-else>{{ scope.row.executeStatusName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="任务状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.statusName === '未开始'" type="info">未开始</el-tag>
            <el-tag v-else-if="scope.row.statusName === '进行中'">进行中</el-tag>
            <el-tag v-else-if="scope.row.statusName === '已完成'" type="success">已完成</el-tag>
            <el-tag v-else-if="scope.row.statusName === '已逾期'" type="danger">已逾期</el-tag>
            <span v-else>{{ scope.row.statusName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="优先级" align="center" width="150">
          <template slot-scope="scope">
            <div v-if="scope.row.taskPriorityName === '最高'">
              <span>最高</span>
              <el-rate :value="5" :colors="rateColors" disabled />
            </div>
            <div v-else-if="scope.row.taskPriorityName === '较高'">
              <span>较高</span>
              <el-rate :value="4" :colors="rateColors" disabled />
            </div>
            <div v-else-if="scope.row.taskPriorityName === '普通'">
              <span>普通</span>
              <el-rate :value="3" :colors="rateColors" disabled />
            </div>
            <div v-else-if="scope.row.taskPriorityName === '较低'">
              <span>较低</span>
              <el-rate :value="2" :colors="rateColors" disabled />
            </div>
            <div v-else-if="scope.row.taskPriorityName === '最低'">
              <span>最低</span>
              <el-rate :value="1" :colors="rateColors" disabled />
            </div>
            <span v-else>{{ scope.row.taskPriorityName }}</span>
          </template>
        </el-table-column>
        <!-- <el-table-column label="当前审批" prop="" align="center" /> -->
        <el-table-column label="创建人" prop="createdBy" align="center" />
        <el-table-column label="任务周期(天)" prop="period" align="center" width="100" />
        <el-table-column label="截止时间" prop="closeTime" align="center" />
        <el-table-column label="任务进度" align="center">
          <template slot-scope="scope">
            <el-progress :percentage="scope.row.taskProcess"></el-progress>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="150">
          <template slot-scope="scope">
            <el-button type="text" @click="handleInfo(scope.row)">详情</el-button>
            <el-button type="text" @click="handleDelete(scope.row)" style="color: #f56c6c">删除</el-button>
            <el-dropdown @command="(command) => handleCommand(command, scope.row)">
              <el-button type="text" icon="el-icon-d-arrow-right">更多</el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="approval">审批</el-dropdown-item>
                <el-dropdown-item command="approvalProgress">审批进度</el-dropdown-item>
                <el-dropdown-item command="setTask">任务设置</el-dropdown-item>
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
    <!-- 新建任务对话框 -->
    <CreateTaskDialog
      :visible.sync="createTaskDialogVisible"
      :getTableData="getTableData"
      :projectOptions="projectOptions"
      :taskPriorityOptions="taskPriorityOptions"
      :isProjectInfo="isProjectInfo"
      :projectId="projectData?.projectId"
    />
    <!-- 导入任务对话框 -->
    <el-dialog title="导入任务" :visible.sync="importTaskDialogVisible" width="50%">
      <h3>第一步：下载模板并填写</h3>
      <p>请先下载「任务模板」并按照模板填写后再上传。</p>
      <el-button @click="downloadTaskTemplate">下载模板</el-button>
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
    <!-- 任务设置对话框 -->
    <SetTaskDialog
      :visible.sync="setTaskDialogVisible"
      :taskId="setTaskId"
      :workFlowable="workFlowable"
      :getTableData="getTableData"
    />
    <!-- 发起审批对话框 -->
    <Start
      :visible.sync="startDialogVisible"
      :taskId="setTaskId"
      :workFlowable="workFlowable"
      :getTableData="getTableData"
      :info="info"
    />
  </div>
</template>

<script>
import { projectStatus } from "@/utils/projectUtils.js"
import CreateTaskDialog from "./components/CreateTaskDialog.vue"
import SetTaskDialog from "./components/SetTaskDialog.vue"
import Start from "./components/Start.vue"
import { getTaskListApi, deleteTaskApi } from "@/api/pmhub-project/my-task.js"
import { getProjectListApi } from "@/api/dashboard/index.js"
import { getStageListApi, getProjectTaskListApi } from "@/api/pmhub-project/my-project.js"
import { getApprovalSetApi } from "@/api/public/public.js"
import { getToken } from "@/utils/auth"

export default {
  name: "MyTask",
  components: { CreateTaskDialog, SetTaskDialog, Start },
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
        taskName: "",
        projectId: undefined,
        stageCode: undefined,
        executor: "",
        createdBy: "",
        executeStatus: undefined,
        status: undefined,
        taskPriority: undefined,
      },
      // 所属项目需要的下拉框数据
      projectOptions: [],
      // 所属阶段需要的下拉框数据
      stageCodeOptions: [],
      // 执行状态需要的下拉框数据
      executeStatusOptions: [
        {
          label: "全部状态",
          value: undefined,
        },
        {
          label: "未开始",
          value: 0,
        },
        {
          label: "进行中",
          value: 1,
        },
        {
          label: "已完成",
          value: 2,
        },
      ],
      // 任务状态需要的下拉框数据
      statusOptions: [
        {
          label: "全部状态",
          value: undefined,
        },
        {
          label: "未开始",
          value: 0,
        },
        {
          label: "进行中",
          value: 1,
        },
        {
          label: "已完成",
          value: 2,
        },
        {
          label: "已逾期",
          value: 3,
        },
      ],
      // 优先级需要的下拉框数据
      taskPriorityOptions: [
        {
          label: "最高",
          value: 0,
        },
        {
          label: "较高",
          value: 1,
        },
        {
          label: "普通",
          value: 2,
        },
        {
          label: "较低",
          value: 3,
        },
        {
          label: "最低",
          value: 4,
        },
      ],

      /* toolbar-wrapper 模块 */

      /* table-wrapper 模块 */
      multipleSelection: [],
      tableData: [],
      rateColors: ["#909399", "#E6A23C", "#F56C6C"],

      /* pager-wrapper 模块 */
      total: 0,
      currentPage: 1,
      pageSize: 10,

      /* 新建任务对话框 */
      createTaskDialogVisible: false,

      /* 导入任务对话框 */
      importTaskDialogVisible: false,
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/project/task/import",
      uploadFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadFileData: {},

      /** 任务设置对话框 */
      setTaskDialogVisible: false,
      setTaskId: "",
      workFlowable: {},

      /** 发起审批对话框 */
      startDialogVisible: false,
      info: {},
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
    changeSearchProject(projectId) {
      this.stageCodeOptions = [{ stageName: "全部阶段", stageCode: undefined }]
      getStageListApi(projectId).then((res) => {
        // 查询阶段列表
        this.stageCodeOptions = [{ stageName: "全部阶段", stageCode: undefined }, ...res.data]
      })
    },

    /* toolbar-wrapper 模块 */
    handleBatchDelete() {
      if (this.multipleSelection.length === 0) return
      const data = {
        taskIdList: [],
      }
      for (let i = 0; i < this.multipleSelection.length; i++) {
        data.taskIdList.push(this.multipleSelection[i].taskId)
      }
      this.$modal
        .confirm(`是否确认删除所选任务？`)
        .then(() => {
          return deleteTaskApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("批量删除成功")
          this.getTableData()
          this.multipleSelection = []
        })
        .catch(() => {})
    },
    exportTask() {
      if (this.multipleSelection.length === 0) {
        this.download("/project/task/exportAll", {}, "所有任务.xlsx")
        return
      }
      const data = {
        taskIds: "",
      }
      for (let i = 0; i < this.multipleSelection.length; i++) {
        data.taskIds += this.multipleSelection[i].taskId + ","
      }
      this.download("/project/task/export", data, "任务.xlsx")
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      const api = this.isProjectInfo ? getProjectTaskListApi : getTaskListApi
      api({
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        taskName: this.searchData.taskName,
        projectId: this.searchData.projectId,
        stageCode: this.searchData.stageCode,
        executor: this.searchData.executor,
        createdBy: this.searchData.createdBy,
        executeStatus: this.searchData.executeStatus,
        status: this.searchData.status,
        taskPriority: this.searchData.taskPriority,
      })
        .then((res) => {
          this.total = res.data.total
          this.tableData = res.data.list
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
    handleInfo(row) {
      this.$router.push({ path: "/pmhub-project/my-task/info", query: { taskId: row.taskId } })
    },
    handleDelete(row) {
      const data = {
        taskIdList: [row.taskId],
      }
      this.$modal
        .confirm(`是否确认删除该任务：${row.taskName}？`)
        .then(() => {
          return deleteTaskApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("删除成功")
          this.getTableData()
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
        case "setTask":
          this.handleSetTask(row)
          break
        default:
          break
      }
    },
    async handleApproved(row) {
      // 修改说明：之前是在列表中获取 workFlowable 相关数据以得到拿到对应审批表单所需的参数，现在修改为调用一个接口获取对应参数
      await this.getApprovalSet(row.taskId)
      const approved = this.workFlowable?.approved
      if (approved === undefined || approved === "1") {
        this.$modal.msgWarning("请先去任务设置页面绑定审批流程")
        return
      }
      this.setTaskId = row.taskId
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
    async handleSetTask(row) {
      await this.getApprovalSet(row.taskId)
      this.setTaskId = row.taskId
      this.setTaskDialogVisible = true
    },
    async getApprovalSet(taskId) {
      // 查询审批设置数据
      const res = await getApprovalSetApi("task", { taskId })
      this.workFlowable = res.data
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

    /* 新建任务对话框 */

    /* 导入任务对话框 */
    downloadTaskTemplate() {
      this.download("/project/task/downloadTaskTemplate", {}, "任务模板.xlsx")
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
        this.importTaskDialogVisible = false
        this.getTableData()
      } else {
        this.$modal.msgError(res.msg || "上传文件异常")
      }
    },
  },
  mounted() {
    getProjectListApi().then((res) => {
      // 获取项目列表
      this.projectOptions = res.data
      //处理已暂停的项目状态
      projectStatus(this.projectOptions)
      // 如果是从项目详情进入该页面，那么需要将项目ID的值固定
      if (this.isProjectInfo) {
        this.searchData.projectId = this.projectData.projectId
        this.changeSearchProject(this.searchData.projectId)
      }
      this.getTableData()
    })
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
  ::v-deep .el-card__body {
    display: flex;
    justify-content: space-between;
  }
}

.table-wrapper {
  margin-bottom: 20px;
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
