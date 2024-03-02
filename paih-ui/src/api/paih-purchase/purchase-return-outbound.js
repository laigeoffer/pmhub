import request from "@/utils/request";

// 查询采购退货出库记录
export function getPurchaseCancelListApi(params) {
  return request({
    url: "/purchase/cancel/list",
    method: "get",
    params,
  });
}

// 删除采购退货出库记录
export function deletePurchaseCancelApi(data) {
  return request({
    url: "/purchase/cancel/delete",
    method: "delete",
    data,
  });
}

// 新增采购退货出库记录
export function createPurchaseCancelApi(data) {
  return request({
    url: "/purchase/cancel/add",
    method: "post",
    data,
  });
}

// 编辑采购退货出库记录
export function updatePurchaseCancelApi(data) {
  return request({
    url: "/purchase/cancel/edit",
    method: "post",
    data,
  });
}

// 审批设置
export function approvalSetApi(data) {
  return request({
    url: "/purchase/outboundApprovalSet",
    method: "post",
    data,
  });
}

// 发起审批
export function startProcessApi(id, processDefId, url, data) {
  return request({
    url: `/purchase/startOutboundApprove/${id}/${processDefId}?url=${url}`,
    method: "post",
    data: data,
  })
}