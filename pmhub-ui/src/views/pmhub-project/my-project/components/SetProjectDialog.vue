<template>
  <div>
    <el-dialog title="设置项目" :visible.sync="visible" width="1200px" :before-close="handleClose" @open="handleOpen">
      <el-tabs tab-position="left" v-model="tabActiveName">
        <el-tab-pane label="基础信息" name="基础信息" class="info-wrapper">
          <el-card shadow="never">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-upload
                  ref="coverUploadRef"
                  :action="uploadCoverFileUrl"
                  :headers="uploadCoverFileHeaders"
                  :data="uploadCoverFileData"
                  :show-file-list="true"
                  :auto-upload="true"
                  :file-list="coverFileList"
                  :before-upload="handleCoverBeforeUpload"
                  :on-change="handleCoverUploadChange"
                  :on-error="handleCoverUploadError"
                  :on-success="handleCoverUploadSuccess"
                  :on-remove="handleCoverUploadRemove"
                  list-type="picture-card"
                >
                  <i class="el-icon-plus" />
                  <div slot="tip" class="el-upload__tip">项目封面最佳图片比例为 150 * 150</div>
                </el-upload>
              </el-col>
              <el-col :span="12">
                <el-form ref="infoFormRef1" :model="infoFormData" label-width="100px" label-position="left">
                  <el-form-item prop="projectName" label="项目名称">
                    <el-input v-model="infoFormData.projectName" placeholder="请输入" />
                  </el-form-item>
                  <el-form-item prop="projectProcess" label="项目进度(%)">
                    <el-input-number
                      v-model.number.trim="infoFormData.projectProcess"
                      :min="0"
                      :max="100"
                      placeholder="请输入"
                    />
                  </el-form-item>
                  <el-form-item prop="description" label="项目描述">
                    <el-input v-model="infoFormData.description" type="textarea" :rows="2" placeholder="请输入" />
                  </el-form-item>
                </el-form>
              </el-col>
            </el-row>
          </el-card>
          <el-card shadow="never">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form ref="infoFormRef2" :model="infoFormData" label-width="100px" label-position="left">
                  <el-form-item prop="projectType" label="项目类型">
                    <el-select v-model="infoFormData.projectType" placeholder="请选择">
                      <el-option
                        v-for="(item, index) in projectTypeOptions"
                        :key="index"
                        :label="item.label"
                        :value="item.value"
                      >
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item prop="status" label="项目状态">
                    <el-select v-model="infoFormData.status" placeholder="请选择" :disabled="infoFormData.status === 2">
                      <el-option
                        v-for="(item, index) in statusOptions"
                        :key="index"
                        :label="item.label"
                        :value="item.value"
                        :disabled="item.value === 2"
                      >
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item prop="published" label="发布状态">
                    <el-select v-model="infoFormData.published" placeholder="请选择">
                      <el-option
                        v-for="(item, index) in publishedOptions"
                        :key="index"
                        :label="item.label"
                        :value="item.value"
                      >
                      </el-option>
                    </el-select>
                  </el-form-item>
                </el-form>
              </el-col>
              <el-col :span="12">
                <el-form ref="infoFormRef3" :model="infoFormData" label-width="100px" label-position="left">
                  <el-form-item prop="userId" label="项目负责人">
                    <el-select v-model="infoFormData.userId" filterable placeholder="请选择">
                      <el-option
                        v-for="(item, index) in nickOptions"
                        :key="index"
                        :label="item.label"
                        :value="item.value"
                      >
                      </el-option>
                    </el-select>
                    <el-tooltip content="请先邀请成员进入项目">
                      <i class="el-icon-question" style="margin-left: 10px; font-size: 18px" />
                    </el-tooltip>
                  </el-form-item>
                  <el-form-item prop="time" label="项目起止时间">
                    <el-date-picker
                      v-model="infoFormData.time"
                      type="datetimerange"
                      value-format="yyyy-MM-dd HH:mm:ss"
                      range-separator="至"
                      start-placeholder="开始日期"
                      end-placeholder="结束日期"
                    >
                    </el-date-picker>
                  </el-form-item>
                  <el-form-item prop="stageCode" label="项目所属阶段">
                    <el-select v-model="infoFormData.stageCode" placeholder="请选择">
                      <el-option
                        v-for="(item, index) in stageCodeOptions"
                        :key="index"
                        :label="item.label"
                        :value="item.value"
                      >
                      </el-option>
                    </el-select>
                  </el-form-item>
                </el-form>
              </el-col>
            </el-row>
          </el-card>
          <el-card shadow="never">
            <el-descriptions title="" :column="1">
              <el-descriptions-item label="项目创建时间">{{ projectData.createdTime }}</el-descriptions-item>
              <el-descriptions-item label="项目更新时间">{{ projectData.updatedTime }}</el-descriptions-item>
            </el-descriptions>
          </el-card>
          <el-card shadow="never" class="file">
            <template slot="header">
              <span>附件</span>
              <el-upload
                :action="uploadFileUrl"
                :headers="uploadCoverFileHeaders"
                :data="uploadFileData"
                :show-file-list="false"
                :auto-upload="true"
                :before-upload="handleBeforeUpload"
                :on-success="handleUploadSuccess"
                :on-error="handleUploadError"
              >
                <el-button type="text">上传</el-button>
              </el-upload>
            </template>
            <el-table :data="fileList">
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
        <el-tab-pane label="项目功能" name="项目功能" class="function-wrapper">
          <el-card shadow="never">
            <h3>项目编号</h3>
            <div class="flex-space-between">
              <span>设置项目编号，编号将作为项目业务唯一键，用以区别项目</span>
              <el-switch v-model="functionData.openPrefix" :active-value="1" :inactive-value="0" />
            </div>
            <el-input v-if="functionData.openPrefix" v-model="functionData.prefix" placeholder="请输入编号" />
          </el-card>
          <el-card shadow="never">
            <h3>自动更新项目进度</h3>
            <div class="flex-space-between">
              <span>根据当前任务的完成情况自动计算项目进度</span>
              <el-switch v-model="functionData.autoUpdateProcess" :active-value="1" :inactive-value="0" />
            </div>
          </el-card>
          <el-card shadow="never">
            <h3>消息提醒</h3>
            <div class="flex-space-between">
              <span>开启消息提醒，方便对项目下的任务设置逾期及快逾期提醒，提醒的配置需在消息配置页面设置</span>
              <el-switch v-model="functionData.msgNotify" :active-value="1" :inactive-value="0" />
            </div>
            <div v-if="functionData.msgNotify">
              提前
              <el-input-number v-model="functionData.notifyDay" :min="0" size="mini" />
              天提醒
            </div>
          </el-card>
          <el-card shadow="never">
            <h3>新任务默认开启隐私模式</h3>
            <div class="flex-space-between">
              <span>对本项目内的新任务默认开启隐私模式，创建成功后仅参与者可见</span>
              <el-switch v-model="functionData.openTaskPrivate" :active-value="1" :inactive-value="0" />
            </div>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="事项流转" name="事项流转" class="circulation-wrapper">
          <el-card shadow="never">
            <h3>自动化规则（敬请期待）</h3>
            <div>
              <span>设置流转规则，任务流转审批自动化</span>
            </div>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="阶段设置" name="阶段设置" class="stage-wrapper">
          <el-card shadow="never">
            <div class="flex-space-between" v-for="(item, index) in stageList" :key="index">
              <el-input v-model="item.stageName" placeholder="请输入" @change="handleUpdateStage(item)" />
              <el-button
                type="danger"
                icon="el-icon-delete"
                circle
                @click="handleDeleteStage(item.stageId)"
              ></el-button>
            </div>
            <el-button type="primary" @click="handleAddStage">新 增</el-button>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="项目操作" name="项目操作" class="operate-wrapper">
          <el-card shadow="never">
            <h3>项目操作</h3>
            <p>您可以执行以下操作</p>
            <el-button type="primary" @click="projectArchive" :disabled="this.projectData.status == 2">
              {{ this.projectData.status == 2 ? "已归档" : "归档" }}
            </el-button>
            <el-button type="danger" @click="projectDelete">删除（移至回收站）</el-button>
            <el-button type="info" @click="projectQuit">退出项目</el-button>
          </el-card>
        </el-tab-pane>
      </el-tabs>
      <template slot="footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="handleSave">保 存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import {
  projectEditApi,
  getProjectMemberApi,
  getStageListApi,
  createStageApi,
  deleteStageApi,
  updateStageApi,
  projectArchiveApi,
  deleteProjectApi,
  projectQuitApi,
  deleteFileApi,
  getFileListApi,
} from "@/api/pmhub-project/my-project.js"
import { getToken } from "@/utils/auth"

