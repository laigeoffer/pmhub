<template>
  <div>
    <el-dialog title="新建项目" :visible.sync="visible" width="50%" :before-close="handleClose">
      <el-form ref="formRef" :rules="rules" :model="formData" label-width="80px" label-position="right">
        <el-form-item prop="projectName" label="项目名称">
          <el-input v-model="formData.projectName" placeholder="请输入" />
        </el-form-item>
        <el-form-item prop="description" label="项目描述">
          <el-input v-model="formData.description" type="textarea" :rows="2" placeholder="请输入" />
        </el-form-item>
        <el-form-item prop="time" label="起止时间">
          <el-date-picker
            v-model="formData.time"
            type="datetimerange"
            value-format="yyyy-MM-dd HH:mm:ss"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item prop="type" label="私有">
          <el-checkbox v-model="formData.type" />
        </el-form-item>
      </el-form>
      <template slot="footer">
        <el-button @click="handleClose">取 消</el-button>
        <el-button type="primary" @click="handleCreate">确 定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script>
import { createProjectApi } from "@/api/pmhub-project/my-project.js"

export default {
  name: "CreateProjectDialog",
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
  },
  data() {
    return {
      formData: {
        projectName: "",
        description: "",
        time: [],
        type: false,
      },
      rules: {
        projectName: [{ required: true, message: "必填", trigger: "blur" }],
      },
    }
  },
  methods: {
    handleCreate() {
      this.$refs["formRef"].validate((valid) => {
        if (valid) {
          createProjectApi({
            projectName: this.formData.projectName,
            description: this.formData.description,
            closeBeginTime: this.formData.time ? this.formData.time[0] : undefined,
            closeEndTime: this.formData ? this.formData.time[1] : undefined,
            type: this.formData.type ? 1 : 0, // 0-公开 1-私有
          }).then((res) => {
            this.$modal.msgSuccess("创建成功")
            this.getTableData()
            this.handleClose()
          })
        } else {
          return false
        }
      })
    },
    handleClose() {
      this.$emit("update:visible", false)
    },
  },
}
</script>

<style scoped lang="scss"></style>
