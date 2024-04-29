<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="流程标识" prop="processKey">
        <el-input
          v-model="queryParams.processKey"
          placeholder="请输入流程标识"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="流程名称" prop="processName">
        <el-input
          v-model="queryParams.processName"
          placeholder="请输入流程名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="流程分类" prop="category">
        <el-select v-model="queryParams.category" clearable filterable placeholder="请选择" size="small">
          <el-option
            v-for="item in categoryOptions"
            :key="item.categoryId"
            :label="item.categoryName"
            :value="item.code">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          v-hasPermi="['workflow:process:startExport']"
          @click="handleExport"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>
    <el-table v-loading="loading" fit :data="processList">
      <el-table-column label="序号" type="index" width="50"></el-table-column>
      <el-table-column label="流程标识" align="center" prop="processKey" :show-overflow-tooltip="true" />
      <el-table-column label="流程名称" align="center" :show-overflow-tooltip="true">
        <template slot-scope="scope">
          <el-button type="text" @click="handleProcessView(scope.row)">
            <span>{{ scope.row.processName }}</span>
          </el-button>
        </template>
      </el-table-column>
      <el-table-column label="流程分类" align="center" prop="categoryName" :formatter="categoryFormat" />
      <el-table-column label="流程版本" align="center">
        <template slot-scope="scope">
          <el-tag size="medium" >v{{ scope.row.version }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center">
        <template slot-scope="scope">
          <el-tag type="success" v-if="!scope.row.suspended">激活</el-tag>
          <el-tag type="warning" v-if="scope.row.suspended">挂起</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="部署时间" align="center" prop="deploymentTime" width="180"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            type="text"
            size="mini"
            icon="el-icon-video-play"
            @click="handleStart(scope.row)"
            v-hasPermi="['workflow:process:start']"
          >发起</el-button>
        </template>
      </el-table-column>
    </el-table>
    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 流程图 -->
    <el-dialog :title="processView.title" :visible.sync="processView.open" width="70%" append-to-body>
      <process-viewer :key="`designer-${processView.index}`" :xml="processView.xmlData" :style="{height: '400px'}" />
    </el-dialog>
  </div>
</template>

<script>
import { listProcess, getBpmnXml } from "@/api/workflow/process";
import { listAllCategory } from '@/api/workflow/category'
import ProcessViewer from '@/components/ProcessViewer'

export default {
  name: 'WorkProcess',
  components: {
    ProcessViewer
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        processKey: undefined,
        processName: undefined,
        category: undefined
      },
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      filterCategoryText: '',
      categoryOptions: [],
      categoryProps: {
        label: 'categoryName',
        value: 'code'
      },
      // 流程定义表格数据
      processList: [],
      processView: {
        title: '',
        open: false,
        index: undefined,
        xmlData:"",
      }
    }
  },
  created() {
    this.getCategoryList();
    this.getList();
  },
  methods: {
    /** 查询流程分类列表 */
    getCategoryList() {
      listAllCategory().then(response => this.categoryOptions = response.data)
    },
    /** 查询流程定义列表 */
    getList() {
      this.loading = true;
      listProcess(this.queryParams).then(response => {
        this.processList = response.rows;
        this.total = response.total;
        this.loading = false
      })
    },
    // 搜索按钮操作
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    // 重置按钮操作
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    /** 查看流程图 */
    handleProcessView(row) {
      let definitionId = row.definitionId;
      this.processView.title = "流程图";
      this.processView.index = definitionId;
      // 发送请求，获取xml
      getBpmnXml(definitionId).then(res => {
        this.processView.xmlData = res.data;
      })
      this.processView.open = true;
    },
    handleStart(row) {
      this.$router.push({
        path: '/workflow/process/start/' + row.deploymentId,
        query: {
          definitionId: row.definitionId,
        }
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('workflow/process/startExport', {
        ...this.queryParams
      }, `wf_start_process_${new Date().getTime()}.xlsx`)
    },
    categoryFormat(row, column) {
      return this.categoryOptions.find(k => k.code === row.category)?.categoryName ?? '';
    }
  }
}
</script>

<style scoped>

</style>
