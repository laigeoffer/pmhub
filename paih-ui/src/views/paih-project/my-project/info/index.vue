<template>
  <el-tabs v-model="activeName" @tab-click="handleClick" class="app-container" v-if="projectData !== null">
    <el-tab-pane label="概况" name="概况">
      <Overview :projectData="projectData" />
    </el-tab-pane>
    <el-tab-pane label="任务" name="任务">
      <Task :projectData="projectData" />
    </el-tab-pane>
    <el-tab-pane label="文件" name="文件">
      <File :projectData="projectData" />
    </el-tab-pane>
    <el-tab-pane label="成员" name="成员">
      <Member :projectData="projectData" />
    </el-tab-pane>
    <el-tab-pane label="物料" name="物料">
      <Material :projectData="projectData" />
    </el-tab-pane>
    <el-tab-pane label="甘特图" name="甘特图">敬请期待</el-tab-pane>
  </el-tabs>
</template>

<script>
import Overview from "./components/Overview.vue"
import Task from "./components/Task.vue"
import File from "./components/File.vue"
import Member from "./components/Member.vue"
import Material from "./components/Material.vue"
import { getProjectDetailApi } from "@/api/paih-project/my-project.js"

export default {
  name: "MyProjectInfo",
  components: { Overview, Task, File, Member, Material },
  props: {},
  data() {
    return {
      projectData: null, // 项目基本数据
      activeName: "概况",
    }
  },
  methods: {
    handleClick({ name }) {
      if (name === "任务") {
        // this.$router.push({ path: "/paih-project/my-task", query: { test: "test" } })
      } else if (name === "物料") {
        // this.$router.push({
        //   path: "/paih-materials/materials-details",
        //   query: { projectId: this.projectData.projectId },
        // })
      }
    },
  },
  created() {
    // 第一种: 获取缓存的项目数据
    // const data = this.$cache.session.getJSON("projectData")
    // 第二种: 从接口获取数据
    const projectId = this.$route.query.projectId
    getProjectDetailApi(projectId)
      .then((res) => {
        this.projectData = res.data
      })
      .catch(() => {
        // 退回上一级路由
        this.$router.replace("/paih-project/my-project")
      })
  },
}
</script>

<style scoped lang="scss"></style>
