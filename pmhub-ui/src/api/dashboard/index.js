import request from "@/utils/request"

// 获取数据总览、进度排行及任务状态统计的数据
export function getStatisticsApi() {
  return request({
    url: "/project/statistics",
    method: "get",
  })
}

// 获取进行中的项目
export function getProjectDoingApi() {
  return request({
    url: "/project/doing",
    method: "get",
  })
}

// 获取我的项目下拉框
export function getProjectListApi() {
  return request({
    url: "/project/select",
    method: "get",
  })
}

// 获取我的任务
export function getMyTaskListApi(data) {
  return request({
    url: "/project/queryMyTaskList",
    method: "post",
    data,
  })
}
