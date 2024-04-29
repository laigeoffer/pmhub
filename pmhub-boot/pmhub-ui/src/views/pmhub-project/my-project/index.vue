<template>
  <div class="app-container" v-loading="loading">
    <!-- toolbar-wrapper 模块 -->
    <el-card shadow="never" class="toolbar-wrapper" v-if="!isRecycleView">
      <el-radio-group v-model="projectRadio" @input="changeProjectRadio">
        <el-radio-button :label="undefined">全部项目</el-radio-button>
        <el-radio-button :label="1">进行中</el-radio-button>
        <el-radio-button :label="2">已归档</el-radio-button>
      </el-radio-group>
      <el-button v-if="!isCollectionView" type="primary" @click="createProjectDialogVisible = true">新建项目</el-button>
    </el-card>
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper" v-if="!isRecycleView">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item prop="keyword" label="搜索">
          <el-input v-model="searchData.keyword" placeholder="请输入项目名或编码" />
        </el-form-item>
        <!-- <el-form-item prop="stageCode" label="项目阶段">
          <el-select v-model="searchData.stageCode" placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataStageCodeOptions"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item> -->
        <el-form-item prop="status" label="项目状态">
          <el-select v-model="searchData.status" placeholder="请选择" :disabled="projectRadio !== undefined">
            <el-option
              v-for="(item, index) in searchDataStatusOptions"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="published" label="发布状态">
          <el-select v-model="searchData.published" placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataPublishedOptions"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="projectType" label="项目类型">
          <el-select v-model="searchData.projectType" placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataProjectTypeOptions"
              :key="index"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="time" label="项目起止时间">
          <el-date-picker
            v-model="searchData.time"
            type="datetimerange"
            value-format="yyyy-MM-dd HH:mm:ss"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="handleResetForm('searchFormRef')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <el-card shadow="never">
      <!-- table-wrapper 模块 -->
      <el-table
        class="table-wrapper"
        :data="tableData"
        @row-dblclick="handleRowClick"
        highlight-current-row
        :row-style="{ cursor: 'pointer' }"
      >
        <el-table-column label="项目编码" prop="projectCode" align="center" />
        <el-table-column label="项目名称" prop="projectName" align="center" />
        <el-table-column label="所属阶段" prop="stageName" align="center" />
        <el-table-column label="项目状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.statusName === '未开始'" type="info">未开始</el-tag>
            <el-tag v-else-if="scope.row.statusName === '进行中'">进行中</el-tag>
            <el-tag v-else-if="scope.row.statusName === '已归档'" type="success">已归档</el-tag>
            <el-tag v-else-if="scope.row.statusName === '已逾期'" type="warning">已逾期</el-tag>
            <el-tag v-else-if="scope.row.statusName === '已暂停'" type="danger">已暂停</el-tag>
            <span v-else>{{ scope.row.statusName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="项目类型" align="center">
          <template slot-scope="scope">
            <div v-if="scope.row.projectTypeName === '公开项目'">
              <i class="el-icon-view" />
              <span> 公开项目</span>
            </div>
            <div v-else-if="scope.row.projectTypeName === '私有项目'">
              <i class="el-icon-lock" />
              <span> 私有项目</span>
            </div>
            <span v-else>{{ scope.row.projectTypeName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="发布状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.publishedName === '已发布'" type="success">已发布</el-tag>
            <el-tag v-else-if="scope.row.publishedName === '未发布'" type="info">未发布</el-tag>
            <span v-else>{{ scope.row.publishedName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="项目进度" align="center">
          <template slot-scope="scope">
            <el-progress :percentage="scope.row.projectProcess"></el-progress>
          </template>
        </el-table-column>
        <el-table-column label="负责人" prop="nickName" align="center" />
        <el-table-column label="项目截止时间" prop="closeEndTime" align="center" />
        <el-table-column label="操作" align="center" width="250">
          <template slot-scope="scope">
            <el-button type="text" @click="handleSet(scope.row)" v-if="!isRecycleView">设置</el-button>
            <el-button type="text" @click="handleAddPeople(scope.row)" v-if="!isRecycleView">加人</el-button>
            <el-button type="text" @click="handleDelete(scope.row)" v-if="!isRecycleView" style="color: #f56c6c">
              删除
            </el-button>
            <el-button type="text" @click="handleInfo(scope.row)">详情</el-button>
            <el-button
              type="text"
              @click="handleCollection(scope.row)"
              v-if="!isRecycleView && scope.row.collected"
              style="color: #67c23a"
            >
              已收藏
            </el-button>
            <el-button
              type="text"
              @click="handleCollection(scope.row)"
              v-if="!isRecycleView && !scope.row.collected"
              style="color: #909399"
            >
              未收藏
            </el-button>
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
    <CreateProjectDialog :visible.sync="createProjectDialogVisible" :getTableData="getTableData" />
    <AddPeopleDialog
      :visible.sync="addPeopleDialogVisible"
      :projectId="currentRow.projectId"
      :getTableData="getTableData"
    />
    <SetProjectDialog :visible.sync="setProjectDialogVisible" :projectData="currentRow" :getTableData="getTableData" />
  </div>
</template>

<script>
import CreateProjectDialog from "./components/CreateProjectDialog"
import AddPeopleDialog from "./components/AddPeopleDialog"
import SetProjectDialog from "./components/SetProjectDialog"
import {
  getProjectListApi,
  projectCollectApi,
  projectCancelCollectApi,
  deleteProjectApi,
} from "@/api/pmhub-project/my-project.js"

export default {
  name: "MyProject",
  components: { CreateProjectDialog, AddPeopleDialog, SetProjectDialog },
  props: {
    // 当前是否处于 "我的收藏" 页面
    isCollectionView: {
      type: Boolean,
      default: false,
    },
    // 当前是否处于 "回收站" 页面
    isRecycleView: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      loading: false,

      /* toolbar-wrapper 模块 */
      projectRadio: undefined,

      /* search-wrapper 模块 */
      searchData: {
        keyword: "",
        stageCode: undefined,
        status: undefined,
        published: undefined,
        projectType: undefined,
        time: [],
      },
      // 搜索板块，项目阶段需要的下拉框数据
      searchDataStageCodeOptions: [
        {
          label: "全部阶段",
          value: undefined,
        },
        {
          label: "项目立项阶段",
          value: 0,
        },
        {
          label: "研发设计输入阶段",
          value: 1,
        },
        {
          label: "研发实施阶段",
          value: 2,
        },
        {
          label: "交付验收阶段",
          value: 3,
        },
        {
          label: "新产品导出阶段",
          value: 4,
        },
      ],
      // 搜索板块，项目状态需要的下拉框数据
      searchDataStatusOptions: [
        {
          label: "全部状态",
          value: undefined,
        },
        {
          label: "未开始",
          value: 0,
        },
        {
          label: "进行中",
          value: 1,
        },
        {
          label: "已归档",
          value: 2,
        },
        {
          label: "已逾期",
          value: 3,
        },
        {
          label: "已暂停",
          value: 4,
        },
      ],
      // 搜索板块，发布状态需要的下拉框数据
      searchDataPublishedOptions: [
        {
          label: "全部状态",
          value: undefined,
        },
        {
          label: "未发布",
          value: 0,
        },
        {
          label: "已发布",
          value: 1,
        },
      ],
      // 搜索板块，项目类型需要的下拉框数据
      searchDataProjectTypeOptions: [
        {
          label: "全部类型",
          value: undefined,
        },
        {
          label: "公开",
          value: 0,
        },
        {
          label: "私有",
          value: 1,
        },
      ],

      /* table-wrapper 模块 */
      tableData: [],
      currentRow: {}, // 当前操作的行

      /* pager-wrapper 模块 */
      total: 0,
      currentPage: 1,
      pageSize: 10,

      /* 对话框模块 */
      createProjectDialogVisible: false,
      addPeopleDialogVisible: false,
      setProjectDialogVisible: false,
    }
  },
  methods: {
    /* toolbar-wrapper 模块 */
    changeProjectRadio(label) {
      this.searchData.status = label
      this.getTableData()
    },

    /* search-wrapper 模块 */
    handleSearch() {
      this.currentPage = 1
      this.getTableData()
    },
    handleResetForm(ref) {
      this.$refs[ref].resetFields()
      this.getTableData()
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      // 我的项目列表传 my 我的收藏传 collect 回收站传 recycle
      let type = "my"
      if (this.isCollectionView) {
        type = "collect"
      }
      if (this.isRecycleView) {
        type = "recycle"
      }
      getProjectListApi({
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        keyword: this.searchData.keyword,
        stageCode: this.searchData.stageCode,
        status: this.searchData.status,
        published: this.searchData.published,
        projectType: this.searchData.projectType,
        closeBeginTime: this.searchData.time ? this.searchData.time[0] : undefined,
        closeEndTime: this.searchData.time ? this.searchData.time[1] : undefined,
        type: type,
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
    handleSet(row) {
      this.currentRow = row
      this.setProjectDialogVisible = true
    },
    handleAddPeople(row) {
      this.currentRow = row
      this.addPeopleDialogVisible = true
    },
    handleDelete(row) {
      const id = row.projectId
      const name = row.projectName
      this.$modal
        .confirm(`是否确认删除项目：${name}？`)
        .then(() => {
          return deleteProjectApi(id)
        })
        .then(() => {
          this.$modal.msgSuccess("删除成功")
          this.getTableData()
        })
        .catch(() => {})
    },
    handleInfo(row) {
      this.currentRow = row
      // this.$cache.session.setJSON("projectData", row) // 缓存当前项目的数据，在详情页会取出展示
      this.$router.push({ path: "/pmhub-project/my-project/info", query: { projectId: row.projectId } })
    },
    handleCollection(row) {
      this.loading = true
      if (row.collected) {
        projectCancelCollectApi(row.projectId)
          .then((res) => {
            this.$modal.msgSuccess("已取消收藏")
            this.getTableData()
          })
          .finally(() => {
            this.loading = false
          })
      } else {
        projectCollectApi(row.projectId)
          .then((res) => {
            this.$modal.msgSuccess("收藏成功")
            this.getTableData()
          })
          .finally(() => {
            this.loading = false
          })
      }
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
.toolbar-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    display: flex;
    justify-content: space-between;
  }
}

.search-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    padding-bottom: 2px;
  }
}

.table-wrapper {
  margin-bottom: 20px;
}

.pager-wrapper {
  display: flex;
  justify-content: flex-end;
}
</style>
