<template>
  <div class="app-container">
    <!-- 数据总览模块 -->
    <el-card header="数据总览" shadow="never" class="data-wrapper">
      <div class="panel" v-for="(item, index) in panelList" :key="index">
        <div class="panel-icon-wrapper" :class="item.class">
          <svg-icon :icon-class="item.icon" class-name="panel-icon" />
        </div>
        <div class="panel-description">
          <div class="panel-text">{{ item.title }}</div>
          <count-to :start-val="0" :end-val="item.number" :duration="1000" class="panel-num" />
        </div>
      </div>
    </el-card>
    <!-- 项目/任务模块 -->
    <el-row :gutter="20">
      <el-col :span="16">
        <el-card shadow="never" class="project-wrapper">
          <template slot="header">
            <span>进行中的项目</span>
            <el-button type="text" @click="link('pmhub-project/my-project')">全部项目</el-button>
          </template>
          <div class="panel" v-for="(item, index) in projectList" :key="index" @click="clickProject(item.projectId)">
            <div class="content">
              <!-- <img :src="item.cover" width="50px" height="50px" /> -->
              <el-image :src="item.cover" style="width: 50px; height: 50px" fit="cover">
                <div slot="error" style="display: flex; justify-content: center; align-items: center; height: 100%">
                  <i class="el-icon-picture-outline" style="font-size: 40px"></i>
                </div>
              </el-image>
              <div class="text">
                <p>项目名:{{ item.projectName }}</p>
                <p>负责人:{{ item.nickName }}</p>
              </div>
            </div>
            <div class="progress">
              <el-progress :text-inside="true" :stroke-width="16" :percentage="item.process"></el-progress>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="never" class="task-wrapper">
          <template slot="header">
            <span>我的任务</span>
            <el-select v-model="projectId" placeholder="请选择项目" size="mini" @change="changeProjectId" filterable>
              <el-option
                v-for="(item, index) in projectOptions"
                :key="index"
                :label="item.projectName"
                :value="item.projectId"
              >
              </el-option>
            </el-select>
          </template>
          <el-radio-group v-model="taskRadio" @input="changeTaskRadio">
            <el-radio-button :label="1">我执行的</el-radio-button>
            <el-radio-button :label="2">我参与的</el-radio-button>
            <el-radio-button :label="3">我创建的</el-radio-button>
          </el-radio-group>
          <el-table
            :data="tableData"
            @row-click="handleRowClick"
            highlight-current-row
            :row-style="{ cursor: 'pointer' }"
            :show-header="false"
          >
            <el-table-column label="任务名" prop="taskName" align="center" show-overflow-tooltip />
            <el-table-column label="所属阶段" prop="stageName" align="center" show-overflow-tooltip />
            <el-table-column label="任务状态" prop="statusName" align="center" show-overflow-tooltip />
            <el-table-column label="时间" prop="createdTime" align="center" show-overflow-tooltip />
          </el-table>
          <el-pagination
            layout="prev, pager, next"
            :total="total"
            :page-size="5"
            :current-page="currentPage"
            @current-change="handleCurrentChange"
          ></el-pagination>
        </el-card>
      </el-col>
    </el-row>
    <!-- 图表模块 -->
    <el-row :gutter="20" class="chart-wrapper">
      <el-col :span="16">
        <el-card header="项目进度排行" shadow="never">
          <div id="projectProgressChart"></div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card header="任务状态" shadow="never">
          <div id="taskStatusChart"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import CountTo from "vue-count-to"
import echarts from "echarts"
import { getStatisticsApi, getProjectDoingApi, getProjectListApi, getMyTaskListApi } from "@/api/dashboard/index.js"

