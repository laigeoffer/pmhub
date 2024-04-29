<template>
  <MyProject :isCollectionView="true" />
</template>

<script>
import MyProject from "../my-project/index"

export default {
  name: "MyCollection",
  components: { MyProject },
  data() {
    return {}
  },
  methods: {},
}
</script>

<style scoped lang="scss"></style>
