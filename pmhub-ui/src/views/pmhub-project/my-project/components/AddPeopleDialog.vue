<template>
  <div>
    <el-dialog title="邀请新成员" :visible.sync="visible" width="50%" :before-close="handleClose" @open="handleOpen">
      <el-input
        v-model="keyword"
        placeholder="请输入昵称或邮箱搜索成员（不输入即可搜索全部）"
        @keydown.enter.native="handleSearch"
      >
        <el-button slot="append" icon="el-icon-search" @click="handleSearch" />
      </el-input>
      <p>默认展示已加入的成员，如需邀请新成员，请用搜索功能</p>
      <el-table :data="tableData">
        <el-table-column label="名称" prop="userName" align="center" />
        <el-table-column label="昵称" prop="nickName" align="center" />
        <el-table-column label="邮箱" prop="email" align="center" />
        <el-table-column align="center" width="150">
          <template slot="header">
            <span>状态</span>
            <span class="repeat">（点击切换）</span>
          </template>
          <template slot-scope="scope">
            <!-- 0-未加入 1-加入 -->
            <el-button v-if="scope.row.joined" type="text" @click="handleAdd(scope.row)">已加入</el-button>
            <el-button v-else type="text" @click="handleAdd(scope.row)" style="color: #909399">未加入</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import {
  getProjectMemberApi,
  queryMemberApi,
  addProjectMemberApi,
  deleteProjectMemberApi,
} from "@/api/pmhub-project/my-project.js"

export default {
  name: "AddPeopleDialog",
  props: {
    visible: {
      type: Boolean,
      default: false,
    },
    projectId: {
      type: String,
      default: "",
    },
    // 重新获取表格数据
    getTableData: {
      type: Function,
      required: true,
    },
  },
  data() {
    return {
      keyword: "",
      tableData: [],
    }
  },
  methods: {
    handleSearch() {
      queryMemberApi(this.projectId, this.keyword).then((res) => {
        this.tableData = res.data
      })
    },
    handleAdd(row) {
      const data = {
        projectId: this.projectId,
        userIdList: [row.userId],
      }
      if (row.joined == 1) {
        deleteProjectMemberApi(data).then((res) => {
          this.$modal.msgSuccess("已移除")
          this.handleOpen()
        })
      } else {
        addProjectMemberApi(data).then((res) => {
          this.$modal.msgSuccess("添加成功")
          this.handleSearch()
        })
      }
    },
    handleClose() {
      this.$emit("update:visible", false)
      this.getTableData()
    },
    handleOpen() {
      // 查询已加入的成员
      getProjectMemberApi(this.projectId).then((res) => {
        this.tableData = res.data
      })
    },
  },
  mounted() {},
}
</script>
<style scoped lang="scss">
p {
  font-size: 12px;
  color: #888;
}

.el-table {
  margin-top: 20px;
}

.repeat::before {
  content: "";
  position: absolute;
  top: 18px;
  width: 78px;
  height: 0.25em;

  background: linear-gradient(135deg, transparent, transparent 45%, red, transparent 55%, transparent 100%),
    linear-gradient(45deg, transparent, transparent 45%, red, transparent 55%, transparent 100%);
  background-size: 0.5em 0.5em;
  background-repeat: repeat-x, repeat-x;
}
</style>