export default {
  name: "Index",
  components: { CountTo },
  data() {
    return {
      /* 总览模块 */
      panelList: [
        {
          title: "项目总数",
          number: 0,
          icon: "project",
          class: "icon-1",
        },
        {
          title: "任务总数",
          number: 0,
          icon: "task",
          class: "icon-2",
        },
        {
          title: "今日任务数",
          number: 0,
          icon: "task2",
          class: "icon-3",
        },
        {
          title: "逾期任务数",
          number: 0,
          icon: "overdue-task",
          class: "icon-4",
        },
      ],

      /* 进行中的项目模块 */
      projectList: [
        // {
        //   projectName: "test",
        //   nickName: "test",
        //   process: 50,
        // },
      ],

      /* 我的任务模块 */
      taskRadio: 1,
      projectId: undefined,
      projectOptions: [],
      tableData: [],
      total: 0,
      currentPage: 1,

      /* 图表模块 */
      projectProgressChart: null,
      projectProgressData: {
        x: [],
        y: [],
      },
      taskStatusChart: null,
      taskStatusData: [
        // { value: 0, name: "已完成" },
        // { value: 0, name: "进行中" },
        // { value: 0, name: "已逾期" },
        // { value: 0, name: "待认领" },
      ],
    }
  },
  methods: {
    link(path) {
      this.$router.push(path)
    },

    /* 进行中的项目模块 */
    clickProject(projectId) {
      this.$router.push({ path: "/pmhub-project/my-project/info", query: { projectId } })
    },

    /* 我的任务模块 */
    changeTaskRadio(label) {
      this.currentPage = 1
      this.getTableData()
    },
    changeProjectId() {
      this.currentPage = 1
      this.getTableData()
    },
    handleRowClick(row, column) {
      // 跳转到任务详情页
      this.$router.push({ path: "/pmhub-project/my-task/info", query: { taskId: row.taskId } })
    },
    handleCurrentChange(value) {
      this.currentPage = value
      this.getTableData()
    },
    getTableData() {
      this.$modal.loading("加载中...")
      getMyTaskListApi({
        pageNum: this.currentPage,
        pageSize: 5,
        projectId: this.projectId,
        type: this.taskRadio,
      })
        .then((res) => {
          this.total = res.data.total
          this.tableData = res.data.list
        })
        .catch(() => {
          this.tableData = []
        })
        .finally(() => {
          this.$modal.closeLoading()
        })
    },

    /* 图表模块 */
    initProjectProgressChart() {
      const dom = document.getElementById("projectProgressChart")
      this.projectProgressChart = echarts.init(dom)
      const option = {
        color: ["#409EFF"],
        tooltip: {
          /** 显示横坐标值 */
          trigger: "axis",
          formatter: function (params) {
            var tar = params[0]
            return "进度：" + tar.value + "%"
          },
        },
        grid: {
          left: "3%",
          right: "3%",
          top: "12%",
          bottom: "6%",
          containLabel: true,
        },
        dataZoom: [
          {
            type: "inside",
            start: 0,
            end: 100,
          },
          {
            start: 0,
            end: 100,
          },
        ],
        xAxis: {
          type: "category",
          data: this.projectProgressData.x,
        },
        yAxis: {
          type: "value",
        },
        series: [
          {
            data: this.projectProgressData.y,
            type: "bar",
          },
        ],
      }
      this.projectProgressChart.setOption(option)
    },
    initTaskStatusChart() {
      const dom = document.getElementById("taskStatusChart")
      this.taskStatusChart = echarts.init(dom)
      const option = {
        color: ["#00DDFF", "#37A2FF", "#FF0087", "#FFBF00", "#909399"],
        tooltip: {
          /** 显示横坐标值 */
          trigger: "item",
        },
        label: {
          alignTo: "edge",
          formatter: "{name|{b}}\n{time|{c}}",
          minMargin: 5,
          edgeDistance: 10,
          lineHeight: 15,
          rich: {
            time: {
              fontSize: 10,
              color: "#999",
            },
          },
        },
        legend: {
          top: "bottom",
        },
        series: [
          {
            data: this.taskStatusData,
            type: "pie",
            radius: ["30%", "50%"],
          },
        ],
      }
      this.taskStatusChart.setOption(option)
    },
    // 图表自适应
    resizeChart() {
      this.projectProgressChart.resize()
      this.taskStatusChart.resize()
    },
    // 销毁图表
    disposeChart() {
      this.projectProgressChart.dispose()
      this.taskStatusChart.dispose()
    },
  },
  mounted() {
    getStatisticsApi().then((res) => {
      // 获取数据总览
      this.panelList[0].number = Number(res.data.projectNum)
      this.panelList[1].number = Number(res.data.taskNum)
      this.panelList[2].number = Number(res.data.todayTaskNum)
      this.panelList[3].number = Number(res.data.overdueTaskNum)
      // 获取项目进度排行
      for (let i = 0; i < res.data.projectRankVOList.length; i++) {
        const item = res.data.projectRankVOList[i]
        this.projectProgressData.x.push(item.projectName)
        this.projectProgressData.y.push(item.process)
      }
      // 获取任务状态
      for (let i = 0; i < res.data.taskStatisticsVOList.length; i++) {
        const item = res.data.taskStatisticsVOList[i]
        this.taskStatusData.push({
          name: item.statusName,
          value: item.taskNum,
        })
      }
      this.initProjectProgressChart()
      this.initTaskStatusChart()
    })
    getProjectDoingApi().then((res) => {
      // 获取进行中的项目
      for (let i = 0; i < res.data.length; i++) {
        res.data[i].cover = process.env.VUE_APP_BASE_API + res.data[i].cover
      }
      this.projectList = res.data
    })
    getProjectListApi().then((res) => {
      // 获取项目列表
      this.projectOptions = [{ projectName: "全部项目", projectId: undefined }, ...res.data]
    })
    this.getTableData()
    window.addEventListener("resize", this.resizeChart)
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.resizeChart)
    this.disposeChart()
  },
}
</script>

