<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="任务名称" prop="asyncName">
        <el-input
          v-model="queryParams.asyncName"
          placeholder="请输入任务名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="asyncStatus">
        <el-select v-model="queryParams.asyncStatus" placeholder="任务状态" clearable>
          <el-option
            v-for="dict in dict.type.async_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
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
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:post:remove']"
        >删除</el-button>
      </el-col>
      
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="asyncList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务编号" align="center" prop="id" />
      <el-table-column label="任务名称" align="center" prop="asyncName" />
      <el-table-column label="任务说明" align="center" prop="asyncDesc" />
      <el-table-column label="任务类型" align="center" prop="asyncType" />
      <el-table-column label="任务进度" align="center" prop="asyncSchedule">
        <template slot-scope="scope">
          <el-progress :percentage="scope.row.asyncSchedule" :status="getProgressStatus(scope.row.asyncStatus)"></el-progress>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" prop="asyncStatus">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.async_status" :value="scope.row.asyncStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            v-if="scope.row.file && scope.row.file.length > 0"
            size="mini"
            type="text"
            icon="el-icon-document-checked"
            @click="handleDownload(scope.row)"
            v-hasPermi="['system:post:edit']"
          >附件下载</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
          >删除</el-button>
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
import { listAsync,delAsync } from "@/api/tool/async";

export default {
  name: "Post",
  dicts: ['async_status'],
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
      // 岗位表格数据
      asyncList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        id: undefined,
        asyncName: undefined,
        asyncStatus: undefined
      },
      // 定时器，用于检查当前页面是否有未完成的任务
      timer: null,
      // 是否有未完成的任务
      isDingJob: false,
      // 表单参数
      form: {}
    };
  },
  created() {
    this.getList();
  },
  mounted() {
    this.timer = setInterval(() => {
      this.isDingJob = false;
      // 检查是否有未完成的任务
      for(let i=0;i<this.asyncList.length;i++){
        if(this.asyncList[i].asyncSchedule<100){
          this.isDingJob = true;
          break;
        }
      }
      if(this.isDingJob){
        listAsync(this.queryParams).then(response => {
          this.asyncList = response.rows;
          this.total = response.total;
        });
      }
     
    }, 2000); // 如果有未完成的任务 每2秒 刷新一下进度
  },
  beforeDestroy() {
    if (this.timer) {
      clearInterval(this.timer); // 清理定时器
    }
  },
  methods: {
    /** 查询岗位列表 */
    getList() {
      this.loading = true;

      listAsync(this.queryParams).then(response => {
        this.asyncList = response.rows;
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
        id: undefined,
        asyncName: undefined,
        asyncSchedule: 0,
        asyncStatus: "0"
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const asyncIds = row.id || this.ids;
      this.$modal.confirm('是否确认删除任务编号为"' + asyncIds + '"的数据项？').then(function() {
        return delAsync(asyncIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 下载按钮操作 */
    handleDownload(row) {
      this.download('tool/async/download?id='+row.id, `post_${new Date().getTime()}.xlsx`)
    },
    getProgressStatus(asyncStatus) {
        switch(asyncStatus) {
            case 0: return ''; // 当 asyncStatus 为 0 时，status 置为空
            case 1: return 'exception'; // 当 asyncStatus 为 1 时，status 为 'exception'
            case 2: return 'success'; // 当 asyncStatus 为 2 时，status 为 'success'
            default: return ''; // 默认情况下 status 置为空
        }
    }
  }
};
</script>
