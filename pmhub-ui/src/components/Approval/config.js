import { transformRegStr } from "@/utils/formDecrypt"

// 请手动配置该 map
export const fieldsConfig = {
  "/pmhub-purchase/purchase-inbound": SET_FIELDS_1,
  "/pmhub-purchase/purchase-return-outbound": SET_FIELDS_2,
  "/pmhub-purchase/supplier-manage": SET_FIELDS_3,
  "/pmhub-storehouse/return-inbound": SET_FIELDS_4,
  "/pmhub-storehouse/other-inbound": SET_FIELDS_5,
  "/pmhub-storehouse/other-outbound": SET_FIELDS_6,
}

function SET_FIELDS_1(fields, nickName, info, transform) {
  fields[0].__config__.defaultValue = "采购管理-采购入库"
  fields[1].__config__.defaultValue = nickName
  fields[2].__config__.defaultValue = info.id
  fields[3].__config__.defaultValue = info.materialsName
  fields[4].__config__.defaultValue = info.supplierName
  fields[5].__config__.defaultValue = info.intoNumber
  fields[6].__config__.defaultValue = info.operatorName
  fields[7].__config__.defaultValue = info.projectName
  fields[8].__config__.defaultValue = info.intoTime
  fields[9].__config__.defaultValue = info.totalPrice ?? "****"
  fields[10].__config__.defaultValue = info.totalPay ?? "****"
  if (transform?.type === "转换") {
    // 加密串
    fields[9].__config__.defaultValue = transformRegStr(info.secrecyMaps?.totalPrice)
    fields[10].__config__.defaultValue = transformRegStr(info.secrecyMaps?.totalPay)
    // 还原备注
    fields[11].__config__.defaultValue = transform?.copyForm.fields[11].__config__.defaultValue
  }
}

function SET_FIELDS_2(fields, nickName, info, transform) {
  fields[0].__config__.defaultValue = "采购管理-采购退货出库"
  fields[1].__config__.defaultValue = nickName
  fields[2].__config__.defaultValue = info.id
  fields[3].__config__.defaultValue = info.materialsName
  fields[4].__config__.defaultValue = info.supplierName
  fields[5].__config__.defaultValue = info.totalCount
  fields[6].__config__.defaultValue = info.operatorName
  fields[7].__config__.defaultValue = info.projectName
  fields[8].__config__.defaultValue = info.linkRecordsId
  fields[9].__config__.defaultValue = info.totalPrice ?? "****"
  fields[10].__config__.defaultValue = info.changeRecordTypeDesc
  fields[11].__config__.defaultValue = info.takeOutTime
  if (transform?.type === "转换") {
    // 加密串
    fields[9].__config__.defaultValue = transformRegStr(info.secrecyMaps?.totalPrice)
    // 还原备注
    fields[12].__config__.defaultValue = transform?.copyForm.fields[12].__config__.defaultValue
  }
}

function SET_FIELDS_3(fields, nickName, info, transform) {
  fields[0].__config__.defaultValue = "采购管理-供应商管理"
  fields[1].__config__.defaultValue = nickName
  fields[2].__config__.defaultValue = info.id
  fields[3].__config__.defaultValue = info.providerName
  fields[4].__config__.defaultValue = info.providerCharger
  fields[5].__config__.defaultValue = info.providerPhone
  fields[6].__config__.defaultValue = info.providerTell
  fields[7].__config__.defaultValue = info.providerEmail
  fields[8].__config__.defaultValue = info.earlypay
  fields[9].__config__.defaultValue = info.endpay
  fields[10].__config__.defaultValue = info.rate
  if (transform?.type === "转换") {
    // 还原备注
    fields[11].__config__.defaultValue = transform?.copyForm.fields[11].__config__.defaultValue
  }
}

function SET_FIELDS_4(fields, nickName, info, transform) {
  fields[0].__config__.defaultValue = "库存管理-归还入库"
  fields[1].__config__.defaultValue = nickName
  fields[2].__config__.defaultValue = info.id
  fields[3].__config__.defaultValue = info.materialsName
  fields[4].__config__.defaultValue = info.supplierName
  fields[5].__config__.defaultValue = info.intoNumber
  fields[6].__config__.defaultValue = info.operatorName
  fields[7].__config__.defaultValue = info.projectName
  fields[8].__config__.defaultValue = info.linkRecordsId
  fields[9].__config__.defaultValue = info.totalPrice ?? "****"
  fields[10].__config__.defaultValue = info.intoTime
  if (transform?.type === "转换") {
    // 加密串
    fields[9].__config__.defaultValue = transformRegStr(info.secrecyMaps?.totalPrice)
    // 还原备注
    fields[11].__config__.defaultValue = transform?.copyForm.fields[11].__config__.defaultValue
  }
}

function SET_FIELDS_5(fields, nickName, info, transform) {
  fields[0].__config__.defaultValue = "库存管理-其他入库"
  fields[1].__config__.defaultValue = nickName
  fields[2].__config__.defaultValue = info.id
  fields[3].__config__.defaultValue = info.materialsName
  fields[4].__config__.defaultValue = info.supplierName
  fields[5].__config__.defaultValue = info.intoNumber
  fields[6].__config__.defaultValue = info.operatorName
  fields[7].__config__.defaultValue = info.projectName
  fields[8].__config__.defaultValue = info.totalPrice ?? "****"
  fields[9].__config__.defaultValue = info.intoTime
  if (transform?.type === "转换") {
    // 加密串
    fields[8].__config__.defaultValue = transformRegStr(info.secrecyMaps?.totalPrice)
    // 还原备注
    fields[10].__config__.defaultValue = transform?.copyForm.fields[10].__config__.defaultValue
  }
}

function SET_FIELDS_6(fields, nickName, info, transform) {
  fields[0].__config__.defaultValue = "库存管理-其他出库"
  fields[1].__config__.defaultValue = nickName
  fields[2].__config__.defaultValue = info.id
  fields[3].__config__.defaultValue = info.materialsName
  fields[4].__config__.defaultValue = info.supplierName
  fields[5].__config__.defaultValue = info.intoNumber
  fields[6].__config__.defaultValue = info.storehouseCount
  fields[7].__config__.defaultValue = info.operatorName
  fields[8].__config__.defaultValue = info.projectName
  fields[9].__config__.defaultValue = info.linkRecordsId
  fields[10].__config__.defaultValue = info.changeRecordTypeDesc
  fields[11].__config__.defaultValue = info.returnTime
  fields[12].__config__.defaultValue = info.takeOutTime
  fields[13].__config__.defaultValue = info.takeOutUserName
  if (transform?.type === "转换") {
    // 还原备注
    fields[14].__config__.defaultValue = transform?.copyForm.fields[14].__config__.defaultValue
  }
}
