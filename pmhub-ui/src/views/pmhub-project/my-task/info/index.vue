<template>
  <div class="app-container">
    <el-card shadow="never" class="title-wrapper">
      任务名称：<el-input v-model.trim="taskName" @change="updateTaskInfo" size="mini"></el-input>
    </el-card>
    <el-card shadow="never" class="param-wrapper">
      <div class="panel">
        <el-image :src="userAvatar" style="width: 50px; height: 50px" fit="cover">
          <div slot="error" style="display: flex; justify-content: center; align-items: center; height: 100%">
            <i class="el-icon-picture-outline" style="font-size: 40px"></i>
          </div>
        </el-image>
        <div class="content">
          <el-select
            v-model="param.userId"
            @change="updateTaskInfo"
            @visible-change="changeUserAvatar"
            size="mini"
            filterable
          >
            <el-option v-for="(item, index) in userOptions" :key="index" :label="item.nickName" :value="item.userId">
            </el-option>
          </el-select>
          <span class="title">执行人</span>
        </div>
      </div>
      <div class="panel">
        <el-image :src="projectCover" style="width: 50px; height: 50px" fit="cover">
          <div slot="error" style="display: flex; justify-content: center; align-items: center; height: 100%">
            <i class="el-icon-picture-outline" style="font-size: 40px"></i>
          </div>
        </el-image>
        <div class="content">
          <el-select
            v-model="param.projectId"
            size="mini"
            @change="updateTaskInfo"
            @visible-change="changeProjectCover"
            filterable
          >
            <el-option
              v-for="(item, index) in projectOptions"
              :key="index"
              :label="item.projectName"
              :value="item.projectId"
            >
            </el-option>
          </el-select>
          <span class="title">所属项目</span>
        </div>
      </div>
      <div class="panel">
        <i v-if="param.executeStatus === 0" class="el-icon-remove-outline" style="font-size: 40px; color: #e6a23c" />
        <i v-else-if="param.executeStatus === 1" class="el-icon-time" style="font-size: 40px; color: #409eff" />
        <i v-else class="el-icon-circle-check" style="font-size: 40px; color: #67c23a" />
        <div class="content">
          <el-select v-model="param.executeStatus" @change="updateTaskInfo" size="mini">
            <el-option
              v-for="(item, index) in executeStatusOptions"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
          <span class="title">执行状态</span>
        </div>
      </div>
      <div class="panel">
        <i v-if="param.status === 0" class="el-icon-remove-outline" style="font-size: 40px; color: #e6a23c" />
        <i v-else-if="param.status === 1" class="el-icon-time" style="font-size: 40px; color: #409eff" />
        <i v-else-if="param.status === 2" class="el-icon-circle-check" style="font-size: 40px; color: #67c23a" />
        <i v-else class="el-icon-warning-outline" style="font-size: 40px; color: #f56c6c" />
        <div class="content">
          <el-select v-model="param.status" @change="updateTaskInfo" size="mini">
            <el-option v-for="(item, index) in statusOptions" :key="index" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
          <span class="title">任务状态</span>
        </div>
      </div>
      <div class="panel">
        <i v-if="param.taskPriority === 0" class="el-icon-warning" style="font-size: 40px; color: #f56c6c" />
        <i v-else-if="param.taskPriority === 1" class="el-icon-warning" style="font-size: 40px; color: #f56c6ccc" />
        <i v-else-if="param.taskPriority === 2" class="el-icon-warning" style="font-size: 40px; color: #f56c6caa" />
        <i v-else-if="param.taskPriority === 3" class="el-icon-warning" style="font-size: 40px; color: #f56c6c99" />
        <i v-else class="el-icon-warning" style="font-size: 40px; color: #f56c6c77" />
        <div class="content">
          <el-select v-model="param.taskPriority" @change="updateTaskInfo" size="mini">
            <el-option
              v-for="(item, index) in taskPriorityOptions"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
          <span class="title">优先级</span>
        </div>
      </div>
      <div class="panel">
        <i class="el-icon-s-flag" style="font-size: 40px; color: #409eff" />
        <div class="content">
          <el-select v-model="param.projectStageId" @change="updateTaskInfo" size="mini">
            <el-option v-for="(item, index) in stageOptions" :key="index" :label="item.stageName" :value="item.stageId">
            </el-option>
          </el-select>
          <span class="title">所属阶段</span>
        </div>
      </div>
      <div class="panel">
        <i class="el-icon-collection-tag" style="font-size: 40px; color: #409eff" />
        <div class="content">
          <el-input v-model.trim="param.taskFlow" @change="updateTaskInfo" size="mini"></el-input>
          <span class="title">所属流程</span>
        </div>
      </div>
    </el-card>
    <el-row :gutter="20">
      <el-col :span="12" class="maxHeight70">
        <el-card shadow="never" class="description-wrapper">
          <div style="font-size: 16px; font-weight: bold; margin-bottom: 20px">描述</div>
          <editor v-model="description" :min-height="192" @input="updateTaskInfoStabilization" />
        </el-card>
        <el-card shadow="never" class="basic-wrapper">
          <el-descriptions :column="1" title="基础信息">
            <el-descriptions-item label="所属项目">{{ basic.projectName }}</el-descriptions-item>
            <el-descriptions-item label="所属阶段">{{ basic.stageName }}</el-descriptions-item>
            <el-descriptions-item label="所属流程">{{ basic.taskFlow }}</el-descriptions-item>
            <el-descriptions-item label="创建者">{{ basic.executor }}</el-descriptions-item>
            <el-descriptions-item label="创建时间">{{ basic.createdTime }}</el-descriptions-item>
            <el-descriptions-item label="更新时间">{{ basic.updatedTime }}</el-descriptions-item>
          </el-descriptions>
        </el-card>
        <el-card shadow="never" class="progress-wrapper">
          <el-descriptions :column="1" title="周期与进度">
            <el-descriptions-item label="预计开始日期">
              <el-date-picker
                v-model="progress.beginTime"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                size="mini"
                @change="updateTaskInfo"
              />
            </el-descriptions-item>
            <el-descriptions-item label="预计完成日期">
              <el-date-picker
                v-model="progress.endTime"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                size="mini"
                @change="updateTaskInfo"
              />
            </el-descriptions-item>
            <el-descriptions-item label="截止日期">
              <el-date-picker
                v-model="progress.closeTime"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                size="mini"
                @change="updateTaskInfo"
              />
            </el-descriptions-item>
            <el-descriptions-item :label="`进度 ${progress.taskProcess}%`">
              <el-input-number
                v-model="progress.taskProcess"
                :min="0"
                :max="100"
                size="mini"
                @change="updateTaskInfo"
              />
            </el-descriptions-item>
          </el-descriptions>
        </el-card>
        <el-card shadow="never" class="subtask-wrapper">
          <template slot="header">
            <span>子任务</span>
            <el-button type="text" @click="createSubTaskDialogVisible = true">添加</el-button>
          </template>
          <div
            class="item"
            v-for="(item, index) in subTaskList"
            :key="index"
            @click="clickSubTask(item.taskId, item.taskName)"
          >
            <span>{{ item.taskName }}</span>
            <el-tag v-if="item.status === 0" type="info">{{ item.statusName }}</el-tag>
            <el-tag v-else-if="item.status === 1">{{ item.statusName }}</el-tag>
            <el-tag v-else-if="item.status === 2" type="success">{{ item.statusName }}</el-tag>
            <el-tag v-else-if="item.status === 3" type="danger">{{ item.statusName }}</el-tag>
          </div>
        </el-card>
        <el-card shadow="never" class="deliverable-wrapper">
          <template slot="header">
            <span>交付物</span>
            <div>
              <el-button type="text" @click="importTaskFileDialogVisible = true">上传交付物</el-button>
            </div>
          </template>
          <el-table :data="taskFileList">
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
      </el-col>
      <el-col :span="12">
        <el-card header="动态" shadow="never" class="dynamic-wrapper">
          <el-radio-group v-model="dynamicRadio" @input="changeDynamicRadio">
            <el-radio-button :label="-1">全部</el-radio-button>
            <el-radio-button :label="1">变更记录</el-radio-button>
            <el-radio-button :label="2">交付物</el-radio-button>
            <el-radio-button :label="3">评论</el-radio-button>
          </el-radio-group>
          <div class="maxHeight55">
            <div class="item" v-for="(item, index) in taskLogList" :key="index">
              <div class="left">
                <img :src="item.avatar" width="24px" height="24px" />
                <div>
                  <div class="title">{{ item.nickName }} - {{ item.remark }}</div>
                  <div v-if="item.logType === 1 && item.content[0].field !== 'description'" class="content">
                    <el-tag type="info" size="mini">{{ item.content[0].oldValue }}</el-tag>
                    更改为
                    <el-tag size="mini">{{ item.content[0].newValue }}</el-tag>
                  </div>
                  <div v-if="item.logType === 2" class="content">{{ item.content.split("/").pop() }}</div>
                  <div v-if="item.logType === 3" class="content">{{ item.content }}</div>
                </div>
              </div>
              <span class="right">{{ item.createdTime }}</span>
            </div>
          </div>
          <vue-tribute :options="tributeOptions">
            <input
              v-model="tributeValue"
              type="text"
              placeholder="@提及任务成员，Ctrl + Enter 发表评论"
              @keydown.enter="enterTribute"
            />
          </vue-tribute>
        </el-card>
      </el-col>
    </el-row>
    <!-- 新建子任务对话框 -->
    <CreateTaskDialog
      :visible.sync="createSubTaskDialogVisible"
      :getTableData="getSubTaskList"
      :projectOptions="projectOptions"
      :taskPriorityOptions="taskPriorityOptions"
      :isSubTask="true"
      :projectId="projectId"
      :taskId="this.taskId"
    />
    <!-- 上传交付物对话框 -->
    <el-dialog title="上传交付物" :visible.sync="importTaskFileDialogVisible" width="50%">
      <h3>第一步：下载交付物模板</h3>
      <p>请先下载「交付物模板」并按照模板要求上传交付物。</p>
      <p>提示：若无交付物模板，请联系项目经理；若无需模板，请直接第二步导入交付物</p>
      <el-button @click="downloadTaskTemplate">下载模板</el-button>
      <h3>第二步：上传交付物</h3>
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
import { getToken } from "@/utils/auth"
import VueTribute from "vue-tribute"
import {
  getTaskDetailApi,
  getTaskExecutorListApi,
  updateTaskDetailApi,
  getTaskLogApi,
  getTaskUserListApi,
  addTaskCommentApi,
  getSubTaskListApi,
} from "@/api/pmhub-project/my-task.js"
import { getProjectListApi } from "@/api/dashboard/index.js"
import { getStageListApi, getFileListApi, deleteFileApi } from "@/api/pmhub-project/my-project.js"
import CreateTaskDialog from "../components/CreateTaskDialog.vue"

