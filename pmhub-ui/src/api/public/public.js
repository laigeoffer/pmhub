import request from "@/utils/request"

// 查询生成表数据
export function getTotalCount(query) {
  return request({
    url: "/materials-records/totalCount/",
    method: "get",
    params: query,
  })
}

// 查询已入库的物料单
export function getStoreOrder(params) {
  return request({
    url: "/storehouse/orderList",
    method: "get",
    params,
  })
}

// 查询审批设置
export function getApprovalSetApi(type, query) {
  return request({
    url: `/workflow/deploy/refApproval/${type}`,
    method: "get",
    params: query,
  })
}

// 流程设计页面 - 查询内置变量
export function getVarListApi(type) {
  return request({
    url: "/system/dict/data/varList",
    method: "get",
  })
}

// 拿取审批状态下拉列表选项
export function getOrderState() {
  return request({
    url: "/storehouse/order-state",
    method: "get",
  })
}

// 敏感信息解密接口
export function decrypt(encryptStr) {
  return request({
    url: "/common/decrypt",
    method: "post",
    data: {
      encryptStr,
    },
  })
}
