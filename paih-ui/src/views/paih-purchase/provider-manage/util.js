// 转换类别菜单数据结构
export function normalizer(node) {
  let isDisabled = true
  if (node.level === 3) {
    // 一共有三层，只有第三层（也是最后一层）是允许选择的
    isDisabled = false
  }
  if (node.categorySon && !node.categorySon.length) {
    delete node.categorySon
  }
  return {
    id: node.id,
    label: node.categoryName,
    children: node.categorySon,
    isDisabled,
  }
}

export function normalizerBySearch(node) {
  if (node.categorySon && !node.categorySon.length) {
    delete node.categorySon
  }
  return {
    id: node.id,
    label: node.categorySon,
    children: node.categorySon,
  }
}
