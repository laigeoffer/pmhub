<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="10" class="project-info">
        <el-card header="项目信息" shadow="never">
          <div class="project-info-descriptions">
            <el-descriptions :column="1">
              <el-descriptions-item label="项目名">{{ projectData.projectName }}</el-descriptions-item>
              <el-descriptions-item label="负责人">{{ projectData.nickName }}</el-descriptions-item>
              <el-descriptions-item label="创建时间">{{ projectData.createdTime }}</el-descriptions-item>
              <el-descriptions-item label="最近更新时间">{{ projectData.updatedTime }}</el-descriptions-item>
              <el-descriptions-item label="起止时间">
                {{ projectData.closeBeginTime }} - {{ projectData.closeEndTime }}
              </el-descriptions-item>
              <el-descriptions-item label="所属阶段">{{ projectData.stageName }}</el-descriptions-item>
              <el-descriptions-item label="项目状态">{{ projectData.statusName }}</el-descriptions-item>
              <el-descriptions-item label="发布状态">{{ projectData.publishedName }}</el-descriptions-item>
            </el-descriptions>
          </div>
          <div class="project-info-progress">
            <div class="project-info-progress-item">
              <el-progress type="circle" :percentage="projectData.projectProcess"></el-progress>
              <span>项目进度</span>
            </div>
            <!-- <div class="project-info-progress-item">
              <el-progress type="circle" :percentage="100"></el-progress>
              <span>物料库存率</span>
            </div> -->
          </div>
        </el-card>
      </el-col>
      <el-col :span="14" class="echarts">
        <el-card header="任务燃尽图" shadow="never">
          <div id="taskBurndownChart" />
        </el-card>
        <el-card header="任务每日新增趋势" shadow="never">
          <div id="dailyTrendChart" />
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :span="10" class="task-overview">
        <el-card header="任务概况" shadow="never">
          <div class="task-overview-item" v-for="(item, index) in taskOverview" :key="index">
            <span class="title">{{ item.title }}</span>
            <span class="number">{{ item.number }}</span>
            <div class="line" :style="{ backgroundColor: item.lineColor }"></div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="14" class="project-dynamics">
        <el-card header="项目动态" shadow="never">
          <span class="tip">共 {{ total }} 条动态</span>
          <div class="project-dynamics-item" v-for="(item, index) in projectDynamics" :key="index">
            <div class="left">
              <!-- <svg-icon icon-class="time" /> -->
              <img :src="item.avatar" width="24px" height="24px" />
              <div>
                <div class="title">{{ item.nickName }} - {{ item.remark }}</div>
                <div class="content" v-if="item.taskName">任务名：{{ item.taskName }}</div>
              </div>
            </div>
            <span class="right">{{ item.createdTime }}</span>
          </div>
          <el-pagination
            layout="prev, pager, next"
            :total="total"
            :page-size="10"
            :current-page="currentPage"
            @current-change="handleCurrentChange"
          ></el-pagination>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import echarts from "echarts"
import {
  getTaskSituationApi,
  getTaskBurnDownChartApi,
  getTaskStatisticsByDateApi,
  getProjectLogListApi,
} from "@/api/pmhub-project/my-project.js"

