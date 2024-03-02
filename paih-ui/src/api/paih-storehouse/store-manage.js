import request from "@/utils/request"

// 查询仓库管理列表
export function listStoremanage(query) {
  return request({
    url: "/storehouse/list",
    method: "get",
    params: query,
  })
}

// 查询仓库管理详细
export function getStoremanage(id) {
  return request({
    url: "/storehouse/" + id,
    method: "get",
  })
}

// 新增仓库管理
export function addStoremanage(data) {
  return request({
    url: "/storehouse",
    method: "post",
    data: data,
  })
}

// 修改仓库管理
export function updateStoremanage(data) {
  return request({
    url: "/storehouse",
    method: "put",
    data: data,
  })
}

// 删除仓库管理
export function delStoremanage(ids) {
  return request({
    url: "/storehouse/" + ids,
    method: "delete",
    data: ids,
  })
}

// 仓库名称查询（查询所有仓库下拉框）
export function getAllStorehouseListApi() {
  return request({
    url: "/storehouse/getStorehouseName",
    method: "get",
  })
}
