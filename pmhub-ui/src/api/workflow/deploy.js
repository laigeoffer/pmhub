import request from '@/utils/request'

// 查询流程部署列表
export function listDeploy(query) {
  return request({
    url: '/workflow/deploy/list',
    method: 'get',
    params: query
  })
}

export function listPublish(query) {
  return request({
    url: '/workflow/deploy/publishList',
    method: 'get',
    params: query
  })
}

// 获取流程模型流程图
export function getBpmnXml(definitionId) {
  return request({
    url: '/workflow/deploy/bpmnXml/' + definitionId,
    method: 'get'
  })
}

// 修改流程状态
export function changeState(params) {
  return request({
    url: '/workflow/deploy/changeState',
    method: 'put',
    params: params
  })
}

// 删除流程部署
export function delDeploy(deployIds) {
  return request({
    url: '/workflow/deploy/' + deployIds,
    method: 'delete'
  })
}

// 查询流程部署关联表单信息
export function getFormByDeployId(deployId) {
  return request({
    url: '/workflow/deploy/form/' + deployId,
    method: 'get',
  })
}
