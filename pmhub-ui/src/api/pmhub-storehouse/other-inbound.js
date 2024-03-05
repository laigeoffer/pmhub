import request from "@/utils/request"


// 查询其他入库记录
export function getOtherInboundListApi(params) {
  return request({
    url: "/storehouse/other-into/list",
    method: "get",
    params,
  })
}

// 删除其他入库记录
export function deleteOtherInboundApi(data) {
  return request({
    url: "/storehouse/other-into/delete",
    method: "delete",
    data,
  })
}

// 新增其他入库记录
export function createOtherInboundApi(data) {
  return request({
    url: "/storehouse/other-into/add",
    method: "post",
    data,
  })
}

// 编辑其他入库记录
export function updateOtherInboundApi(data) {
  return request({
    url: "/storehouse/other-into/edit",
    method: "post",
    data,
  })
}

// 单据类型
export function getOrderTypeListApi() {
  return request({
    url: "/storehouse/other-into/order-type",
    method: "get",
  })
}

// 发起审批
export function returnInboundStartProcessApi(id, processDefId, url, data) {
  return request({
    url: `/storehouse/startReturnIntoApprove/${id}/${processDefId}?url=${url}`,
    method: "post",
    data: data,
  })
}

// 审批设置
export function returnInboundApprovalSetApi(data) {
  return request({
    url: "/storehouse/returnIntoApprovalSet",
    method: "post",
    data,
  })
}

// 发起审批
export function otherInboundStartProcessApi(id, processDefId, url, data) {
  return request({
    url: `/storehouse/startOtherIntoApprove/${id}/${processDefId}?url=${url}`,
    method: "post",
    data: data,
  })
}

// 审批设置
export function otherInboundApprovalSetApi(data) {
  return request({
    url: "/storehouse/otherIntoApprovalSet",
    method: "post",
    data,
  })
}
