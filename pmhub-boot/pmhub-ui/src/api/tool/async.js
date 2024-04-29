import request from '@/utils/request'

// 查询任务列表
export function listAsync(query) {
  return request({
    url: '/tool/async/list',
    method: 'get',
    params: query
  })
}


// 删除任务
export function delAsync(asyncIds) {
  return request({
    url: '/tool/async/delete/' + asyncIds,
    method: 'delete'
  })
}