export default {
  name: "MyTaskInfo",
  components: { VueTribute, CreateTaskDialog },
  props: {},
  data() {
    return {
      taskId: "", // 从路由上获取下来的任务 ID
      projectId: "", // 从接口中获取下来的项目 ID

      /* title-wrapper 模块 */
      taskName: "",

      /* param-wrapper 模块 */
      userAvatar: "",
      projectCover: "",
      param: {
        userId: "",
        projectId: "",
        executeStatus: "",
        status: "",
        taskPriority: "",
        projectStageId: "",
        taskFlow: "",
      },
      // 执行人需要的下拉框数据
      userOptions: [],
      // 所属项目需要的下拉框数据
      projectOptions: [],
      // 执行状态需要的下拉框数据
      executeStatusOptions: [
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
      // 所属阶段需要的下拉框数据
      stageOptions: [],

      /* 描述模块 */
      description: "",
      timerId: undefined,

      /* 基础信息模块 */
      basic: {
        projectName: "",
        stageName: "",
        taskFlow: "",
        executor: "",
        createdTime: "",
        updatedTime: "",
      },

      /* 周期与进度模块 */
      progress: {
        beginTime: "",
        endTime: "",
        closeTime: "",
        taskProcess: 0,
      },

      /* 子任务模块 */
      subTaskList: [],
      createSubTaskDialogVisible: false,

      /* 交付物模块 */
      taskFileList: [],
      importTaskFileDialogVisible: false,
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/project/file/upload",
      uploadFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadFileData: {
        id: this.$route.query.taskId,
        type: "task",
      },

      /* 动态模块 */
      taskLogList: [],
      dynamicRadio: -1,
      tributeValue: "",
      tributeOptions: {
        trigger: "@",
        requireLeadingSpace: false,
        values: [],
      },
    }
  },
  methods: {
    init() {
      // 获取任务详情
      getTaskDetailApi(this.taskId).then((res) => {
        this.projectId = res.data.projectId
        // title-wrapper 模块
        this.taskName = res.data.taskName
        // param-wrapper 模块
        this.param.userId = res.data.userId
        this.param.projectId = res.data.projectId
        this.param.executeStatus = res.data.executeStatus
        this.param.status = res.data.status
        this.param.taskPriority = res.data.taskPriority
        this.param.projectStageId = res.data.projectStageId
        this.param.taskFlow = res.data.taskFlow
        // 描述模块
        this.description = res.data.description
        // 基础信息模块
        this.basic.projectName = res.data.projectName
        this.basic.stageName = res.data.stageName
        this.basic.taskFlow = res.data.taskFlow
        this.basic.executor = res.data.executor
        this.basic.createdTime = res.data.createdTime
        this.basic.updatedTime = res.data.updatedTime
        // 周期与进度模块
        this.progress.beginTime = res.data.beginTime
        this.progress.endTime = res.data.endTime
        this.progress.closeTime = res.data.closeTime
        this.progress.taskProcess = res.data.taskProcess

        // 查询执行人列表
        getTaskExecutorListApi(this.projectId).then((res) => {
          this.userOptions = res.data
          this.changeUserAvatar()
        })
        // 查询阶段列表
        getStageListApi(this.projectId).then((res) => {
          this.stageOptions = res.data
        })
      })
      getProjectListApi().then((res) => {
        // 获取项目列表
        this.projectOptions = res.data
        projectStatus(this.projectOptions)
        this.changeProjectCover()
      })
      // 获取动态数据
      this.getTaskLog()
      // 获取任务成员
      this.getTaskUserList()
    },
    changeUserAvatar() {
      // 切换执行人时，需要切换用户头像
      const options = this.userOptions
      const id = this.param.userId
      for (let i = 0; i < options.length; i++) {
        if (options[i].userId === id) {
          this.userAvatar = process.env.VUE_APP_BASE_API + options[i].avatar
          return
        }
      }
    },
    changeProjectCover() {
      // 切换所属项目时，需要切换项目封面图
      const options = this.projectOptions
      const id = this.param.projectId
      for (let i = 0; i < options.length; i++) {
        if (options[i].projectId === id) {
          this.projectCover = process.env.VUE_APP_BASE_API + options[i].cover
          return
        }
      }
    },
    updateTaskInfo() {
      // 修改任务
      const data = {
        taskName: this.taskName,
        userId: this.param.userId,
        projectId: this.param.projectId,
        executeStatus: this.param.executeStatus,
        status: this.param.status,
        taskPriority: this.param.taskPriority,
        projectStageId: this.param.projectStageId,
        taskFlow: this.param.taskFlow,
        description: this.description,
        beginTime: this.progress.beginTime ? this.progress.beginTime : "",
        endTime: this.progress.endTime ? this.progress.endTime : "",
        closeTime: this.progress.closeTime ? this.progress.closeTime : "",
        taskProcess: this.progress.taskProcess,
        taskId: this.taskId,
      }
      updateTaskDetailApi(data)
        .then((res) => {
          this.$modal.msgSuccess("修改任务成功")
        })
        .finally(() => {
          // 无论是否成功，都重新初始化当前页面的数据
          this.init()
        })
    },
    // 防抖
    updateTaskInfoStabilization() {
      if (this.timerId) {
        clearTimeout(this.timerId) // 停止之前的计时
      }
      if (this.timerId === undefined) {
        // 进入页面时会对富文本框赋值，会触发该函数，这里是为了免去刚进入页面就调更新接口
        this.timerId = null
      } else {
        this.timerId = setTimeout(() => {
          // 重新计时
          this.updateTaskInfo()
          this.timerId = null
        }, 2000)
      }
    },

    /* 描述模块 */

    /* 子任务模块 */
    getSubTaskList() {
      getSubTaskListApi(this.taskId)
        .then((res) => {
          this.subTaskList = res.data
        })
        .catch(() => {
          this.subTaskList = []
        })
    },
    clickSubTask(taskId, taskName) {
      // this.$tab.openPage(`子任务-${taskName}`, `/pmhub-project/my-task/child/info?taskId=${taskId}`)
      this.$router.push({ path: "/pmhub-project/my-task/child/info", query: { taskId: taskId } })
    },

    /* 交付物模块 */
    getTaskFileList() {
      getFileListApi({
        pageNum: 1,
        pageSize: 50,
        fileName: undefined,
        id: this.taskId,
        type: "task",
      })
        .then((res) => {
          this.taskFileList = res.data.list
        })
        .catch(() => {
          this.taskFileList = []
        })
    },
    downloadTaskTemplate() {
      this.download("/project/task/file/downloadTemplate", { taskId: this.taskId })
    },
    handleBeforeUpload(file) {
      // 上传文件之前触发
      this.$modal.loading("上传文件中...")
      // const isXlsx = file.type === "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      const isLt50M = file.size / 1024 / 1024 < 50
      if (!isLt50M) {
        this.$message.error("上传文件大小不能超过 50MB!")
        this.$modal.closeLoading()
      }
      // if (!isXlsx) {
      //   this.$message.error("只能是 xlsx 格式文件!")
      //   this.$modal.closeLoading()
      // }
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
          this.getTaskFileList()
        })
        .catch(() => {})
    },

    /* 动态模块 */
    getTaskLog() {
      getTaskLogApi({
        pageNum: 1,
        pageSize: 100,
        logType: this.dynamicRadio,
        taskId: this.taskId,
      })
        .then((res) => {
          for (let i = 0; i < res.data.length; i++) {
            const avatar = res.data[i].avatar
            res.data[i].avatar =
              avatar == "" || avatar == null ? require("@/assets/logo/logo.png") : process.env.VUE_APP_BASE_API + avatar
          }
          this.taskLogList = res.data
        })
        .catch(() => {
          this.taskLogList = []
        })
    },
    getTaskUserList() {
      getTaskUserListApi(this.taskId)
        .then((res) => {
          for (let i = 0; i < res.data.length; i++) {
            this.tributeOptions.values.push({
              key: res.data[i].nickName,
              value: res.data[i].nickName,
            })
          }
        })
        .catch(() => {
          this.tributeOptions.values = []
        })
    },
    changeDynamicRadio(label) {
      this.getTaskLog()
    },
    // 评论框按回车键
    enterTribute(e) {
      if (e.ctrlKey && e.keyCode === 13) {
        addTaskCommentApi({
          projectId: this.projectId,
          taskId: this.taskId,
          comment: this.tributeValue,
          userIdList: [],
        }).then((res) => {
          this.$modal.msgSuccess("评论成功")
          this.tributeValue = ""
          this.getTaskLog()
        })
      }
    },
  },
  mounted() {
    this.taskId = this.$route.query.taskId
    this.init()
    this.getSubTaskList()
    this.getTaskFileList()
  },
  beforeDestroy() {},
}
</script>

