import request from "@/utils/request"

// 查询物料明细列表
export function getMaterialsRecordsListApi(params) {
  return request({
    url: "/materials-records/list",
    method: "get",
    params,
  })
}

// 单据类型
export function getOrderTypeListApi() {
  return request({
    url: "/materials-records/order-type",
    method: "get",
  })
}
