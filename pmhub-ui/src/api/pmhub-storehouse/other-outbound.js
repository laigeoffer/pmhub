import request from "@/utils/request";

// 查询领用说明
export function getOutReason() {
  return request({
    url: "/storehouse/reason",
    method: "get",
   
  });
}


// 查询其他出库记录
export function getOtherOutboundListApi(params) {
  return request({
    url: "/storehouse/other-take-out/list",
    method: "get",
    params,
  });
}

// 删除其他出库记录
export function deleteOtherOutboundApi(data) {
  return request({
    url: "/storehouse/other-take-out/delete",
    method: "delete",
    data,
  });
}

// 新增其他出库记录
export function createOtherOutboundApi(data) {
  return request({
    url: "/storehouse/other-take-out/add",
    method: "post",
    data,
  });
}

// 编辑其他出库记录
export function updateOtherOutboundApi(data) {
  return request({
    url: "/storehouse/other-take-out/edit",
    method: "post",
    data,
  });
}

// 单据类型
export function getOrderTypeListApi() {
  return request({
    url: "/storehouse/other-take-out/order-type",
    method: "get",
  });
}

// 发起审批
export function startProcessApi(id, processDefId, url, data) {
  return request({
    url: `/storehouse/startOtherOutApprove/${id}/${processDefId}?url=${url}`,
    method: "post",
    data: data,
  })
}

// 审批设置
export function approvalSetApi(data) {
  return request({
    url: "/storehouse/otherOutApprovalSet",
    method: "post",
    data,
  })
}