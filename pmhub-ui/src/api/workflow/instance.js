import request from '@/utils/request'

// 查询流程实例详情信息
export function getDetailInstance(query) {
  return request({
    url: '/workflow/instance/detail',
    method: 'get',
    params: query
  })
}
