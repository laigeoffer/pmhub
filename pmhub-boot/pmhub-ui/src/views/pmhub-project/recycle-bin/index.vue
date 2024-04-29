<template>
  <MyProject :isRecycleView="true" />
</template>

<script>
import MyProject from "../my-project/index"

export default {
  name: "RecycleBin",
  components: { MyProject },
  data() {
    return {}
  },
  methods: {},
}
</script>

<style scoped lang="scss"></style>
