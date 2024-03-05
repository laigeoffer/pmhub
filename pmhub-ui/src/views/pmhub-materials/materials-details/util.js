// 转换类别菜单数据结构
export function normalizer(node) {
  let isDisabled = true
  if (node.level === 3) {
    // 一共有三层，只有第三层（也是最后一层）是允许选择的
    isDisabled = false
  }
  if (node.materialsTypeSon && !node.materialsTypeSon.length) {
    delete node.materialsTypeSon
  }
  return {
    id: node.id,
    label: node.materialsTypeName,
    children: node.materialsTypeSon,
    isDisabled,
  }
}

export function normalizerBySearch(node) {
  if (node.materialsTypeSon && !node.materialsTypeSon.length) {
    delete node.materialsTypeSon
  }
  return {
    id: node.id,
    label: node.materialsTypeName,
    children: node.materialsTypeSon,
  }
}
