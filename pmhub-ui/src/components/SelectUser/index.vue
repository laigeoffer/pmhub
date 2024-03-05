<template>
  <div>
    <el-dialog
      title="选择用户"
      :visible.sync="visible"
      width="60%"
      append-to-body
      :before-close="handleClose"
      @open="handleOpen"
    >
      <el-row type="flex" :gutter="20">
        <!-- 部门树 -->
        <el-col :span="7">
          <el-card shadow="never" style="height: 100%">
            <div class="head-container">
              <el-input
                @input="getUserList"
                v-model.trim="queryParams.nickName"
                placeholder="筛选用户"
                clearable
                size="small"
                prefix-icon="el-icon-search"
                style="margin-bottom: 20px"
              />
              <el-tree
                :data="deptOptions"
                :props="deptProps"
                :expand-on-click-node="false"
                ref="tree"
                default-expand-all
                @node-click="handleNodeClick"
              />
            </div>
          </el-card>
        </el-col>
        <!-- 用户列表 -->
        <el-col :span="17">
          <el-table
            ref="multipleTable"
            height="600"
            :data="userTableList"
            border
            @selection-change="handleSelectionChange"
            @row-click="handleRowClick"
            highlight-current-row
          >
            <!-- <el-table-column type="selection" width="50" align="center" /> -->
            <el-table-column type="index" label="序号" align="center" width="50" />
            <el-table-column label="用户名" align="center" prop="nickName" />
            <el-table-column label="部门" align="center" prop="dept.deptName" />
          </el-table>
          <pagination
            :total="queryParams.userTotal"
            :page.sync="queryParams.pageNum"
            :limit.sync="queryParams.pageSize"
            @pagination="getUserList"
          />
        </el-col>
      </el-row>
      <div slot="footer" class="dialog-footer">
        <el-card shadow="never" style="margin-bottom: 20px; text-align: left">
          <!-- 当前已选用户：{{ selectedUserString }} -->
          当前已选用户（点击列表即可选择）：
          <el-tag
            v-for="(item, index) in selectedUserData"
            :key="index"
            closable
            @close="removeSelectedUserData(index)"
            style="margin: 2px"
          >
            {{ item.nickName }}
          </el-tag>
        </el-card>
        <el-button type="primary" @click="handleComplete">确 定</el-button>
        <el-button @click="handleClose">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listUser, deptTreeSelect } from "@/api/system/user"

const QUERY_PARAMS = {
  pageNum: 1,
  pageSize: 10,
  userTotal: 0,
  nickName: undefined,
  deptId: undefined,
}

export default {
  name: "SelectUser",
  props: {
    // 开关
    visible: {
      type: Boolean,
      default: false,
    },
    // 单选
    radio: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      /** 部门树 */
      deptOptions: [],
      deptProps: {
        children: "children",
        label: "label",
      },

      /** 查询参数 */
      queryParams: { ...QUERY_PARAMS },

      /** 用户列表 */
      userTableList: [],
      selectedUserData: [],
      // copySelectedUserData: [],
    }
  },
  computed: {
    // selectedUserString() {
    //   const arr = []
    //   for (let i = 0; i < this.selectedUserData.length; i++) {
    //     arr.push(this.selectedUserData[i].nickName)
    //   }
    //   return arr.toString()
    // },
  },
  methods: {
    handleClose() {
      this.queryParams = { ...QUERY_PARAMS }
      this.userTableList = []
      this.selectedUserData = []
      // this.copySelectedUserData = []
      this.$emit("update:visible", false)
    },
    handleOpen() {
      this.getDeptOptions()
      this.getUserList()
    },
    handleComplete() {
      const res = {
        userId: [],
        nickName: [],
      }
      const selectedUserData = this.selectedUserData
      const length = selectedUserData.length
      if (!selectedUserData || length <= 0) {
        this.$modal.msgWarning("未选择用户")
      }
      if (this.radio && length > 1) {
        this.$modal.msgError("只能选择一个用户")
        return
      }
      for (let i = 0; i < length; i++) {
        const item = selectedUserData[i]
        res.userId.push(item.userId)
        res.nickName.push(item.nickName)
      }
      this.$emit("change", res)
      this.handleClose()
    },

    /**
     * 部门树
     */
    // 节点单击事件
    handleNodeClick(data) {
      this.queryParams.deptId = data.id
      this.getUserList()
    },
    // 查询部门下拉树结构
    getDeptOptions() {
      if (!this.deptOptions || this.deptOptions.length <= 0) {
        deptTreeSelect().then((response) => {
          this.deptOptions = response.data
        })
      }
    },

    /**
     * 用户列表
     */
    getUserList() {
      // this.copySelectedUserData = JSON.parse(JSON.stringify(this.selectedUserData))
      if (this.queryParams.nickName) {
        this.queryParams.deptId = undefined
      }
      listUser(this.queryParams).then((response) => {
        this.userTableList = response.rows
        this.queryParams.userTotal = response.total
      })
    },
    // 单击某一行
    handleRowClick(row) {
      this.selectedUserData.push(row)
      this.selectedUserData = this.noRepeat(this.selectedUserData)
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      // if (this.copySelectedUserData.length === 0) {
      //   this.selectedUserData = selection
      // } else {
      //   this.selectedUserData = this.noRepeat([...this.copySelectedUserData, ...selection])
      // }
    },
    // 数组去重
    noRepeat(arr) {
      const newArr = JSON.parse(JSON.stringify(arr))
      for (let i = 0; i < newArr.length - 1; i++) {
        for (let j = i + 1; j < newArr.length; j++) {
          if (newArr[i].userId === newArr[j].userId) {
            newArr.splice(j, 1)
            j--
          }
        }
      }
      return newArr
    },
    // 移除已选择的用户
    removeSelectedUserData(index) {
      this.selectedUserData.splice(index, 1)
    },
  },
}
</script>
