import request from '@/utils/request'

// 查询物料分类树形数据
export function listMaterialsSort(query) {
  return request({
      url: '/materials-type/list',
      method: 'get',
      params: query
  })
}

// 新增物料分类
export function addMaterialsSort(data) {
  return request({
      url: '/materials-type/add',
      method: 'post',
      data: data
  })
}

// 修改物料分类
export function editMaterialsSort(data) {
  return request({
      url: '/materials-type/edit',
      method: 'post',
      data: data
  })
}


// 删除物料分类
export function deleteMaterialsSort(data) {
  return request({
      url: '/materials-type/delete',
      method: 'delete',
      data: data
  })
}