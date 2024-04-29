<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="流程名称" prop="processName">
        <el-input
          v-model="queryParams.processName"
          placeholder="请输入流程名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="接收时间">
        <el-date-picker
          v-model="dateRange"
          style="width: 240px"
          value-format="yyyy-MM-dd HH:mm:ss"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          :default-time="['00:00:00', '23:59:59']"
        ></el-date-picker>
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
          v-hasPermi="['workflow:process:todoExport']"
          @click="handleExport"
        >导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-edit-outline"
          size="mini"
          v-hasPermi="['workflow:process:approval']"
          @click="batchProcessing"
        >批量办理</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="todoList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="任务编号" align="center" prop="taskId" :show-overflow-tooltip="true"/>
      <el-table-column label="流程名称" align="center" prop="procDefName"/>
      <el-table-column label="任务节点" align="center" prop="taskName"/>
      <el-table-column label="流程版本" align="center">
        <template slot-scope="scope">
          <el-tag size="medium" >v{{scope.row.procDefVersion}}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="流程发起人" align="center">
        <template slot-scope="scope">
          <label>{{scope.row.startUserName}} <el-tag type="info" size="mini">{{scope.row.startDeptName}}</el-tag></label>
        </template>
      </el-table-column>
      <el-table-column label="接收时间" align="center" prop="createTime" width="180"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit-outline"
            @click="handleProcess(scope.row)"
            v-hasPermi="['workflow:process:approval']"
          >办理
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加或修改岗位对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body @close="handleDialogClose">
      <el-form ref="taskForm" :model="taskForm" :rules="rules" label-width="80px">
        <el-form-item label="任务数量">
          {{ multipleSelection.length }}/{{ total }}
        </el-form-item>
        <el-form-item label="审批意见" prop="comment">
          <el-input type="textarea" :rows="5" v-model="taskForm.comment" placeholder="请输入审批意见" :disabled="batLoading"/>
        </el-form-item>
        <el-form-item v-show="batError" label="错误消息" style="color: brown;">
          <div v-html="errorInput"></div>
        </el-form-item>
        <el-progress :percentage="batFlag" :status="batFlagDesc"  v-show="batLoading" style="padding-left: 40px;"></el-progress>

      </el-form>
      <el-row slot="footer"  type="flex" justify="center">
        <el-col :span="8" style="text-align: center;" v-show="!batLoading">
              <el-button icon="el-icon-circle-check" type="success" @click="batAccept">通过</el-button>
        </el-col>
        <el-col :span="8" style="text-align: center;" v-show="!batLoading">
              <el-button icon="el-icon-circle-close" type="danger" @click="batPass">拒绝</el-button>
        </el-col>
        <el-col :span="24" v-show="batLoading" style="text-align: center;">
              <el-button icon="el-icon-circle-close" type="primary" v-show="!(batSuccess||batError)" :loading="true" disabled >处理中</el-button>
              <el-button type="success" v-show="batSuccess"  icon="el-icon-check" @click="closeBatPad" round>处理完成</el-button>
              <el-button type="danger" v-show="batError"  icon="el-icon-close" @click="closeBatPad" round>终止处理</el-button>
        </el-col>
      </el-row>
    </el-dialog>

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
import { listTodoProcess } from '@/api/workflow/process';
import { complete, delegate, transfer, rejectTask, returnList, returnTask } from "@/api/workflow/task"