<style scoped lang="scss">
.data-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__body {
    display: flex;
    justify-content: space-between;
  }
  .panel {
    width: 22%;
    min-width: 200px;
    height: 108px;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, 0.05);
    &:hover {
      .panel-icon-wrapper {
        color: #fff;
      }
      .icon-1 {
        background: #36a3f7;
      }
      .icon-2 {
        background: #40c9c6;
      }
      .icon-3 {
        background: #ff8c00;
      }
      .icon-4 {
        background: #f4516c;
      }
    }
    .icon-1 {
      color: #36a3f7;
    }
    .icon-2 {
      color: #40c9c6;
    }
    .icon-3 {
      color: #ff8c00;
    }
    .icon-4 {
      color: #f4516c;
    }
    .panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
      .panel-icon {
        font-size: 48px;
      }
    }
    .panel-description {
      float: right;
      font-weight: bold;
      margin: 26px;
      margin-left: 0px;
      .panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 16px;
        margin-bottom: 12px;
      }
      .panel-num {
        font-size: 20px;
      }
    }
  }
}

.project-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  ::v-deep .el-card__body {
    max-height: 500px;
    overflow: auto;
    display: flex;
    flex-wrap: wrap;
  }
  .panel {
    &:nth-child(1),
    &:nth-child(2),
    &:nth-child(3n) {
      flex: 1;
    }
    cursor: pointer;
    overflow: auto;
    margin: 0 1% 1% 1%;
    min-width: 31%;
    height: 150px;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, 0.05);
    display: flex;
    flex-direction: column;
    justify-content: center;
    .content {
      display: flex;
      justify-content: space-around;
      align-items: center;
      .text {
        font-size: 14px;
        width: 60%;
        white-space: nowrap; // 禁止换行
      }
    }
    .progress {
      margin: 10px 10px 0 10px;
    }
  }
}

.task-wrapper {
  margin-bottom: 20px;
  ::v-deep .el-card__header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  .el-table {
    margin-top: 15px;
  }
  .el-pagination {
    margin-top: 20px;
    text-align: center;
  }
}

.chart-wrapper {
  ::v-deep .el-card__body {
    padding: 0;
  }
  #projectProgressChart,
  #taskStatusChart {
    height: 250px;
  }
}
</style>
