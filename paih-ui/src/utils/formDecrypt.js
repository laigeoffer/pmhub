/** 截取审批表单中的加密串需要的正则 */
export const formDecryptReg = /(?<=@@start@@paih@@)(.*?)(?=@@end@@paih@@)/g

/** 将加密串改造为正则需要的格式 */
export function transformRegStr(str) {
  return "@@start@@paih@@" + str + "@@end@@paih@@"
}