export default {
  name: "Todo",
  components: {},
  data() {
    return {
      // 遮罩层
      loading: true,
      rules: {
        comment: [{ required: true, message: "请输入审批意见", trigger: "blur" }],
      },
      // 选中数组
      ids: [],
      // 选中的记录
      multipleSelection:[],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 流程待办任务表格数据
      todoList: [],
      // 弹出层标题
      title: "批量办理",
      // 是否显示弹出层
      open: false,
      // 是否正在提交批量数据
      batLoading: false,
      // 是否完成提交
      batSuccess: false,
      // 是否发生错误
      batError: false,
      // 错误信息
      errorInput: "",
      // 批处理进度
      batFlag: 0,
      // 批处理进度
      batFlagDesc: null,
      // 任务提交信息
      taskForm: {
        comment: "", // 意见内容
        procInsId: "", // 流程实例编号
        deployId: "", // 流程定义编号
        taskId: "", // 流程任务编号
        definitionId: "", // 流程编号
        copyUserIds: "", // 抄送人Id
        vars: "",
        targetKey: "",
      },
      // 日期范围
      dateRange: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        category: null
      },
      // 表单参数
      form: {}
    };
  },
  beforeRouteEnter(to, from, next) {
    next(vm => {
      vm.getList()
    })
  },
  beforeRouteLeave(to, from, next) {
    // 在离开路由前调用
    this.open = false;
    next(); // 确保调用 next() 来解析这个钩子
  },
  methods: {
    /** 查询流程定义列表 */
    getList() {
      this.loading = true;
      listTodoProcess(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.todoList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 跳转到处理页面
    handleProcess(row) {
      this.$router.push({
        path: '/workflow/process/detail/' + row.procInsId,
        query: {
          definitionId: row.procDefId,
          deployId: row.deployId,
          taskId: row.taskId,
          finished: true
        }
      })
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        name: null,
        category: null,
        key: null,
        tenantId: null,
        deployTime: null,
        derivedFrom: null,
        derivedFromRoot: null,
        parentDeploymentId: null,
        engineVersion: null
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
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
      this.multipleSelection = selection
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加流程定义";
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('workflow/process/todoExport', {
        ...this.queryParams
      }, `wf_todo_process_${new Date().getTime()}.xlsx`)
    },
    /* 任务批处理 */
    batchProcessing(){
       console.log(this.multipleSelection);
        if(this.multipleSelection.length<=0){
          this.$modal.msgError("必须先勾选需要批处理的任务")
        }else{
          this.open = true;
        }
    },
    /* 批量通过 */
    async batAccept(){
      if( this.checkComment()){
        let thisItem;
        try{
          this.batLoading = true;
          for(let i = 0;i<this.multipleSelection.length;i++){
            let item = this.multipleSelection[i];
            thisItem  = item;
            let index = i;
            this.taskForm.taskId = item.taskId;
            this.taskForm.definitionId = item.procDefId;
            this.taskForm.deployId = item.deployId;
            this.taskForm.procInsId = item.procInsId;
            console.log(this.taskForm.comment)
            let dat = this.taskForm;
            await complete(dat); // 等待请求完成
            this.batFlag = ((index+1)*100) / this.multipleSelection.length;
          }
          this.batFlagDesc = "success";
          this.batSuccess = true;
        }
        catch(error){
          this.errorInput = "当前任务无法被处理："
                          +"<br>任务编号："+thisItem.taskId
                          +"<br>流程名称："+thisItem.procDefName
                          +"<br>错误信息："+error.message;
          this.batError = true;
        }
      }else{
        this.$modal.msgError("必须填写审批意见")
      }
      
    },
    /* 批量拒绝 */
    batPass(){
      if( this.checkComment()){

        this.$modal
            .confirm("拒绝审批单流程会终止，是否继续？")
            .then(() => {
                this.passAction();
            })
      }else{
        this.$modal.msgError("必须填写审批意见")
      }
      
    },
    async passAction(){
      let thisItem;
      this.batLoading = true;
      try{
        for(let i = 0;i<this.multipleSelection.length;i++){
          let item = this.multipleSelection[i];
          let index = i;
          thisItem  = item;
          this.taskForm.taskId = item.taskId;
          this.taskForm.definitionId = item.procDefId;
          this.taskForm.deployId = item.deployId;
          this.taskForm.procInsId = item.procInsId;
          console.log(this.taskForm.comment)
          let dat = this.taskForm;
          await rejectTask(dat); // 等待请求完成
          this.batFlag = ((index+1)*100) / this.multipleSelection.length;
        }

        this.batFlagDesc = "success";
        this.batSuccess = true; 
        }
      catch(error){
        this.errorInput = "当前任务无法被处理："
                        +"<br>任务编号："+thisItem.taskId
                        +"<br>流程名称："+thisItem.procDefName
                        +"<br>错误信息："+error.message;
        this.batError = true;
      }

      
              
      
    },
    checkComment(){
        return this.taskForm.comment.length > 0;
    },
    /* 弹出框关闭事件 */
    handleDialogClose(){
      // 重制状态
      this.batLoading = false;
      // 刷新数据
      this.handleQuery();
      this.batFlag = 0;
      this.batFlagDesc = null;
      this.batSuccess = false;
      this.batError = false;
      this.errorInput = "";
    },
    /* 任务批处理 */
    closeBatPad(){
      this.open = false;
    }
  },
  // 进度条状态
  getProgressStatus(batFlag) {
    if(asyncStatus>=100){
      return 'success';
    }else{
      return '';
    }
  }
};
</script>
