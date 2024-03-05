<template>
  <MyTask :isProjectInfo="true" :projectData="projectData" />
</template>

<script>
import MyTask from "@/views/pmhub-project/my-task/index.vue"

export default {
  name: "MyProjectInfoTask",
  components: { MyTask },
  props: {
    // 项目基本数据
    projectData: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {}
  },
  methods: {},
}
</script>

<style scoped lang="scss"></style>