export default {
  name: "SetProjectDialog",
  props: {
    visible: {
      type: Boolean,
      default: false,
    },
    // 项目基本数据
    projectData: {
      type: Object,
      required: true,
    },
    // 重新获取表格数据
    getTableData: {
      type: Function,
      required: true,
    },
  },
  data() {
    return {
      tabActiveName: "基础信息",

      /* 基础信息模块 */
      uploadCoverFileUrl: process.env.VUE_APP_BASE_API + "/project/file/upload",
      uploadCoverFileHeaders: { Authorization: "Bearer " + getToken() },
      uploadCoverFileData: { id: "", type: "cover" },
      coverFileList: [],
      infoFormData: {
        cover: "", // 封面 URL
        projectName: "", // 项目名称
        projectProcess: 0, // 项目进度
        description: "", // 描述
        projectType: 0, // 项目类型
        status: 0, // 项目状态
        published: 0, // 是否发布
        userId: 0, // 负责人 ID
        time: [], // 起止时间
        stageCode: 0, // 项目阶段 code
        projectId: "", // 项目 ID
      },
      projectTypeOptions: [
        {
          label: "公开（所有人都可通过链接访问，仅项目成员可编辑）",
          value: 0,
        },
        {
          label: "私有（仅项目成员可查看和编辑）",
          value: 1,
        },
      ],
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
          label: "已归档",
          value: 2,
        },
        {
          label: "已逾期",
          value: 3,
        },
        {
          label: "已暂停",
          value: 4,
        },
      ],
      publishedOptions: [
        {
          label: "未发布",
          value: 0,
        },
        {
          label: "已发布",
          value: 1,
        },
      ],
      nickOptions: [],
      stageCodeOptions: [],

      /* 附件 */
      fileList: [],
      uploadFileUrl: process.env.VUE_APP_BASE_API + "/project/file/upload",
      uploadFileData: {
        id: "",
        type: "project",
      },

      /* 项目功能模块 */
      functionData: {
        openPrefix: 0, // 0-否 1-开启
        prefix: "", // 项目编号
        autoUpdateProcess: 0, // 0-否 1-是
        msgNotify: 0, // 0-否 1-是
        notifyDay: 2, // 逾期消息提醒默认天数
        openTaskPrivate: 1, // 0-否 1-是
      },

      /* 阶段设置模块 */
      stageList: [],
    }
  },
  methods: {
    /* 基础信息模块 */
    handleCoverBeforeUpload(file) {
      // 上传文件之前触发
      const isJPG = file.type === "image/jpeg"
      const isPNG = file.type === "image/png"
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!(isJPG || isPNG)) {
        this.$message.error("上传图片只能是 JPG/JPEG/PNG 格式!")
      }
      if (!isLt2M) {
        this.$message.error("上传图片大小不能超过 2MB!")
      }
      return (isJPG || isPNG) && isLt2M
    },
    handleCoverUploadChange(file, fileList) {
      // 用来控制列表
      this.coverFileList = fileList.slice(-1)
    },
    handleCoverUploadError() {
      // 上传失败时触发
      this.$modal.msgError("封面上传失败")
    },
    handleCoverUploadSuccess(res) {
      // 上传成功时触发
      this.$modal.msgSuccess("封面上传成功")
      this.infoFormData.cover = res.data.fileUrl
      this.coverFileList.push({
        name: res.data.fileName,
        url: res.data.fileUrl,
      })
      this.getTableData()

      if (res.code === 200) {
      } else {
        this.$modal.msgError(res.msg || "上传文件异常")
      }
    },
    handleCoverUploadRemove(file, fileList) {
      this.coverFileList = []
      this.infoFormData.cover = ""
    },
    handleSave() {
      const data = {
        ...this.infoFormData,
        ...this.functionData,
        closeBeginTime: this.infoFormData.time ? this.infoFormData.time[0] : undefined,
        closeEndTime: this.infoFormData.time ? this.infoFormData.time[1] : undefined,
      }
      data.time = undefined // 后端接口不需要该属性
      projectEditApi(data).then((res) => {
        this.$modal.msgSuccess("保存成功")
        this.getTableData()
        this.$emit("update:visible", false)
      })
    },
    handleClose() {
      this.coverFileList = []
      this.$emit("update:visible", false)
    },
    handleOpen() {
      // 将项目数据赋值到对话框页面
      this.coverFileList = this.projectData.cover
        ? [{ name: "", url: process.env.VUE_APP_BASE_API + this.projectData.cover }]
        : []
      // 赋值基础信息数据
      this.infoFormData.cover = this.projectData.cover
      this.infoFormData.projectName = this.projectData.projectName
      this.infoFormData.projectProcess = this.projectData.projectProcess
      this.infoFormData.description = this.projectData.description
      this.infoFormData.projectType = this.projectData.projectType
      this.infoFormData.status = this.projectData.status
      this.infoFormData.published = this.projectData.published
      this.infoFormData.userId = this.projectData.userId
      this.infoFormData.time = [this.projectData.closeBeginTime ?? "", this.projectData.closeEndTime ?? ""]
      this.infoFormData.stageCode = this.projectData.stageCode
      this.infoFormData.projectId = this.projectData.projectId
      // 赋值项目功能数据
      this.functionData.openPrefix = this.projectData.openPrefix
      this.functionData.prefix = this.projectData.prefix
      this.functionData.autoUpdateProcess = this.projectData.autoUpdateProcess
      this.functionData.msgNotify = this.projectData.msgNotify
      this.functionData.notifyDay = this.projectData.notifyDay
      this.functionData.openTaskPrivate = this.projectData.openTaskPrivate
      // 赋值附件上传所需的id
      this.uploadCoverFileData.id = this.projectData.projectId
      this.uploadFileData.id = this.projectData.projectId

      // 获取可选的负责人列表
      getProjectMemberApi(this.projectData.projectId).then((res) => {
        this.nickOptions = []
        for (let i = 0; i < res.data.length; i++) {
          const item = res.data[i]
          this.nickOptions.push({
            label: item.nickName,
            value: item.userId,
          })
        }
      })
      // 获取阶段列表
      this.getStageList()
      // 获取附件
      this.getFileList()
    },

    /* 附件 */
    getFileList() {
      getFileListApi({
        pageNum: 1,
        pageSize: 50,
        fileName: undefined,
        id: this.projectData.projectId,
        type: "project",
      })
        .then((res) => {
          this.fileList = res.data.list
        })
        .catch(() => {
          this.fileList = []
        })
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
        this.getFileList()
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
          this.getFileList()
        })
        .catch(() => {})
    },

    /* 阶段设置模块 */
    getStageList() {
      getStageListApi(this.projectData.projectId).then((res) => {
        this.stageList = res.data
        this.stageCodeOptions = []
        for (let i = 0; i < res.data.length; i++) {
          const item = res.data[i]
          this.stageCodeOptions.push({
            label: item.stageName,
            value: item.stageCode,
          })
        }
      })
    },
    handleAddStage() {
      // 添加新阶段
      createStageApi(this.projectData.projectId, "请重命名").then((res) => {
        this.$modal.msgSuccess("已新增一个阶段")
        this.getStageList()
      })
    },
    handleDeleteStage(stageId) {
      // 删除一个阶段
      deleteStageApi(stageId).then((res) => {
        this.$modal.msgSuccess("删除阶段成功")
        this.getStageList()
      })
    },
    handleUpdateStage(item) {
      // 修改阶段名称
      updateStageApi(item.stageId, item.stageName).then((res) => {
        this.$modal.msgSuccess("修改阶段名称成功")
        this.getStageList()
      })
    },

    /* 项目操作模块 */
    projectArchive() {
      // 归档项目
      this.$modal
        .confirm("该操作是不可逆的，确定归档该项目?")
        .then(() => {
          return projectArchiveApi(this.projectData.projectId)
        })
        .then(() => {
          this.$modal.msgSuccess("归档成功")
          this.getTableData()
          this.$emit("update:visible", false)
        })
        .catch(() => {})
    },
    projectDelete() {
      // 删除项目
      const id = this.projectData.projectId
      const name = this.projectData.projectName
      this.$modal
        .confirm(`是否确认删除项目：${name}？`)
        .then(() => {
          return deleteProjectApi(id)
        })
        .then(() => {
          this.$modal.msgSuccess("删除成功")
          this.getTableData()
          this.$emit("update:visible", false)
        })
        .catch(() => {})
    },
    projectQuit() {
      // 退出项目
      const id = this.projectData.projectId
      const name = this.projectData.projectName
      this.$modal
        .confirm(`是否退出项目：${name}？`)
        .then(() => {
          return projectQuitApi(id)
        })
        .then(() => {
          this.$modal.msgSuccess("退出项目成功")
          this.getTableData()
          this.$emit("update:visible", false)
        })
        .catch(() => {})
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

.info-wrapper {
  .file {
    ::v-deep .el-card__header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
  }
}

.function-wrapper {
  ::v-deep .el-card__body {
    .flex-space-between {
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
    }
  }
}

.circulation-wrapper {
}

.stage-wrapper {
  ::v-deep .el-card__body {
    padding: 2% 25%;
    .flex-space-between {
      margin-bottom: 10px;
      .el-input {
        margin-right: 20px;
      }
      display: flex;
      justify-content: center;
      align-items: center;
    }
  }
}

.operate-wrapper {
}
</style>