export default {
  name: "MyProjectInfoOverview",
  props: {
    // 项目基本数据
    projectData: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      taskBurndownChart: null,
      dailyTrendChart: null,
      taskOverview: [
        {
          title: "总数",
          number: 0,
          lineColor: "rgb(53, 153, 255)",
        },
        {
          title: "未完成",
          number: 0,
          lineColor: "rgb(255, 229, 193)",
        },
        {
          title: "今日到期",
          number: 0,
          lineColor: "rgb(255, 204, 208)",
        },
        {
          title: "待认领",
          number: 0,
          lineColor: "rgb(229, 233, 242)",
        },
        {
          title: "时间待定",
          number: 0,
          lineColor: "rgb(220, 203, 255)",
        },
        {
          title: "已逾期",
          number: 0,
          lineColor: "rgb(245, 78, 96)",
        },
        {
          title: "已完成",
          number: 0,
          lineColor: "rgb(25, 197, 189)",
        },
        {
          title: "逾期完成",
          number: 0,
          lineColor: "rgb(255, 168, 0)",
        },
      ],
      projectDynamics: [],
      total: 0,
      currentPage: 1,
    }
  },
  methods: {
    // 初始化任务概括
    initTaskOverview() {
      getTaskSituationApi(this.projectData.projectId).then((res) => {
        this.taskOverview[0].number = res.data.total ?? 0
        this.taskOverview[1].number = res.data.unDone ?? 0
        this.taskOverview[2].number = res.data.expireToday ?? 0
        this.taskOverview[3].number = res.data.toBeAssign ?? 0
        this.taskOverview[4].number = res.data.timeUndetermined ?? 0
        this.taskOverview[5].number = res.data.overdue ?? 0
        this.taskOverview[6].number = res.data.done ?? 0
        this.taskOverview[7].number = res.data.doneOverdue ?? 0
      })
    },
    // 初始化任务燃尽图
    initTaskBurndownChart() {
      const dom = document.getElementById("taskBurndownChart")
      this.taskBurndownChart = echarts.init(dom)
      const option = {
        tooltip: {
          /** 显示横坐标值 */
          trigger: "axis",
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
          data: [],
        },
        yAxis: {
          type: "value",
        },
        series: [
          {
            data: [],
            type: "line",
            smooth: true,
            name: "理想剩余任务",
          },
          {
            data: [],
            type: "line",
            smooth: true,
            name: "实际剩余任务",
          },
        ],
      }
      getTaskBurnDownChartApi(this.projectData.projectId).then((res) => {
        for (let i = 0; i < res.data.length; i++) {
          option.xAxis.data.push(res.data[i].date)
          option.series[0].data.push(res.data[i].baseLineNum)
          option.series[1].data.push(res.data[i].unDoneTaskNum)
        }
        this.taskBurndownChart.setOption(option)
      })
    },
    // 初始化任务每日新增趋势图
    initDailyTrendChart() {
      const dom = document.getElementById("dailyTrendChart")
      this.dailyTrendChart = echarts.init(dom)
      const option = {
        tooltip: {
          /** 显示横坐标值 */
          trigger: "axis",
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
          data: [],
        },
        yAxis: {
          type: "value",
        },
        series: [
          {
            data: [],
            type: "line",
            smooth: true,
            name: "任务数",
          },
        ],
      }
      getTaskStatisticsByDateApi(this.projectData.projectId).then((res) => {
        for (let i = 0; i < res.data.length; i++) {
          option.xAxis.data.push(res.data[i].date)
          option.series[0].data.push(res.data[i].total)
        }
        this.dailyTrendChart.setOption(option)
      })
    },
    // 初始化项目动态
    initProjectDynamics() {
      this.$modal.loading("加载中...")
      getProjectLogListApi({
        pageNum: this.currentPage,
        pageSize: 10,
        projectId: this.projectData.projectId,
      })
        .then((res) => {
          this.total = res.data.total
          for (let i = 0; i < res.data.list.length; i++) {
            const avatar = res.data.list[i].avatar
            res.data.list[i].avatar =
              avatar == "" || avatar == null ? require("@/assets/logo/logo.png") : process.env.VUE_APP_BASE_API + avatar
          }
          this.projectDynamics = res.data.list
        })
        .catch(() => {
          this.projectDynamics = []
        })
        .finally(() => {
          this.$modal.closeLoading()
        })
    },
    handleCurrentChange(value) {
      this.currentPage = value
      this.initProjectDynamics()
    },
    // 图表自适应
    resizeChart() {
      this.taskBurndownChart.resize()
      this.dailyTrendChart.resize()
    },
    // 销毁图表
    disposeChart() {
      this.taskBurndownChart.dispose()
      this.dailyTrendChart.dispose()
    },
  },
  created() {
    this.initTaskOverview()
    this.initProjectDynamics()
  },
  mounted() {
    this.initTaskBurndownChart()
    this.initDailyTrendChart()
    window.addEventListener("resize", this.resizeChart)
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.resizeChart)
    this.disposeChart()
  },
}
</script>

<style scoped lang="scss">
.el-row {
  margin-bottom: 20px;
}

.project-info {
  height: 500px;
  .el-card {
    height: 100%;
    .project-info-descriptions {
    }
    .project-info-progress {
      margin-top: 20px;
      display: flex;
      .project-info-progress-item {
        width: 50%;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        span {
          margin-top: 10px;
        }
      }
    }
  }
}

.echarts {
  height: 500px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  .el-card {
    height: 245px;
    ::v-deep .el-card__body {
      padding: 0;
    }
    #taskBurndownChart,
    #dailyTrendChart {
      height: 200px;
    }
  }
}

.task-overview {
  ::v-deep .el-card__body {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    .task-overview-item {
      width: 20%;
      margin: 20px 5px;
      display: flex;
      flex-direction: column;
      .title {
        color: #606266;
      }
      .number {
        font-size: 28px;
        margin: 5px 0;
      }
      .line {
        height: 4px;
        border-radius: 2px;
      }
    }
  }
}

.project-dynamics {
  ::v-deep .el-card__body {
    .tip {
      font-size: 14px;
      color: #606266;
    }
    .project-dynamics-item {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
      .left {
        display: flex;
        align-items: center;
        .svg-icon {
          font-size: 24px;
          margin-right: 10px;
          color: rgb(245, 78, 96);
        }
        img {
          margin-right: 10px;
        }
        .title {
          font-size: 14px;
        }
        .content {
          color: #606266;
          font-size: 12px;
        }
      }
      .right {
        color: #606266;
        font-size: 14px;
      }
    }
    .el-pagination {
      margin-top: 20px;
      text-align: center;
    }
  }
}
</style>
