import request from "@/utils/request"

// 查询供应商管理列表
export function listProviderManage(query) {
  return request({
    url: "/paih-purchase/providerManage/list",
    method: "get",
    params: query,
  })
}

// 查询供应商管理详细
export function getProviderManage(id) {
  return request({
    url: "/paih-purchase/providerManage/" + id,
    method: "get",
  })
}

// 新增供应商管理
export function addProviderManage(data) {
  return request({
    url: "/paih-purchase/providerManage",
    method: "post",
    data: data,
  })
}

// 修改供应商管理
export function updateProviderManage(data) {
  return request({
    url: "/paih-purchase/providerManage",
    method: "put",
    data: data,
  })
}

// 删除供应商管理
export function delProviderManage(ids) {
  return request({
    url: "/paih-purchase/providerManage/" + ids,
    method: "delete",
  })
}

// 供应商名称查询（查询所有供应商下拉框）
export function getAllProviderListApi() {
  return request({
    url: "/paih-purchase/providerManage/getProviderName",
    method: "get",
  })
}

// 发起审批
export function startProcessApi(providerId, processDefId, url, data) {
  return request({
    url: `/paih-purchase/providerManage/startProviderApprove/${providerId}/${processDefId}?url=${url}`,
    method: "post",
    data: data,
  })
}

// 审批设置
export function approvalSetApi(data) {
  return request({
    url: "/paih-purchase/providerManage/ApprovalSet",
    method: "post",
    data,
  })
}


// 修改供应商状态为试用
export function returnProviderProbation(id) {
  return request({
    url: `/paih-purchase/providerManage/returnProviderProbation/${id}`,
    method: "put",
  })
}

// 根据供应商类型生成供应商编码
export function getCodeByType(providerCategoryId) {
  return request({
    url: `/paih-purchase/providerManage/getCodeByType`,
    method: "get",
    params: {
      providerCategoryId,
    },
  })
}

