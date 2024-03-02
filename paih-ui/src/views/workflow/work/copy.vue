<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="流程名称" prop="processName">
        <el-input
          v-model="queryParams.processName"
          placeholder="请输入流程名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="发起人" prop="originatorName">
        <el-input
          v-model="queryParams.originatorName"
          placeholder="请输入发起人"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['workflow:process:copyExport']"
          @click="handleExport"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="copyList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="抄送编号" align="center" prop="copyId" />
      <el-table-column label="标题" align="center" prop="title" :show-overflow-tooltip="true" />
      <el-table-column label="流程名称" align="center" prop="processName" :show-overflow-tooltip="true" />
      <el-table-column label="发起人" align="center" prop="originatorName" />
      <el-table-column label="创建时间" align="center" prop="createTime">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-tickets"
            @click="handleFlowRecord(scope.row)"
            v-hasPermi="['workflow:process:query']"
          >详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import { listCopyProcess } from "@/api/workflow/process"

export default {
  name: "Copy",
  data() {
    return {
      // 按钮loading
      buttonLoading: false,
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
      // 流程抄送表格数据
      copyList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        processId: undefined,
        processName: undefined,
        categoryId: undefined,
        taskId: undefined,
        userId: undefined,
        originatorName: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        copyId: [
          { required: true, message: "抄送主键不能为空", trigger: "blur" }
        ],
        processId: [
          { required: true, message: "流程主键不能为空", trigger: "blur" }
        ],
        processName: [
          { required: true, message: "流程名称不能为空", trigger: "blur" }
        ],
        categoryId: [
          { required: true, message: "流程分类主键不能为空", trigger: "blur" }
        ],
        taskId: [
          { required: true, message: "任务主键不能为空", trigger: "blur" }
        ],
        userId: [
          { required: true, message: "用户主键不能为空", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询流程抄送列表 */
    getList() {
      this.loading = true;
      listCopyProcess(this.queryParams).then(response => {
        this.copyList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        copyId: undefined,
        processId: undefined,
        processName: undefined,
        categoryId: undefined,
        taskId: undefined,
        userId: undefined,
        originatorName: undefined,
        createBy: undefined,
        createTime: undefined,
        updateBy: undefined,
        updateTime: undefined,
        delFlag: undefined
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
      this.ids = selection.map(item => item.copyId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 查看详情 */
    handleFlowRecord(row){
      this.$router.push({
        path: '/workflow/process/detail/' + row.instanceId,
        query: {
          definitionId: row.processId,
          deployId: row.deploymentId,
          taskId: row.taskId,
          finished: false
        }
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('workflow/process/copyExport', {
        ...this.queryParams
      }, `wf_copy_process_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
