import request from "@/utils/request"

// 查询所有项目下拉框
export function getAllProjectListApi() {
  return request({
    url: "/project/queryAllProject",
    method: "get",
  })
}

// 分页查询我的项目列表
export function getProjectListApi(data) {
  return request({
    url: "/project/list",
    method: "post",
    data,
  })
}

// 收藏项目
export function projectCollectApi(projectId) {
  return request({
    url: "/project/collect",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 取消收藏项目
export function projectCancelCollectApi(projectId) {
  return request({
    url: "/project/cancelCollect",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 删除项目
export function deleteProjectApi(projectId) {
  return request({
    url: "/project/delete",
    method: "delete",
    data: {
      projectId,
    },
  })
}

// 新建项目
export function createProjectApi(data) {
  return request({
    url: "/project/add",
    method: "post",
    data,
  })
}

// 加人 - 查询已加入的成员
export function getProjectMemberApi(projectId) {
  return request({
    url: "/project/member/queryUserListById",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 加人 - 搜索成员
export function queryMemberApi(projectId, keyword) {
  return request({
    url: "/project/queryUserList",
    method: "post",
    data: {
      projectId,
      keyword,
    },
  })
}

// 加人 - 添加新成员
export function addProjectMemberApi(data) {
  return request({
    url: "/project/inviteMemberList",
    method: "post",
    data,
  })
}

// 加人 - 移除旧成员
export function deleteProjectMemberApi(data) {
  return request({
    url: "/project/removeMemberList",
    method: "post",
    data,
  })
}

// 设置 - 基础信息 & 项目功能
export function projectEditApi(data) {
  return request({
    url: "/project/edit",
    method: "post",
    data,
  })
}

// 设置 - 阶段设置 - 获取阶段列表
export function getStageListApi(projectId) {
  return request({
    url: "/project/stage/list",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 设置 - 阶段设置 - 新增阶段
export function createStageApi(projectId, stageName) {
  return request({
    url: "/project/stage/add",
    method: "post",
    data: {
      projectId,
      stageName,
    },
  })
}

// 设置 - 阶段设置 - 删除阶段
export function deleteStageApi(stageId) {
  return request({
    url: "/project/stage/delete",
    method: "delete",
    data: {
      stageId,
    },
  })
}

// 设置 - 阶段设置 - 修改阶段
export function updateStageApi(stageId, stageName) {
  return request({
    url: "/project/stage/edit",
    method: "post",
    data: {
      stageId,
      stageName,
    },
  })
}

// 设置 - 项目操作 - 归档
export function projectArchiveApi(projectId) {
  return request({
    url: "/project/archive",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 设置 - 项目操作 - 取消归档
// export function projectCancelArchiveApi(projectId) {
//   return request({
//     url: "/project/cancelArchive",
//     method: "post",
//     data: {
//       projectId,
//     },
//   })
// }

// 设置 - 项目操作 - 退出项目
export function projectQuitApi(projectId) {
  return request({
    url: "/project/quit",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 详情
export function getProjectDetailApi(projectId) {
  return request({
    url: "/project/detail",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 详情 - 概况 - 获取任务概况
export function getTaskSituationApi(projectId) {
  return request({
    url: "/project/task/situation",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 详情 - 概况 - 获取任务燃尽图
export function getTaskBurnDownChartApi(projectId) {
  return request({
    url: "/project/task/burnDownChart",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 详情 - 概况 - 获取任务每日新增趋势图
export function getTaskStatisticsByDateApi(projectId) {
  return request({
    url: "/project/taskStatisticsByDate",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 详情 - 概况 - 项目动态
export function getProjectLogListApi(data) {
  return request({
    url: "/project/log/list",
    method: "post",
    data,
  })
}

// 详情 - 成员 - 获取列表
export function getMemberListApi(data) {
  return request({
    url: "/project/member/list",
    method: "post",
    data,
  })
}

// 详情 - 任务 - 获取列表
export function getProjectTaskListApi(data) {
  return request({
    url: "/project/detail/taskList",
    method: "post",
    data,
  })
}

// 详情 - 文件 - 获取列表
export function getFileListApi(data) {
  return request({
    url: "/project/file/list",
    method: "post",
    data,
  })
}

// 详情 - 文件 - 删除
export function deleteFileApi(data) {
  return request({
    url: "/project/file/delete",
    method: "post",
    data,
  })
}

// 详情 - 文件 - 重命名
export function renameFileApi(data) {
  return request({
    url: "/project/file/rename",
    method: "post",
    data,
  })
}