<style scoped lang="scss">
.el-card {
  margin-bottom: 20px;
}

.maxHeight70 {
  height: 70vh;
  max-height: 70vh;
  overflow: auto;
}

.maxHeight55 {
  height: 55vh;
  max-height: 55vh;
  overflow: auto;
}

.title-wrapper {
  .el-input {
    width: 20%;
  }
}

.param-wrapper {
  ::v-deep .el-card__body {
    display: flex;
  }
  .panel {
    margin-right: 2%;
    width: 12%;
    display: flex;
    align-items: center;
    .el-image,
    i {
      margin-right: 10px;
    }
    .content {
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      // align-items: center;
      .title {
        font-size: 14px;
        color: #888;
      }
    }
  }
}

.subtask-wrapper {
  ::v-deep .el-card__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .item {
    padding: 0 0 0 10px;
    margin-bottom: 5px;
    display: flex;
    justify-content: space-between;
    &:hover {
      cursor: pointer;
      background-color: #eee;
      border-radius: 4px;
    }
  }
}

.deliverable-wrapper {
  ::v-deep .el-card__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    div {
      display: flex;
      .el-button {
        margin-left: 20px;
      }
    }
  }
}

.dynamic-wrapper {
  .item {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
    .left {
      display: flex;
      align-items: center;
      img {
        margin-right: 10px;
      }
      .title {
        font-size: 14px;
      }
      .content {
        color: #606266;
        font-size: 12px;
      }
    }
    .right {
      color: #606266;
      font-size: 14px;
      min-width: 150px;
    }
  }
  .v-tribute {
    margin-top: 20px;
    width: 100%;
    input {
      width: 100%;
      height: 50px;
    }
  }
}
</style>
