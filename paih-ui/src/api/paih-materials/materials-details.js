import request from "@/utils/request"

// 查询物料明细列表
export function getMaterialsListApi(params) {
  return request({
    url: "/materials/list",
    method: "get",
    params,
  })
}

// 删除物料明细
export function deleteMaterialsApi(data) {
  return request({
    url: "/materials/delete",
    method: "delete",
    data,
  })
}

// 物料状态
export function getMaterialsStateListApi() {
  return request({
    url: "/materials-records/list/state-list",
    method: "get",
  })
}

// 新增物料明细
export function createMaterialsApi(data) {
  return request({
    url: "/materials/add",
    method: "post",
    data,
  })
}

// 编辑物料明细
export function updateMaterialsApi(data) {
  return request({
    url: "/materials/edit",
    method: "post",
    data,
  })
}

// 获取附件列表
// export function getFileListApi(fileName) {
//   return request({
//     url: "/public/download/list",
//     method: "get",
//     params: {
//       fileName,
//     },
//   })
// }

// 创建导出后台任务
export function exportBackgroundApi(params){
  return request({
    url: "/materials/list/export/background",
    method: "get",
    params,
  })
}


// 通过分类获取一个新的物料编码
export function getCodeByTypeApi(materialsTypeId) {
  return request({
    url: "/materials/getCodeByType",
    method: "get",
    params: {
      materialsTypeId,
    },
  })
}
