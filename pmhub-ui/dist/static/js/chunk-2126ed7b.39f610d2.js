(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-2126ed7b"],{"06f0":function(e,t,r){"use strict";r.r(t);r("14d9"),r("d3b7"),r("0643"),r("4e3e"),r("159b");t["default"]={options:function(e,t,r){var s=[];return t.__slot__.options.forEach((function(t){s.push(e("el-option",{attrs:{label:t.label,value:t.value,disabled:t.disabled}}))})),s}}},"1c83":function(e,t,r){"use strict";r.r(t);r("14d9"),r("d3b7"),r("0643"),r("4e3e"),r("159b");t["default"]={options:function(e,t,r){var s=[];return t.__slot__.options.forEach((function(r){"button"===t.__config__.optionType?s.push(e("el-radio-button",{attrs:{label:r.value}},[r.label])):s.push(e("el-radio",{attrs:{label:r.value,border:t.border}},[r.label]))})),s}}},"25bd":function(e,t,r){"use strict";r.d(t,"b",(function(){return n})),r.d(t,"c",(function(){return a})),r.d(t,"a",(function(){return o}));var s=r("b775");function n(e,t){return Object(s["a"])({url:"/workflow/deploy/refApproval/".concat(e),method:"get",params:t})}function a(e){return Object(s["a"])({url:"/system/dict/data/varList",method:"get"})}function o(e){return Object(s["a"])({url:"/common/decrypt",method:"post",data:{encryptStr:e}})}},"5e7c":function(e,t,r){},9299:function(e,t,r){"use strict";r.r(t);r("b0c0");var s=function(){var e=this,t=e._self._c;return t("div",{staticClass:"app-container"},[t("el-tabs",{attrs:{"tab-position":"top",value:"true"===e.finished?"approval":"form"},on:{"tab-click":e.tabClick}},["true"===e.finished?t("el-tab-pane",{attrs:{label:"任务办理",name:"approval"}},[e.taskFormOpen?t("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[t("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[t("span",[e._v("填写表单")])]),t("el-col",{attrs:{span:20,offset:2}},[t("parser",{ref:"taskFormParser",attrs:{"form-conf":e.taskFormData}})],1)],1):e._e(),t("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[t("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[t("span",[e._v("审批流程")])]),t("el-row",[t("el-col",{attrs:{span:20,offset:2}},[t("el-form",{ref:"taskForm",attrs:{model:e.taskForm,rules:e.rules,"label-width":"120px"}},[t("el-form-item",{attrs:{label:"审批意见",prop:"comment"}},[t("el-input",{attrs:{type:"textarea",rows:5,placeholder:"请输入 审批意见"},model:{value:e.taskForm.comment,callback:function(t){e.$set(e.taskForm,"comment",t)},expression:"taskForm.comment"}})],1),t("el-form-item",{attrs:{label:"抄送人",prop:"copyUserIds"}},[e._l(e.copyUser,(function(r,s){return t("el-tag",{key:s,attrs:{closable:"","disable-transitions":!1},on:{close:function(t){return e.handleClose("copy",r)}}},[e._v(" "+e._s(r.nickName)+" ")])})),t("el-button",{staticClass:"button-new-tag",attrs:{type:"primary",icon:"el-icon-plus",size:"mini",circle:""},on:{click:e.onSelectCopyUsers}})],2),t("el-form-item",{attrs:{label:"指定审批人",prop:"copyUserIds"}},[e._l(e.nextUser,(function(r,s){return t("el-tag",{key:s,attrs:{closable:"","disable-transitions":!1},on:{close:function(t){return e.handleClose("next",r)}}},[e._v(" "+e._s(r.nickName)+" ")])})),t("el-button",{staticClass:"button-new-tag",attrs:{type:"primary",icon:"el-icon-plus",size:"mini",circle:""},on:{click:e.onSelectNextUsers}})],2)],1)],1)],1),t("el-row",{attrs:{gutter:10,type:"flex",justify:"center"}},[t("el-col",{attrs:{span:1.5}},[t("el-button",{attrs:{icon:"el-icon-circle-check",type:"success"},on:{click:e.handleComplete}},[e._v("通过")])],1),t("el-col",{attrs:{span:1.5}},[t("el-button",{attrs:{icon:"el-icon-chat-line-square",type:"primary"},on:{click:e.handleDelegate}},[e._v("委派")])],1),t("el-col",{attrs:{span:1.5}},[t("el-button",{attrs:{icon:"el-icon-thumb",type:"success"},on:{click:e.handleTransfer}},[e._v("转办")])],1),t("el-col",{attrs:{span:1.5}},[t("el-button",{attrs:{icon:"el-icon-refresh-left",type:"warning"},on:{click:e.handleReturn}},[e._v("退回")])],1),t("el-col",{attrs:{span:1.5}},[t("el-button",{attrs:{icon:"el-icon-circle-close",type:"danger"},on:{click:e.handleReject}},[e._v("拒绝")])],1)],1)],1)],1):e._e(),t("el-tab-pane",{attrs:{label:"表单信息",name:"form"}},[e.formOpen?t("div",e._l(e.processFormList,(function(r,s){return t("el-card",{key:s,staticClass:"box-card",attrs:{shadow:"never"}},[t("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[t("span",[e._v(e._s(r.title))])]),t("div",{staticClass:"layout"},[t("div",{staticClass:"form-conf"},[t("parser",{attrs:{"form-conf":r}})],1),[t("el-divider",{attrs:{direction:"vertical"}}),t("div",{staticClass:"action"},[e.jumpInfoButtonVisible?t("el-button",{attrs:{type:"primary",size:"small"},on:{click:e.handleJumpInfo}},[e._v(" 跳转到单据详情 ")]):e._e(),e.downloadButtonVisible?t("el-button",{attrs:{type:"primary",size:"small"},on:{click:e.handleDownload}},[e._v(" 下载最终交付物 ")]):e._e()],1)]],2)])})),1):e._e()]),t("el-tab-pane",{attrs:{label:"流转记录",name:"record"}},[t("el-card",{staticClass:"box-card",attrs:{shadow:"never"}},[t("el-col",{attrs:{span:20,offset:2}},[t("div",{staticClass:"block"},[t("el-timeline",e._l(e.historyProcNodeList,(function(r,s){return t("el-timeline-item",{key:s,attrs:{icon:e.setIcon(r.endTime),color:e.setColor(r.endTime)}},[t("p",{staticStyle:{"font-weight":"700"}},[e._v(e._s(r.activityName))]),"startEvent"===r.activityType?t("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[e._v(" "+e._s(r.assigneeName)+" 在 "+e._s(r.createTime)+" 发起流程 ")]):e._e(),"userTask"===r.activityType?t("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[t("el-descriptions",{attrs:{column:5,labelStyle:{"font-weight":"bold"}}},[t("el-descriptions-item",{attrs:{label:"实际办理"}},[e._v(e._s(r.assigneeName||"-"))]),t("el-descriptions-item",{attrs:{label:"候选办理"}},[e._v(e._s(r.candidate||"-"))]),t("el-descriptions-item",{attrs:{label:"接收时间"}},[e._v(e._s(r.createTime||"-"))]),t("el-descriptions-item",{attrs:{label:"办结时间"}},[e._v(e._s(r.endTime||"-"))]),t("el-descriptions-item",{attrs:{label:"耗时"}},[e._v(e._s(r.duration||"-"))])],1),r.commentList&&r.commentList.length>0?t("div",e._l(r.commentList,(function(r,s){return t("div",{key:s},[t("el-divider",{attrs:{"content-position":"left"}},[t("el-tag",{attrs:{type:e.approveTypeTag(r.type),size:"mini"}},[e._v(" "+e._s(e.commentType(r.type))+" ")]),t("el-tag",{attrs:{type:"info",effect:"plain",size:"mini"}},[e._v(e._s(r.time))])],1),t("span",[e._v(e._s(r.fullMessage))])],1)})),0):e._e()],1):e._e(),"endEvent"===r.activityType?t("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[e._v(" "+e._s(r.createTime)+" 结束流程 ")]):e._e()],1)})),1)],1)])],1)],1),t("el-tab-pane",{attrs:{label:"流程跟踪",name:"track"}},[t("el-card",{staticClass:"box-card",attrs:{shadow:"never"}},[t("process-viewer",{key:"designer-".concat(e.loadIndex),ref:"processViewerRef",style:"height:"+e.height,attrs:{xml:e.xmlData,finishedInfo:e.finishedInfo,allCommentList:e.historyProcNodeList}})],1)],1),t("el-tab-pane",{attrs:{label:"打印",name:"print"}},[t("div",{staticStyle:{"margin-bottom":"20px",float:"right"}},[t("el-button",{attrs:{type:"primary",size:"small"},on:{click:e.downloadPDF}},[e._v("导出 PDF")])],1),t("div",{attrs:{id:"print"}},[e.formOpen?t("div",e._l(e.processFormList,(function(r,s){return t("el-card",{key:s,staticClass:"box-card",attrs:{shadow:"never"}},[t("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[t("span",[e._v(e._s(r.title))])]),t("parser",{attrs:{"form-conf":r}})],1)})),1):e._e(),t("el-card",{staticClass:"box-card",attrs:{shadow:"never"}},[t("el-col",{attrs:{span:20,offset:2}},[t("div",{staticClass:"block"},[t("el-timeline",e._l(e.historyProcNodeList,(function(r,s){return t("el-timeline-item",{key:s,attrs:{icon:e.setIcon(r.endTime),color:e.setColor(r.endTime)}},[t("p",{staticStyle:{"font-weight":"700"}},[e._v(e._s(r.activityName))]),"startEvent"===r.activityType?t("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[e._v(" "+e._s(r.assigneeName)+" 在 "+e._s(r.createTime)+" 发起流程 ")]):e._e(),"userTask"===r.activityType?t("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[t("el-descriptions",{attrs:{column:5,labelStyle:{"font-weight":"bold"}}},[t("el-descriptions-item",{attrs:{label:"实际办理"}},[e._v(e._s(r.assigneeName||"-"))]),t("el-descriptions-item",{attrs:{label:"候选办理"}},[e._v(e._s(r.candidate||"-"))]),t("el-descriptions-item",{attrs:{label:"接收时间"}},[e._v(e._s(r.createTime||"-"))]),t("el-descriptions-item",{attrs:{label:"办结时间"}},[e._v(e._s(r.endTime||"-"))]),t("el-descriptions-item",{attrs:{label:"耗时"}},[e._v(e._s(r.duration||"-"))])],1),r.commentList&&r.commentList.length>0?t("div",e._l(r.commentList,(function(r,s){return t("div",{key:s},[t("el-divider",{attrs:{"content-position":"left"}},[t("el-tag",{attrs:{type:e.approveTypeTag(r.type),size:"mini"}},[e._v(" "+e._s(e.commentType(r.type)))]),t("el-tag",{attrs:{type:"info",effect:"plain",size:"mini"}},[e._v(e._s(r.time))])],1),t("span",[e._v(e._s(r.fullMessage))])],1)})),0):e._e()],1):e._e(),"endEvent"===r.activityType?t("el-card",{staticClass:"box-card",attrs:{shadow:"hover"}},[e._v(" "+e._s(r.createTime)+" 结束流程 ")]):e._e()],1)})),1)],1)])],1)],1)])],1),t("el-dialog",{attrs:{title:e.returnTitle,visible:e.returnOpen,width:"40%","append-to-body":""},on:{"update:visible":function(t){e.returnOpen=t}}},[t("el-form",{ref:"taskForm",attrs:{model:e.taskForm,"label-width":"80px"}},[t("el-form-item",{attrs:{label:"退回节点",prop:"targetKey"}},[t("el-radio-group",{model:{value:e.taskForm.targetKey,callback:function(t){e.$set(e.taskForm,"targetKey",t)},expression:"taskForm.targetKey"}},e._l(e.returnTaskList,(function(r){return t("el-radio-button",{key:r.id,attrs:{label:r.id}},[e._v(" "+e._s(r.name))])})),1)],1)],1),t("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[t("el-button",{on:{click:function(t){e.returnOpen=!1}}},[e._v("取 消")]),t("el-button",{attrs:{type:"primary"},on:{click:e.submitReturn}},[e._v("确 定")])],1)],1),t("el-dialog",{attrs:{title:e.userData.title,visible:e.userData.open,width:"60%","append-to-body":""},on:{"update:visible":function(t){return e.$set(e.userData,"open",t)}}},[t("el-row",{attrs:{type:"flex",gutter:20}},[t("el-col",{attrs:{span:5}},[t("el-card",{staticStyle:{height:"100%"},attrs:{shadow:"never"}},[t("div",{attrs:{slot:"header"},slot:"header"},[t("span",[e._v("部门列表")])]),t("div",{staticClass:"head-container"},[t("el-input",{attrs:{placeholder:"请输入部门名称",clearable:"",size:"small","prefix-icon":"el-icon-search"},model:{value:e.deptName,callback:function(t){e.deptName=t},expression:"deptName"}}),t("el-tree",{ref:"tree",attrs:{data:e.deptOptions,props:e.deptProps,"expand-on-click-node":!1,"filter-node-method":e.filterNode,"default-expand-all":""},on:{"node-click":e.handleNodeClick}})],1)])],1),t("el-col",{attrs:{span:18}},[t("el-table",{directives:[{name:"loading",rawName:"v-loading",value:e.userLoading,expression:"userLoading"}],key:e.userData.type,ref:"userTable",attrs:{height:"500",data:e.userList,"highlight-current-row":""},on:{"current-change":e.changeCurrentUser,"selection-change":e.handleSelectionChange}},["copy"===e.userData.type||"next"===e.userData.type?t("el-table-column",{attrs:{width:"55",type:"selection"}}):t("el-table-column",{attrs:{width:"30"},scopedSlots:e._u([{key:"default",fn:function(r){return[t("el-radio",{attrs:{label:r.row.userId},model:{value:e.currentUserId,callback:function(t){e.currentUserId=t},expression:"currentUserId"}},[e._v(e._s(""))])]}}])}),t("el-table-column",{attrs:{label:"用户名",align:"center",prop:"nickName"}}),t("el-table-column",{attrs:{label:"手机",align:"center",prop:"phonenumber"}}),t("el-table-column",{attrs:{label:"部门",align:"center",prop:"dept.deptName"}})],1),t("pagination",{attrs:{total:e.total,page:e.queryParams.pageNum,limit:e.queryParams.pageSize},on:{"update:page":function(t){return e.$set(e.queryParams,"pageNum",t)},"update:limit":function(t){return e.$set(e.queryParams,"pageSize",t)},pagination:e.getList}})],1)],1),t("span",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[t("el-button",{on:{click:function(t){e.userData.open=!1}}},[e._v("取 消")]),t("el-button",{attrs:{type:"primary"},on:{click:e.submitUserData}},[e._v("确 定")])],1)],1)],1)},n=[],a=r("c7eb"),o=r("1da1"),i=(r("7db0"),r("a15b"),r("d81d"),r("14d9"),r("a434"),r("e9c4"),r("b64b"),r("d3b7"),r("ac1f"),r("00b4"),r("3ca3"),r("466d"),r("5319"),r("0643"),r("fffc"),r("4e3e"),r("a573"),r("159b"),r("ddb0"),r("ca94")),l=r("b09b"),_=r("ed08"),c=r("9a9d"),u=r("c0c7"),d=r("ff87"),f=(r("542c"),r("ca17")),p=r.n(f),m=r("c0e9"),h=r.n(m),b=r("8baf"),v=r("25bd"),g=/(?<=@@start@@pmhub@@)(.*?)(?=@@end@@pmhub@@)/g;function y(e){return"@@start@@pmhub@@"+e+"@@end@@pmhub@@"}var k=/http/,O={name:"WorkDetail",components:{ProcessViewer:d["a"],Parser:l["a"],Treeselect:p.a},props:{},computed:{commentType:function(){return function(e){switch(e){case"1":return"通过";case"2":return"退回";case"3":return"驳回";case"4":return"委派";case"5":return"转办";case"6":return"终止";case"7":return"撤回"}}},approveTypeTag:function(){return function(e){switch(e){case"1":return"success";case"2":return"warning";case"3":return"danger";case"4":return"primary";case"5":return"success";case"6":return"danger";case"7":return"info"}}},jumpInfoButtonVisible:function(){try{var e=this.processFormList[0].fields[2].__config__.defaultValue;return!!k.test(e)}catch(t){this.$modal.msgError("表单数据不符合要求，请尽快联系管理员")}},downloadButtonVisible:function(){try{var e=this.processFormList[0].fields[2].__config__.defaultValue,t=/\/pmhub-materials\/materials-scrap/;return!t.test(e)&&!!k.test(e)}catch(r){this.$modal.msgError("表单数据不符合要求，请尽快联系管理员")}}},data:function(){return{height:document.documentElement.clientHeight-205+"px;",loadIndex:0,xmlData:void 0,finishedInfo:{finishedSequenceFlowSet:[],finishedTaskSet:[],unfinishedTaskSet:[],rejectedTaskSet:[]},historyProcNodeList:[],deptName:void 0,deptOptions:void 0,userLoading:!1,userList:null,deptProps:{children:"children",label:"label"},queryParams:{deptId:void 0},total:0,loading:!0,taskForm:{comment:"",procInsId:"",deployId:"",taskId:"",definitionId:"",copyUserIds:"",vars:"",targetKey:""},rules:{comment:[{required:!0,message:"请输入审批意见",trigger:"blur"}]},currentUserId:null,variables:[],taskFormOpen:!1,taskFormData:{},processFormList:[],formOpen:!1,returnTaskList:[],finished:"false",returnTitle:null,returnOpen:!1,rejectOpen:!1,rejectTitle:null,userData:{title:"",type:"",open:!1},copyUser:[],nextUser:[],userMultipleSelection:[],userDialogTitle:"",userOpen:!1}},created:function(){this.initData()},methods:{tabClick:function(e){var t=this;"track"===e.name&&(setTimeout((function(){t.$refs.processViewerRef.processReZoom()}),100),setTimeout((function(){t.$refs.processViewerRef.processReZoom()}),500),setTimeout((function(){t.$refs.processViewerRef.processReZoom()}),800))},initData:function(){this.taskForm.procInsId=this.$route.params&&this.$route.params.procInsId,this.taskForm.deployId=this.$route.query&&this.$route.query.deployId,this.taskForm.definitionId=this.$route.query&&this.$route.query.definitionId,this.taskForm.taskId=this.$route.query&&this.$route.query.taskId,this.finished=this.$route.query&&this.$route.query.finished,this.taskForm.taskId&&this.getProcessDetails(this.taskForm.procInsId,this.taskForm.deployId,this.taskForm.taskId),this.loadIndex=this.taskForm.procInsId},getTreeSelect:function(){var e=this;Object(u["d"])().then((function(t){e.deptOptions=t.data}))},getList:function(){var e=this;this.userLoading=!0,Object(u["j"])(this.addDateRange(this.queryParams,this.dateRange)).then((function(t){e.userList=t.rows,e.total=t.total,e.toggleSelection(e.userMultipleSelection),e.userLoading=!1}))},filterNode:function(e,t){return!e||-1!==t.label.indexOf(e)},handleNodeClick:function(e){this.queryParams.deptId=e.id,this.getList()},setIcon:function(e){return e?"el-icon-check":"el-icon-time"},setColor:function(e){return e?"#2bc418":"#b3bdbb"},handleSelectionChange:function(e){this.userMultipleSelection=e},toggleSelection:function(e){var t=this;e&&e.length>0?this.$nextTick((function(){e.forEach((function(e){var r=t.userList.find((function(t){return t.userId===e.userId}));t.$refs.userTable.toggleRowSelection(r)}))})):this.$nextTick((function(){t.$refs.userTable.clearSelection()}))},handleClose:function(e,t){var r=this.userMultipleSelection.find((function(e){return e.userId===t.id}));if(this.userMultipleSelection.splice(this.userMultipleSelection.indexOf(r),1),"copy"===e)if(this.copyUser=this.userMultipleSelection,this.copyUser&&this.copyUser.length>0){var s=this.copyUser.map((function(e){return e.id}));this.taskForm.copyUserIds=s instanceof Array?s.join(","):s}else this.taskForm.copyUserIds="";else if("next"===e)if(this.nextUser=this.userMultipleSelection,this.nextUser&&this.nextUser.length>0){var n=this.nextUser.map((function(e){return e.id}));this.taskForm.nextUserIds=n instanceof Array?n.join(","):n}else this.taskForm.nextUserIds=""},handleCheckChange:function(e){this.taskForm.values=e instanceof Array?{approval:e.join(",")}:{approval:e}},transformProcessFormList:function(e){return Object(o["a"])(Object(a["a"])().mark((function t(){var r,s,n,o,i,l;return Object(a["a"])().wrap((function(t){while(1)switch(t.prev=t.next){case 0:r=JSON.stringify(e),s=r.match(g),n=[],o=0;case 4:if(!(o<(null===s||void 0===s?void 0:s.length))){t.next=12;break}return t.next=7,Object(v["a"])(s[o]);case 7:i=t.sent,n.push({old:y(s[o]),new:i.data});case 9:o++,t.next=4;break;case 12:for(l=0;l<n.length;l++)r=r.replace(n[l].old,n[l].new);return t.abrupt("return",JSON.parse(r));case 14:case"end":return t.stop()}}),t)})))()},getProcessDetails:function(e,t,r){var s=this,n={procInsId:e,deployId:t,taskId:r};Object(i["b"])(n).then(function(){var e=Object(o["a"])(Object(a["a"])().mark((function e(t){var r;return Object(a["a"])().wrap((function(e){while(1)switch(e.prev=e.next){case 0:return r=t.data,s.xmlData=r.bpmnXml,e.next=4,s.transformProcessFormList(r.processFormList);case 4:s.processFormList=e.sent,s.taskFormOpen=r.existTaskForm,s.taskFormOpen&&(s.taskFormData=r.taskFormData),s.historyProcNodeList=r.historyProcNodeList,s.finishedInfo=r.flowViewer,s.formOpen=!0;case 10:case"end":return e.stop()}}),e)})));return function(t){return e.apply(this,arguments)}}())},onSelectCopyUsers:function(){this.userMultipleSelection=this.copyUser,this.onSelectUsers("添加抄送人","copy")},onSelectNextUsers:function(){this.userMultipleSelection=this.nextUser,this.onSelectUsers("指定审批人","next")},onSelectUsers:function(e,t){this.userData.title=e,this.userData.type=t,this.getTreeSelect(),this.getList(),this.userData.open=!0},handleComplete:function(){var e=this,t=this.$refs.taskFormParser,r=void 0!==t,s=!r||new Promise((function(e,r){t.$refs[t.formConfCopy.formRef].validate((function(t){t?e():r()}))})),n=new Promise((function(t,r){e.$refs["taskForm"].validate((function(e){e?t():r()}))}));Promise.all([s,n]).then((function(){r&&(e.taskForm.variables=t[t.formConfCopy.formModel]),e.$modal.loading("处理中..."),Object(c["b"])(e.taskForm).then((function(t){e.$modal.msgSuccess(t.msg),e.goBack()})).finally((function(){e.$modal.closeLoading()}))}))},handleDelegate:function(){var e=this;this.$refs["taskForm"].validate((function(t){t&&(e.userData.type="delegate",e.userData.title="委派任务",e.userData.open=!0,e.getTreeSelect())}))},handleTransfer:function(){var e=this;this.$refs["taskForm"].validate((function(t){t&&(e.userData.type="transfer",e.userData.title="转办任务",e.userData.open=!0,e.getTreeSelect())}))},handleReject:function(){var e=this;this.$refs["taskForm"].validate((function(t){if(t){var r=e;e.$modal.confirm("拒绝审批单流程会终止，是否继续？").then((function(){return e.$modal.loading("处理中..."),Object(c["d"])(r.taskForm)})).then((function(t){e.$modal.msgSuccess(t.msg),e.goBack()})).finally((function(){e.$modal.closeLoading()}))}}))},changeCurrentUser:function(e){this.currentUserId=e.userId},goBack:function(){this.$tab.closePage(this.$route),this.$router.push({path:"/work/todo"})},getData:function(e){if(e){var t=[];e.fields.forEach((function(e){var r={};if(r.label=e.__config__.label,e.__config__.defaultValue instanceof Array){var s=[];e.__config__.defaultValue.forEach((function(e){s.push(e)})),r.val=s}else r.val=e.__config__.defaultValue;t.push(r)})),this.variables=t}},submitUserData:function(){var e=this,t=this.userData.type;if("copy"===t||"next"===t){if(!this.userMultipleSelection||this.userMultipleSelection.length<=0)return this.$modal.msgError("请选择用户"),!1;var r=this.userMultipleSelection.map((function(e){return e.userId}));"copy"===t?(this.copyUser=this.userMultipleSelection,this.taskForm.copyUserIds=r instanceof Array?r.join(","):r):"next"===t&&(this.nextUser=this.userMultipleSelection,this.taskForm.nextUserIds=r instanceof Array?r.join(","):r),this.userData.open=!1}else{if(!this.taskForm.comment)return this.$modal.msgError("请输入审批意见"),!1;if(!this.currentUserId)return this.$modal.msgError("请选择用户"),!1;this.taskForm.userId=this.currentUserId,"delegate"===t&&Object(c["c"])(this.taskForm).then((function(t){e.$modal.msgSuccess(t.msg),e.goBack()})),"transfer"===t&&Object(c["g"])(this.taskForm).then((function(t){e.$modal.msgSuccess(t.msg),e.goBack()}))}},handleReturn:function(){var e=this;this.$refs["taskForm"].validate((function(t){t&&(e.returnTitle="退回流程",Object(c["e"])(e.taskForm).then((function(t){e.returnTaskList=t.data,e.taskForm.values=null,e.returnOpen=!0})))}))},submitReturn:function(){var e=this;this.$refs["taskForm"].validate((function(t){t&&(e.taskForm.targetKey||e.$modal.msgError("请选择退回节点！"),Object(c["f"])(e.taskForm).then((function(t){e.$modal.msgSuccess(t.msg),e.goBack()})))}))},handleJumpInfo:function(){try{var e=this.processFormList[0].fields[2].__config__.defaultValue;k.test(e)?window.open(e):this.$modal.msgWarning("未发现详情链接")}catch(t){this.$modal.msgError("表单数据不符合要求，请尽快联系管理员")}},handleDownload:function(){try{var e=this.processFormList[0].fields[2].__config__.defaultValue;if(k.test(e)){var t=Object(_["e"])(e),r=t.projectFileId,s=t.fileUrl;if(void 0===r||void 0===s||"undefined"===r||"undefined"===s)return void this.$modal.msgError("没有交付物数据");this.download("/project/file/download",{projectFileId:r,fileUrl:s},void 0)}else this.$modal.msgWarning("没有该功能")}catch(n){this.$modal.msgError("表单数据不符合要求，请尽快联系管理员")}},printFile:function(){this.$store.state.app.sidebar.opened&&this.$store.dispatch("app/toggleSideBar"),this.$nextTick((function(){window.print()}))},downloadPDF:function(){var e=document.getElementById("print");h()(e).then((function(e){var t=e.width,r=e.height,s=t/592.28*841.89,n=r,a=0,o=595.28,i=592.28/t*r,l=e.toDataURL("image/jpeg",1),_=new b["a"]("","pt","a4");if(n<s)_.addImage(l,"JPEG",0,0,o,i);else while(n>0)_.addImage(l,"JPEG",0,a,o,i),n-=s,a-=841.89,n>0&&_.addPage();_.save("流程详情"+ +new Date+".pdf")}))}}},E=O,w=(r("eca1"),r("2877")),j=Object(w["a"])(E,s,n,!1,null,"26987826",null);t["default"]=j.exports},"9a9d":function(e,t,r){"use strict";r.d(t,"b",(function(){return n})),r.d(t,"c",(function(){return a})),r.d(t,"g",(function(){return o})),r.d(t,"f",(function(){return i})),r.d(t,"d",(function(){return l})),r.d(t,"a",(function(){return _})),r.d(t,"e",(function(){return c}));var s=r("b775");function n(e){return Object(s["a"])({url:"/workflow/task/complete",method:"post",data:e,timeout:12e4})}function a(e){return Object(s["a"])({url:"/workflow/task/delegate",method:"post",data:e})}function o(e){return Object(s["a"])({url:"/workflow/task/transfer",method:"post",data:e})}function i(e){return Object(s["a"])({url:"/workflow/task/return",method:"post",data:e})}function l(e){return Object(s["a"])({url:"/workflow/task/reject",method:"post",data:e})}function _(e){return Object(s["a"])({url:"/workflow/task/claim",method:"post",data:e})}function c(e){return Object(s["a"])({url:"/workflow/task/returnList",method:"post",data:e})}},a85b:function(e,t,r){"use strict";var s=r("5530"),n=r("2909"),a=r("53ca"),o=(r("99af"),r("caad"),r("14d9"),r("b64b"),r("d3b7"),r("4d63"),r("c607"),r("ac1f"),r("2c3e"),r("25f0"),r("5319"),r("0643"),r("4e3e"),r("159b"),r("ddb0"),r("ed08")),i={},l=r("d7d0"),_=l.keys()||[];function c(e,t){var r=this;e.props.value=t,e.on.input=function(e){r.$emit("input",e)}}function u(e,t,r){var s=i[t.__config__.tag];s&&Object.keys(s).forEach((function(n){var a=s[n];t.__slot__&&t.__slot__[n]&&r.push(a(e,t,n))}))}function d(e){var t=this;["on","nativeOn"].forEach((function(r){var s=Object.keys(e[r]||{});s.forEach((function(s){var n=e[r][s];"string"===typeof n&&(e[r][s]=function(e){return t.$emit(n,e)})}))}))}function f(e,t){var r=this;Object.keys(e).forEach((function(o){var i=e[o];"__vModel__"===o?c.call(r,t,e.__config__.defaultValue):void 0!==t[o]?null===t[o]||t[o]instanceof RegExp||["boolean","string","number","function"].includes(Object(a["a"])(t[o]))?t[o]=i:Array.isArray(t[o])?t[o]=[].concat(Object(n["a"])(t[o]),Object(n["a"])(i)):t[o]=Object(s["a"])(Object(s["a"])({},t[o]),i):t.attrs[o]=i})),p(t)}function p(e){delete e.attrs.__config__,delete e.attrs.__slot__,delete e.attrs.__methods__}function m(){return{class:{},attrs:{},props:{},domProps:{},nativeOn:{},on:{},style:{},directives:[],scopedSlots:{},slot:null,key:null,ref:null,refInFor:!0}}_.forEach((function(e){var t=e.replace(/^\.\/(.*)\.\w+$/,"$1");i[t]=l(e).default})),t["a"]={props:{conf:{type:Object,required:!0}},render:function(e){var t=m(),r=Object(o["c"])(this.conf),s=this.$slots.default||[];return u.call(this,e,r,s),d.call(this,r),f.call(this,r,t),e(this.conf.__config__.tag,t,s)}}},b09b:function(module,__webpack_exports__,__webpack_require__){"use strict";var _Users_canghe_responsibility_canghe_laigeoffer_pmhub_pmhub_ui_node_modules_babel_runtime_helpers_esm_defineProperty_js__WEBPACK_IMPORTED_MODULE_0__=__webpack_require__("ade3"),_vue_babel_helper_vue_jsx_merge_props__WEBPACK_IMPORTED_MODULE_1__=__webpack_require__("2638"),_vue_babel_helper_vue_jsx_merge_props__WEBPACK_IMPORTED_MODULE_1___default=__webpack_require__.n(_vue_babel_helper_vue_jsx_merge_props__WEBPACK_IMPORTED_MODULE_1__),core_js_modules_es_error_cause_js__WEBPACK_IMPORTED_MODULE_2__=__webpack_require__("d9e2"),core_js_modules_es_error_cause_js__WEBPACK_IMPORTED_MODULE_2___default=__webpack_require__.n(core_js_modules_es_error_cause_js__WEBPACK_IMPORTED_MODULE_2__),core_js_modules_es_array_map_js__WEBPACK_IMPORTED_MODULE_3__=__webpack_require__("d81d"),core_js_modules_es_array_map_js__WEBPACK_IMPORTED_MODULE_3___default=__webpack_require__.n(core_js_modules_es_array_map_js__WEBPACK_IMPORTED_MODULE_3__),core_js_modules_es_array_push_js__WEBPACK_IMPORTED_MODULE_4__=__webpack_require__("14d9"),core_js_modules_es_array_push_js__WEBPACK_IMPORTED_MODULE_4___default=__webpack_require__.n(core_js_modules_es_array_push_js__WEBPACK_IMPORTED_MODULE_4__),core_js_modules_es_object_keys_js__WEBPACK_IMPORTED_MODULE_5__=__webpack_require__("b64b"),core_js_modules_es_object_keys_js__WEBPACK_IMPORTED_MODULE_5___default=__webpack_require__.n(core_js_modules_es_object_keys_js__WEBPACK_IMPORTED_MODULE_5__),core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_6__=__webpack_require__("d3b7"),core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_6___default=__webpack_require__.n(core_js_modules_es_object_to_string_js__WEBPACK_IMPORTED_MODULE_6__),core_js_modules_esnext_iterator_constructor_js__WEBPACK_IMPORTED_MODULE_7__=__webpack_require__("0643"),core_js_modules_esnext_iterator_constructor_js__WEBPACK_IMPORTED_MODULE_7___default=__webpack_require__.n(core_js_modules_esnext_iterator_constructor_js__WEBPACK_IMPORTED_MODULE_7__),core_js_modules_esnext_iterator_for_each_js__WEBPACK_IMPORTED_MODULE_8__=__webpack_require__("4e3e"),core_js_modules_esnext_iterator_for_each_js__WEBPACK_IMPORTED_MODULE_8___default=__webpack_require__.n(core_js_modules_esnext_iterator_for_each_js__WEBPACK_IMPORTED_MODULE_8__),core_js_modules_esnext_iterator_map_js__WEBPACK_IMPORTED_MODULE_9__=__webpack_require__("a573"),core_js_modules_esnext_iterator_map_js__WEBPACK_IMPORTED_MODULE_9___default=__webpack_require__.n(core_js_modules_esnext_iterator_map_js__WEBPACK_IMPORTED_MODULE_9__),core_js_modules_web_dom_collections_for_each_js__WEBPACK_IMPORTED_MODULE_10__=__webpack_require__("159b"),core_js_modules_web_dom_collections_for_each_js__WEBPACK_IMPORTED_MODULE_10___default=__webpack_require__.n(core_js_modules_web_dom_collections_for_each_js__WEBPACK_IMPORTED_MODULE_10__),_utils_index__WEBPACK_IMPORTED_MODULE_11__=__webpack_require__("ed08"),_utils_auth__WEBPACK_IMPORTED_MODULE_12__=__webpack_require__("5f87"),_utils_generator_render__WEBPACK_IMPORTED_MODULE_13__=__webpack_require__("a85b"),axios__WEBPACK_IMPORTED_MODULE_14__=__webpack_require__("bc3a"),axios__WEBPACK_IMPORTED_MODULE_14___default=__webpack_require__.n(axios__WEBPACK_IMPORTED_MODULE_14__),vue__WEBPACK_IMPORTED_MODULE_15__=__webpack_require__("2b0e");vue__WEBPACK_IMPORTED_MODULE_15__["default"].prototype.$axios=axios__WEBPACK_IMPORTED_MODULE_14___default.a;var ruleTrigger={"el-input":"blur","el-input-number":"blur","el-select":"change","el-radio-group":"change","el-checkbox-group":"change","el-cascader":"change","el-time-picker":"change","el-date-picker":"change","el-rate":"change","el-upload":"change"},layouts={colFormItem:function(e,t){var r=t.__config__,s=buildListeners.call(this,t),n=r.labelWidth?"".concat(r.labelWidth,"px"):null;return!1===r.showLabel&&(n="0"),e("el-col",{attrs:{span:r.span}},[e("el-form-item",{attrs:{"label-width":n,prop:t.__vModel__,label:r.showLabel?r.label:""}},[e(_utils_generator_render__WEBPACK_IMPORTED_MODULE_13__["a"],_vue_babel_helper_vue_jsx_merge_props__WEBPACK_IMPORTED_MODULE_1___default()([{attrs:{conf:t}},{on:s}]))])])},rowFormItem:function(e,t){var r=renderChildren.apply(this,arguments);return"flex"===t.type&&(r=e("el-row",{attrs:{type:t.type,justify:t.justify,align:t.align}},[r])),e("el-col",{attrs:{span:t.__config__.span}},[e("el-row",[r])])}};function renderFrom(e){var t=this.formConfCopy;return e("el-row",{attrs:{gutter:t.gutter}},[e("el-form",_vue_babel_helper_vue_jsx_merge_props__WEBPACK_IMPORTED_MODULE_1___default()([{attrs:{size:t.size,"label-position":t.labelPosition,disabled:t.disabled,"label-width":"".concat(t.labelWidth,"px")},ref:t.formRef},{props:{model:this[t.formModel]}},{attrs:{rules:this[t.formRules]}}]),[renderFormItem.call(this,e,t.fields),t.formBtns&&formBtns.call(this,e)])])}function formBtns(e){return e("el-col",[e("el-form-item",{attrs:{size:"large"}},[e("el-button",{attrs:{type:"primary"},on:{click:this.submitForm}},["提交"]),e("el-button",{on:{click:this.resetForm}},["重置"])])])}function renderFormItem(e,t){var r=this;return t.map((function(t){var s=t.__config__,n=layouts[s.layout];if(n)return n.call(r,e,t);throw new Error("没有与".concat(s.layout,"匹配的layout"))}))}function renderChildren(e,t){var r=t.__config__;return Array.isArray(r.children)?renderFormItem.call(this,e,r.children):null}function setValue(e,t,r){this.$set(t,"defaultValue",e),this.$set(this[this.formConf.formModel],r.__vModel__,e)}function buildListeners(e){var t=this,r=e.__config__,s=this.formConf.__methods__||{},n={};return Object.keys(s).forEach((function(e){n[e]=function(r){return s[e].call(t,r)}})),n.input=function(s){return setValue.call(t,s,r,e)},n}__webpack_exports__["a"]={components:{render:_utils_generator_render__WEBPACK_IMPORTED_MODULE_13__["a"]},props:{formConf:{type:Object,required:!0}},data:function(){var e=Object(_Users_canghe_responsibility_canghe_laigeoffer_pmhub_pmhub_ui_node_modules_babel_runtime_helpers_esm_defineProperty_js__WEBPACK_IMPORTED_MODULE_0__["a"])(Object(_Users_canghe_responsibility_canghe_laigeoffer_pmhub_pmhub_ui_node_modules_babel_runtime_helpers_esm_defineProperty_js__WEBPACK_IMPORTED_MODULE_0__["a"])({formConfCopy:Object(_utils_index__WEBPACK_IMPORTED_MODULE_11__["c"])(this.formConf)},this.formConf.formModel,{}),this.formConf.formRules,{});return this.initFormData(e.formConfCopy.fields,e[this.formConf.formModel]),this.buildRules(e.formConfCopy.fields,e[this.formConf.formRules]),e},methods:{initFormData:function(e,t){var r=this;e.forEach((function(e){r.buildOptionMethod(e);var s=e.__config__;e.__vModel__&&(t[e.__vModel__]=s.defaultValue,e.action&&s.defaultValue&&(e["file-list"]=s.defaultValue)),e.action&&(e["headers"]={Authorization:"Bearer "+Object(_utils_auth__WEBPACK_IMPORTED_MODULE_12__["a"])()},e["on-success"]=function(r,n,a){t[e.__vModel__]=a,200===r.code&&a&&(s.defaultValue=a,s.defaultValue.forEach((function(e){e.url=n.response.data.url,e.ossId=n.response.data.ossId,e.response=null})))},e["on-preview"]=function(e){r.$download.oss(e.ossId)}),s.children&&r.initFormData(s.children,t)}))},buildOptionMethod:function(e){var t=e.__config__;t&&"el-cascader"===t.tag&&"dynamic"===t.dataType&&this.$axios({method:t.method,url:t.url}).then((function(r){var s=r.data;e[t.dataConsumer]=s[t.dataKey]}))},buildRules:function buildRules(componentList,rules){var _this4=this;componentList.forEach((function(cur){var config=cur.__config__;if(Array.isArray(config.regList)){if(config.required){var required={required:config.required,message:cur.placeholder};Array.isArray(config.defaultValue)&&(required.type="array",required.message="请至少选择一个".concat(config.label)),void 0===required.message&&(required.message="".concat(config.label,"不能为空")),config.regList.push(required)}rules[cur.__vModel__]=config.regList.map((function(item){return item.pattern&&(item.pattern=eval(item.pattern)),item.trigger=ruleTrigger&&ruleTrigger[config.tag],item}))}config.children&&_this4.buildRules(config.children,rules)}))},resetForm:function(){this.formConfCopy=Object(_utils_index__WEBPACK_IMPORTED_MODULE_11__["c"])(this.formConf),this.$refs[this.formConf.formRef].resetFields()},submitForm:function(){var e=this;this.$refs[this.formConf.formRef].validate((function(t){if(!t)return!1;var r={formData:e.formConfCopy,valData:e[e.formConf.formModel]};return e.$emit("submit",r),!0}))},getData:function(){this.$emit("getData",this[this.formConf.formModel])}},render:function(e){return renderFrom.call(this,e)}}},b7a1:function(e,t,r){"use strict";r.r(t);r("14d9"),r("d3b7"),r("0643"),r("4e3e"),r("159b");t["default"]={options:function(e,t,r){var s=[];return t.__slot__.options.forEach((function(r){"button"===t.__config__.optionType?s.push(e("el-checkbox-button",{attrs:{label:r.value}},[r.label])):s.push(e("el-checkbox",{attrs:{label:r.value,border:t.border}},[r.label]))})),s}}},c0c7:function(e,t,r){"use strict";r.d(t,"h",(function(){return a})),r.d(t,"j",(function(){return o})),r.d(t,"f",(function(){return i})),r.d(t,"a",(function(){return l})),r.d(t,"l",(function(){return _})),r.d(t,"c",(function(){return c})),r.d(t,"i",(function(){return u})),r.d(t,"b",(function(){return d})),r.d(t,"g",(function(){return f})),r.d(t,"m",(function(){return p})),r.d(t,"n",(function(){return m})),r.d(t,"o",(function(){return h})),r.d(t,"e",(function(){return b})),r.d(t,"k",(function(){return v})),r.d(t,"d",(function(){return g}));var s=r("b775"),n=r("c38a");function a(e){return Object(s["a"])({url:"/system/user/list",method:"get",params:e})}function o(e){return Object(s["a"])({url:"/system/user/list",method:"get",params:e})}function i(e){return Object(s["a"])({url:"/system/user/"+Object(n["e"])(e),method:"get"})}function l(e){return Object(s["a"])({url:"/system/user",method:"post",data:e})}function _(e){return Object(s["a"])({url:"/system/user",method:"put",data:e})}function c(e){return Object(s["a"])({url:"/system/user/"+e,method:"delete"})}function u(e,t){var r={userId:e,password:t};return Object(s["a"])({url:"/system/user/resetPwd",method:"put",data:r})}function d(e,t){var r={userId:e,status:t};return Object(s["a"])({url:"/system/user/changeStatus",method:"put",data:r})}function f(){return Object(s["a"])({url:"/system/user/profile",method:"get"})}function p(e){return Object(s["a"])({url:"/system/user/profile",method:"put",data:e})}function m(e,t){var r={oldPassword:e,newPassword:t};return Object(s["a"])({url:"/system/user/profile/updatePwd",method:"put",params:r})}function h(e){return Object(s["a"])({url:"/system/user/profile/avatar",method:"post",data:e})}function b(e){return Object(s["a"])({url:"/system/user/authRole/"+e,method:"get"})}function v(e){return Object(s["a"])({url:"/system/user/authRole",method:"put",params:e})}function g(){return Object(s["a"])({url:"/system/user/deptTree",method:"get"})}},cd9d:function(e,t,r){"use strict";r.r(t),t["default"]={prepend:function(e,t,r){return e("template",{slot:"prepend"},[t.__slot__[r]])},append:function(e,t,r){return e("template",{slot:"append"},[t.__slot__[r]])}}},d134:function(e,t,r){"use strict";r.r(t),t["default"]={default:function(e,t,r){return t.__slot__[r]}}},d7d0:function(e,t,r){var s={"./el-button.js":"d134","./el-checkbox-group.js":"b7a1","./el-input.js":"cd9d","./el-radio-group.js":"1c83","./el-select.js":"06f0","./el-upload.js":"e782"};function n(e){var t=a(e);return r(t)}function a(e){if(!r.o(s,e)){var t=new Error("Cannot find module '"+e+"'");throw t.code="MODULE_NOT_FOUND",t}return s[e]}n.keys=function(){return Object.keys(s)},n.resolve=a,e.exports=n,n.id="d7d0"},e782:function(e,t,r){"use strict";r.r(t);r("14d9");t["default"]={"list-type":function(e,t,r){var s=[],n=t.__config__;return"picture-card"===t["list-type"]?s.push(e("i",{class:"el-icon-plus"})):s.push(e("el-button",{attrs:{size:"small",type:"primary",icon:"el-icon-upload"}},[n.buttonText])),n.showTip&&s.push(e("div",{slot:"tip",class:"el-upload__tip"},["只能上传不超过 ",n.fileSize,n.sizeUnit," 的",t.accept,"文件"])),s}}},eca1:function(e,t,r){"use strict";r("5e7c")},ed08:function(e,t,r){"use strict";r.d(t,"b",(function(){return n})),r.d(t,"c",(function(){return a})),r.d(t,"d",(function(){return o})),r.d(t,"a",(function(){return i})),r.d(t,"g",(function(){return l})),r.d(t,"f",(function(){return _})),r.d(t,"e",(function(){return c}));var s=r("53ca");r("d9e2"),r("a630"),r("a15b"),r("d81d"),r("14d9"),r("fb6a"),r("b64b"),r("d3b7"),r("4d63"),r("c607"),r("ac1f"),r("2c3e"),r("00b4"),r("25f0"),r("6062"),r("3ca3"),r("466d"),r("5319"),r("0643"),r("4e3e"),r("a573"),r("159b"),r("ddb0"),r("c38a");function n(e,t,r){var s,n,a,o,i,l=function(){var _=+new Date-o;_<t&&_>0?s=setTimeout(l,t-_):(s=null,r||(i=e.apply(a,n),s||(a=n=null)))};return function(){for(var n=arguments.length,_=new Array(n),c=0;c<n;c++)_[c]=arguments[c];a=this,o=+new Date;var u=r&&!s;return s||(s=setTimeout(l,t)),u&&(i=e.apply(a,_),a=_=null),i}}function a(e){if(!e&&"object"!==Object(s["a"])(e))throw new Error("error arguments","deepClone");var t=e.constructor===Array?[]:{};return Object.keys(e).forEach((function(r){e[r]&&"object"===Object(s["a"])(e[r])?t[r]=a(e[r]):t[r]=e[r]})),t}var o="export default ",i={html:{indent_size:"2",indent_char:" ",max_preserve_newlines:"-1",preserve_newlines:!1,keep_array_indentation:!1,break_chained_methods:!1,indent_scripts:"separate",brace_style:"end-expand",space_before_conditional:!0,unescape_strings:!1,jslint_happy:!1,end_with_newline:!0,wrap_line_length:"110",indent_inner_html:!0,comma_first:!1,e4x:!0,indent_empty_lines:!0},js:{indent_size:"2",indent_char:" ",max_preserve_newlines:"-1",preserve_newlines:!1,keep_array_indentation:!1,break_chained_methods:!1,indent_scripts:"normal",brace_style:"end-expand",space_before_conditional:!0,unescape_strings:!1,jslint_happy:!0,end_with_newline:!0,wrap_line_length:"110",indent_inner_html:!0,comma_first:!1,e4x:!0,indent_empty_lines:!0}};function l(e){return e.replace(/( |^)[a-z]/g,(function(e){return e.toUpperCase()}))}function _(e){return/^[+-]?(0|([1-9]\d*))(\.\d+)?$/g.test(e)}function c(e){for(var t=e.split("?")[1],r={},s=null===t||void 0===t?void 0:t.split("&"),n=0;n<(null===s||void 0===s?void 0:s.length);n++){var a=s[n].split("=");r[a[0]]=a[1]}return r}}}]);