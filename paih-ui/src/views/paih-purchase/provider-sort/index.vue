<template>
  <div class="app-container">
    <el-card shadow="never">
      <el-button type="primary" icon="el-icon-plus" @click="handleAdd" v-hasPermi="['codeautoflow:common-category:add']">
        新增
      </el-button>
      <el-button
        type="danger"
        icon="el-icon-delete"
        :disabled="checkIds.length > 1 ? false : true"
        @click="handleDelete"
        v-hasPermi="['codeautoflow:common-category:delete']"
      >
        批量删除
      </el-button>
      <el-button icon="el-icon-refresh" @click="refresh">刷新</el-button>
    </el-card>

    <el-card shadow="never">
      <div v-if="showLeaf" class="tip">
        当前选择：{{ checkLeafName }}
        <a @click="cancelChecked" style="color: #f56c6c; margin-left: 8px">取消选择</a>
      </div>
      <div v-else class="tip">请选择要操作的分类</div>

      <el-dropdown style="margin-bottom: 20px" @command="handleCommand">
        <el-button type="primary">树操作<i class="el-icon-arrow-down el-icon--right"></i></el-button>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item command="a">全选</el-dropdown-item>
          <el-dropdown-item command="b">全不选</el-dropdown-item>
          <el-dropdown-item command="c">展开</el-dropdown-item>
          <el-dropdown-item command="d">合并</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>

      <div class="tree-container">
        <div class="tree">
          <el-tree
            v-loading="loading"
            ref="materialsSortTree"
            node-key="id"
            :data="treeList"
            :props="defaultProps"
            @check-change="handleChecked"
            show-checkbox
            :expand-on-click-node="false"
            :default-expand-all="expandAll"
            :check-strictly="true"
            @node-click="changeMaterialsTypePidByElTree"
          >
            <span class="custom-tree-node" slot-scope="{ node, data }" @click="() => handleEdit(data)">
              <span>{{ node.label }}</span>
              <span>
                <el-button type="text" @click="() => handleEdit(data)">详情</el-button>
                <el-button
                  type="text"
                  @click="() => handleDelete(node, data)"
                  v-hasPermi="['codeautoflow:common-category:delete']"
                  style="color: #f56c6c"
                >
                  删除
                </el-button>
              </span>
            </span>
          </el-tree>
        </div>
        <div class="edit" v-if="openEdit">
          <el-form ref="formEdit" :model="form" label-width="100px" :rules="rules">
            <el-form-item label="分类 ID" prop="id">
              <el-input v-model="form.id" disabled />
            </el-form-item>
            <el-form-item label="类别名称" prop="categoryName">
              <el-input v-model="form.categoryName" placeholder="请输入类别名称" />
            </el-form-item>
            <el-form-item style="margin-bottom: 10px" label="类别编号" prop="categoryCode">
              <el-input v-model="form.categoryCode" placeholder="请输入类别编号" />
            </el-form-item>
            <el-form-item style="margin-bottom: 0px">
              <span style="color: #909399">{{ finishCodeTips }}</span>
            </el-form-item>
            <el-form-item label="上级目录" prop="categoryPid">
              <treeselect
                v-model="form.categoryPid"
                :options="menuOptions"
                :normalizer="normalizer"
                :show-count="true"
                placeholder="选择上级菜单(新建根目录则不选)"
                noChildrenText="无数据"
                noOptionsText="无数据"
                noResultsText="无数据"
                @select="changeMaterialsTypePid"
              />
            </el-form-item>
            <el-form-item label="排序" prop="categoryOrder">
              <el-input-number v-model="form.categoryOrder" placeholder="请输入排序" />
            </el-form-item>
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" placeholder="请输入备注" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="submitForm('formEdit')" v-hasPermi="['codeautoflow:common-category:edit']">
                保 存
              </el-button>
              <el-button @click="cancel">取 消</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </el-card>

    <!-- 添加或修改仓库管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" label-width="80px" :rules="rules">
        <el-form-item label="类别名称" prop="categoryName">
          <el-input v-model="form.categoryName" placeholder="请输入类别名称" />
        </el-form-item>
        <el-form-item style="margin-bottom: 10px" label="类别编号" prop="categoryCode">
          <el-input v-model="form.categoryCode" placeholder="请输入类别编号" />
        </el-form-item>
        <el-form-item style="margin-bottom: 0px">
          <span style="color: #909399">{{ finishCodeTips }}</span>
        </el-form-item>
        <el-form-item label="上级目录" prop="categoryPid">
          <treeselect
            v-model="form.categoryPid"
            :options="menuOptions"
            :normalizer="normalizer"
            :show-count="true"
            placeholder="选择上级菜单(新建根目录则不选)"
            noChildrenText="无数据"
            noOptionsText="无数据"
            noResultsText="无数据"
            @select="changeMaterialsTypePid"
          />
        </el-form-item>
        <el-form-item label="排序" prop="categoryOrder">
          <el-input-number v-model="form.categoryOrder" placeholder="请输入排序" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm('form')">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  listProviderSort,
  addProviderSort,
  editProviderSort,
  deleteProviderSort,
} from "@/api/paih-purchase/provider-sort.js"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"
export default {
  components: {
    Treeselect,
  },
  data() {
    return {
      // 删除按钮是否可用
      multiple: true,
      // 遮罩层
      loading: false,
      // 控制是否打开对话框
      open: false,
      // 控制是否打开修改表单
      openEdit: false,
      // 对话框标题
      title: "",
      // 是否打开所有叶节点
      expandAll: false,
      // 上级目录选择列表
      menuOptions: [],
      // 表单参数
      form: {
        // 设置供应商类别场景为 1
        categoryScene: '1'
      },
      oldFormCategoryCode: "",
      // 表单验证
      rules: {
        categoryName: [
          {
            required: true,
            message: "类别名称不能为空",
            trigger: "blur",
          },
        ],
        categoryCode: [
          {
            required: true,
            message: "类别编号不能为空",
            trigger: "blur",
          },
        ],
      },
      // 树形数据
      treeList: [],
      // 控制el-tree展示
      defaultProps: {
        children: "categorySon",
        label: "categoryName",
      },
      //复选框选中的id
      checkIds: [],

      // 是否显示叶子节点的回显
      showLeaf: false,
      // 选中某一叶子节点
      checkLeafName: "",

      // 当前选择的上级目录所对应的 finishCode 和 categoryName
      finishCode: "",
      categoryName: "",
    }
  },
  created() {
    this.getTreeList()
  },
  computed: {
    leafNode() {
      return ""
    },
    finishCodeTips() {
      return this.categoryName + "目录下的最大类别编号为：" + this.finishCode
    },
  },
  methods: {
    // 获取数据
    getTreeList() {
      this.loading = true
      listProviderSort()
        .then((response) => {
          this.treeList = response.data
          this.menuOptions = response.data
        })
        .finally(() => {
          this.loading = false
        })
    },

    //添加类别执行的回调
    handleAdd() {
      this.reset()
      this.open = true
      this.openEdit = false
      this.title = "新增供应商类别"
      this.finishCode = ""
      this.categoryName = ""
    },

    //删除操作
    handleDelete(node, data) {
      if (data) {
        if (!data.theLastType) {
          this.$modal
            .confirm("该节点：" + data.categoryName + "   存在子结点，会一并删除，请确认是否删除？")
            .then(function () {
              return deleteProviderSort([data.id])
            })
            .then(() => {
              this.getTreeList()
              this.$modal.msgSuccess("删除成功")
            })
        } else {
          this.$modal
            .confirm("是否确认删除名称为" + data.categoryName + "的数据项？")
            .then(function () {
              return deleteProviderSort([data.id])
            })
            .then(() => {
              this.getTreeList()
              this.$modal.msgSuccess("删除成功")
              this.cancel()
            })
        }
      } else {
        this.$modal
          .confirm("是否执行批量删除？")
          .then(() => deleteProviderSort(this.checkIds))
          .then(() => {
            this.getTreeList()
            this.$modal.msgSuccess("删除成功")
            this.cancel()
          })
      }
    },

    //修改按钮
    handleEdit(data) {
      this.form = JSON.parse(JSON.stringify(data))
      this.oldFormCategoryCode = data.categoryCode
      this.title = "修改类别"
      // this.open = true
      this.openEdit = true
    },

    // 提交按钮执行的回调
    submitForm(ref) {
      this.$refs[ref].validate((valid) => {
        if (valid) {
          if (this.form.id != undefined) {
            if (this.oldFormCategoryCode !== this.form.categoryCode) {
              this.$confirm("你已经修改了供应商编码, 是否继续?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
              })
                .then(() => {
                  this.submitFormByEdit()
                })
                .catch(() => {})
            } else {
              this.submitFormByEdit()
            }
          } else {
            addProviderSort(this.form).then((res) => {
              this.$modal.msgSuccess("新增成功")
              this.cancel()
              this.getTreeList()
            })
          }
        } else {
          this.$message({
            showClose: true,
            message: "请检查表单",
            type: "error",
          })
        }
      })
    },
    submitFormByEdit() {
      editProviderSort(this.form).then((response) => {
        this.$modal.msgSuccess("修改成功")
        this.cancel()
        this.getTreeList()
      })
    },

    /** 转换菜单数据结构 */
    normalizer(node) {
      if (node.level === 2) {
        // 一共有三层，但只能选到第二层
        delete node.categorySon
      }
      if (node.categorySon && !node.categorySon.length) {
        delete node.categorySon
      }
      return {
        id: node.id,
        label: node.categoryName,
        children: node.categorySon,
      }
    },
    /** 查询菜单下拉树结构 */
    getTreeselect() {
      listProviderSort().then((response) => {
        this.menuOptions = response.data
      })
    },
    // 改变上级目录（treeselect）
    changeMaterialsTypePid(data) {
      this.finishCode = data.finishCode ?? ""
      this.categoryName = data.categoryName ?? ""
    },
    // 改变上级目录（el-tree）
    changeMaterialsTypePidByElTree(data) {
      const node = this.$refs.materialsSortTree.getNode(data.categoryPid)
      this.finishCode = node?.data?.finishCode ?? ""
      this.categoryName = node?.data?.categoryName ?? ""
    },

    // 表单重置
    reset() {
      this.form = {categoryScene: '1'}
      this.oldFormCategoryCode = ""
      this.resetForm("form")
    },

    // 取消按钮执行的回调
    cancel() {
      this.open = false
      this.openEdit = false
      this.showLeaf = false;
      this.reset()
    },

    //树操作下拉框
    handleCommand(command) {
      const nodes = this.$refs.materialsSortTree.store.nodesMap
      switch (command) {
        case "a":
          this.checkIds = []
          for (let i in nodes) {
            const node = nodes[i]
            node.checked = true
            this.checkIds.push(node.data.id)
          }
          break
        case "b":
          for (let i in nodes) {
            nodes[i].checked = false
          }
          this.checkIds = []
          break
        case "c":
          for (let i in nodes) {
            const node = nodes[i]
            const level = node.level
            if (level === 1 || level === 2) node.expanded = true
          }
          break
        case "d":
          for (let i in nodes) {
            const node = nodes[i]
            const level = node.level
            if (level === 1 || level === 2) node.expanded = false
          }
          break
      }
    },
    // 回显：取消选择
    cancelChecked() {
      const nodes = this.$refs.materialsSortTree.store.nodesMap
      for (let i in nodes) {
        nodes[i].checked = false
      }
    },

    // 刷新
    refresh() {
      this.getTreeList()
      this.cancel()
    },

    handleChecked(a, b, c) {
      this.checkIds = []
      let checkedNodes = this.$refs.materialsSortTree.getCheckedNodes()
      //拿到选中节点的ids数组
      checkedNodes.map((node) => {
        this.checkIds.push(node.id)
      })

      // 选中单一叶子节点时做数据回显
      if (checkedNodes.length == 1 && checkedNodes[0].theLastType) {
        this.showLeaf = true
        this.checkLeafName = checkedNodes[0].categoryName
      } else {
        this.showLeaf = false
      }
    },
  },
}
</script>
<style scoped lang="scss">
.el-card {
  margin-bottom: 20px;
}

.tree-container {
  display: flex;
  justify-content: space-between;
  .tree {
    min-width: 400px;
    width: 20%;
    max-height: calc(100vh - 300px);
    overflow: auto;
  }
  .edit {
    width: 50%;
  }
}

.tip {
  margin-bottom: 20px;
  padding: 8px 16px;
  background-color: #ecf8ff;
  border-radius: 4px;
  border-left: 5px solid #50bfff;
  color: #606266;
  font-size: 16px;
}

.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  padding-right: 8px;
}
</style>
