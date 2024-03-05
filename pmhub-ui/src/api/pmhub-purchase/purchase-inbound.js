import request from "@/utils/request"

// 查询采购入库记录
export function getPurchaseListApi(params) {
  return request({
    url: "/purchase/list",
    method: "get",
    params,
  })
}

// 删除采购入库记录
export function deletePurchaseApi(data) {
  return request({
    url: "/purchase/delete",
    method: "delete",
    data,
  })
}

// 新增采购入库记录
export function createPurchaseApi(data) {
  return request({
    url: "/purchase/add",
    method: "post",
    data,
  })
}

// 编辑采购入库记录
export function updatePurchaseApi(data) {
  return request({
    url: "/purchase/edit",
    method: "post",
    data,
  })
}

// 发起审批
export function startProcessApi(id, processDefId, url, data) {
  return request({
    url: `/purchase/startInboundApprove/${id}/${processDefId}?url=${url}`,
    method: "post",
    data: data,
  })
}

// 审批设置
export function approvalSetApi(data) {
  return request({
    url: "/purchase/inboundApprovalSet",
    method: "post",
    data,
  })
}
