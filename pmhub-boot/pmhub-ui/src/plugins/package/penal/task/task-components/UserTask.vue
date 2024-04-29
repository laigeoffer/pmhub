<template>
  <div>
    <el-row>
      <h4><b>审批人设置</b></h4>
      <el-radio-group v-model="dataType" @change="changeDataType">
        <el-radio label="USERS">指定用户</el-radio>
        <el-radio label="ROLES">角色</el-radio>
        <el-radio label="DEPTS">部门</el-radio>
        <el-radio label="INITIATOR">发起人</el-radio>
        <el-radio label="VAR">变量</el-radio>
      </el-radio-group>
    </el-row>
    <el-row>
      <div v-if="dataType === 'USERS'">
        <el-tag v-for="userText in selectedUser.text" :key="userText" effect="plain">
          {{ userText }}
        </el-tag>
        <div class="element-drawer__button">
          <el-button size="mini" type="primary" icon="el-icon-plus" @click="onSelectUsers()">添加用户</el-button>
        </div>
      </div>
      <div v-if="dataType === 'ROLES'">
        <el-select v-model="roleIds" multiple size="mini" placeholder="请选择 角色" @change="changeSelectRoles">
          <el-option
            v-for="item in roleOptions"
            :key="item.roleId"
            :label="item.roleName"
            :value="`ROLE${item.roleId}`"
            :disabled="item.status === 1"
          >
          </el-option>
        </el-select>
      </div>
      <div v-if="dataType === 'DEPTS'">
        <tree-select
          :width="320"
          :height="400"
          size="mini"
          :data="deptTreeData"
          :defaultProps="deptProps"
          multiple
          clearable
          checkStrictly
          nodeKey="id"
          :checkedKeys="deptIds"
          @change="checkedDeptChange"
        >
        </tree-select>
      </div>
      <div v-if="dataType === 'VAR'" class="var">
        <el-input v-model.trim="variable" placeholder="${变量名}" size="mini" @input="changeVar">
          <el-select v-model="variable" slot="append" placeholder="内置变量" filterable @change="changeVar">
            <el-option v-for="(item, index) in variableList" :key="index" :label="item.varKey" :value="item.varValue" />
          </el-select>
        </el-input>
      </div>
    </el-row>
    <el-row>
      <div v-show="showMultiFlog">
        <el-divider />
        <h4><b>多实例审批方式</b></h4>
        <el-row>
          <el-radio-group v-model="multiLoopType" @change="changeMultiLoopType()">
            <el-row v-show="dataType !== 'VAR'"><el-radio label="Null">无</el-radio></el-row>
            <el-row><el-radio label="SequentialMultiInstance">会签（需所有审批人同意）</el-radio></el-row>
            <el-row><el-radio label="ParallelMultiInstance">或签（一名审批人同意即可）</el-radio></el-row>
          </el-radio-group>
        </el-row>
        <el-row v-if="multiLoopType !== 'Null'">
          <el-tooltip content="开启后，实例需按顺序轮流审批" placement="top-start" @click.stop.prevent>
            <i class="header-icon el-icon-info"></i>
          </el-tooltip>
          <span class="custom-label">顺序审批：</span>
          <el-switch v-model="isSequential" @change="changeMultiLoopType()" />
        </el-row>
      </div>
    </el-row>

    <!-- 候选用户弹窗 -->
    <el-dialog title="候选用户" :visible.sync="userOpen" width="60%" append-to-body>
      <el-row type="flex" :gutter="20">
        <!--部门数据-->
        <el-col :span="7">
          <el-card shadow="never" style="height: 100%">
            <!-- <div slot="header">
              <span>部门列表</span>
            </div> -->
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
                :filter-node-method="filterNode"
                ref="tree"
                default-expand-all
                @node-click="handleNodeClick"
              />
            </div>
          </el-card>
        </el-col>
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
            :total="userTotal"
            :page.sync="queryParams.pageNum"
            :limit.sync="queryParams.pageSize"
            @pagination="getUserList"
          />
        </el-col>
      </el-row>
      <div slot="footer" class="dialog-footer">
        <el-card shadow="never" style="margin-bottom: 20px; text-align: left">
          当前已选用户（点击列表即可选择）：
          <el-tag
            v-for="(item, index) in selectedUserDate"
            :key="index"
            closable
            @close="removeSelectedUserData(index)"
            style="margin: 2px"
          >
            {{ item.nickName }}
          </el-tag>
        </el-card>
        <el-button type="primary" @click="handleTaskUserComplete">确 定</el-button>
        <el-button @click="userOpen = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listUser, deptTreeSelect } from "@/api/system/user"
