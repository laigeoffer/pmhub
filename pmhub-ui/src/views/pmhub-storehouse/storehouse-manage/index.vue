<template>
  <div class="app-container">
    <el-card shadow="never" class="search-wrapper">
      <el-form :model="queryParams" ref="queryForm" :inline="true">
        <el-form-item label="仓库名称" prop="storeName">
          <el-input v-model="queryParams.storeName" placeholder="请输入" @keyup.enter.native="handleQuery" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="handleQuery">查询</el-button>
          <el-button icon="el-icon-refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-card shadow="never" class="toolbar-wrapper">
      <el-button
        type="primary"
        icon="el-icon-plus"
        @click="handleAdd"
        v-hasPermi="['storehouse-manage:storemanage:add']"
      >
        新增
      </el-button>
      <el-button
        type="danger"
        icon="el-icon-delete"
        :disabled="multiple"
        @click="handleDelete"
        v-hasPermi="['storehouse-manage:storemanage:remove']"
      >
        批量删除
      </el-button>
    </el-card>

    <el-table
      v-loading="loading"
      :data="storemanageList"
      @row-dblclick="handleRowClick"
      highlight-current-row
      :row-style="{ cursor: 'pointer' }"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="仓库编号" align="center" prop="id" />
      <el-table-column label="仓库名称" align="center" prop="storeName" />
      <el-table-column label="仓库地址" align="center" prop="storeAddress" />
      <el-table-column label="仓库负责人" align="center" prop="storeCharger" />
      <el-table-column label="排序" align="center" prop="storeOrder" />
      <el-table-column label="备注" align="center" prop="storeNote" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['storehouse-manage:storemanage:edit']"
          >
            编辑
          </el-button>
          <el-button
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['storehouse-manage:storemanage:remove']"
            style="color: #f56c6c"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      background
      :page-sizes="[10, 50, 100, 200]"
      layout="total, slot, prev, pager, next,sizes, jumper"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    >
    </pagination>

    <!-- 添加或修改仓库管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="85px">
        <el-form-item label="仓库名称" prop="storeName">
          <el-input v-model="form.storeName" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="仓库地址" prop="storeAddress">
          <el-input v-model="form.storeAddress" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="仓库负责人" prop="storeCharger">
          <el-input v-model="form.storeCharger" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="排序" prop="storeOrder">
          <el-input v-model="form.storeOrder" placeholder="请输入" />
        </el-form-item>

        <el-form-item label="备注" prop="storeNote">
          <el-input v-model="form.storeNote" placeholder="请输入" type="textarea" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  getStoremanage,
  listStoremanage,
  addStoremanage,
  updateStoremanage,
  delStoremanage,
} from "@/api/pmhub-storehouse/store-manage.js"

export default {
  name: "StoreManage",
  data() {
    return {
      // 遮罩层
      loading: false,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 总条数
      total: 0,
      // 仓库管理表格数据
      storemanageList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        storeName: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        storeName: [
          {
            required: true,
            message: "仓库名称不能为空",
            trigger: "blur",
          },
        ],
      },
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询仓库管理列表 */
    getList() {
      this.loading = true
      listStoremanage(this.queryParams)
        .then((response) => {
          this.storemanageList = response.data.list
          this.total = response.data.total
        })
        .finally(() => {
          this.loading = false
        })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        storeName: null,
        storeAddress: null,
        storeCharger: null,
        storeOrder: null,
        storeNote: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleRowClick(row, column) {
      this.handleUpdate(row)
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map((item) => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加仓库管理"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id
      getStoremanage(id).then((response) => {
        this.form = response.data
        this.open = true
        this.title = "修改仓库管理"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate((valid) => {
        if (valid) {
          if (this.form.id != undefined) {
            updateStoremanage(this.form).then((response) => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addStoremanage(this.form).then((response) => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids
      this.$modal
        .confirm(`是否确认删除公告编号为 ${ids} 的数据项？`)
        .then(function () {
          return delStoremanage(ids)
        })
        .then(() => {
          this.getList()
          this.$modal.msgSuccess("删除成功")
        })
        .catch(() => {})
    },
  },
}
</script>
<style lang="scss" scoped>
.search-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    padding-bottom: 2px;
  }
}

.toolbar-wrapper {
  margin-bottom: 20px;
}
</style>
