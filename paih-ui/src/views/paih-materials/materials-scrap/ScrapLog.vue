<template>
  <div class="app-container" v-loading="loading">
    <!-- search-wrapper 模块 -->
    <el-card shadow="never" class="search-wrapper">
      <el-form ref="searchFormRef" :inline="true" :model="searchData">
        <el-form-item prop="keyword" label="搜索">
          <el-input v-model="searchData.keyword" placeholder="单号、物料名称" />
        </el-form-item>
        <el-form-item prop="materialsTypeId" label="类别">
          <treeselect
            v-model="searchData.materialsTypeId"
            :options="searchDataMaterialsTypeOptions"
            :normalizer="normalizer"
            :disable-branch-nodes="false"
            :show-count="true"
            placeholder="请选择"
            noChildrenText="无数据"
            noOptionsText="无数据"
            noResultsText="无数据"
            :flat="true"
          />
        </el-form-item>
        <el-form-item prop="projectId" label="归属项目">
          <el-select v-model="searchData.projectId" filterable placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataProjectOptions"
              :key="index"
              :label="item.projectName"
              :value="item.projectId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="resolution" label="处理意见">
          <el-select v-model="searchData.resolution" placeholder="请选择">
            <el-option label="待定" value="待定"></el-option>
            <el-option label="留用" value="留用"></el-option>
            <el-option label="报废" value="报废"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="dangerous" label="是否危废">
          <el-select v-model="searchData.dangerous" placeholder="请选择">
            <el-option label="待定" value="待定"></el-option>
            <el-option label="是" value="是"></el-option>
            <el-option label="否" value="否"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="time" label="业务时间">
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
        <el-form-item prop="approved" label="审批状态">
          <el-select v-model="searchData.approved" placeholder="请选择">
            <el-option v-for="(item, index) in searchDataStateOptions" :key="index" :label="item" :value="item">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="createId" label="处理人">
          <el-select v-model="searchData.createId" filterable placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataPrincipalOptions"
              :key="index"
              :label="item.nickName"
              :value="item.userId"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="principalId" label="责任人">
          <el-select v-model="searchData.principalId" filterable placeholder="请选择">
            <el-option
              v-for="(item, index) in searchDataPrincipalOptions"
              :key="index"
              :label="item.nickName"
              :value="item.userId"
            >
            </el-option>
          </el-select>
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
        @row-click="handleRowClick"
        highlight-current-row
        :row-style="{ cursor: 'pointer' }"
      >
        <el-table-column label="单号" prop="recordId" align="center" />
        <el-table-column label="名称" prop="materialsName" align="center" />
        <el-table-column label="物料编码" prop="materialsId" align="center" />
        <el-table-column label="归属项目" prop="projectName" align="center" />
        <el-table-column label="类别" prop="materialsTypeName" align="center" />
        <el-table-column label="供应商" prop="supplierName" align="center" />
        <el-table-column label="入库时间" prop="intoTime" align="center" />
        <el-table-column label="入库数量" prop="intoNumber" align="center" />
        <el-table-column label="单位" prop="unit" align="center" />
        <el-table-column label="库存" prop="materialsCount" align="center" />
        <el-table-column label="单价" prop="unitPrice" align="center">
          <template slot-scope="scope">
            {{ scope.row.unitPrice ?? "****" }}
          </template>
        </el-table-column>
        <el-table-column label="总价" prop="totalRate" align="center">
          <template slot-scope="scope">
            {{ scope.row.totalRate ?? "****" }}
          </template>
        </el-table-column>
        <el-table-column label="处理意见" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.resolution === '待定'" type="info">待定</el-tag>
            <el-tag v-else-if="scope.row.resolution === '留用'">留用</el-tag>
            <el-tag v-else-if="scope.row.resolution === '报废'" type="danger">报废</el-tag>
            <span v-else>{{ scope.row.resolution }}</span>
          </template>
        </el-table-column>
        <el-table-column label="是否危废" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.dangerous === '待定'" type="info">待定</el-tag>
            <el-tag v-else-if="scope.row.dangerous === '是'" type="danger">是</el-tag>
            <el-tag v-else-if="scope.row.dangerous === '否'" type="success">否</el-tag>
            <span v-else>{{ scope.row.dangerous }}</span>
          </template>
        </el-table-column>
        <el-table-column label="责任人" prop="principalName" align="center" />
        <el-table-column label="处理人" prop="createName" align="center" />
        <el-table-column label="审批状态" align="center">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.approvedName === '未审核'" type="info">未审核</el-tag>
            <el-tag v-else-if="scope.row.approvedName === '审核中'">审核中</el-tag>
            <el-tag v-else-if="scope.row.approvedName === '已审核'" type="success">已审核</el-tag>
            <span v-else>{{ scope.row.approvedName }}</span>
          </template>
        </el-table-column>
        <el-table-column label="处理时间" prop="createTime" align="center" />
      </el-table>
      <!-- pager-wrapper 模块 -->
      <div class="pager-wrapper">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :page-sizes="[10, 20, 50, 100, 200]"
          :total="total"
          :page-size="pageSize"
          :current-page="currentPage"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        >
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>

