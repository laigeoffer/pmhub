import request from '@/utils/request'

// 查询供应商分类树形数据
export function listProviderSort(query) {
  return request({
      url: '/common-category/list',
      method: 'get',
      params: query
  })
}

// 新增供应商分类
export function addProviderSort(data) {
  return request({
      url: '/common-category/add',
      method: 'post',
      data: data
  })
}

// 修改供应商分类
export function editProviderSort(data) {
  return request({
      url: '/common-category/edit',
      method: 'post',
      data: data
  })
}


// 删除供应商分类
export function deleteProviderSort(data) {
  return request({
      url: '/common-category/delete',
      method: 'delete',
      data: data
  })
}