import BpmnProcessDesigner from "./ProcessDesigner.vue";

BpmnProcessDesigner.install = function(Vue) {
  Vue.component(BpmnProcessDesigner.name, BpmnProcessDesigner);
};

export default BpmnProcessDesigner;
