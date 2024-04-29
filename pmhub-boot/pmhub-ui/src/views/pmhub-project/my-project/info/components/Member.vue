<template>
  <div class="app-container" v-loading="loading">
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper">
      <el-form ref="searchFormRef" :inline="true" :model="searchData" @submit.native.prevent>
        <el-form-item prop="keyword" label="成员名">
          <el-input v-model="searchData.keyword" placeholder="请输入成员名" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="handleResetForm('searchFormRef')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <!-- toolbar-wrapper 模块 -->
    <el-card shadow="never" class="toolbar-wrapper">
      <el-button type="primary" @click="handleAddPeople">加人</el-button>
      <el-button type="danger" @click="handleBatchDelete">批量移除</el-button>
    </el-card>
    <el-card shadow="never">
      <!-- table-wrapper 模块 -->
      <el-table
        class="table-wrapper"
        :data="tableData"
        @row-dblclick="handleRowClick"
        highlight-current-row
        :row-style="{ cursor: 'pointer' }"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55"> </el-table-column>
        <el-table-column label="成员名" prop="nickName" align="center" />
        <el-table-column label="所在部门" prop="deptName" align="center" />
        <el-table-column label="角色" prop="roleName" align="center" />
        <el-table-column label="加入时间" prop="joinedTime" align="center" />
        <el-table-column label="操作" align="center" width="210">
          <template slot-scope="scope">
            <el-button type="text" @click="handleInfo(scope.row)">详情</el-button>
            <el-button type="text" @click="handleDelete(scope.row)" style="color: #f56c6c">移除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <!-- pager-wrapper 模块 -->
      <div class="pager-wrapper">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :page-sizes="[10, 20, 50]"
          :total="total"
          :page-size="pageSize"
          :current-page="currentPage"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        >
        </el-pagination>
      </div>
    </el-card>

    <!-- 对话框模块 -->
    <AddPeopleDialog
      :visible.sync="addPeopleDialogVisible"
      :projectId="projectData.projectId"
      :getTableData="getTableData"
    />
  </div>
</template>

<script>
import AddPeopleDialog from "@/views/pmhub-project/my-project/components/AddPeopleDialog"
import { getMemberListApi, deleteProjectMemberApi } from "@/api/pmhub-project/my-project.js"

export default {
  name: "MyProjectInfoMember",
  components: { AddPeopleDialog },
  props: {
    // 项目基本数据
    projectData: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      loading: false,

      /* search-wrapper 模块 */
      searchData: {
        keyword: "",
      },

      /* toolbar-wrapper 模块 */
      addPeopleDialogVisible: false,

      /* table-wrapper 模块 */
      multipleSelection: [],
      tableData: [],

      /* pager-wrapper 模块 */
      total: 0,
      currentPage: 1,
      pageSize: 10,
    }
  },
  methods: {
    /* search-wrapper 模块 */
    handleSearch() {
      this.currentPage = 1
      this.getTableData()
    },
    handleResetForm(ref) {
      this.$refs[ref].resetFields()
      this.getTableData()
    },

    /* toolbar-wrapper 模块 */
    handleAddPeople(row) {
      this.addPeopleDialogVisible = true
    },
    handleBatchDelete() {
      if (this.multipleSelection.length === 0) return
      const userIdList = []
      for (let i = 0; i < this.multipleSelection.length; i++) {
        userIdList.push(this.multipleSelection[i].userId)
      }
      this.$modal
        .confirm(`是否确认移除所选成员？`)
        .then(() => {
          const data = {
            projectId: this.projectData.projectId,
            userIdList: userIdList,
          }
          return deleteProjectMemberApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("批量删除成功")
          this.getTableData()
          this.multipleSelection = []
        })
        .catch(() => {})
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      getMemberListApi({
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        keyword: this.searchData.keyword,
        projectId: this.projectData.projectId,
      })
        .then((res) => {
          this.total = res.data.total
          this.tableData = res.data.list
        })
        .catch(() => {
          this.tableData = []
        })
        .finally(() => {
          this.loading = false
        })
    },
    handleRowClick(row, column) {
      this.handleInfo(row)
    },
    handleSelectionChange(val) {
      this.multipleSelection = val
    },
    handleInfo(row) {
      this.$router.push({ path: "/system/user", query: { nickName: row.nickName } })
    },
    handleDelete(row) {
      const id = row.userId
      const name = row.nickName
      this.$modal
        .confirm(`是否确认移除该成员：${name}？`)
        .then(() => {
          const data = {
            projectId: this.projectData.projectId,
            userIdList: [id],
          }
          return deleteProjectMemberApi(data)
        })
        .then(() => {
          this.$modal.msgSuccess("删除成功")
          this.getTableData()
        })
        .catch(() => {})
    },

    /** pager-wrapper 模块 */
    handleCurrentChange(value) {
      this.currentPage = value
      this.getTableData()
    },
    handleSizeChange(value) {
      this.pageSize = value
      this.getTableData()
    },
  },
  mounted() {
    this.getTableData()
  },
}
</script>

<style scoped lang="scss">
.search-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    padding-bottom: 2px;
  }
}

.toolbar-wrapper {
  margin-bottom: 20px;
}

.table-wrapper {
  margin-bottom: 20px;
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
