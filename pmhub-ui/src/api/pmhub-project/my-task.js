import request from "@/utils/request"

// 任务列表
export function getTaskListApi(data) {
  return request({
    url: "/project/task/list",
    method: "post",
    data,
  })
}

// 新建任务
export function createTaskApi(data) {
  return request({
    url: "/project/task/add",
    method: "post",
    data,
  })
}

// 删除任务
export function deleteTaskApi(data) {
  return request({
    url: "/project/task/delete",
    method: "delete",
    data,
  })
}

// 查询执行人列表
export function getTaskExecutorListApi(projectId) {
  return request({
    url: "/project/task/queryExecutorList",
    method: "post",
    data: {
      projectId,
    },
  })
}

// 更多 - 发起审批
export function startProcessApi(taskId, processDefId, url, data) {
  return request({
    url: `/workflow/process/startTaskApprove/${taskId}/${processDefId}?url=${url}`,
    method: "post",
    data: data,
  })
}

// 更多 - 审批设置
export function updateApprovalSetApi(data) {
  return request({
    url: "/project/task/updateApprovalSet",
    method: "post",
    data,
  })
}

// 详情 - 获取任务详情
export function getTaskDetailApi(taskId) {
  return request({
    url: "/project/task/detail",
    method: "post",
    data: {
      taskId,
    },
  })
}

// 详情 - 修改任务详情
export function updateTaskDetailApi(data) {
  return request({
    url: "/project/task/edit",
    method: "post",
    data,
  })
}

// 详情 - 查询子任务
export function getSubTaskListApi(taskId) {
  return request({
    url: "/project/task/queryChildTask",
    method: "post",
    data: {
      taskId,
    },
  })
}

// 详情 - 添加子任务
export function createSubTaskApi(data) {
  return request({
    url: "/project/task/addChildTask",
    method: "post",
    data,
  })
}

// 详情 - 任务动态
export function getTaskLogApi(data) {
  return request({
    url: "/project/task/log/list",
    method: "post",
    data,
  })
}

// 详情 - 任务动态 - 查询任务成员列表
export function getTaskUserListApi(taskId) {
  return request({
    url: "/project/task/queryUserList",
    method: "post",
    data: {
      taskId,
    },
  })
}

// 详情 - 任务动态 - 添加评论
export function addTaskCommentApi(data) {
  return request({
    url: "/project/task/addComment",
    method: "post",
    data,
  })
}
