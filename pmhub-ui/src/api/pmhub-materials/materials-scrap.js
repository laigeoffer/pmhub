import request from "@/utils/request"

// 查询报废列表
export function getMaterialsUselessListApi(params) {
  return request({
    url: "/materials-useless/list",
    method: "get",
    params,
  })
}

// 查询报废记录
export function getMaterialsUselessLogApi(data) {
  return request({
    url: "/materials-useless/uselessList",
    method: "post",
    data,
  })
}

// 设置负责人
export function updateMaterialsUselessPrincipalApi(data) {
  return request({
    url: "/materials-useless/updatePrincipalId",
    method: "post",
    data,
  })
}

// 处理意见/是否危废
export function updateMaterialsUselessOpinionApi(data) {
  return request({
    url: "/materials-useless/opinion",
    method: "post",
    data,
  })
}

// 发起审批
export function startProcessApi(materialsIds, processDefId, url, data) {
  return request({
    url: `/materials-useless/startUselessApprove/${processDefId}`,
    method: "post",
    params: {
      materialsIds,
      url,
    },
    data: data,
  })
}

// 审批设置
export function approvalSetApi(data) {
  return request({
    url: "/materials-useless/approvalSet",
    method: "post",
    data,
  })
}

// 密文求和
export function ciphertextSum(array) {
  return request({
    url: "/common/ciphertextSum",
    method: "post",
    data: array,
  })
}
