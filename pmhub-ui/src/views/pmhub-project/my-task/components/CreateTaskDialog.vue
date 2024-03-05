<template>
  <div>
    <el-dialog title="新建任务" :visible.sync="visible" width="50%" :before-close="handleClose" @open="handleOpen">
      <el-form ref="formRef" :rules="rules" :model="formData" label-width="150px" label-position="top" inline>
        <el-form-item prop="taskName" label="任务名称">
          <el-input v-model="formData.taskName" placeholder="请输入" />
        </el-form-item>
        <el-form-item prop="approvalName">
          <template slot="label">
            <span>审批设置</span>
            <el-button type="text" style="margin-left: 10px" @click="setTaskDialogVisible = true">去设置</el-button>
          </template>
          <el-input v-model="formData.approvalName" disabled />
        </el-form-item>
        <el-form-item prop="projectId" label="所属项目">
          <el-select
            v-model="formData.projectId"
            placeholder="请选择"
            @change="changeDialogProject"
            :disabled="isSubTask || isProjectInfo"
            filterable
          >
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
        <el-form-item prop="taskPriority" label="优先级">
          <el-select v-model="formData.taskPriority" placeholder="请选择">
            <el-option
              v-for="(item, index) in taskPriorityOptions"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="userId" label="执行人">
          <el-select v-model="formData.userId" placeholder="请选择" filterable>
            <el-option v-for="(item, index) in userOptions" :key="index" :label="item.nickName" :value="item.userId">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="projectStageId" label="所属阶段">
          <el-select v-model="formData.projectStageId" placeholder="请选择">
            <el-option
              v-for="(item, index) in dialogStageOptions"
              :key="index"
              :label="item.stageName"
              :value="item.stageId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-row>
          <el-col :span="24">
            <el-form-item prop="description" label="描述">
              <editor v-model="formData.description" :min-height="192" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item prop="taskFlow" label="所属流程">
          <el-input v-model="formData.taskFlow" placeholder="请输入所属流程名" />
        </el-form-item>
        <el-form-item prop="beginTime" label="预计开始时间">
          <el-date-picker
            v-model="formData.beginTime"
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择日期时间"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item prop="endTime" label="预计结束时间">
          <el-date-picker
            v-model="formData.endTime"
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择日期时间"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item prop="closeTime" label="截止时间">
          <el-date-picker
            v-model="formData.closeTime"
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="选择日期时间"
          >
          </el-date-picker>
        </el-form-item>
      </el-form>
      <template slot="footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="handleCreate">确 定</el-button>
      </template>
    </el-dialog>
    <!-- 任务设置对话框 -->
    <SetTaskDialog :visible.sync="setTaskDialogVisible" @change="changeApproval" v-if="visible" />
  </div>
</template>

<script>
import { createTaskApi, getTaskExecutorListApi, createSubTaskApi } from "@/api/pmhub-project/my-task.js"
import { getStageListApi } from "@/api/pmhub-project/my-project.js"
import SetTaskDialog from "./SetTaskDialog.vue"

