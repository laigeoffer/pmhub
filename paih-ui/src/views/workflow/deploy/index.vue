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
      <el-form-item label="状态" prop="state">
        <el-select v-model="queryParams.state" size="small" clearable placeholder="请选择状态">
          <el-option :key="1" label="激活" value="active" />
          <el-option :key="2" label="挂起" value="suspended" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['workflow:deploy:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row> -->

    <el-row :gutter="10" class="mb8">
      <el-table v-loading="loading" fit :data="deployList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
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
              icon="el-icon-price-tag"
              @click.native="handlePublish(scope.row)"
              v-hasPermi="['workflow:deploy:list']"
            >版本管理</el-button>
            <!-- <el-button
              type="text"
              size="mini"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['workflow:deploy:remove']"
            >删除</el-button> -->
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
    </el-row>

    <!-- 流程图 -->
    <el-dialog :title="processView.title" :visible.sync="processView.open" width="70%" append-to-body>
      <process-viewer :key="`designer-${processView.index}`" :xml="processView.xmlData" :style="{height: '400px'}" />
    </el-dialog>

    <!-- 版本管理 -->
    <el-dialog title="版本管理" :visible.sync="publish.open" width="50%" append-to-body>
      <el-table v-loading="publish.loading" :data="publish.dataList">
        <el-table-column label="流程标识" align="center" prop="processKey" :show-overflow-tooltip="true" />
        <el-table-column label="流程名称" align="center" :show-overflow-tooltip="true">
          <template slot-scope="scope">
            <el-button type="text" @click="handleProcessView(scope.row)">
              <span>{{ scope.row.processName }}</span>
            </el-button>
          </template>
        </el-table-column>
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
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
          <template slot-scope="scope">
            <el-button
              type="text"
              size="mini"
              icon="el-icon-video-pause"
              v-if="!scope.row.suspended"
              @click.native="handleChangeState(scope.row, 'suspended')"
              v-hasPermi="['workflow:deploy:status']"
            >挂起</el-button>
            <el-button
              type="text"
              size="mini"
              icon="el-icon-video-play"
              v-if="scope.row.suspended"
              @click.native="handleChangeState(scope.row, 'active')"
              v-hasPermi="['workflow:deploy:status']"
            >激活</el-button>
            <!-- <el-button
              type="text"
              size="mini"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['workflow:deploy:remove']"
            >删除</el-button> -->
          </template>
        </el-table-column>
      </el-table>
      <pagination
        v-show="publishTotal > 0"
        :total="publishTotal"
        :page.sync="publishQueryParams.pageNum"
        :limit.sync="publishQueryParams.pageSize"
        @pagination="getPublishList"
      />
    </el-dialog>

  </div>
</template>

<script>
import { listAllCategory } from '@/api/workflow/category'
import { listDeploy, listPublish, getBpmnXml, changeState, delDeploy } from '@/api/workflow/deploy'
import ProcessViewer from '@/components/ProcessViewer'

export default {
  name: 'Deploy',
  components: {
    ProcessViewer
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        processKey: null,
        processName: null,
        category: null,
        state: null
      },
      deployList: [],
      categoryOptions: [],
      processView: {
        title: '',
        open: false,
        index: undefined,
        xmlData:"",
      },
      publish: {
        open: false,
        loading: false,
        dataList: []
      },
      publishTotal: 0,
      publishQueryParams: {
        pageNum: 1,
        pageSize: 10,
        processKey: ""
      },
    }
  },
  created() {
    this.getCategoryList();
    this.getList();
  },
  methods: {
    /** 查询流程分类列表 */
    getCategoryList() {
      listAllCategory().then(response => this.categoryOptions = response.data);
    },
    /** 查询流程部署列表 */
    getList() {
      this.loading = true;
      listDeploy(this.queryParams).then(response => {
        this.deployList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        processKey: null,
        processName: null,
        category: null,
        state: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.deploymentId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 查看流程图 */
    handleProcessView(row) {
      let definitionId = row.definitionId;
      this.processView.title = "流程图";
      this.processView.index = definitionId;
      // 发送请求，获取xml
      getBpmnXml(definitionId).then(response => {
        this.processView.xmlData = response.data;
      })
      this.processView.open = true;
    },
    getPublishList() {
      this.publish.loading = true;
      listPublish(this.publishQueryParams).then(response => {
        this.publish.dataList = response.rows;
        this.publishTotal = response.total;
        this.publish.loading = false;
      })
    },
    handlePublish(row) {
      this.publishQueryParams.processKey = row.processKey;
      this.publish.open = true;
      this.getPublishList();
    },
    /** 挂起/激活流程 */
    handleChangeState(row, state) {
      const params = {
        definitionId: row.definitionId,
        state: state
      }
      changeState(params).then(res => {
        this.$modal.msgSuccess(res.msg)
        this.getPublishList();
      });
    },
    handleDelete(row) {
      const deploymentIds = row.deploymentId || this.ids;
      this.$modal.confirm('是否确认删除选中的数据项？').then(() => {
        this.loading = true;
        return delDeploy(deploymentIds);
      }).then(() => {
        this.loading = false;
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).finally(() => {
        this.loading = false;
      });
    },
    categoryFormat(row, column) {
      return this.categoryOptions.find(k => k.code === row.category)?.categoryName ?? '';
    }
  }
}
</script>

<style scoped>

</style>
