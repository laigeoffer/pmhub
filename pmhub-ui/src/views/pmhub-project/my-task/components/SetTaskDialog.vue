<template>
  <div>
    <el-dialog title="任务设置" :visible.sync="visible" width="1200px" :before-close="handleClose" @open="handleOpen">
      <el-tabs tab-position="left" v-model="tabActiveName">
        <el-tab-pane label="交付物模板" name="交付物模板" class="deliverable-wrapper" v-if="taskId">
          <el-card shadow="never">
            <el-upload
              :action="uploadFileUrl"
              :headers="uploadFileHeaders"
              :data="uploadTemplateFileData"
              :show-file-list="false"
              :auto-upload="true"
              :before-upload="handleBeforeUpload"
              :on-success="handleUploadSuccess"
              :on-error="handleUploadError"
            >
              <el-button type="text">上传交付物模板</el-button>
            </el-upload>
          </el-card>
          <el-card shadow="never">
            <el-table :data="templateList">
              <el-table-column label="文件名" prop="fileName" align="center" show-overflow-tooltip />
              <el-table-column label="上传人" prop="nickName" align="center" show-overflow-tooltip />
              <el-table-column label="文件大小（KB）" prop="fileSize" align="center" show-overflow-tooltip />
              <el-table-column label="上传时间" prop="createdTime" align="center" show-overflow-tooltip />
              <el-table-column label="操作" align="center" width="100">
                <template slot-scope="scope">
                  <el-button type="text" @click="handleDownload(scope.row)">下载</el-button>
                  <el-button type="text" @click="handleDelete(scope.row)" style="color: #f56c6c">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="审批设置" name="审批设置" class="approval-wrapper">
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
import { getToken } from "@/utils/auth"
import { listProcess, getBpmnXml } from "@/api/workflow/process"
import { listAllCategory } from "@/api/workflow/category"
import { updateApprovalSetApi } from "@/api/pmhub-project/my-task"
import { getFileListApi, deleteFileApi } from "@/api/pmhub-project/my-project.js"
import ProcessViewer from "@/components/ProcessViewer"

export default {
  name: "SetTaskDialog",
  components: {
    ProcessViewer,
  },
  props: {
    visible: {
      type: Boolean,
      default: false,
    },
    // 没有 taskId 则代表是从 "新建任务" 调用该组件
    // 有 taskId 代表是从 "任务设置" 调用该组件
    taskId: {
      type: String,
      default: "",
    },
    // 后端返回的审批设置数据（有 taskId 时才会用到 workFlowable）
    workFlowable: {
      type: Object,
    },
    // 重新获取任务列表数据
    getTableData: {
      type: Function,
    },
  },
  watch: {
    taskId: {
      handler(val) {
        this.tabActiveName = val ? "交付物模板" : "审批设置"
      },
      immediate: true,
    },
  },
  data() {
    return {
      tabActiveName: "",

      /** 交付物模板模块 */
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/project/file/upload",
      uploadFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadTemplateFileData: {
        id: "",
        type: "template",
      },
      templateList: [],

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
      filterCategoryText: "",
      categoryOptions: [],
      categoryProps: {
        label: "categoryName",
        value: "code",
      },
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
      if (this.taskId) {
        updateApprovalSetApi({
          approved: this.isApproval ? "0" : "1",
          definitionId: this.isApproval ? this.taskDefinitionId : "",
          deploymentId: this.isApproval ? this.taskDeploymentId : "",
          taskId: this.taskId,
        }).then(() => {
          this.$modal.msgSuccess("设置成功")
          this.getTableData()
        })
      } else {
        this.$emit("change", {
          isApproval: this.isApproval,
          taskDefinitionId: this.taskDefinitionId,
          taskDeploymentId: this.taskDeploymentId,
          taskApprovalName: this.taskApprovalName,
        })
      }
      this.handleClose()
    },
    handleClose() {
      this.queryParams.pageNum = 1
      this.$emit("update:visible", false)
    },
    handleOpen() {
      this.getCategoryList()
      this.getList()
      // 如果是从任务设置进入
      if (this.taskId) {
        // 交付物模板列表
        this.getTemplateList()
        // 赋值附件上传所需的id
        this.uploadTemplateFileData.id = this.taskId
        // 回显以前的审批设置
        this.isApproval = this.workFlowable?.approved === "0" ? true : false
        this.taskDefinitionId = this.workFlowable?.definitionId ?? ""
        this.taskDeploymentId = this.workFlowable?.deploymentId ?? ""
      }
    },

    /** 交付物模板模块 */
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
        this.getTemplateList()
      } else {
        this.$modal.msgError(res.msg || "上传文件异常")
      }
    },
    getTemplateList() {
      getFileListApi({
        pageNum: 1,
        pageSize: 1,
        fileName: undefined,
        id: this.taskId,
        type: "template",
      })
        .then((res) => {
          this.templateList = res.data.list
        })
        .catch(() => {
          this.templateList = []
        })
    },
    handleDownload(row) {
      this.download(
        "/project/file/download",
        {
          projectFileId: row.projectFileId,
          fileUrl: row.fileUrl,
        },
        row.fileName
      )
    },
    handleDelete(row) {
      const data = {
        fileVOList: [
          {
            projectFileId: row.projectFileId,
            fileUrl: row.fileUrl,
          },
        ],
      }
      this.$modal
        .confirm(`是否确认删除文件：${row.fileName}？`)
        .then(() => {
          return deleteFileApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("删除成功")
          this.getTemplateList()
        })
        .catch(() => {})
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
