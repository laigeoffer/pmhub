<template>
  <el-tabs v-model="activeName" @tab-click="handleClick" class="app-container">
    <el-tab-pane label="报废列表" name="报废列表" lazy>
      <ScrapList />
    </el-tab-pane>
    <el-tab-pane label="报废记录" name="报废记录" lazy>
      <ScrapLog :ids.sync="ids" />
    </el-tab-pane>
  </el-tabs>
</template>

<script>
import ScrapList from "./ScrapList.vue"
import ScrapLog from "./ScrapLog.vue"

export default {
  name: "MaterialsScrap",
  components: { ScrapList, ScrapLog },
  data() {
    return {
      activeName: "报废列表",
      ids: "",
    }
  },
  methods: {
    handleClick({ name }) {},
  },
  mounted() {
    // 如果有 ids 代表是从审批流程表单的详情链接跳转进来的
    this.ids = this.$route.query.ids
    if (this.ids) {
      this.activeName = "报废记录"
    }
  },
}
</script>

<style scoped lang="scss"></style>
