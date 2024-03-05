<template>
  <div>
    <el-dialog title="发起审批流程" :visible.sync="visible" width="70%" :before-close="handleClose" @open="handleOpen">
      <div class="layout">
        <div class="form-conf" v-if="formOpen">
          <parser :key="formOpen" :form-conf="formData" @submit="submit" ref="parser" @getData="getData" />
        </div>
        <el-divider direction="vertical"></el-divider>
        <div class="action">
          <el-button type="primary" size="small" @click="handleProcessView">查看流程图</el-button>
          <el-button type="primary" size="small" @click="handleJumpInfo">跳转到单据详情</el-button>
        </div>
      </div>
    </el-dialog>
    <!-- 流程图 -->
    <el-dialog :title="processView.title" :visible.sync="processView.open" width="70%" append-to-body>
      <process-viewer :key="`designer-${processView.index}`" :xml="processView.xmlData" :style="{ height: '400px' }" />
    </el-dialog>
  </div>
</template>

<script>
import { getProcessForm, getBpmnXml } from "@/api/workflow/process"
import { getUserProfile } from "@/api/system/user"
import Parser from "@/utils/generator/parser"
import ProcessViewer from "@/components/ProcessViewer"
import { SET_FIELDS } from "./config"

let INFO_PATH = ""
let INFO_URL = ""

export default {
  name: "Start",
  components: {
    Parser,
    ProcessViewer,
  },
  props: {
    visible: {
      type: Boolean,
      required: true,
    },
    ids: {
      type: String,
      required: true,
    },
    // 后端返回的审批设置数据
    workFlowable: {
      type: Object,
      required: true,
    },
    // 重新获取任务列表数据
    getTableData: {
      type: Function,
    },
    // 接口
    startProcessApi: {
      type: Function,
      required: true,
    },
    // 单条单据详情数据
    info: {
      type: Object,
      required: false,
    },
    // 多条单据详情需要的数据
    infos: {
      type: Object,
      required: false,
    },
  },
  data() {
    return {
      user: {},
      formOpen: false,
      formData: {},
      processView: {
        title: "",
        open: false,
        index: undefined,
        xmlData: "",
      },
      allowSubmit: false, // 点击提交按钮时是否允许提交
    }
  },
  created() {
    INFO_PATH = window.location.pathname
    INFO_URL = `${window.location.origin}${INFO_PATH}`
    getUserProfile().then((response) => {
      // 拿到当前登录的用户信息，审批流程表单需要填写用户昵称字段
      this.user = response.data
    })
  },
  methods: {
    handleClose() {
      this.formOpen = false
      this.$emit("update:visible", false)
    },
    handleOpen() {
      this.initData()
    },
    // 查看流程图
    handleProcessView() {
      let definitionId = this.workFlowable?.definitionId
      this.processView.title = "流程图"
      this.processView.index = definitionId
      // 发送请求，获取xml
      getBpmnXml(definitionId).then((res) => {
        this.processView.xmlData = res.data
      })
      this.processView.open = true
    },
    // 跳转到详情页
    handleJumpInfo() {
      window.open(`${INFO_PATH}?ids=${this.ids}`)
    },
    initData() {
      getProcessForm({
        definitionId: this.workFlowable?.definitionId,
        deployId: this.workFlowable?.deploymentId,
      }).then((res) => {
        if (res.data) {
          try {
            const fields = res.data.fields
            SET_FIELDS(fields, this.user.nickName, `${INFO_URL}?ids=${this.ids}`, this.ids, this.info, this.infos)
          } catch (error) {
            this.$modal.msgError("表单设计不符合要求，请尽快联系管理员")
          }
          this.formData = res.data
          this.formOpen = true
        }
      })
    },
    /** 接收子组件传的值 */
    getData(data) {
      if (data) {
        const variables = []
        data.fields.forEach((item) => {
          let variableData = {}
          variableData.label = item.__config__.label
          // 表单值为多个选项时
          if (item.__config__.defaultValue instanceof Array) {
            const array = []
            item.__config__.defaultValue.forEach((val) => {
              array.push(val)
            })
            variableData.val = array
          } else {
            variableData.val = item.__config__.defaultValue
          }
          variables.push(variableData)
        })
        this.variables = variables
      }
    },
    submit(data) {
      if (this.allowSubmit) {
        if (data && this.workFlowable?.definitionId) {
          this.$modal.loading("处理中...")
          // 启动流程并将表单数据加入流程变量
          const url = encodeURIComponent(`${INFO_URL}?ids=${this.ids}`)
          this.startProcessApi(this.ids, this.workFlowable?.definitionId, url, JSON.stringify(data.valData))
            .then((res) => {
              this.$modal.msgSuccess(res.msg)
              this.getTableData()
              this.handleClose()
            })
            .finally(() => {
              this.$modal.closeLoading()
            })
        }
        this.allowSubmit = false
      } else {
        this.$modal.loading("提交中...", "rgba(255, 255, 255)")
        try {
          SET_FIELDS(
            this.formData.fields,
            this.user.nickName,
            `${INFO_URL}?ids=${this.ids}`,
            this.ids,
            this.info,
            this.infos,
            {
              type: "转换",
              copyForm: data.formData,
            }
          )
        } catch (error) {
          this.$modal.closeLoading()
          this.$modal.msgError("表单设计不符合要求，请尽快联系管理员")
          return
        }
        setTimeout(() => {
          this.formOpen = false
        }, 200)
        setTimeout(() => {
          // 关闭表单再打开是为了再次渲染新的 JSON
          this.formOpen = true
          this.allowSubmit = true
        }, 500)
        setTimeout(() => {
          this.$modal.closeLoading()
          this.$refs.parser.submitForm()
          this.handleClose()
        }, 1000)
      }
    },
  },
}
</script>

<style lang="scss" scoped>
.layout {
  display: flex;
  // .form-conf {
  //   width: 80%;
  // }
  .el-divider--vertical {
    height: auto;
    margin: 0 30px;
  }
  .action {
    display: flex;
    flex-direction: column;
    .el-button {
      margin-bottom: 15px;
    }
    .el-button + .el-button {
      margin-left: 0px;
    }
  }
}
</style>
