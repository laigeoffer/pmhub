import { transformRegStr } from "@/utils/formDecrypt"

export function SET_FIELDS(fields, nickName, url, ids, info, infos, transform) {
  fields[1].__config__.defaultValue = nickName
  fields[2].__config__.defaultValue = url
  if (ids.split(",").length === 1) {
    // 单条审批
    fields[0].__config__.defaultValue = "物料管理-物料报废（单条审批）"
    fields[3].__config__.defaultValue = info.id
    fields[4].__config__.defaultValue = info.materialsName
    fields[5].__config__.defaultValue = info.materialsId
    fields[6].__config__.defaultValue = info.projectName
    fields[7].__config__.defaultValue = info.materialsTypeName
    fields[8].__config__.defaultValue = info.supplierName
    fields[9].__config__.defaultValue = info.intoTime
    fields[10].__config__.defaultValue = info.intoNumber
    fields[11].__config__.defaultValue = info.unit
    fields[12].__config__.defaultValue = info.materialsCount
    fields[13].__config__.defaultValue = info.reason
    fields[14].__config__.defaultValue = info.unitPrice ?? "****"
    fields[15].__config__.defaultValue = info.totalRate ?? "****"
    fields[16].__config__.defaultValue = info.resolution
    fields[17].__config__.defaultValue = info.dangerous
    fields[18].__config__.defaultValue = info.principalName
  } else {
    // 批量审批
    fields[0].__config__.defaultValue = "物料管理-多条物料报废（批量审批）"
    fields[4].__config__.defaultValue = infos.materialsName
    fields[12].__config__.defaultValue = infos.materialsCount
    fields[15].__config__.defaultValue = infos.totalRate ?? "****"
  }
  if (transform?.type === "转换") {
    // 加密串
    if (ids.split(",").length === 1) {
      fields[14].__config__.defaultValue = transformRegStr(info.secrecyMaps?.unitPrice)
      fields[15].__config__.defaultValue = transformRegStr(info.secrecyMaps?.totalRate)
    } else {
      fields[15].__config__.defaultValue = transformRegStr(infos.totalRateCiphertext)
    }
    // 还原备注
    fields[19].__config__.defaultValue = transform?.copyForm.fields[19].__config__.defaultValue
  }
}