export default {
  name: "CreateTaskDialog",
  components: { SetTaskDialog },
  props: {
    visible: {
      type: Boolean,
      default: false,
    },
    // 重新获取表格数据
    getTableData: {
      type: Function,
      required: true,
    },
    // 所属项目需要的下拉框数据
    projectOptions: {
      type: Array,
      required: true,
    },
    // 优先级需要的下拉框数据
    taskPriorityOptions: {
      type: Array,
      required: true,
    },
    // 是否为添加子任务（一共有添加任务和添加子任务两种模式）
    isSubTask: {
      type: Boolean,
      default: false,
    },
    // 父任务 ID（添加子任务时需要传递）
    taskId: {
      type: String,
      default: "",
    },
    // 是否是从项目详情进入到该页面
    isProjectInfo: {
      type: Boolean,
      default: false,
    },
    // 项目 ID（"添加子任务" 和从 "从项目详情进入到该页面" 时需要传递）
    projectId: {
      type: String,
      default: "",
    },
  },

  data() {
    return {
      formData: {
        taskName: "",
        projectId: "",
        taskPriority: "",
        userId: "",
        projectStageId: "",
        description: "",
        taskFlow: "",
        beginTime: "",
        endTime: "",
        closeTime: "",
        // 审批设置相关
        approvalName: "当前审批流：无需审批", // 当前选择的流程名
        approved: "1", // 1:无需审批 0:需要审批
        definitionId: "", // 当前选择的流程 id
        deploymentId: "", // 当前选择的部署 id
      },
      userOptions: [], // 执行人需要的下拉框数据
      dialogStageOptions: [], // 所属阶段需要的下拉框数据
      rules: {
        taskName: [{ required: true, message: "必填", trigger: "blur" }],
        approvalName: [{ required: true, message: "必填", trigger: "blur" }],
        projectId: [{ required: true, message: "必填", trigger: "change" }],
        taskPriority: [{ required: true, message: "必填", trigger: "change" }],
        userId: [{ required: true, message: "必填", trigger: "change" }],
      },
      /** 任务设置对话框 */
      setTaskDialogVisible: false,
    }
  },
  methods: {
    handleCreate() {
      this.$refs["formRef"].validate((valid) => {
        if (valid) {
          if (this.isSubTask) {
            createSubTaskApi({
              taskId: this.taskId,
              taskName: this.formData.taskName,
              projectId: this.formData.projectId,
              taskPriority: this.formData.taskPriority,
              userId: this.formData.userId,
              projectStageId: this.formData.projectStageId,
              description: this.formData.description,
              taskFlow: this.formData.taskFlow,
              beginTime: this.formData.beginTime ? this.formData.beginTime : undefined,
              endTime: this.formData.endTime ? this.formData.endTime : undefined,
              closeTime: this.formData.closeTime ? this.formData.closeTime : undefined,
              approved: this.formData.approved,
              definitionId: this.formData.definitionId,
              deploymentId: this.formData.deploymentId,
            }).then((res) => {
              this.$modal.msgSuccess("创建子任务成功")
              this.getTableData()
            })
          } else {
            createTaskApi({
              taskName: this.formData.taskName,
              projectId: this.formData.projectId,
              taskPriority: this.formData.taskPriority,
              userId: this.formData.userId,
              projectStageId: this.formData.projectStageId,
              description: this.formData.description,
              taskFlow: this.formData.taskFlow,
              beginTime: this.formData.beginTime ? this.formData.beginTime : undefined,
              endTime: this.formData.endTime ? this.formData.endTime : undefined,
              closeTime: this.formData.closeTime ? this.formData.closeTime : undefined,
              approved: this.formData.approved,
              definitionId: this.formData.definitionId,
              deploymentId: this.formData.deploymentId,
            }).then((res) => {
              this.$modal.msgSuccess("创建任务成功")
              this.getTableData()
              this.handleClose()
            })
          }
        } else {
          return false
        }
      })
    },
    handleClose() {
      this.$refs["formRef"].resetFields()
      this.userOptions = []
      this.dialogStageOptions = []
      this.resetApproval()
      this.$emit("update:visible", false)
    },
    handleOpen() {
      if (this.isSubTask || this.isProjectInfo) {
        this.formData.projectId = this.projectId
        this.changeDialogProject(this.projectId)
      }
    },
    changeDialogProject(projectId) {
      this.formData.userId = ""
      this.formData.projectStageId = ""
      this.userOptions = []
      this.dialogStageOptions = []
      getTaskExecutorListApi(projectId).then((res) => {
        // 查询执行人列表
        this.userOptions = res.data
      })
      getStageListApi(projectId).then((res) => {
        // 查询阶段列表
        this.dialogStageOptions = res.data
      })
    },

    /** 任务设置对话框 */
    changeApproval(data) {
      this.formData.approvalName = "当前审批流：" + (data.isApproval ? data.taskApprovalName : "无需审批")
      this.formData.approved = data.isApproval ? "0" : "1"
      this.formData.definitionId = data.isApproval ? data.taskDefinitionId : ""
      this.formData.deploymentId = data.isApproval ? data.taskDeploymentId : ""
      this.setTaskDialogVisible = false
    },
    // 重置审批设置数据
    resetApproval() {
      this.formData.approvalName = "当前审批流：无需审批"
      this.formData.approved = ""
      this.formData.definitionId = ""
      this.formData.deploymentId = ""
    },
  },
  mounted() {},
}
</script>

<style scoped lang="scss"></style>
