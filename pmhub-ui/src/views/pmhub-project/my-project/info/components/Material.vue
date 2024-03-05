<template>
  <MaterialsDetails :isProjectInfo="true" :projectData="projectData" />
</template>

<script>
import MaterialsDetails from "@/views/pmhub-materials/materials-details/index.vue"
export default {
  name: "MyProjectInfoMaterial",
  components: { MaterialsDetails },
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