import { listRole } from "@/api/system/role"
import { getVarListApi } from "@/api/public/public"
import TreeSelect from "@/components/TreeSelect"

const userTaskForm = {
  dataType: "",
  assignee: "",
  candidateUsers: "",
  candidateGroups: "",
  text: "",
  // dueDate: '',
  // followUpDate: '',
  // priority: ''
}

export default {
  name: "UserTask",
  props: {
    id: String,
    type: String,
  },
  components: { TreeSelect },
  data() {
    return {
      loading: false,
      dataType: "USERS",
      selectedUser: {
        ids: [],
        text: [],
      },
      userOpen: false,
      deptName: undefined,
      deptOptions: [],
      deptProps: {
        children: "children",
        label: "label",
      },
      deptTempOptions: [],
      userTableList: [],
      userTotal: 0,
      selectedUserDate: [],
      roleOptions: [],
      roleIds: [],
      deptTreeData: [],
      deptIds: [],
      variable: undefined,
      variableList: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        nickName: undefined,
        deptId: undefined,
      },
      showMultiFlog: false,
      isSequential: false,
      multiLoopType: "Null",
    }
  },
  watch: {
    id: {
      immediate: true,
      handler() {
        this.bpmnElement = window.bpmnInstances.bpmnElement
        this.$nextTick(() => this.resetTaskForm())
      },
    },
  },
  mounted() {
    getVarListApi().then((res) => {
      this.variableList = res.data
    })
  },
  beforeDestroy() {
    this.bpmnElement = null
  },
  methods: {
    resetTaskForm() {
      const bpmnElementObj = this.bpmnElement?.businessObject
      if (!bpmnElementObj) {
        return
      }
      this.clearOptionsData()
      this.dataType = bpmnElementObj["dataType"]
      if (this.dataType === "USERS") {
        let userIdData = bpmnElementObj["candidateUsers"] || bpmnElementObj["assignee"]
        let userText = bpmnElementObj["text"] || []
        if (userIdData && userIdData.toString().length > 0 && userText && userText.length > 0) {
          this.selectedUser.ids = userIdData?.toString().split(",")
          this.selectedUser.text = userText?.split(",")
        }
        if (this.selectedUser.ids.length > 1) {
          this.showMultiFlog = true
        }
      } else if (this.dataType === "ROLES") {
        this.getRoleOptions()
        let roleIdData = bpmnElementObj["candidateGroups"] || []
        if (roleIdData && roleIdData.length > 0) {
          this.roleIds = roleIdData.split(",")
        }
        this.showMultiFlog = true
      } else if (this.dataType === "DEPTS") {
        this.getDeptTreeData().then(() => {
          let deptIdData = bpmnElementObj["candidateGroups"] || []
          if (deptIdData && deptIdData.length > 0) {
            this.deptIds = deptIdData.split(",")
          }
        })
        this.showMultiFlog = true
      } else if (this.dataType === "VAR") {
        this.variable = bpmnElementObj["loopCharacteristics"]["collection"]
        this.showMultiFlog = true
      }
      this.getElementLoop(bpmnElementObj)
    },
    /**
     * 清空选项数据
     */
    clearOptionsData() {
      this.selectedUser.ids = []
      this.selectedUser.text = []
      this.roleIds = []
      this.deptIds = []
      this.variable = undefined
    },
    /**
     * 跟新节点数据
     */
    updateElementTask() {
      const taskAttr = Object.create(null)
      for (let key in userTaskForm) {
        taskAttr[key] = userTaskForm[key]
      }
      window.bpmnInstances.modeling.updateProperties(this.bpmnElement, taskAttr)
    },
    /**
     * 查询部门下拉树结构
     */
    getDeptOptions() {
      return new Promise((resolve, reject) => {
        if (!this.deptOptions || this.deptOptions.length <= 0) {
          deptTreeSelect().then((response) => {
            this.deptTempOptions = response.data
            this.deptOptions = response.data
            resolve()
          })
        } else {
          reject()
        }
      })
    },
    /**
     * 查询部门下拉树结构（含部门前缀）
     */
    getDeptTreeData() {
      function refactorTree(data) {
        return data.map((node) => {
          let treeData = { id: `DEPT${node.id}`, label: node.label, parentId: node.parentId, weight: node.weight }
          if (node.children && node.children.length > 0) {
            treeData.children = refactorTree(node.children)
          }
          return treeData
        })
      }
      return new Promise((resolve, reject) => {
        if (!this.deptTreeData || this.deptTreeData.length <= 0) {
          this.getDeptOptions()
            .then(() => {
              this.deptTreeData = refactorTree(this.deptOptions)
              resolve()
            })
            .catch(() => {
              reject()
            })
        } else {
          resolve()
        }
      })
    },
    /**
     * 查询部门下拉树结构
     */
    getRoleOptions() {
      if (!this.roleOptions || this.roleOptions.length <= 0) {
        listRole().then((response) => (this.roleOptions = response.rows))
      }
    },
    /** 查询用户列表 */
    getUserList() {
      if (this.queryParams.nickName) {
        this.queryParams.deptId = undefined
      }
      listUser(this.addDateRange(this.queryParams, this.dateRange)).then((response) => {
        this.userTableList = response.rows
        this.userTotal = response.total
      })
    },
    // 筛选节点
    filterNode(value, data) {
      if (!value) return true
      return data.label.indexOf(value) !== -1
    },
    // 节点单击事件
    handleNodeClick(data) {
      this.queryParams.deptId = data.id
      this.getUserList()
    },
    // 关闭标签
    handleClose(tag) {
      this.selectedUserDate.splice(this.selectedUserDate.indexOf(tag), 1)
      this.$refs.multipleTable.toggleRowSelection(tag)
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.selectedUserDate = selection
    },
    // 单击某一行
    handleRowClick(row) {
      this.selectedUserDate.push(row)
      this.selectedUserDate = this.noRepeat(this.selectedUserDate)
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
      this.selectedUserDate.splice(index, 1)
    },
    onSelectUsers() {
      this.selectedUserDate = []
      this.$refs.multipleTable?.clearSelection()
      this.getDeptOptions()
      this.getUserList()
      this.userOpen = true
    },
    handleTaskUserComplete() {
      if (!this.selectedUserDate || this.selectedUserDate.length <= 0) {
        this.$modal.msgError("请选择用户")
        return
      }
      userTaskForm.dataType = "USERS"
      this.selectedUser.text = this.selectedUserDate.map((k) => k.nickName) || []
      this.selectedUser.ids = this.selectedUserDate.map((k) => k.userId) || []
      if (this.selectedUserDate.length === 1) {
        let data = this.selectedUserDate[0]
        userTaskForm.assignee = data.userId
        userTaskForm.text = data.nickName
        userTaskForm.candidateUsers = null
        this.showMultiFlog = false
        this.multiLoopType = "Null"
        this.changeMultiLoopType()
      } else {
        userTaskForm.candidateUsers = this.selectedUserDate.map((k) => k.userId).join() || null
        userTaskForm.text = this.selectedUserDate.map((k) => k.nickName).join() || null
        userTaskForm.assignee = null
        this.showMultiFlog = true
      }
      this.updateElementTask()
      this.userOpen = false
    },
    changeSelectRoles(val) {
      let groups = null
      let text = null
      if (val && val.length > 0) {
        userTaskForm.dataType = "ROLES"
        groups = val.join() || null
        let textArr = this.roleOptions.filter((k) => val.indexOf(`ROLE${k.roleId}`) >= 0)
        text = textArr?.map((k) => k.roleName).join() || null
      } else {
        userTaskForm.dataType = null
        this.multiLoopType = "Null"
      }
      userTaskForm.candidateGroups = groups
      userTaskForm.text = text
      this.updateElementTask()
      this.changeMultiLoopType()
    },
    checkedDeptChange(checkedIds) {
      let groups = null
      let text = null
      this.deptIds = checkedIds
      if (checkedIds && checkedIds.length > 0) {
        userTaskForm.dataType = "DEPTS"
        groups = checkedIds.join() || null
        let textArr = []
        let treeStarkData = JSON.parse(JSON.stringify(this.deptTreeData))
        checkedIds.forEach((id) => {
          let stark = []
          stark = stark.concat(treeStarkData)
          while (stark.length) {
            let temp = stark.shift()
            if (temp.children) {
              stark = temp.children.concat(stark)
            }
            if (id === temp.id) {
              textArr.push(temp)
            }
          }
        })
        text = textArr?.map((k) => k.label).join() || null
      } else {
        userTaskForm.dataType = null
        this.multiLoopType = "Null"
      }
      userTaskForm.candidateGroups = groups
      userTaskForm.text = text
      this.updateElementTask()
      this.changeMultiLoopType()
    },
    changeVar(val) {
      if (val.length > 0) {
        userTaskForm.dataType = "VAR"
        userTaskForm.text = "变量"
      } else {
        userTaskForm.dataType = null
        this.multiLoopType = "Null"
      }
      this.updateElementTask()
      this.changeMultiLoopType()
    },
    changeDataType(val) {
      if (val === "ROLES" || val === "DEPTS" || (val === "USERS" && this.selectedUser.ids.length > 1)) {
        this.showMultiFlog = true
        this.multiLoopType = "Null"
      } else if (val === "VAR") {
        this.showMultiFlog = true
        this.multiLoopType = "SequentialMultiInstance"
      } else {
        this.showMultiFlog = false
        this.multiLoopType = "Null"
      }
      this.changeMultiLoopType()
      // 清空 userTaskForm 所有属性值
      Object.keys(userTaskForm).forEach((key) => (userTaskForm[key] = null))
      userTaskForm.dataType = val
      if (val === "USERS") {
        if (this.selectedUser && this.selectedUser.ids && this.selectedUser.ids.length > 0) {
          if (this.selectedUser.ids.length === 1) {
            userTaskForm.assignee = this.selectedUser.ids[0]
          } else {
            userTaskForm.candidateUsers = this.selectedUser.ids.join()
          }
          userTaskForm.text = this.selectedUser.text?.join() || null
        }
      } else if (val === "ROLES") {
        this.getRoleOptions()
        if (this.roleIds && this.roleIds.length > 0) {
          userTaskForm.candidateGroups = this.roleIds.join() || null
          let textArr = this.roleOptions.filter((k) => this.roleIds.indexOf(`ROLE${k.roleId}`) >= 0)
          userTaskForm.text = textArr?.map((k) => k.roleName).join() || null
        }
      } else if (val === "DEPTS") {
        this.getDeptTreeData()
        if (this.deptIds && this.deptIds.length > 0) {
          userTaskForm.candidateGroups = this.deptIds.join() || null
          let textArr = []
          let treeStarkData = JSON.parse(JSON.stringify(this.deptTreeData))
          this.deptIds.forEach((id) => {
            let stark = []
            stark = stark.concat(treeStarkData)
            while (stark.length) {
              let temp = stark.shift()
              if (temp.children) {
                stark = temp.children.concat(stark)
              }
              if (id === temp.id) {
                textArr.push(temp)
              }
            }
          })
          userTaskForm.text = textArr?.map((k) => k.label).join() || null
        }
      } else if (val === "INITIATOR") {
        userTaskForm.assignee = "${initiator}"
        userTaskForm.text = "流程发起人"
      } else if (val === "VAR") {
        userTaskForm.text = "变量"
      }
      this.updateElementTask()
    },
    getElementLoop(businessObject) {
      if (!businessObject.loopCharacteristics) {
        this.multiLoopType = "Null"
        return
      }
      this.isSequential = businessObject.loopCharacteristics.isSequential
      if (businessObject.loopCharacteristics.completionCondition) {
        if (
          businessObject.loopCharacteristics.completionCondition.body === "${nrOfCompletedInstances >= nrOfInstances}"
        ) {
          this.multiLoopType = "SequentialMultiInstance"
        } else {
          this.multiLoopType = "ParallelMultiInstance"
        }
      }
    },
    changeMultiLoopType() {
      // 取消多实例配置
      if (this.multiLoopType === "Null") {
        window.bpmnInstances.modeling.updateProperties(this.bpmnElement, { loopCharacteristics: null, assignee: null })
        return
      }
      this.multiLoopInstance = window.bpmnInstances.moddle.create("bpmn:MultiInstanceLoopCharacteristics", {
        isSequential: this.isSequential,
      })
      // 更新多实例配置
      window.bpmnInstances.modeling.updateProperties(this.bpmnElement, {
        loopCharacteristics: this.multiLoopInstance,
        assignee: "${assignee}",
      })
      // 完成条件
      let completionCondition = null
      // 会签
      if (this.multiLoopType === "SequentialMultiInstance") {
        completionCondition = window.bpmnInstances.moddle.create("bpmn:FormalExpression", {
          body: "${nrOfCompletedInstances >= nrOfInstances}",
        })
      }
      // 或签
      if (this.multiLoopType === "ParallelMultiInstance") {
        completionCondition = window.bpmnInstances.moddle.create("bpmn:FormalExpression", {
          body: "${nrOfCompletedInstances > 0}",
        })
      }
      // 更新模块属性信息
      window.bpmnInstances.modeling.updateModdleProperties(this.bpmnElement, this.multiLoopInstance, {
        collection: this.dataType === "VAR" ? this.variable : "${multiInstanceHandler.getUserIds(execution)}",
        elementVariable: "assignee",
        completionCondition,
      })
    },
  },
}
</script>

<style scoped lang="scss">
.el-row .el-radio-group {
  margin-bottom: 15px;
  .el-radio {
    line-height: 28px;
  }
}
.el-tag {
  margin-bottom: 10px;
  + .el-tag {
    margin-left: 10px;
  }
}

.custom-label {
  padding-left: 5px;
  font-weight: 500;
  font-size: 14px;
  color: #606266;
}

.var {
  ::v-deep .el-select .el-input {
    width: 100px;
  }
}
</style>