<script>
import { projectStatus } from "@/utils/projectUtils.js"
import { getMaterialsUselessLogApi } from "@/api/paih-materials/materials-scrap.js"
import { listMaterialsSort } from "@/api/paih-materials/materials-sort.js"
import { getAllProjectListApi } from "@/api/paih-project/my-project.js"
import { queryMemberApi } from "@/api/paih-project/my-project.js"
import { getOrderState } from "@/api/public/public.js"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"

export default {
  name: "ScrapLog",
  components: { Treeselect },
  props: {
    // 要通过 ids 筛选出来的记录
    ids: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      loading: false,

      /* search-wrapper 模块 */
      searchData: {
        keyword: "",
        materialsTypeId: undefined,
        projectId: undefined,
        resolution: undefined,
        dangerous: undefined,
        time: [],
        approved: undefined,
        createId: undefined,
        principalId: undefined,
      },
      // 下拉框数据
      searchDataProjectOptions: [],
      searchDataMaterialsTypeOptions: [],
      searchDataPrincipalOptions: [],
      searchDataStateOptions: [],

      /* table-wrapper 模块 */
      tableLastLabel: "操作",
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
    normalizer(node) {
      if (node.materialsTypeSon && !node.materialsTypeSon.length) {
        delete node.materialsTypeSon
      }
      return {
        id: node.id,
        label: node.materialsTypeName,
        children: node.materialsTypeSon,
      }
    },

    /* table-wrapper 模块 */
    getTableData() {
      this.loading = true
      this.pageSize = this.ids ? 200 : this.pageSize
      const ids = this.ids ? this.ids : undefined
      getMaterialsUselessLogApi({
        keyword: this.searchData.keyword,
        materialsTypeId: this.searchData.materialsTypeId,
        projectId: this.searchData.projectId,
        resolution: this.searchData.resolution,
        dangerous: this.searchData.dangerous,
        beginTime: this.searchData.time[0],
        endTime: this.searchData.time[1],
        approved: this.searchData.approved,
        createId: this.searchData.createId,
        principalId: this.searchData.principalId,
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        ids,
      })
        .then((res) => {
          this.total = res.data.total
          this.tableData = res.data.list
          this.$emit("update:ids", "") // 重置 ids，后续的查询就可以查询所有了
        })
        .catch(() => {
          this.tableData = []
        })
        .finally(() => {
          this.loading = false
        })
    },
    handleRowClick(row, column) {
      if (column.label !== this.tableLastLabel) {
        this.handleInfo(row)
      }
    },
    handleInfo(row) {},

    /* pager-wrapper 模块 */
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
    // 查询类别
    listMaterialsSort().then((res) => {
      this.searchDataMaterialsTypeOptions = res.data
    })
    // 查询所有项目下拉框
    getAllProjectListApi().then((res) => {
      this.searchDataProjectOptions = res.data
      //处理已暂停的项目状态
      projectStatus(this.searchDataProjectOptions)
    })
    // 查询所有人
    queryMemberApi().then((res) => {
      this.searchDataPrincipalOptions = res.data
    })
    // 查询审批状态下拉框
    getOrderState().then((res) => {
      this.searchDataStateOptions = res.data
    })
  },
}
</script>

<style scoped lang="scss">
.search-wrapper {
  overflow: visible; // 防止 vue-treeselect 组件被遮挡
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    padding-bottom: 2px;
  }
  .vue-treeselect {
    width: 217px;
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
