<template>
  <div>
    <div class="mask" v-show="isShowSelect" @click="isShowSelect = !isShowSelect"></div>
    <el-popover placement="bottom-start" :width="width" trigger="manual" v-model="isShowSelect" @hide="popoverHide">
      <el-select
        slot="reference"
        ref="select"
        :size="size"
        v-model="selectedData"
        :multiple="multiple"
        :clearable="clearable"
        :collapse-tags="collapseTags"
        @click.native="isShowSelect = !isShowSelect"
        @remove-tag="removeSelectedNodes"
        @clear="removeSelectedNode"
        @change="changeSelectedNodes"
        class="tree-select"
      >
        <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
      </el-select>
      <el-tree
        class="common-tree"
        ref="tree"
        :style="`width: 100%; ${height}px`"
        :data="data"
        :props="defaultProps"
        :show-checkbox="multiple"
        :node-key="nodeKey"
        :check-strictly="checkStrictly"
        default-expand-all
        :expand-on-click-node="false"
        :check-on-click-node="multiple"
        :highlight-current="true"
        @node-click="handleNodeClick"
        @check-change="handleCheckChange"
      />
    </el-popover>
  </div>
</template>

<script>
export default {
  name: 'tree-select',
  props: {
    // 树结构数据
    data: {
      type: Array,
      default() {
        return [];
      }
    },
    defaultProps: {
      type: Object,
      default() {
        return {};
      }
    },
    // 配置是否可多选
    multiple: {
      type: Boolean,
      default() {
        return false;
      }
    },
    // 配置是否可清空选择
    clearable: {
      type: Boolean,
      default() {
        return false;
      }
    },
    // 配置多选时是否将选中值按文字的形式展示
    collapseTags: {
      type: Boolean,
      default() {
        return false;
      }
    },
    nodeKey: {
      type: String,
      default() {
        return 'id';
      }
    },
    // 显示复选框情况下，是否严格遵循父子不互相关联
    checkStrictly: {
      type: Boolean,
      default() {
        return false;
      }
    },
    // 默认选中的节点key数组
    checkedKeys: {
      type: Array,
      default() {
        return [];
      }
    },
    size: {
      type: String,
      default() {
        return 'small';
      }
    },
    width: {
      type: Number,
      default() {
        return 250;
      }
    },
    height: {
      type: Number,
      default() {
        return 300;
      }
    }
  },
  data() {
    return {
      isShowSelect: false, // 是否显示树状选择器
      options: [],
      selectedData: [], // 选中的节点
      style: 'width:' + this.width + 'px;' + 'height:' + this.height + 'px;',
      selectStyle: 'width:' + (this.width + 24) + 'px;',
      checkedIds: [],
      checkedData: []
    };
  },
  mounted() {
    this.initCheckedData();
  },
  methods: {
    // 单选时点击tree节点，设置select选项
    setSelectOption(node) {
      let tmpMap = {};
      tmpMap.value = node.key;
      tmpMap.label = node.label;
      this.options = [];
      this.options.push(tmpMap);
      this.selectedData = node.key;
    },
    // 单选，选中传进来的节点
    checkSelectedNode(checkedKeys) {
      var item = checkedKeys[0];
      this.$refs.tree.setCurrentKey(item);
      var node = this.$refs.tree.getNode(item);
      this.setSelectOption(node);
    },
    // 多选，勾选上传进来的节点
    checkSelectedNodes(checkedKeys) {
      this.$refs.tree.setCheckedKeys(checkedKeys);
    },
    // 单选，清空选中
    clearSelectedNode() {
      this.$refs.tree.setCurrentKey(null);
    },
    // 多选，清空所有勾选
    clearSelectedNodes() {
      var checkedKeys = this.$refs.tree.getCheckedKeys(); // 所有被选中的节点的 key 所组成的数组数据
      for (let i = 0; i < checkedKeys.length; i++) {
        this.$refs.tree.setChecked(checkedKeys[i], false);
      }
    },
    initCheckedData() {
      if (this.multiple) {
        // 多选
        if (this.checkedKeys.length > 0) {
          this.selectedData = this.checkedKeys;
          this.checkSelectedNodes(this.checkedKeys);
        } else {
          this.selectedData = '';
          this.clearSelectedNodes();
        }
      } else {
        // 单选
        if (this.checkedKeys.length > 0) {
          this.selectedData = this.checkedKeys[0];
          this.checkSelectedNode(this.checkedKeys);
        } else {
          this.selectedData = '';
          this.clearSelectedNode();
        }
      }
    },
    a2b(ls) {
      return ls.map(obj => {
        let result = { id: '', text: '' };
        if (obj.children && obj.children.length > 0) {
          result.id = obj.value;
          result.text = obj.label;
          result.arr = a2b(obj.children);
          return result;
        } else {
          result.id = obj.value;
          result.text = obj.label;
          return result;
        }
      });
    },
    popoverHide() {
      if (this.multiple) {
        this.checkedIds = this.$refs.tree.getCheckedKeys(); // 所有被选中的节点的 key 所组成的数组数据
        this.checkedData = this.$refs.tree.getCheckedNodes(); // 所有被选中的节点所组成的数组数据
      } else {
        this.checkedIds = this.$refs.tree.getCurrentKey();
        this.checkedData = this.$refs.tree.getCurrentNode();
      }
      this.$emit('checked-change', this.checkedIds, this.checkedData);
    },
    // 单选，节点被点击时的回调,返回被点击的节点数据
    handleNodeClick(data, node) {
      if (!this.multiple) {
        this.setSelectOption(node);
        this.isShowSelect = !this.isShowSelect;
        this.$emit('change', this.selectedData);
      }
    },
    // 多选，节点勾选状态发生变化时的回调
    handleCheckChange() {
      var checkedKeys = this.$refs.tree.getCheckedKeys(); // 所有被选中的节点的 key 所组成的数组数据
      this.options = checkedKeys.map((item) => {
        var node = this.$refs.tree.getNode(item); // 所有被选中的节点对应的node
        let tmpMap = {};
        tmpMap.value = node.key;
        tmpMap.label = node.label;
        return tmpMap;
      });
      this.selectedData = this.options.map((item) => {
        return item.value;
      });
      this.$emit('change', this.selectedData);
    },
    // 多选,删除任一select选项的回调
    removeSelectedNodes(val) {
      this.$refs.tree.setChecked(val, false);
      var node = this.$refs.tree.getNode(val);
      if (!this.checkStrictly && node.childNodes.length > 0) {
        this.treeToList(node).map(item => {
          if (item.childNodes.length <= 0) {
            this.$refs.tree.setChecked(item, false);
          }
        });
        this.handleCheckChange();
      }
      this.$emit('change', this.selectedData);
    },
    treeToList(tree) {
      var queen = [];
      var out = [];
      queen = queen.concat(tree);
      while (queen.length) {
        var first = queen.shift();
        if (first.childNodes) {
          queen = queen.concat(first.childNodes);
        }
        out.push(first);
      }
      return out;
    },
    // 单选,清空select输入框的回调
    removeSelectedNode() {
      this.clearSelectedNode();
      this.$emit('change', this.selectedData);
    },
    // 选中的select选项改变的回调
    changeSelectedNodes(selectedData) {
      // 多选,清空select输入框时，清除树勾选
      if (this.multiple && selectedData.length <= 0) {
        this.clearSelectedNodes();
      }
      this.$emit('change', this.selectedData);
    }
  },
  watch: {
    isShowSelect(val) {
      // 隐藏select自带的下拉框
      this.$refs.select.blur();
    },
    checkedKeys(val) {
      if (!val) return;
      this.checkedKeys = val;
      this.initCheckedData();
    }
  }
};
</script>

<style scoped>
.mask {
  width: 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  opacity: 0;
  z-index: 11;
}

.common-tree {
  overflow: auto;
}

.tree-select {
  z-index: 111;
}
</style>
