<template>
  <div class="app-container">
    <h2>{{ designerData.title }}</h2>
    <process-designer
      :key="designerData.modelId"
      style="border: 1px solid rgba(0, 0, 0, 0.1)"
      ref="modelDesigner"
      v-loading="designerData.loading"
      :bpmnXml="designerData.bpmnXml"
      :designerForm="designerData.form"
      @save="onSaveDesigner"
    />
  </div>
</template>

<script>
import { saveModel } from "@/api/workflow/model"
import ProcessDesigner from "@/components/ProcessDesigner"

export default {
  name: "ModelDesign",
  components: {
    ProcessDesigner,
  },
  data() {
    return {
      designerData: {
        title: "",
        loading: false,
        bpmnXml: "",
        modelId: null,
        form: {
          processName: null,
          processKey: null,
          namespace: null,
        },
      },
    }
  },
  created() {
    const designerData = this.$cache.session.getJSON("designerData")
    if (!designerData) {
      // 退回上一级路由
      this.$modal.msgWarning("没有数据，为你返回流程设计列表")
      this.$router.replace("/process/model")
      return
    }
    this.designerData = designerData
    if (this.$store.state.app.sidebar.opened) {
      // 收起左侧导航栏
      this.$store.dispatch("app/toggleSideBar")
    }
  },
  methods: {
    onSaveDesigner(bpmnXml) {
      let dataBody = {
        modelId: this.designerData.modelId,
        bpmnXml: bpmnXml,
      }
      this.$confirm("是否将此模型保存为新版本？", "提示", {
        distinguishCancelAndClose: true,
        confirmButtonText: "是",
        cancelButtonText: "否",
      })
        .then(() => {
          this.confirmSave(dataBody, true)
        })
        .catch((action) => {
          if (action === "cancel") {
            this.confirmSave(dataBody, false)
          }
        })
    },
    confirmSave(body, newVersion) {
      this.designerData.loading = true
      saveModel(
        Object.assign(body, {
          newVersion: newVersion,
        })
      )
        .then(() => {
          this.$tab.closeOpenPage({ path: "/process/model" })
        })
        .finally(() => {
          this.designerData.loading = false
        })
    },
  },
}
</script>
