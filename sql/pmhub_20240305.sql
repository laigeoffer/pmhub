/*
 Navicat Premium Data Transfer

 Source Server         : canghe-aliyun-laigeoffer
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 8.137.9.219:33706
 Source Schema         : laigeoffer-pmhub

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44)
 File Encoding         : 65001/*
 Navicat Premium Data Transfer

 Source Server         : canghe-aliyun-laigeoffer
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 8.137.9.219:33706
 Source Schema         : laigeoffer-pmhub

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44)
 File Encoding         : 65001

 Date: 31/05/2024 16:08:12
*/

CREATE DATABASE  `laigeoffer-pmhub` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;



SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `laigeoffer-pmhub`;

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log` (
                               `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
                               `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                               `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DATA_` longblob,
                               `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `IS_PROCESSED_` tinyint(4) DEFAULT '0',
                               PRIMARY KEY (`LOG_NR_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_evt_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `BYTES_` longblob,
                                    `GENERATED_` tinyint(4) DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------
BEGIN;
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('f7cf0e4e-18af-11ef-bdc0-0242ac110002', 1, 'source', NULL, 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A62706D6E323D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A64633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22313233343536222069643D226469616772616D5F50726F636573735F3137313634333239343734343022207873693A736368656D614C6F636174696F6E3D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2042504D4E32302E787364223E0A20203C70726F636573732069643D2250726F636573735F3137313634333239343734343022206E616D653D22E4B89AE58AA1E6B581E7A88B5F313731363433323934373434302220697345786563757461626C653D2274727565223E0A202020203C73746172744576656E742069643D2273746172745F6576656E74223E3C2F73746172744576656E743E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F50726F636573735F31373136343332393437343430223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D2250726F636573735F31373136343332393437343430222069643D2242504D4E506C616E655F50726F636573735F31373136343332393437343430223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2273746172745F6576656E74222069643D2242504D4E53686170655F73746172745F6576656E74223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223630322E302220793D223131322E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property` (
                                   `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
BEGIN;
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('batch.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('common.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('entitylink.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('eventsubscription.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('identitylink.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('job.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('next.dbid', '1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.history', 'create(6.7.2.0)', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('task.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('variable.schema.version', '6.7.2.0', 1);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `START_TIME_` datetime(3) NOT NULL,
                                  `END_TIME_` datetime(3) DEFAULT NULL,
                                  `TRANSACTION_ORDER_` int(11) DEFAULT NULL,
                                  `DURATION_` bigint(20) DEFAULT NULL,
                                  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`) USING BTREE,
                                  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`) USING BTREE,
                                  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                     `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                     `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TIME_` datetime(3) DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TIME_` datetime(3) NOT NULL,
                                  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `FULL_MSG_` longblob,
                                  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail` (
                                 `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                 `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                 `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                 `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                 `REV_` int(11) DEFAULT NULL,
                                 `TIME_` datetime(3) NOT NULL,
                                 `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `DOUBLE_` double DEFAULT NULL,
                                 `LONG_` bigint(20) DEFAULT NULL,
                                 `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                 `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                 PRIMARY KEY (`ID_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_entitylink`;
CREATE TABLE `act_hi_entitylink` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     KEY `ACT_IDX_HI_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_HI_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_HI_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_entitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT '1',
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `END_TIME_` datetime(3) DEFAULT NULL,
                                   `DURATION_` bigint(20) DEFAULT NULL,
                                   `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                   `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `REFERENCE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `REFERENCE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `BUSINESS_STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`) USING BTREE,
                                   KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`) USING BTREE,
                                   KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT '1',
                                   `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `CLAIM_TIME_` datetime(3) DEFAULT NULL,
                                   `END_TIME_` datetime(3) DEFAULT NULL,
                                   `DURATION_` bigint(20) DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `PRIORITY_` int(11) DEFAULT NULL,
                                   `DUE_DATE_` datetime(3) DEFAULT NULL,
                                   `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                   `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   KEY `ACT_IDX_HI_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_IDX_HI_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_IDX_HI_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_tsk_log
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_tsk_log`;
CREATE TABLE `act_hi_tsk_log` (
                                  `ID_` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `DATA_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_tsk_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DOUBLE_` double DEFAULT NULL,
                                  `LONG_` bigint(20) DEFAULT NULL,
                                  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`) USING BTREE,
                                  KEY `ACT_IDX_HI_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                  KEY `ACT_IDX_HI_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_PROCVAR_EXE` (`EXECUTION_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_id_bytearray`;
CREATE TABLE `act_id_bytearray` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `BYTES_` longblob,
                                    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_bytearray
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_priv
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv`;
CREATE TABLE `act_id_priv` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                               PRIMARY KEY (`ID_`) USING BTREE,
                               UNIQUE KEY `ACT_UNIQ_PRIV_NAME` (`NAME_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_priv
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_priv_mapping
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv_mapping`;
CREATE TABLE `act_id_priv_mapping` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `PRIV_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_FK_PRIV_MAPPING` (`PRIV_ID_`) USING BTREE,
                                       KEY `ACT_IDX_PRIV_USER` (`USER_ID_`) USING BTREE,
                                       KEY `ACT_IDX_PRIV_GROUP` (`GROUP_ID_`) USING BTREE,
                                       CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_priv_mapping
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_property
-- ----------------------------
DROP TABLE IF EXISTS `act_id_property`;
CREATE TABLE `act_id_property` (
                                   `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_property
-- ----------------------------
BEGIN;
INSERT INTO `act_id_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.7.2.0', 1);
COMMIT;

-- ----------------------------
-- Table structure for act_id_token
-- ----------------------------
DROP TABLE IF EXISTS `act_id_token`;
CREATE TABLE `act_id_token` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `TOKEN_VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TOKEN_DATE_` timestamp(3) NULL DEFAULT NULL,
                                `IP_ADDRESS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `USER_AGENT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TOKEN_DATA_` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
                                PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
                                    KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
                                    KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_procdef_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                     `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
                                     `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_DEPLOYMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `VERSION_` int(11) DEFAULT NULL,
                                `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                PRIMARY KEY (`ID_`) USING BTREE,
                                KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`) USING BTREE,
                                KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) USING BTREE,
                                KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`) USING BTREE,
                                CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
                                CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------
BEGIN;
INSERT INTO `act_re_model` (`ID_`, `REV_`, `NAME_`, `KEY_`, `CATEGORY_`, `CREATE_TIME_`, `LAST_UPDATE_TIME_`, `VERSION_`, `META_INFO_`, `DEPLOYMENT_ID_`, `EDITOR_SOURCE_VALUE_ID_`, `EDITOR_SOURCE_EXTRA_VALUE_ID_`, `TENANT_ID_`) VALUES ('f7ba4dcd-18af-11ef-bdc0-0242ac110002', 2, '业务流程_1716432947440', 'Process_1716432947440', '123456', '2024-05-23 10:55:52.630', '2024-05-23 10:55:52.767', 1, '{\"createUser\":\"laige\",\"description\":null,\"formType\":null,\"formId\":null}', NULL, 'f7cf0e4e-18af-11ef-bdc0-0242ac110002', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT NULL,
                                  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `VERSION_` int(11) NOT NULL,
                                  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
                                  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
                                  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_VERSION_` int(11) NOT NULL DEFAULT '0',
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`DERIVED_VERSION_`,`TENANT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_actinst`;
CREATE TABLE `act_ru_actinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `START_TIME_` datetime(3) NOT NULL,
                                  `END_TIME_` datetime(3) DEFAULT NULL,
                                  `DURATION_` bigint(20) DEFAULT NULL,
                                  `TRANSACTION_ORDER_` int(11) DEFAULT NULL,
                                  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_START` (`START_TIME_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_END` (`END_TIME_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_PROC` (`PROC_INST_ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_PROC_ACT` (`PROC_INST_ID_`,`ACT_ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_EXEC` (`EXECUTION_ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_EXEC_ACT` (`EXECUTION_ID_`,`ACT_ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_TASK` (`TASK_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_actinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_deadletter_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_deadletter_job`;
CREATE TABLE `act_ru_deadletter_job` (
                                         `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                         `REV_` int(11) DEFAULT NULL,
                                         `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                         `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                         `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                         `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                         `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                         `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                         PRIMARY KEY (`ID_`) USING BTREE,
                                         KEY `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                                         KEY `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                                         KEY `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                                         KEY `ACT_IDX_DJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                         KEY `ACT_IDX_DJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                         KEY `ACT_IDX_DJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                         KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`) USING BTREE,
                                         KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`) USING BTREE,
                                         KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`) USING BTREE,
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_deadletter_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_entitylink`;
CREATE TABLE `act_ru_entitylink` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                     `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     KEY `ACT_IDX_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_entitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                       `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`) USING BTREE,
                                       KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`) USING BTREE,
                                       CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
                                    `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
                                    `IS_SCOPE_` tinyint(4) DEFAULT NULL,
                                    `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
                                    `IS_MI_ROOT_` tinyint(4) DEFAULT NULL,
                                    `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                                    `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `START_TIME_` datetime(3) DEFAULT NULL,
                                    `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
                                    `EVT_SUBSCR_COUNT_` int(11) DEFAULT NULL,
                                    `TASK_COUNT_` int(11) DEFAULT NULL,
                                    `JOB_COUNT_` int(11) DEFAULT NULL,
                                    `TIMER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `SUSP_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `DEADLETTER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `EXTERNAL_WORKER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `VAR_COUNT_` int(11) DEFAULT NULL,
                                    `ID_LINK_COUNT_` int(11) DEFAULT NULL,
                                    `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `REFERENCE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `REFERENCE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `BUSINESS_STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`) USING BTREE,
                                    KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`) USING BTREE,
                                    KEY `ACT_IDX_EXEC_REF_ID_` (`REFERENCE_ID_`) USING BTREE,
                                    KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`) USING BTREE,
                                    KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`) USING BTREE,
                                    KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`) USING BTREE,
                                    KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE,
                                    CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                    CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_external_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_external_job`;
CREATE TABLE `act_ru_external_job` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                       `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                       `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `RETRIES_` int(11) DEFAULT NULL,
                                       `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                       `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                       `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                       `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                                       KEY `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                                       KEY `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                                       KEY `ACT_IDX_EJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_EJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_EJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                       CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_external_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_history_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_history_job`;
CREATE TABLE `act_ru_history_job` (
                                      `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                      `REV_` int(11) DEFAULT NULL,
                                      `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `RETRIES_` int(11) DEFAULT NULL,
                                      `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                      `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                      `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `ADV_HANDLER_CFG_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                      PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_history_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`) USING BTREE,
                                       KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`) USING BTREE,
                                       KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`) USING BTREE,
                                       CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                       CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                       CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job` (
                              `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                              `REV_` int(11) DEFAULT NULL,
                              `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                              `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                              `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                              `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `RETRIES_` int(11) DEFAULT NULL,
                              `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                              `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                              `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                              `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                              `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                              PRIMARY KEY (`ID_`) USING BTREE,
                              KEY `ACT_IDX_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                              KEY `ACT_IDX_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                              KEY `ACT_IDX_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                              KEY `ACT_IDX_JOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                              KEY `ACT_IDX_JOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                              KEY `ACT_IDX_JOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                              KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`) USING BTREE,
                              KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`) USING BTREE,
                              KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`) USING BTREE,
                              CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_suspended_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_suspended_job`;
CREATE TABLE `act_ru_suspended_job` (
                                        `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                        `REV_` int(11) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                        `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                        `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `RETRIES_` int(11) DEFAULT NULL,
                                        `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                        `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                        `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                        `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        KEY `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                                        KEY `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                                        KEY `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                                        KEY `ACT_IDX_SJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                        KEY `ACT_IDX_SJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                        KEY `ACT_IDX_SJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                        KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`) USING BTREE,
                                        KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`) USING BTREE,
                                        KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`) USING BTREE,
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_suspended_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `REV_` int(11) DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PRIORITY_` int(11) DEFAULT NULL,
                               `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `DUE_DATE_` datetime(3) DEFAULT NULL,
                               `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                               `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                               `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `CLAIM_TIME_` datetime(3) DEFAULT NULL,
                               `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
                               `VAR_COUNT_` int(11) DEFAULT NULL,
                               `ID_LINK_COUNT_` int(11) DEFAULT NULL,
                               `SUB_TASK_COUNT_` int(11) DEFAULT NULL,
                               PRIMARY KEY (`ID_`) USING BTREE,
                               KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`) USING BTREE,
                               KEY `ACT_IDX_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                               KEY `ACT_IDX_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                               KEY `ACT_IDX_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                               KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`) USING BTREE,
                               KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`) USING BTREE,
                               KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
                               CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                               CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                               CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_timer_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_timer_job`;
CREATE TABLE `act_ru_timer_job` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                    `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                    `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `RETRIES_` int(11) DEFAULT NULL,
                                    `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                    `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                    `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                    `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    KEY `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                                    KEY `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                                    KEY `ACT_IDX_TIMER_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                                    KEY `ACT_IDX_TIMER_JOB_DUEDATE` (`DUEDATE_`) USING BTREE,
                                    KEY `ACT_IDX_TJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                    KEY `ACT_IDX_TJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                    KEY `ACT_IDX_TJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                    KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`) USING BTREE,
                                    KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`) USING BTREE,
                                    KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_timer_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                   `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                   `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DOUBLE_` double DEFAULT NULL,
                                   `LONG_` bigint(20) DEFAULT NULL,
                                   `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   KEY `ACT_IDX_RU_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_IDX_RU_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`) USING BTREE,
                                   KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`) USING BTREE,
                                   KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`) USING BTREE,
                                   KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`) USING BTREE,
                                   CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                   CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                   CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_channel_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_channel_definition`;
CREATE TABLE `flw_channel_definition` (
                                          `ID_` varchar(255) NOT NULL,
                                          `NAME_` varchar(255) DEFAULT NULL,
                                          `VERSION_` int(11) DEFAULT NULL,
                                          `KEY_` varchar(255) DEFAULT NULL,
                                          `CATEGORY_` varchar(255) DEFAULT NULL,
                                          `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                          `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) DEFAULT NULL,
                                          `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                          `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                          `TYPE_` varchar(255) DEFAULT NULL,
                                          `IMPLEMENTATION_` varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (`ID_`) USING BTREE,
                                          UNIQUE KEY `ACT_IDX_CHANNEL_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_channel_definition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ev_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangelog`;
CREATE TABLE `flw_ev_databasechangelog` (
                                            `ID` varchar(255) NOT NULL,
                                            `AUTHOR` varchar(255) NOT NULL,
                                            `FILENAME` varchar(255) NOT NULL,
                                            `DATEEXECUTED` datetime NOT NULL,
                                            `ORDEREXECUTED` int(11) NOT NULL,
                                            `EXECTYPE` varchar(10) NOT NULL,
                                            `MD5SUM` varchar(35) DEFAULT NULL,
                                            `DESCRIPTION` varchar(255) DEFAULT NULL,
                                            `COMMENTS` varchar(255) DEFAULT NULL,
                                            `TAG` varchar(255) DEFAULT NULL,
                                            `LIQUIBASE` varchar(20) DEFAULT NULL,
                                            `CONTEXTS` varchar(255) DEFAULT NULL,
                                            `LABELS` varchar(255) DEFAULT NULL,
                                            `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_ev_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda', 'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda', 'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '4.3.5', NULL, NULL, '8259922348');
COMMIT;

-- ----------------------------
-- Table structure for flw_ev_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangeloglock`;
CREATE TABLE `flw_ev_databasechangeloglock` (
                                                `ID` int(11) NOT NULL,
                                                `LOCKED` bit(1) NOT NULL,
                                                `LOCKGRANTED` datetime DEFAULT NULL,
                                                `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_ev_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `flw_ev_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for flw_event_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_definition`;
CREATE TABLE `flw_event_definition` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `VERSION_` int(11) DEFAULT NULL,
                                        `KEY_` varchar(255) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) DEFAULT NULL,
                                        `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                        `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        UNIQUE KEY `ACT_IDX_EVENT_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_event_definition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_event_deployment
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_deployment`;
CREATE TABLE `flw_event_deployment` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) DEFAULT NULL,
                                        `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_event_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_event_resource
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_resource`;
CREATE TABLE `flw_event_resource` (
                                      `ID_` varchar(255) NOT NULL,
                                      `NAME_` varchar(255) DEFAULT NULL,
                                      `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                      `RESOURCE_BYTES_` longblob,
                                      PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_event_resource
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ru_batch
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch`;
CREATE TABLE `flw_ru_batch` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `TYPE_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `SEARCH_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `SEARCH_KEY2_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CREATE_TIME_` datetime(3) NOT NULL,
                                `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
                                `STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `BATCH_DOC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of flw_ru_batch
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ru_batch_part
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch_part`;
CREATE TABLE `flw_ru_batch_part` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `BATCH_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TYPE_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SEARCH_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SEARCH_KEY2_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) NOT NULL,
                                     `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
                                     `STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `RESULT_DOC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     KEY `FLW_IDX_BATCH_PART` (`BATCH_ID_`) USING BTREE,
                                     CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `flw_ru_batch` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of flw_ru_batch_part
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
                             `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                             `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
                             `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
                             `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
                             `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
                             `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
                             `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
                             `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
                             `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
                             `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
                             `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
                             `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
                             `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
                             `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
                             `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
                             `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                             `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                             `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
                                    `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                    `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
                                    `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
                                    `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
                                    `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
                                    `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
                                    `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
                                    `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
                                    `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
                                    `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
                                    `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
                                    `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
                                    `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
                                    `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
                                    `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
                                    `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
                                    `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
                                    `sort` int(11) DEFAULT NULL COMMENT '排序',
                                    `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                    `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                    PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_approval_template
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_approval_template`;
CREATE TABLE `pmhub_approval_template` (
                                           `id` varchar(64) NOT NULL,
                                           `template_id` varchar(64) NOT NULL COMMENT '审批模板id',
                                           `template_name` varchar(255) NOT NULL COMMENT '审批模板名称',
                                           `file_url` varchar(255) DEFAULT NULL,
                                           `path_name` varchar(255) DEFAULT NULL,
                                           `created_by` varchar(64) DEFAULT NULL,
                                           `created_time` datetime DEFAULT NULL,
                                           `updated_by` varchar(64) DEFAULT NULL,
                                           `updated_time` datetime DEFAULT NULL,
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_approval_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_async
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_async`;
CREATE TABLE `pmhub_async` (
                               `id` varchar(64) NOT NULL COMMENT '任务id',
                               `async_type` varchar(64) NOT NULL COMMENT '任务类型',
                               `async_name` varchar(512) NOT NULL COMMENT '任务名称',
                               `async_desc` varchar(2048) DEFAULT NULL COMMENT '任务描述',
                               `create_time` datetime NOT NULL COMMENT '任务创建时间',
                               `create_by` varchar(64) NOT NULL COMMENT '创建者',
                               `update_time` datetime NOT NULL COMMENT '最后汇报时间',
                               `update_by` varchar(64) DEFAULT NULL,
                               `async_schedule` decimal(10,0) DEFAULT NULL COMMENT '进度（0-100）',
                               `finish_time` datetime DEFAULT NULL COMMENT '结束时间',
                               `async_status` int(11) NOT NULL COMMENT '任务当前状态（0 进行中 1 已失败 2 已完成）',
                               `async_log` json DEFAULT NULL COMMENT '任务执行信息',
                               `file` varchar(10240) DEFAULT NULL COMMENT '附件地址',
                               `deleted` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='离线任务';

-- ----------------------------
-- Records of pmhub_async
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_document_data
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_document_data`;
CREATE TABLE `pmhub_document_data` (
                                       `id` varchar(64) NOT NULL,
                                       `module_name` varchar(64) DEFAULT NULL COMMENT '模块名称',
                                       `module_type` int(11) DEFAULT NULL COMMENT '模块类型',
                                       `document_type` varchar(64) DEFAULT NULL COMMENT '单据类型',
                                       `document_name` varchar(64) DEFAULT NULL COMMENT '单据名称',
                                       `sort` int(11) DEFAULT NULL COMMENT '排序',
                                       `audited` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
                                       `template_id` varchar(64) DEFAULT NULL COMMENT '审批模板id',
                                       `created_by` varchar(64) DEFAULT NULL,
                                       `created_time` datetime DEFAULT NULL,
                                       `updated_by` varchar(64) DEFAULT NULL,
                                       `updated_time` datetime DEFAULT NULL,
                                       `type` varchar(32) NOT NULL COMMENT '类型',
                                       `document_type_id` varchar(64) NOT NULL COMMENT '单据类型id',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_document_data
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_document_type
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_document_type`;
CREATE TABLE `pmhub_document_type` (
                                       `id` varchar(64) NOT NULL,
                                       `type_name` varchar(64) DEFAULT NULL COMMENT '分类名称',
                                       `pid` varchar(64) DEFAULT NULL COMMENT '父id',
                                       `sort` int(11) DEFAULT NULL COMMENT '排序',
                                       `created_by` varchar(64) DEFAULT NULL,
                                       `created_time` datetime DEFAULT NULL,
                                       `updated_by` varchar(64) DEFAULT NULL,
                                       `updated_time` datetime DEFAULT NULL,
                                       `joint_name` varchar(100) DEFAULT NULL,
                                       `type` varchar(64) DEFAULT NULL,
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='单据分类';

-- ----------------------------
-- Records of pmhub_document_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_materials
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_materials`;
CREATE TABLE `pmhub_materials` (
                                   `id` varchar(64) NOT NULL COMMENT '记录id',
                                   `code` int(11) DEFAULT NULL COMMENT '五级代码-物料流水编号',
                                   `materials_name` varchar(64) NOT NULL COMMENT '物料名称',
                                   `project_id` varchar(64) DEFAULT NULL COMMENT '项目id',
                                   `materials_type_id` varchar(64) NOT NULL COMMENT '物料类别id',
                                   `norms` varchar(64) DEFAULT NULL COMMENT '规格',
                                   `model` varchar(128) DEFAULT NULL COMMENT '型号',
                                   `unit` varchar(64) DEFAULT NULL COMMENT '型号',
                                   `unit_price` decimal(15,3) NOT NULL COMMENT '单价',
                                   `color` varchar(16) DEFAULT NULL COMMENT '颜色',
                                   `weight` varchar(64) DEFAULT NULL COMMENT '重量',
                                   `quality_guarantee_period` int(11) DEFAULT NULL COMMENT '质保期（天）',
                                   `lot_number` tinyint(1) DEFAULT NULL COMMENT '是否有批号',
                                   `base_storehouse_count` decimal(15,3) NOT NULL COMMENT '期初库存',
                                   `remarks` varchar(2048) DEFAULT NULL COMMENT '备注',
                                   `part_code` varchar(64) DEFAULT NULL COMMENT '零件编码',
                                   `create_by` varchar(64) NOT NULL COMMENT '创建者',
                                   `create_time` datetime NOT NULL COMMENT '创建时间',
                                   `update_by` varchar(64) NOT NULL COMMENT '更新者',
                                   `update_time` datetime NOT NULL COMMENT '更新时间',
                                   `deleted` int(11) NOT NULL COMMENT '是否删除（1：已删除，0：未删除）',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE KEY `code_and_type_pk` (`code`,`materials_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='物料明细';

-- ----------------------------
-- Records of pmhub_materials
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_materials_approval_set
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_materials_approval_set`;
CREATE TABLE `pmhub_materials_approval_set` (
                                                `id` varchar(32) NOT NULL,
                                                `type` varchar(32) DEFAULT NULL,
                                                `approved` varchar(10) DEFAULT NULL,
                                                `deployment_id` varchar(64) DEFAULT NULL,
                                                `definition_id` varchar(64) DEFAULT NULL,
                                                `created_by` varchar(64) DEFAULT NULL,
                                                `created_time` datetime DEFAULT NULL,
                                                `updated_by` varchar(64) DEFAULT NULL,
                                                `updated_time` datetime DEFAULT NULL,
                                                `extra_id` varchar(32) DEFAULT NULL,
                                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_materials_approval_set
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_my_apply
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_my_apply`;
CREATE TABLE `pmhub_my_apply` (
                                  `id` varchar(64) NOT NULL,
                                  `sp_no` varchar(64) NOT NULL COMMENT '审批编号',
                                  `data_name` varchar(100) NOT NULL COMMENT '单据标题',
                                  `data_type` varchar(100) NOT NULL COMMENT '单据类型',
                                  `data_type_id` varchar(64) NOT NULL COMMENT '单据类型id',
                                  `template_id` varchar(64) NOT NULL COMMENT '模板id',
                                  `sp_status` int(11) NOT NULL COMMENT '审批状态',
                                  `apply_time` datetime DEFAULT NULL COMMENT '提交日期',
                                  `created_by` varchar(64) DEFAULT NULL,
                                  `created_time` datetime DEFAULT NULL,
                                  `updated_by` varchar(64) DEFAULT NULL,
                                  `updated_time` datetime DEFAULT NULL,
                                  `extra_id` varchar(64) DEFAULT NULL COMMENT '项目id、任务id等',
                                  `type` varchar(32) DEFAULT NULL COMMENT '类型project、task',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_my_apply
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_oauth2_agree
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_oauth2_agree`;
CREATE TABLE `pmhub_oauth2_agree` (
                                      `id` varchar(64) DEFAULT NULL,
                                      `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
                                      `client_id` varchar(64) DEFAULT NULL COMMENT '应用id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='已允许单点登录的用户及对应应用';

-- ----------------------------
-- Records of pmhub_oauth2_agree
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_oauth2_client
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_oauth2_client`;
CREATE TABLE `pmhub_oauth2_client` (
                                       `id` varchar(64) DEFAULT NULL,
                                       `client_name` varchar(128) DEFAULT NULL COMMENT '应用名称',
                                       `client_id` varchar(64) DEFAULT NULL COMMENT '应用id',
                                       `client_secret` varchar(1024) DEFAULT NULL COMMENT '应用secret',
                                       `img` varchar(2048) DEFAULT NULL COMMENT '应用图标'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_oauth2_client
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project`;
CREATE TABLE `pmhub_project` (
                                 `id` varchar(64) NOT NULL COMMENT '主键id',
                                 `project_code` varchar(32) NOT NULL COMMENT '项目编码',
                                 `project_name` varchar(200) NOT NULL COMMENT '项目名称',
                                 `description` varchar(500) DEFAULT NULL COMMENT '描述',
                                 `close_begin_time` datetime DEFAULT NULL COMMENT '项目开始时间',
                                 `close_end_time` datetime DEFAULT NULL COMMENT '项目结束时间',
                                 `cover` varchar(255) DEFAULT NULL COMMENT '封面',
                                 `stage_code` int(11) NOT NULL DEFAULT '0' COMMENT '项目阶段 默认是0',
                                 `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目类型 是否私有 0-公开 1-私有',
                                 `prefix` varchar(20) DEFAULT NULL COMMENT '项目编号前缀',
                                 `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                 `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
                                 `archived` tinyint(1) DEFAULT NULL COMMENT '是否归档 0-否 1-归档',
                                 `archived_time` datetime DEFAULT NULL COMMENT '归档时间',
                                 `published` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布 0-否 1-发布',
                                 `project_process` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '项目进度',
                                 `created_by` varchar(100) DEFAULT NULL COMMENT '创建人',
                                 `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `updated_by` varchar(100) DEFAULT NULL COMMENT '更新人',
                                 `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `user_id` bigint(20) DEFAULT NULL COMMENT '项目负责人',
                                 `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态 默认0-未开始',
                                 `auto_update_process` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自动更新进度 0-否 1-是',
                                 `open_begin_time` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启任务开始时间',
                                 `open_task_private` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启新任务默认开启隐私模式',
                                 `msg_notify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启消息提醒',
                                 `notify_day` int(11) NOT NULL DEFAULT '2' COMMENT '提醒的天数',
                                 `open_prefix` tinyint(1) DEFAULT '0' COMMENT '是否开启项目前缀',
                                 `project_stage_id` varchar(64) DEFAULT NULL COMMENT '阶段id',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目表';

-- ----------------------------
-- Records of pmhub_project
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project` (`id`, `project_code`, `project_name`, `description`, `close_begin_time`, `close_end_time`, `cover`, `stage_code`, `type`, `prefix`, `deleted`, `deleted_time`, `archived`, `archived_time`, `published`, `project_process`, `created_by`, `created_time`, `updated_by`, `updated_time`, `user_id`, `status`, `auto_update_process`, `open_begin_time`, `open_task_private`, `msg_notify`, `notify_day`, `open_prefix`, `project_stage_id`) VALUES ('aa3a0a9c72c6322d893768c3b05615fa', 'P20240401145842A001', '来个offer', '🔥🔥 来个offer-开源实战项目,助力学生党和工作党拿个更好的offer💪🏻', '2024-04-01 00:00:00', '2024-05-08 00:00:00', '/profile/cover/admin/20240530/laigeoffer大图.pic.jpg', 0, 0, NULL, 0, NULL, NULL, NULL, 1, 2.00, 'admin', '2024-04-01 14:58:43', 'admin', '2024-05-31 15:26:47', 1, 1, 0, 0, 0, 0, 2, 0, '936cf8a130ce76e39b73e6e0ebe36800');
INSERT INTO `pmhub_project` (`id`, `project_code`, `project_name`, `description`, `close_begin_time`, `close_end_time`, `cover`, `stage_code`, `type`, `prefix`, `deleted`, `deleted_time`, `archived`, `archived_time`, `published`, `project_process`, `created_by`, `created_time`, `updated_by`, `updated_time`, `user_id`, `status`, `auto_update_process`, `open_begin_time`, `open_task_private`, `msg_notify`, `notify_day`, `open_prefix`, `project_stage_id`) VALUES ('c3e462c400f66fe0b68d9d2c1bef9ffc', 'P20240401160110A002', '222', '', NULL, NULL, NULL, 0, 0, NULL, 1, '2024-04-02 14:52:01', NULL, NULL, 0, 0.00, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-02 14:52:01', 1, 0, 0, 0, 0, 0, 2, 0, '5a3eda6d32b85df82964021a7a042159');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_collection
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_collection`;
CREATE TABLE `pmhub_project_collection` (
                                            `id` varchar(64) NOT NULL COMMENT '主键id',
                                            `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                            `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                            `updated_by` varchar(64) DEFAULT NULL COMMENT '更新人',
                                            `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                            `project_id` varchar(64) DEFAULT NULL COMMENT '项目id',
                                            `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目-收藏表';

-- ----------------------------
-- Records of pmhub_project_collection
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_file
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_file`;
CREATE TABLE `pmhub_project_file` (
                                      `id` varchar(64) NOT NULL COMMENT '主键id',
                                      `type` varchar(20) DEFAULT NULL COMMENT '文件归属类型 task 或者 project',
                                      `pt_id` varchar(64) NOT NULL COMMENT 'type是task 对应就是task的id type是project 对应就是project的id',
                                      `file_name` varchar(100) NOT NULL COMMENT '文件名称',
                                      `file_size` decimal(11,2) DEFAULT NULL COMMENT '文件大小',
                                      `extension` varchar(32) NOT NULL COMMENT '扩展名',
                                      `file_url` varchar(200) NOT NULL COMMENT '文件完整地址',
                                      `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                      `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
                                      `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                      `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                      `updated_by` varchar(64) DEFAULT NULL COMMENT '更新人',
                                      `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                      `user_id` bigint(20) DEFAULT NULL COMMENT '上传人id',
                                      `project_id` varchar(64) NOT NULL COMMENT '项目id',
                                      `path_name` varchar(200) DEFAULT NULL,
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目或任务附件表';

-- ----------------------------
-- Records of pmhub_project_file
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_log
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_log`;
CREATE TABLE `pmhub_project_log` (
                                     `id` varchar(64) NOT NULL COMMENT '主键id',
                                     `user_id` bigint(20) NOT NULL COMMENT '操作人id',
                                     `type` varchar(16) NOT NULL COMMENT '类型 project 或者 task',
                                     `operate_type` varchar(32) NOT NULL COMMENT '操作类型',
                                     `content` text COMMENT '操作内容',
                                     `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                     `pt_id` varchar(64) NOT NULL COMMENT '项目或者任务id',
                                     `to_user_id` bigint(20) DEFAULT NULL,
                                     `created_by` varchar(64) DEFAULT NULL,
                                     `created_time` datetime DEFAULT NULL,
                                     `updated_by` varchar(64) DEFAULT NULL,
                                     `updated_time` datetime DEFAULT NULL,
                                     `log_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1-动态 2-交付物 3-评论',
                                     `file_url` varchar(500) DEFAULT NULL COMMENT '文件地址',
                                     `icon` varchar(20) DEFAULT NULL,
                                     `project_id` varchar(64) NOT NULL COMMENT '项目id',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目-任务日志';

-- ----------------------------
-- Records of pmhub_project_log
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('032fac95f33172ae8df72333ba257e6d', 173, 'task', 'addTask', 'f', '参与了任务', '0414ef914297d4bef45bf55ec6bba599', NULL, 'laige', '2024-05-31 13:58:25', 'laige', '2024-05-31 13:58:25', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('07b1a38dfae7d38f8abbff308551f813', 1, 'task', 'editTask', '[{\"field\":\"status\",\"fieldName\":\"任务状态\",\"newValue\":\"进行中\",\"oldValue\":\"未开始\"}]', '更新了任务状态', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-07 16:31:35', 'admin', '2024-04-07 16:31:35', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('0a05e2fdbfa543eb51ec5a1088643c8c', 1, 'project', 'delete', '222', '删除了项目', 'c3e462c400f66fe0b68d9d2c1bef9ffc', NULL, 'admin', '2024-04-02 14:52:01', 'admin', '2024-04-02 14:52:01', 1, NULL, NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('0b22aabfc66eb9f88fff7e07d2254876', 1, 'project', 'create', '来个offer', '创建了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('13b05ecff09164e096706c40ff392dde', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-05-31 15:26:47', 'admin', '2024-05-31 15:26:47', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('1a99bd82bc42b36359b4e97a2d21963b', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-05-30 19:56:54', 'admin', '2024-05-30 19:56:54', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('2aca1b1eb3854281ad02b3bbd68343c5', 1, 'task', 'addTask', '212', '参与了任务', '99b6803d35b3b474568bebf0f97722dc', NULL, 'admin', '2024-04-01 16:01:33', 'admin', '2024-04-01 16:01:33', 1, NULL, NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('31d5cec856454899238054b485e3f66f', 1, 'task', 'editTask', '[{\"field\":\"description\",\"fieldName\":\"描述\",\"newValue\":\"<p><span style=\\\"color: rgb(99, 108, 118);\\\">🚀来个offer，民间开源实战项目，助力学生党和工作党拿个更好的offer💪🏻，欢迎 Follow 关注我们 👉</span></p>\",\"oldValue\":\"<p><br></p>\"}]', '更新了描述', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-07 16:30:54', 'admin', '2024-04-07 16:30:54', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('49d8fe1c298a2fdc21499907e6aa47e1', 1, 'task', 'addTask', '第一个任务', '参与了任务', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-01 15:15:40', 'admin', '2024-04-01 15:15:40', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('4b686f7ab59f8a13eb84853b7f472a40', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-05-30 19:56:17', 'admin', '2024-05-30 19:56:17', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('6176f2e8aed6113671c092d23f352708', 1, 'task', 'editTask', '[{\"field\":\"description\",\"fieldName\":\"描述\",\"newValue\":\"<p><br></p>\",\"oldValue\":\"<p>测试任务</p>\"}]', '更新了描述', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-07 16:30:39', 'admin', '2024-04-07 16:30:39', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('77e6f86d17e5d41428de8bc5c9455b02', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-04-04 01:33:11', 'admin', '2024-04-04 01:33:11', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('78fa3f7c80ca583f09b2c4883dcdf54f', 1, 'project', 'inviteMember', '超级管理员', '加入了项目', 'c3e462c400f66fe0b68d9d2c1bef9ffc', 1, 'admin', '2024-04-01 16:01:11', 'admin', '2024-04-01 16:01:11', 1, NULL, NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('8ff312302c1a4ffc52665d8ef79f619d', 1, 'project', 'inviteMember', '超级管理员', '加入了项目', 'aa3a0a9c72c6322d893768c3b05615fa', 1, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('cbeb538a3ec25086f13927283967aa54', 1, 'project', 'create', '222', '创建了项目', 'c3e462c400f66fe0b68d9d2c1bef9ffc', NULL, 'admin', '2024-04-01 16:01:11', 'admin', '2024-04-01 16:01:11', 1, NULL, NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('d22127f1e8baea4efb1706f923537f4a', 1, 'task', 'editTask', '[{\"field\":\"executeStatus\",\"fieldName\":\"执行状态\",\"newValue\":\"进行中\",\"oldValue\":\"未开始\"}]', '更新了执行状态', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-07 16:31:32', 'admin', '2024-04-07 16:31:32', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('de5710715cfd8793518e9ef69f5f64de', 1, 'task', 'addTask', '第一个任务', '参与了任务', 'f0ddb49790bba0cc58b833470de0d48c', NULL, 'admin', '2024-04-01 14:59:21', 'admin', '2024-04-01 14:59:21', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('f3583a743885d0c707a2154bbb868f9a', 1, 'task', 'addTask', '第一个任务', '参与了任务', '4b3c00afaf7a6358b2108d465e0db48a', NULL, 'admin', '2024-04-01 14:59:40', 'admin', '2024-04-01 14:59:40', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('f4d694793d04a4b12944517272b56862', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-04-04 01:32:44', 'admin', '2024-04-04 01:32:44', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_member
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_member`;
CREATE TABLE `pmhub_project_member` (
                                        `id` varchar(64) NOT NULL COMMENT '主键id',
                                        `pt_id` varchar(64) NOT NULL COMMENT '项目或者任务id',
                                        `user_id` bigint(20) NOT NULL COMMENT '用户id',
                                        `joined_time` datetime DEFAULT NULL COMMENT '加入时间',
                                        `created_by` varchar(100) DEFAULT NULL COMMENT '创建人',
                                        `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                        `updated_by` varchar(100) DEFAULT NULL COMMENT '更新人',
                                        `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                        `type` varchar(32) NOT NULL COMMENT '类型是项目还是任务 task project',
                                        `creator` tinyint(1) DEFAULT '0' COMMENT '是否创建者',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目-任务成员';

-- ----------------------------
-- Records of pmhub_project_member
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('0c1d0483413d800a972f8f8598acc3d6', 'f0ddb49790bba0cc58b833470de0d48c', 1, '2024-04-01 14:59:21', 'admin', '2024-04-01 14:59:21', 'admin', '2024-04-01 14:59:21', 'task', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('3de03dda428830dde4e8a573d293aa79', 'c3e462c400f66fe0b68d9d2c1bef9ffc', 1, '2024-04-01 16:01:11', 'admin', '2024-04-01 16:01:11', 'admin', '2024-04-01 16:01:11', 'project', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('42c2b685177dd040587626f3f206325e', 'aa3a0a9c72c6322d893768c3b05615fa', 1, '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43', 'project', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('5d64e940bb99f2fa3f649df30104b614', 'aa3a0a9c72c6322d893768c3b05615fa', 173, '2024-04-04 01:39:16', 'admin', '2024-04-04 01:39:16', 'admin', '2024-04-04 01:39:16', 'project', 0);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('8e3c1b48af1608c12b49b004c7580dc5', '0414ef914297d4bef45bf55ec6bba599', 173, '2024-05-31 13:58:25', 'laige', '2024-05-31 13:58:25', 'laige', '2024-05-31 13:58:25', 'task', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('9142a2503746eb0dd082c8b9ef466df9', '6dab92bed8d03d904962cca5dace9893', 1, '2024-04-01 15:15:40', 'admin', '2024-04-01 15:15:40', 'admin', '2024-04-01 15:15:40', 'task', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('936489d30d610e048cc4b9f8fd644401', '99b6803d35b3b474568bebf0f97722dc', 1, '2024-04-01 16:01:33', 'admin', '2024-04-01 16:01:33', 'admin', '2024-04-01 16:01:33', 'task', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('9dac17d94f07e0db7e9a41b9774825ad', '4b3c00afaf7a6358b2108d465e0db48a', 1, '2024-04-01 14:59:40', 'admin', '2024-04-01 14:59:40', 'admin', '2024-04-01 14:59:40', 'task', 1);
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_stage
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_stage`;
CREATE TABLE `pmhub_project_stage` (
                                       `id` varchar(64) NOT NULL COMMENT '主键id',
                                       `stage_code` int(11) NOT NULL COMMENT '阶段编码',
                                       `stage_name` varchar(100) NOT NULL COMMENT '阶段名称',
                                       `description` varchar(255) DEFAULT NULL COMMENT '阶段描述',
                                       `project_id` varchar(64) NOT NULL COMMENT '项目id',
                                       `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                       `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                       `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                       `updated_by` varchar(64) DEFAULT NULL COMMENT '更新人',
                                       `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目阶段';

-- ----------------------------
-- Records of pmhub_project_stage
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('0daaf2b9de2b3c9bcb9d7c89eeff9c03', 3, '交付验收阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('4325973a30ce9b9d7d5f1e4fa074891f', 2, '研发实施阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('5a3eda6d32b85df82964021a7a042159', 0, '项目立项阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('5c40e5da93bd6fc343a0909a9f01c73c', 3, '交付验收阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('6359652deefcbc760893e79f55b23a20', 4, '新产品导出阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('64a586191a41de633fba33976af476ca', 1, '研发设计输入阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('83641c127c6514ff68222eb666f3cadf', 1, '研发设计输入阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('8c7441c41bcc7e824a7a4b3c1cd72d24', 2, '研发实施阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('936cf8a130ce76e39b73e6e0ebe36800', 0, '项目立项阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('c459c5b373983888cf0a98055a95451f', 4, '新产品导出阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_task
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_task`;
CREATE TABLE `pmhub_project_task` (
                                      `id` varchar(64) NOT NULL COMMENT '主键id',
                                      `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                      `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                      `updated_by` varchar(64) DEFAULT NULL COMMENT '更新人',
                                      `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                      `task_name` varchar(100) DEFAULT NULL COMMENT '任务名称',
                                      `project_id` varchar(64) DEFAULT NULL COMMENT '项目id',
                                      `task_priority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务优先级',
                                      `user_id` bigint(20) NOT NULL COMMENT '用户id',
                                      `project_stage_id` varchar(64) NOT NULL COMMENT '项目阶段id',
                                      `description` varchar(500) DEFAULT NULL COMMENT '任务描述',
                                      `begin_time` datetime DEFAULT NULL COMMENT '预计开始时间',
                                      `end_time` datetime DEFAULT NULL COMMENT '预计结束时间',
                                      `close_time` datetime DEFAULT NULL COMMENT '截止时间',
                                      `task_pid` varchar(64) DEFAULT NULL COMMENT '任务父节点',
                                      `assign_to` varchar(64) DEFAULT NULL COMMENT '指派给谁',
                                      `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务状态',
                                      `execute_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '执行状态',
                                      `task_process` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '任务进度',
                                      `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
                                      `deleted_time` datetime DEFAULT NULL,
                                      `task_flow` varchar(200) DEFAULT NULL COMMENT '所属流程',
                                      `task_type_id` varchar(64) DEFAULT NULL COMMENT '任务类型id',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      KEY `idx` (`id`,`project_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目-任务表';

-- ----------------------------
-- Records of pmhub_project_task
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('0414ef914297d4bef45bf55ec6bba599', 'laige', '2024-05-31 13:58:25', 'laige', '2024-05-31 13:58:25', 'f', 'aa3a0a9c72c6322d893768c3b05615fa', 4, 173, '', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0.00, 0, NULL, '', NULL);
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('4b3c00afaf7a6358b2108d465e0db48a', 'admin', '2024-04-01 14:59:40', 'admin', '2024-04-01 14:59:40', '第一个任务', 'aa3a0a9c72c6322d893768c3b05615fa', 0, 1, '936cf8a130ce76e39b73e6e0ebe36800', '<p>测试任务</p>', NULL, NULL, NULL, NULL, NULL, 0, 0, 0.00, 1, '2024-04-04 01:39:26', '', NULL);
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('6dab92bed8d03d904962cca5dace9893', 'admin', '2024-04-01 15:15:40', 'admin', '2024-04-07 16:31:35', '第一个任务', 'aa3a0a9c72c6322d893768c3b05615fa', 0, 1, '936cf8a130ce76e39b73e6e0ebe36800', '<p><span style=\"color: rgb(99, 108, 118);\">🚀来个offer，民间开源实战项目，助力学生党和工作党拿个更好的offer💪🏻，欢迎 Follow 关注我们 👉</span></p>', NULL, NULL, NULL, NULL, NULL, 1, 1, 0.00, 0, NULL, '', NULL);
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('99b6803d35b3b474568bebf0f97722dc', 'admin', '2024-04-01 16:01:33', 'admin', '2024-04-01 16:01:33', '212', 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 1, '', '<p>12121</p>', NULL, NULL, NULL, NULL, NULL, 0, 0, 0.00, 1, '2024-04-02 14:51:49', '', NULL);
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('f0ddb49790bba0cc58b833470de0d48c', 'admin', '2024-04-01 14:59:21', 'admin', '2024-04-01 14:59:21', '第一个任务', 'aa3a0a9c72c6322d893768c3b05615fa', 0, 1, '936cf8a130ce76e39b73e6e0ebe36800', '<p>测试任务</p>', NULL, NULL, NULL, NULL, NULL, 0, 0, 0.00, 1, '2024-04-04 01:39:33', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_task_notify
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_task_notify`;
CREATE TABLE `pmhub_project_task_notify` (
                                             `id` varchar(64) NOT NULL,
                                             `task_id` varchar(64) DEFAULT NULL COMMENT '任务id',
                                             `user_id` int(11) DEFAULT NULL COMMENT '用户id',
                                             `user_wx_name` varchar(64) DEFAULT NULL COMMENT '企业微信id',
                                             `project_id` varchar(64) DEFAULT NULL COMMENT '项目id',
                                             `overdue` tinyint(1) DEFAULT NULL COMMENT '是否逾期 0-否 1-是',
                                             `close_time` datetime DEFAULT NULL,
                                             `task_name` varchar(255) DEFAULT NULL,
                                             PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务提醒表';

-- ----------------------------
-- Records of pmhub_project_task_notify
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_task_process
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_task_process`;
CREATE TABLE `pmhub_project_task_process` (
                                              `id` varchar(64) NOT NULL,
                                              `extra_id` varchar(64) DEFAULT NULL COMMENT '项目任务id',
                                              `approved` varchar(10) DEFAULT NULL COMMENT '是否需要审批',
                                              `instance_id` varchar(64) DEFAULT NULL COMMENT '流程实例id',
                                              `deployment_id` varchar(64) DEFAULT NULL COMMENT '部署id',
                                              `definition_id` varchar(64) DEFAULT NULL COMMENT '流程定义id',
                                              `created_by` varchar(64) DEFAULT NULL,
                                              `created_time` datetime DEFAULT NULL,
                                              `updated_by` varchar(64) DEFAULT NULL,
                                              `updated_time` datetime DEFAULT NULL,
                                              `type` varchar(64) DEFAULT NULL COMMENT '类型task/project等',
                                              `task_id` varchar(64) DEFAULT NULL COMMENT '流程任务id',
                                              `url` varchar(1000) DEFAULT NULL COMMENT '详情地址',
                                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_project_task_process
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_task_work_time
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_task_work_time`;
CREATE TABLE `pmhub_project_task_work_time` (
                                                `id` varchar(64) NOT NULL COMMENT '主键id',
                                                `project_task_id` varchar(64) NOT NULL COMMENT '任务id',
                                                `user_id` varchar(64) NOT NULL COMMENT '用户id',
                                                `work_time` decimal(5,2) DEFAULT NULL COMMENT '工时',
                                                `project_id` varchar(64) NOT NULL COMMENT '项目id',
                                                `created_by` varchar(64) DEFAULT NULL,
                                                `created_time` datetime DEFAULT NULL,
                                                `updated_by` varchar(64) DEFAULT NULL,
                                                `updated_time` datetime DEFAULT NULL,
                                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务工时表';

-- ----------------------------
-- Records of pmhub_project_task_work_time
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_public_file
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_public_file`;
CREATE TABLE `pmhub_public_file` (
                                     `id` varchar(64) NOT NULL COMMENT '主键id',
                                     `file_name` varchar(100) NOT NULL COMMENT '文件名称',
                                     `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
                                     `extension` varchar(128) NOT NULL COMMENT '扩展名',
                                     `file_url` varchar(200) NOT NULL COMMENT '文件下载地址',
                                     `path_name` varchar(200) NOT NULL COMMENT '文件物理路径',
                                     `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                     `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                     `update_by` varchar(64) DEFAULT NULL COMMENT '更新、删除人',
                                     `update_time` datetime DEFAULT NULL COMMENT '更新、删除时间',
                                     `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不指定目标的上传文件';

-- ----------------------------
-- Records of pmhub_public_file
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_public_file_cache
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_public_file_cache`;
CREATE TABLE `pmhub_public_file_cache` (
                                           `id` varchar(64) NOT NULL COMMENT '主键id',
                                           `file_name` varchar(100) NOT NULL COMMENT '文件名称',
                                           `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
                                           `extension` varchar(32) NOT NULL COMMENT '扩展名',
                                           `file_url` varchar(200) NOT NULL COMMENT '文件下载地址',
                                           `path_name` varchar(200) NOT NULL COMMENT '文件物理路径',
                                           `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                           `update_by` varchar(64) DEFAULT NULL COMMENT '更新、删除人',
                                           `update_time` datetime DEFAULT NULL COMMENT '更新、删除时间',
                                           `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不指定目标的上传文件缓存表';

-- ----------------------------
-- Records of pmhub_public_file_cache
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_public_file_link
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_public_file_link`;
CREATE TABLE `pmhub_public_file_link` (
                                          `id` varchar(64) NOT NULL COMMENT '主键id',
                                          `object_id` varchar(64) NOT NULL COMMENT '文件名称',
                                          `object_type` varchar(16) DEFAULT NULL COMMENT '关联对象类型',
                                          `file_id` varchar(64) NOT NULL COMMENT '扩展名',
                                          `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                          `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                          `update_by` varchar(64) DEFAULT NULL COMMENT '更新、删除人',
                                          `update_time` datetime DEFAULT NULL COMMENT '更新、删除时间',
                                          `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件引用关联表，所有未指定关系的上传文件都应该在这里指定关联关系，如果有文件在这个关联表中没有任何关联关系，则会被定时任务物理删除';

-- ----------------------------
-- Records of pmhub_public_file_link
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_task_message_deal
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_task_message_deal`;
CREATE TABLE `pmhub_task_message_deal` (
                                           `id` varchar(64) NOT NULL,
                                           `task_id` varchar(64) DEFAULT NULL,
                                           `instance_id` varchar(64) DEFAULT NULL,
                                           `assignee` varchar(64) DEFAULT NULL,
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_task_message_deal
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_task_type
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_task_type`;
CREATE TABLE `pmhub_task_type` (
                                   `id` varchar(64) NOT NULL,
                                   `type_name` varchar(64) DEFAULT NULL COMMENT '类型名称',
                                   `sort` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
                                   `created_by` varchar(64) DEFAULT NULL,
                                   `created_time` datetime DEFAULT NULL,
                                   `updated_by` varchar(64) DEFAULT NULL,
                                   `updated_time` datetime DEFAULT NULL,
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_task_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_template
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_template`;
CREATE TABLE `pmhub_template` (
                                  `id` varchar(64) NOT NULL,
                                  `file` longblob NOT NULL COMMENT '文件二进制数据',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='模板文件';

-- ----------------------------
-- Records of pmhub_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_cancel
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_cancel`;
CREATE TABLE `pmhub_wf_cancel` (
                                   `id` varchar(64) DEFAULT NULL COMMENT 'id',
                                   `inst_id` varchar(128) DEFAULT NULL COMMENT 'inst_id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户发起取消流程';

-- ----------------------------
-- Records of pmhub_wf_cancel
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_category
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_category`;
CREATE TABLE `pmhub_wf_category` (
                                     `category_id` bigint(20) NOT NULL COMMENT '流程分类id',
                                     `category_name` varchar(64) DEFAULT '' COMMENT '流程分类名称',
                                     `code` varchar(64) DEFAULT '' COMMENT '分类编码',
                                     `remark` varchar(500) DEFAULT '' COMMENT '备注',
                                     `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                     `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                     `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                     `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                     `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                     PRIMARY KEY (`category_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程分类表';

-- ----------------------------
-- Records of pmhub_wf_category
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_wf_category` (`category_id`, `category_name`, `code`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`) VALUES (1793475859094540290, '信息流转流程', '123456', '123456', '', NULL, '', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_copy
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_copy`;
CREATE TABLE `pmhub_wf_copy` (
                                 `copy_id` varchar(64) NOT NULL COMMENT '抄送主键',
                                 `title` varchar(255) DEFAULT '' COMMENT '抄送标题',
                                 `process_id` varchar(64) DEFAULT '' COMMENT '流程主键',
                                 `process_name` varchar(255) DEFAULT '' COMMENT '流程名称',
                                 `category_id` varchar(255) DEFAULT '' COMMENT '流程分类主键',
                                 `deployment_id` varchar(64) DEFAULT '' COMMENT '部署主键',
                                 `instance_id` varchar(64) DEFAULT '' COMMENT '流程实例主键',
                                 `task_id` varchar(64) DEFAULT '' COMMENT '任务主键',
                                 `user_id` bigint(20) DEFAULT NULL COMMENT '用户主键',
                                 `originator_id` bigint(20) DEFAULT NULL COMMENT '发起人主键',
                                 `originator_name` varchar(64) DEFAULT '' COMMENT '发起人名称',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                 PRIMARY KEY (`copy_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程抄送表';

-- ----------------------------
-- Records of pmhub_wf_copy
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_deploy_form
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_deploy_form`;
CREATE TABLE `pmhub_wf_deploy_form` (
                                        `deploy_id` varchar(64) NOT NULL COMMENT '流程实例主键',
                                        `form_key` varchar(64) NOT NULL COMMENT '表单Key',
                                        `node_key` varchar(64) NOT NULL COMMENT '节点Key',
                                        `form_name` varchar(64) DEFAULT '' COMMENT '表单名称',
                                        `node_name` varchar(255) DEFAULT '' COMMENT '节点名称',
                                        `content` longtext COMMENT '表单内容',
                                        PRIMARY KEY (`deploy_id`,`form_key`,`node_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程实例关联表单';

-- ----------------------------
-- Records of pmhub_wf_deploy_form
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_form
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_form`;
CREATE TABLE `pmhub_wf_form` (
                                 `form_id` bigint(20) NOT NULL COMMENT '表单主键',
                                 `form_name` varchar(64) DEFAULT '' COMMENT '表单名称',
                                 `content` longtext COMMENT '表单内容',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                 `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                 PRIMARY KEY (`form_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程表单信息表';

-- ----------------------------
-- Records of pmhub_wf_form
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_wf_form` (`form_id`, `form_name`, `content`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`, `del_flag`) VALUES (1794270355885494273, '民意测评', '{\"formRef\":\"elForm\",\"formModel\":\"formData\",\"size\":\"medium\",\"labelPosition\":\"right\",\"labelWidth\":100,\"formRules\":\"rules\",\"gutter\":15,\"disabled\":false,\"span\":24,\"formBtns\":true,\"fields\":[{\"__config__\":{\"label\":\"单行文本\",\"labelWidth\":null,\"showLabel\":true,\"changeTag\":true,\"tag\":\"el-input\",\"tagIcon\":\"input\",\"defaultValue\":\"民意测评\",\"required\":true,\"layout\":\"colFormItem\",\"span\":24,\"document\":\"https://element.eleme.cn/#/zh-CN/component/input\",\"regList\":[],\"formId\":1716622210876,\"renderKey\":\"17166222108761716622210876\"},\"__slot__\":{\"prepend\":\"\",\"append\":\"\"},\"placeholder\":\"请输入单行文本\",\"style\":{\"width\":\"100%\"},\"clearable\":true,\"prefix-icon\":\"\",\"suffix-icon\":\"\",\"maxlength\":null,\"show-word-limit\":false,\"readonly\":false,\"disabled\":false,\"__vModel__\":\"field1716622210876\"},{\"__config__\":{\"label\":\"下拉选择\",\"showLabel\":true,\"labelWidth\":null,\"tag\":\"el-select\",\"tagIcon\":\"select\",\"layout\":\"colFormItem\",\"span\":24,\"required\":true,\"regList\":[],\"changeTag\":true,\"document\":\"https://element.eleme.cn/#/zh-CN/component/select\",\"formId\":1716622303124,\"renderKey\":\"17166223031241716622303124\"},\"__slot__\":{\"options\":[{\"label\":\"选项一\",\"value\":5},{\"label\":\"选项二\",\"value\":10},{\"label\":\"选项三\",\"value\":15}]},\"placeholder\":\"请选择下拉选择\",\"style\":{\"width\":\"100%\"},\"clearable\":true,\"disabled\":false,\"filterable\":false,\"multiple\":false,\"__vModel__\":\"field1716622303124\"}]}', 'laige', '2024-05-25 15:32:43', 'laige', '2024-05-25 15:32:43', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_model_deploy
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_model_deploy`;
CREATE TABLE `pmhub_wf_model_deploy` (
                                         `id` varchar(64) NOT NULL,
                                         `model_id` varchar(64) NOT NULL COMMENT '模型id',
                                         `deployed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-未部署 1-已部署',
                                         `created_by` varchar(64) DEFAULT NULL,
                                         `created_time` datetime DEFAULT NULL,
                                         `updated_by` varchar(64) DEFAULT NULL,
                                         `updated_time` datetime DEFAULT NULL,
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_wf_model_deploy
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_wf_model_deploy` (`id`, `model_id`, `deployed`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('0d752fa5a7981ae3ee28ca290482449c', 'f7ba4dcd-18af-11ef-bdc0-0242ac110002', 0, 'laige', '2024-05-23 10:55:53', 'laige', '2024-05-23 10:55:53');
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
                              `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
                              `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
                              `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
                              `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
                              `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
                              `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
                            `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
                            `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
                            `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
                            `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
                            `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
                            `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
                            `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
                            `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
                            `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (100, 0, '0', '来个offer科技有限公司', 0, '苍何', '15833888121', 'ry@qq.com', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2024-03-05 06:48:31');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (101, 211, '0,100,211', 'offer技术研究院', 9, '苍何', '', 'ry@qq.com', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2024-03-05 06:48:56');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (102, 100, '0,100', '长沙分公司', 2, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (103, 101, '0,100,211,101', '研发设计部', 2, '', '', '', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-18 17:43:16');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (104, 101, '0,100,211,101', '实验室', 3, '', '', '', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2024-03-05 06:49:46');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (105, 101, '0,100,211,101', '测试部门', 12, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-19 09:31:23');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (106, 101, '0,100,211,101', '数据中心', 4, '', '', '', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2024-03-05 06:49:52');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (107, 101, '0,100,211,101', '运维部门', 5, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (108, 102, '0,100,102', '市场部门', 1, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (109, 102, '0,100,102', '财务部门', 2, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (200, 101, '0,100,211,101', '测试', 6, NULL, NULL, NULL, '0', '2', 'admin', '2023-01-13 14:05:12', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (201, 101, '0,100,211,101', '技术探讨部', 1, '', '', NULL, '0', '0', 'admin', '2023-01-18 15:28:33', 'admin', '2024-03-05 06:49:39');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (202, 102, '0,100,102', '测试', 3, NULL, NULL, NULL, '0', '2', 'admin', '2023-01-18 15:41:47', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (203, 211, '0,100,211', '董事会办公司', 1, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:24:29', 'admin', '2023-01-18 17:30:57');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (204, 211, '0,100,211', '综合管理部', 2, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:25:09', 'admin', '2023-01-18 17:31:23');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (205, 211, '0,100,211', '人力资源部', 3, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:25:42', 'admin', '2023-01-18 17:32:33');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (206, 211, '0,100,211', '资产财务部', 4, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:26:33', 'admin', '2023-01-18 17:32:56');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (207, 211, '0,100,211', '审计法务部', 5, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:27:06', 'admin', '2023-01-18 17:33:14');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (208, 211, '0,100,211', '投资发展部', 6, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:27:40', 'admin', '2023-01-18 17:33:34');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (209, 211, '0,100,211', '市场营销部', 7, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:28:16', 'admin', '2023-01-18 17:33:51');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (210, 211, '0,100,211', '供应链管理部', 8, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:29:04', 'admin', '2023-01-18 17:34:03');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (211, 100, '0,100', '重庆总公司', 1, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:30:22', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (212, 211, '0,100,211', '生产管理部', 10, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:46:50', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (213, 211, '0,100,211', '项目管理部', 11, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:47:15', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (214, 101, '0,100,211,101', '测试部门', 5, '李四', NULL, NULL, '0', '0', 'dxj', '2023-03-29 14:33:13', 'admin', '2023-04-21 14:49:41');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (215, 101, '0,100,211,101', '顶顶顶顶', 6, NULL, NULL, NULL, '0', '2', 'dxj', '2023-08-31 18:09:59', 'admin', '2023-08-31 18:10:06');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (216, 106, '0,100,211,101,106', 'eee', 1, NULL, NULL, NULL, '0', '2', 'canghe', '2023-09-22 09:28:22', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
                                 `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
                                 `dict_sort` int(11) DEFAULT '0' COMMENT '字典排序',
                                 `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
                                 `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
                                 `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
                                 `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
                                 `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
                                 `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
                                 `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                 PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '性别男');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '性别女');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '通知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '公告');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, 1, '未开始', '0', 'project_task_execute_status', NULL, 'default', 'N', '0', 'admin', '2022-12-14 17:04:59', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, 2, '进行中', '1', 'project_task_execute_status', NULL, 'default', 'N', '0', 'admin', '2022-12-14 17:05:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, 3, '已完成', '2', 'project_task_execute_status', NULL, 'default', 'N', '0', 'admin', '2022-12-14 17:05:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, 4, '直属上级', '${startUserLeaderList}', 'var', NULL, 'default', 'N', '0', 'dxj', '2023-04-21 14:00:21', 'dxj', '2023-04-26 09:39:17', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, 0, '进行中', '0', 'async_status', NULL, 'primary', 'N', '0', 'admin', '2023-12-22 11:15:07', 'admin', '2023-12-22 11:16:34', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, 2, '已完成', '2', 'async_status', NULL, 'success', 'N', '0', 'admin', '2023-12-22 11:15:52', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, 1, '已失败', '1', 'async_status', NULL, 'danger', 'N', '0', 'admin', '2023-12-22 11:16:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (118, 0, '启用', '1', 'sxsd_status', NULL, 'primary', 'N', '0', 'admin', '2024-01-15 10:06:45', 'qyh', '2024-01-16 16:47:18', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (119, 1, '停用', '0', 'sxsd_status', NULL, 'danger', 'N', '0', 'admin', '2024-01-15 10:07:28', 'admin', '2024-01-15 10:09:34', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
                                 `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
                                 `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
                                 `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
                                 `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                 PRIMARY KEY (`dict_id`) USING BTREE,
                                 UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '项目-任务执行状态', 'project_task_execute_status', '0', 'admin', '2022-12-14 17:04:40', '', NULL, '项目-任务执行状态');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '审批人变量', 'var', '0', 'dxj', '2023-04-18 11:28:52', 'dxj', '2023-04-21 13:58:44', '未知审批人变量');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '异步任务状态', 'async_status', '0', 'admin', '2023-12-22 11:14:35', '', NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, 'sxsd-status', 'sxsd_status', '0', 'admin', '2024-01-15 10:05:47', '', NULL, '三峡时代通用状态');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
                           `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
                           `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
                           `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
                           `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
                           `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
                           `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
                           `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
                           `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
                           `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                           `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
                           PRIMARY KEY (`job_id`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '任务待逾期提醒', 'DEFAULT', 'com.sxsd.quartz.task.TaskNotifyTask.taskNotify()', '0 0 9 * * ?', '1', '1', '1', 'admin', '2023-10-12 09:50:01', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '任务已逾期提醒', 'DEFAULT', 'com.sxsd.quartz.task.TaskOverdueNotifyTask.taskNotify()', '0 0 9 * * ?', '1', '1', '1', 'admin', '2023-10-12 09:57:14', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '任务已逾期状态修改', 'DEFAULT', 'com.sxsd.quartz.task.TaskOverdueStatusTask.taskNotify()', '0 0 1 * * ?', '1', '1', '1', 'admin', '2023-10-12 09:58:12', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '任务已逾期周提醒', 'DEFAULT', 'com.sxsd.quartz.task.TaskOverdueWeekNotifyTask.taskNotify()', '0 0 10 ? * MON', '1', '1', '1', 'admin', '2023-10-12 09:59:12', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '代办任务提醒', 'DEFAULT', 'com.sxsd.quartz.task.TodoRemindTask.sayWord()', '0 0 9 1/2 * ?', '1', '1', '1', 'admin', '2023-10-12 10:00:24', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '计算物料批次存量', 'DEFAULT', 'com.sxsd.quartz.task.MaterialsCountCalcTask.countCalc()', '0 0 3 * * ?', '1', '1', '1', 'admin', '2023-10-12 10:08:14', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '计算分类编码头', 'DEFAULT', 'com.sxsd.quartz.task.MaterialsTypeCodeHeadCalcTask.countCalc()', '0 0 1 1 * ?', '1', '1', '1', 'admin', '2023-10-12 10:09:15', 'lisi', '2023-10-23 16:31:03', '');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
                               `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
                               `job_name` varchar(64) NOT NULL COMMENT '任务名称',
                               `job_group` varchar(64) NOT NULL COMMENT '任务组名',
                               `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
                               `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
                               `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
                               `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
                               `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                               PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
                                  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
                                  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
                                  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
                                  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
                                  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
                                  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
                                  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
                                  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
                                  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
                                  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8994 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8873, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-05 09:18:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8874, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-13 15:09:28');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8875, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-15 07:04:46');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8876, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '密码输入错误1次', '2024-03-28 09:38:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8877, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '用户不存在/密码错误', '2024-03-28 09:38:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8878, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2024-03-28 09:38:13');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8879, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-29 09:40:33');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8880, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2024-03-29 10:05:11');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8881, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-01 06:07:45');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8882, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-01 06:08:21');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8883, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-01 06:19:02');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8884, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-01 06:40:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8885, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-01 06:40:55');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8886, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-02 06:42:12');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8887, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '密码输入错误1次', '2024-04-02 08:52:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8888, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '用户不存在/密码错误', '2024-04-02 08:52:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8889, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2024-04-02 08:52:54');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8890, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2024-04-02 08:53:48');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8891, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-04-03 17:29:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8892, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-04-03 17:29:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8893, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:29:31');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8894, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-03 17:40:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8895, 'laige', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:40:25');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8896, 'laige', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-03 17:41:12');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8897, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:41:15');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8898, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-03 17:41:32');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8899, 'laige', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:41:35');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8900, 'laige', '164.92.117.137', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:44:20');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8901, 'laige', '125.62.3.184', 'XX XX', 'Chrome Mobile', 'Mac OS X (iPhone)', '0', '登录成功', '2024-04-04 00:32:22');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8902, 'laige', '164.92.117.137', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-04 05:06:45');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8903, 'laige', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-04 14:38:58');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8904, 'admin', '43.132.98.47', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-04-07 02:31:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8905, 'admin', '43.132.98.47', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-04-07 02:31:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8906, 'admin', '43.132.98.47', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误2次', '2024-04-07 02:31:17');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8907, 'admin', '43.132.98.47', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-04-07 02:31:17');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8908, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-07 06:58:34');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8909, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-07 08:29:29');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8910, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-07 08:29:37');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8911, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-07 15:05:49');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8912, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-16 03:34:09');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8913, 'admin', '125.62.3.167', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-16 13:13:04');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8914, 'admin', '125.62.3.167', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-16 13:14:08');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8915, 'admin', '125.62.3.167', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-16 13:20:53');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8916, 'admin', '123.147.251.185', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2024-04-18 10:53:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8917, 'root', '27.148.97.168', 'XX XX', 'Chrome 12', 'Windows 10', '1', '登录用户：root 不存在', '2024-04-24 04:03:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8918, 'admin', '27.148.97.168', 'XX XX', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2024-04-24 04:39:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8919, 'admin', '27.148.97.168', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-04-24 04:39:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8920, 'laige', '27.148.97.168', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-24 04:40:11');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8921, 'laige', '112.97.87.85', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-10 02:45:17');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8922, 'admin', '42.224.165.45', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-05-14 03:49:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8923, 'admin', '42.224.165.45', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-05-14 03:49:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8924, 'laige', '113.64.74.144', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-15 13:22:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8925, 'admin', '125.62.3.222', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-15 13:31:47');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8926, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-05-17 08:28:50');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8927, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-05-17 08:28:50');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8928, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-05-17 08:43:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8929, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-05-17 08:43:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8930, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-17 08:47:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8931, 'laige', '222.178.212.82', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-22 08:17:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8932, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-22 08:42:04');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8933, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-05-22 08:59:32');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8934, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-22 09:02:18');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8935, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-05-22 09:04:40');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8936, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-22 09:04:47');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8937, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-05-22 09:04:53');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8938, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-22 09:04:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8939, 'admin', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2024-05-23 00:39:20');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8940, 'admin', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 00:39:20');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8941, 'laige', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-23 00:39:37');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8942, 'laige', '61.52.222.189', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-05-23 01:20:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8943, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-23 01:30:30');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8944, 'laige', '36.21.144.154', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-05-23 01:42:08');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8945, 'laige', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-05-23 02:12:45');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8946, 'laige', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-23 02:13:06');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8947, '111', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '登录用户：111 不存在', '2024-05-23 04:22:07');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8948, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2024-05-23 04:22:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8949, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 04:22:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8950, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误2次', '2024-05-23 04:22:25');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8951, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 04:22:25');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8952, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2024-05-23 04:34:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8953, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 04:34:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8954, 'laige', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-05-23 04:38:50');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8955, 'admin', '180.169.244.190', 'XX XX', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2024-05-23 05:35:52');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8956, 'admin', '180.169.244.190', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 05:35:52');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8957, 'admin', '180.169.244.190', 'XX XX', 'Chrome 12', 'Windows 10', '1', '密码输入错误2次', '2024-05-23 05:35:55');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8958, 'admin', '180.169.244.190', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 05:35:55');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8959, 'laige', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-23 07:01:41');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8960, 'laige', '115.60.12.103', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-25 06:42:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8961, 'laige', '39.144.92.214', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-25 07:29:39');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8962, 'admin', '125.62.3.155', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-27 22:00:27');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8963, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '登录成功', '2024-05-27 22:00:46');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8964, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '退出成功', '2024-05-27 22:16:33');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8965, 'admin', '183.69.244.46', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-28 16:24:08');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8966, 'admin', '183.69.244.46', NULL, NULL, NULL, '0', '登录成功', '2024-05-28 16:24:16');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8967, 'admin', '183.69.244.46', NULL, NULL, NULL, '0', '退出成功', '2024-05-28 17:00:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8968, 'admin', '183.69.244.46', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-29 16:58:54');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8969, 'admin', '183.69.244.46', NULL, NULL, NULL, '0', '登录成功', '2024-05-29 16:59:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8970, 'laige', '1.180.149.94', NULL, NULL, NULL, '0', '登录成功', '2024-05-29 16:59:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8971, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '退出成功', '2024-05-30 06:15:33');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8972, 'admin', '118.81.149.129', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-30 11:34:53');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8973, 'laige', '118.81.149.129', NULL, NULL, NULL, '0', '登录成功', '2024-05-30 11:35:44');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8974, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '登录成功', '2024-05-30 19:55:42');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8975, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '退出成功', '2024-05-30 19:56:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8976, 'laige', '117.158.45.71', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 01:19:39');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8977, 'laige', '180.213.169.203', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:27:36');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8978, 'laige', '122.192.82.87', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:28:27');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8979, 'laige', '172.82.190.203', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:33:22');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8980, 'laige', '183.63.222.250', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:42:13');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8981, 'laige', '117.61.17.205', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:48:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8982, 'admin', '36.152.116.214', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-31 09:53:22');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8983, 'laige', '36.152.116.214', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-31 09:56:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8984, 'laige', '36.152.116.214', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:56:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8985, 'laige', '120.227.20.134', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 10:02:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8986, 'laige', '171.221.148.248', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 10:16:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8987, 'laige', '171.221.148.248', NULL, NULL, NULL, '0', '退出成功', '2024-05-31 10:16:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8988, 'admin', '171.221.148.248', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-31 10:18:05');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8989, 'laige', '171.221.148.248', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 10:18:21');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8990, 'laige', '14.153.32.4', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 10:18:23');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8991, 'laige', '180.167.148.2', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 13:52:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8992, 'laige', '222.92.146.66', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 13:57:54');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8993, 'admin', '183.69.244.46', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 15:26:00');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
                            `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                            `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
                            `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
                            `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
                            `path` varchar(200) DEFAULT '' COMMENT '路由地址',
                            `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
                            `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
                            `is_frame` int(11) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
                            `is_cache` int(11) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
                            `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
                            `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
                            `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
                            `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
                            `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT '' COMMENT '备注',
                            PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2171 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统管理', 0, 100, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-12-06 17:32:35', 'admin', '2023-02-23 13:53:29', '系统管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统监控', 0, 101, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-12-06 17:32:35', 'admin', '2023-02-23 13:53:35', '系统监控目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统工具', 0, 102, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-12-06 17:32:35', 'admin', '2023-02-23 13:53:40', '系统工具目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 1, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-18 15:41:08', '用户管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-12-06 17:32:35', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 1, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-18 15:41:12', '菜单管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-12-06 17:32:35', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-12-06 17:32:35', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-12-06 17:32:35', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-12-06 17:32:35', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-12-06 17:32:35', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-12-06 17:32:35', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-12-06 17:32:35', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-12-06 17:32:35', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '1', '1', 'monitor:druid:list', 'druid', 'admin', '2022-12-06 17:32:35', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-12-06 17:32:35', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-12-06 17:32:35', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-12-06 17:32:35', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, '表单构建（别删）', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '1', '0', 'tool:build:list', 'build', 'admin', '2022-12-06 17:32:35', 'admin', '2023-02-23 17:35:15', '表单构建菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-12-06 17:32:35', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-12-06 17:32:35', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (121, '流程分类', 1061, 1, 'category', 'workflow/category/index', '', 1, 0, 'C', '0', '0', 'workflow:category:list', 'nested', 'admin', '2023-02-23 13:39:32', '', NULL, '流程分类菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (122, '表单设计', 1061, 2, 'form', 'workflow/form/index', '', 1, 0, 'C', '0', '0', 'workflow:form:list', 'form', 'admin', '2023-02-23 13:39:32', 'admin', '2023-03-02 17:21:19', '表单配置菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (123, '流程设计', 1061, 3, 'model', 'workflow/model/index', '', 1, 1, 'C', '0', '0', 'workflow:model:list', 'component', 'admin', '2023-02-23 13:39:32', 'admin', '2023-03-06 14:44:37', '流程模型菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (124, '部署管理', 1061, 4, 'deploy', 'workflow/deploy/index', '', 1, 0, 'C', '0', '0', 'workflow:deploy:list', 'example', 'admin', '2023-02-23 13:39:32', '', NULL, '部署管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (125, '发起流程', 1062, 1, 'create', 'workflow/work/index', '', 1, 0, 'C', '0', '0', 'workflow:process:startList', 'guide', 'admin', '2023-02-23 13:39:32', 'admin', '2023-03-02 17:24:01', '新建流程菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (126, '我的流程', 1062, 2, 'own', 'workflow/work/own', '', 1, 0, 'C', '0', '0', 'workflow:process:ownList', 'cascader', 'admin', '2023-02-23 13:39:32', '', NULL, '我的流程菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (127, '待办任务', 1062, 3, 'todo', 'workflow/work/todo', '', 1, 0, 'C', '0', '0', 'workflow:process:todoList', 'time-range', 'admin', '2023-02-23 13:39:32', '', NULL, '待办任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (128, '待签任务', 1062, 4, 'claim', 'workflow/work/claim', '', 1, 0, 'C', '0', '0', 'workflow:process:claimList', 'checkbox', 'admin', '2023-02-23 13:39:32', '', NULL, '待签任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (129, '已办任务', 1062, 5, 'finished', 'workflow/work/finished', '', 1, 0, 'C', '0', '0', 'workflow:process:finishedList', 'checkbox', 'admin', '2023-02-23 13:39:32', '', NULL, '已办任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (130, '抄送我的', 1062, 6, 'copy', 'workflow/work/copy', '', 1, 0, 'C', '0', '0', 'workflow:process:copyList', 'checkbox', 'admin', '2023-02-23 13:39:32', '', NULL, '抄送我的菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-12-06 17:32:35', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-12-06 17:32:35', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1061, '流程管理', 0, 8, 'process', NULL, '', 1, 0, 'M', '0', '0', '', 'skill', 'admin', '2023-02-23 13:39:32', 'admin', '2023-02-23 14:32:47', '流程管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1062, '我的事务', 0, 7, 'work', NULL, '', 1, 0, 'M', '0', '0', '', 'job', 'admin', '2023-02-23 13:39:32', 'admin', '2023-02-23 14:32:42', '我的事务目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1140, '分类查询', 121, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1141, '分类新增', 121, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:add', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1142, '分类编辑', 121, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:edit', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1143, '分类删除', 121, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1144, '所有分类', 121, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:listAll', '#', 'admin', '2023-02-24 10:27:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1150, '表单查询', 122, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1151, '表单新增', 122, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:add', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1152, '表单修改', 122, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:edit', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1153, '表单删除', 122, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1154, '表单导出', 122, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:export', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1160, '模型查询', 123, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1161, '模型新增', 123, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:add', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1162, '模型修改', 123, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:edit', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1163, '模型删除', 123, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1164, '模型导出', 123, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:export', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1165, '模型导入', 123, 6, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:import', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1166, '模型设计', 123, 7, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:designer', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1167, '模型保存', 123, 8, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:save', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1168, '流程部署', 123, 9, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:deploy', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1170, '部署查询', 124, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:deploy:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1171, '部署删除', 124, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:deploy:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1172, '更新状态', 124, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:deploy:status', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1180, '发起流程', 125, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:start', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1181, '新建流程导出', 125, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:startExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1190, '流程详情', 126, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1191, '流程删除', 126, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1192, '流程取消', 126, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:cancel', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1193, '我的流程导出', 126, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:ownExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1200, '流程办理', 127, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:approval', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1201, '待办流程导出', 127, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:todoExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1210, '流程签收', 128, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:claim', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1211, '待签流程导出', 128, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:claimExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1220, '流程撤回', 129, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:revoke', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1221, '已办流程导出', 129, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:finishedExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1230, '抄送流程导出', 130, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:copyExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2001, '项目管理', 0, 2, 'pmhub-project', NULL, NULL, 1, 0, 'M', '0', '0', '', 'tab', 'admin', '2022-12-08 09:54:31', 'admin', '2024-03-05 06:02:10', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2002, '我的项目', 2001, 1, 'my-project', 'pmhub-project/my-project', NULL, 1, 1, 'C', '0', '0', 'pmhub-project:my-project', 'list', 'admin', '2022-12-08 09:57:17', 'admin', '2024-03-05 06:02:00', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2003, '我的收藏', 2001, 3, 'my-collection', 'pmhub-project/my-collection', NULL, 1, 1, 'C', '0', '0', 'pmhub-project:my-collection', 'list', 'admin', '2022-12-08 10:01:23', 'admin', '2024-03-05 06:02:30', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2004, '我的任务', 2001, 2, 'my-task', 'pmhub-project/my-task', NULL, 1, 1, 'C', '0', '0', 'pmhub-project:my-task', 'list', 'admin', '2022-12-08 10:02:19', 'admin', '2024-03-05 06:02:23', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2005, '回收站', 2001, 4, 'recycle-bin', 'pmhub-project/recycle-bin', NULL, 1, 1, 'C', '0', '0', 'pmhub-project:recycle-bin', 'list', 'admin', '2022-12-08 10:03:09', 'admin', '2024-03-05 06:02:38', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2006, '库存管理', 0, 4, 'sxsd-storehouse', NULL, NULL, 1, 0, 'M', '1', '1', '', 'tool', 'admin', '2022-12-08 15:00:39', 'admin', '2024-03-05 06:00:26', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2007, '仓库管理', 2006, 1, 'storehouse-manage', 'sxsd-storehouse/storehouse-manage', NULL, 1, 1, 'C', '0', '0', '', 'list', 'admin', '2022-12-08 15:20:00', 'admin', '2022-12-21 11:31:54', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2008, '采购管理', 0, 3, 'sxsd-purchase', NULL, NULL, 1, 0, 'M', '1', '1', '', 'shopping', 'admin', '2022-12-09 15:41:24', 'admin', '2024-03-05 06:00:16', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2009, '物料管理', 0, 5, 'sxsd-materials', NULL, NULL, 1, 0, 'M', '1', '1', '', 'documentation', 'admin', '2022-12-09 15:42:17', 'admin', '2024-03-05 06:00:32', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2010, '供应商管理', 2008, 3, 'supplier-manage', 'sxsd-purchase/provider-manage', NULL, 1, 0, 'C', '0', '0', '', 'list', 'admin', '2022-12-09 16:06:34', 'admin', '2022-12-13 09:10:04', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2011, '供应商详情', 2010, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:query', '#', 'admin', '2022-12-09 16:10:05', 'admin', '2023-01-18 16:45:42', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2012, '仓库新增', 2007, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse-manage:storemanage:add', '#', 'admin', '2022-12-09 17:59:38', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2013, '仓库删除', 2007, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse-manage:storemanage:remove', '#', 'admin', '2022-12-09 18:08:46', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2014, '仓库修改', 2007, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse-manage:storemanage:edit', '#', 'admin', '2022-12-09 18:10:23', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2015, '列表', 2007, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse-manage:storemanage:list', '#', 'admin', '2022-12-09 18:18:50', 'admin', '2022-12-09 18:30:55', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2016, '详情', 2002, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'pmhub-project:my-project:info', '#', 'admin', '2022-12-12 10:33:04', 'admin', '2024-04-03 17:40:11', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2017, '物料类别', 2009, 2, 'materials-sort', 'sxsd-materials/materials-sort', NULL, 1, 0, 'C', '0', '0', '', 'list', 'admin', '2022-12-20 09:13:16', 'admin', '2022-12-21 11:32:17', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2018, '详情', 2004, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-project:my-task:info', '#', 'admin', '2022-12-20 09:42:12', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2019, '采购入库', 2008, 1, 'purchase-inbound', 'sxsd-purchase/purchase-inbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-purchase:purchase-inbound', 'list', 'admin', '2022-12-20 17:30:05', 'admin', '2022-12-20 17:30:38', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2020, '采购退货出库', 2008, 2, 'purchase-return-outbound', 'sxsd-purchase/purchase-return-outbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-purchase:purchase-return-outbound', 'list', 'admin', '2022-12-20 17:31:38', 'admin', '2022-12-20 17:32:00', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2022, '其他入库', 2006, 3, 'other-inbound', 'sxsd-storehouse/other-inbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-storehouse:other-inbound', 'list', 'admin', '2022-12-21 11:55:11', 'admin', '2023-04-11 14:02:01', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2023, '其他出库', 2006, 4, 'other-outbound', 'sxsd-storehouse/other-outbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-storehouse:other-outbound', 'list', 'admin', '2022-12-21 11:55:50', 'admin', '2023-04-11 14:02:06', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2024, '物料明细', 2009, 1, 'materials-details', 'sxsd-materials/materials-details', NULL, 1, 1, 'C', '0', '0', 'sxsd-materials:materials-details', 'list', 'admin', '2022-12-21 13:42:46', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2025, '物料台账', 2009, 3, 'materials-bill', 'sxsd-materials/materials-bill', NULL, 1, 1, 'C', '0', '0', 'sxsd-materials:materials-bill', 'list', 'admin', '2022-12-21 13:43:26', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2028, '文件上传', 2016, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:upload', '#', 'admin', '2023-01-04 17:31:41', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2029, '新增项目', 2002, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:add', '#', 'admin', '2023-01-04 17:49:54', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2030, '首页统计', 2002, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:statistics', '#', 'admin', '2023-01-04 17:50:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2031, '与我有关的项目', 2002, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:select', '#', 'admin', '2023-01-04 17:50:49', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2033, '查询所有项目', 2002, 18, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:queryAllProject', '#', 'admin', '2023-01-04 17:52:38', 'admin', '2023-01-05 14:37:04', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2034, '进行中的项目', 2002, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:doing', '#', 'admin', '2023-01-04 17:53:03', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2035, '首页-我的任务', 2002, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryMyTaskList', '#', 'admin', '2023-01-04 17:55:48', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2036, '项目列表', 2002, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:list', '#', 'admin', '2023-01-04 18:02:59', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2037, '修改项目', 2002, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:edit', '#', 'admin', '2023-01-04 18:03:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2038, '删除项目', 2002, 9, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:delete', '#', 'admin', '2023-01-04 18:03:58', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2039, '项目归档', 2002, 10, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:archive', '#', 'admin', '2023-01-04 18:04:24', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2040, '退出项目', 2002, 11, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:quit', '#', 'admin', '2023-01-04 18:04:44', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2041, '概况-任务每日新增趋势', 2002, 12, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:taskStatisticsByDate', '#', 'admin', '2023-01-04 18:05:03', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2042, '项目详情-任务列表', 2002, 13, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:detail:taskList', '#', 'admin', '2023-01-04 18:05:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2043, '文件上传', 2002, 14, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:upload', '#', 'admin', '2023-01-04 18:08:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2044, '文件列表', 2002, 15, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:queryFileList', '#', 'admin', '2023-01-04 18:08:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2045, '文件重命名', 2002, 16, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:rename', '#', 'admin', '2023-01-04 18:09:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2046, '文件删除', 2002, 17, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:delete', '#', 'admin', '2023-01-04 18:09:34', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2047, '首页-我的任务', 2004, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryMyTaskList', '#', 'admin', '2023-01-05 14:54:23', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2048, '概况-任务概况', 2004, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:situation', '#', 'admin', '2023-01-05 15:31:15', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2049, '删除任务', 2004, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:delete', '#', 'admin', '2023-01-05 15:31:44', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2050, '任务详情', 2004, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:detail', '#', 'admin', '2023-01-05 15:32:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2051, '任务详情-查询执行人', 2004, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryExecutorList', '#', 'admin', '2023-01-05 15:33:07', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2052, '添加任务', 2004, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:add', '#', 'admin', '2023-01-05 15:34:44', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2053, '添加子任务', 2004, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:addChildTask', '#', 'admin', '2023-01-05 15:35:08', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2054, '修改任务', 2004, 9, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:edit', '#', 'admin', '2023-01-05 15:40:33', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2055, '我的任务列表', 2004, 10, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:list', '#', 'admin', '2023-01-05 15:40:56', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2056, '查询子任务', 2004, 11, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryChildTask', '#', 'admin', '2023-01-05 15:44:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2057, '添加评论', 2004, 12, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:addComment', '#', 'admin', '2023-01-05 15:46:02', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2058, '任务动态', 2004, 13, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:logList', '#', 'admin', '2023-01-05 15:46:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2059, '导入任务', 2004, 14, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:import', '#', 'admin', '2023-01-05 15:47:31', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2060, '项目阶段列表', 2002, 19, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:stage:list', '#', 'admin', '2023-01-05 15:53:02', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2061, '添加项目阶段', 2002, 20, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:stage:add', '#', 'admin', '2023-01-05 15:53:33', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2062, '编辑项目阶段', 2002, 21, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:stage:edit', '#', 'admin', '2023-01-05 15:53:56', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2063, '删除项目阶段', 2002, 22, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:stage:delete', '#', 'admin', '2023-01-05 15:54:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2064, '添加成员', 2002, 23, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:inviteMemberList', '#', 'admin', '2023-01-05 15:56:00', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2065, '移除成员', 2002, 24, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:removeMemberList', '#', 'admin', '2023-01-05 15:56:22', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2066, '搜索成员', 2002, 25, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:list', '#', 'admin', '2023-01-05 15:56:39', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2067, '获取用户列表', 2002, 26, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:queryUserList', '#', 'admin', '2023-01-05 15:57:03', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2068, '获取已加入项目成员', 2002, 27, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:queryUserListById', '#', 'admin', '2023-01-05 15:57:37', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2069, '项目动态', 2002, 28, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:log:list', '#', 'admin', '2023-01-05 15:58:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2070, '收藏项目', 2002, 30, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:collect', '#', 'admin', '2023-01-05 15:59:10', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2071, '取消收藏项目', 2002, 31, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:cancelCollect', '#', 'admin', '2023-01-05 15:59:29', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2074, '首页（别删）', 0, 1, '虚拟首页不用配置', NULL, NULL, 1, 0, 'M', '1', '1', '', 'dashboard', 'admin', '2023-01-13 15:33:05', 'admin', '2023-02-23 14:26:08', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2075, '首页统计', 2074, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:statistics', '#', 'admin', '2023-01-13 15:35:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2076, '与我有关的项目', 2074, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:select', '#', 'admin', '2023-01-13 15:35:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2077, '进行中的项目', 2074, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:doing', '#', 'admin', '2023-01-13 15:36:13', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2078, '首页-我的任务列表', 2074, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryMyTaskList', '#', 'admin', '2023-01-13 15:37:15', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2079, '查询', 2024, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:list', '#', 'admin', '2023-01-18 16:35:00', 'admin', '2023-01-18 16:44:41', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2080, '新增', 2024, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:add', '#', 'admin', '2023-01-18 16:37:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2081, '编辑', 2024, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:edit', '#', 'admin', '2023-01-18 16:37:34', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2082, '删除', 2024, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:delete', '#', 'admin', '2023-01-18 16:37:54', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2083, '查询', 2017, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-type:list', '#', 'admin', '2023-01-18 16:42:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2084, '新增', 2017, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-type:add', '#', 'admin', '2023-01-18 16:42:28', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2086, '删除', 2017, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-type:delete', '#', 'admin', '2023-01-18 16:42:59', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2087, '供应商列表', 2010, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:list', '#', 'admin', '2023-01-18 16:44:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2088, '查询', 2025, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-records:list', '#', 'admin', '2023-01-18 16:45:03', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2091, '新增供应商', 2010, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:add', '#', 'admin', '2023-01-18 16:46:05', 'admin', '2023-04-06 14:56:16', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2093, '修改供应商', 2010, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:edit', '#', 'admin', '2023-01-18 16:46:23', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2094, '删除供应商', 2010, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:remove', '#', 'admin', '2023-01-18 16:46:50', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2095, '编辑', 2017, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-type:edit', '#', 'admin', '2023-01-18 16:46:50', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2096, '查询', 2022, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:list', '#', 'admin', '2023-01-18 16:50:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2097, '新增', 2022, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:add', '#', 'admin', '2023-01-18 16:51:08', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2098, '编辑', 2022, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:edit', '#', 'admin', '2023-01-18 16:51:24', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2099, '删除', 2022, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:delete', '#', 'admin', '2023-01-18 16:51:50', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2100, '查询', 2023, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-take-out:list', '#', 'admin', '2023-01-18 16:53:37', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2101, '新增', 2023, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-take-out:add', '#', 'admin', '2023-01-18 16:54:09', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2102, '编辑', 2023, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-take-out:edit', '#', 'admin', '2023-01-18 16:54:49', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2103, '删除', 2023, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-take-out:delete', '#', 'admin', '2023-01-18 16:55:15', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2104, '查询', 2019, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:purchase:list', '#', 'admin', '2023-01-18 16:56:41', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2105, '新增', 2019, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:purchase:add', '#', 'admin', '2023-01-18 16:57:01', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2106, '编辑', 2019, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:purchase:edit', '#', 'admin', '2023-01-18 16:57:19', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2107, '删除', 2019, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:purchase:delete', '#', 'admin', '2023-01-18 16:57:37', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2108, '查询', 2020, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:cancel:list', '#', 'admin', '2023-01-18 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2109, '新增', 2020, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:cancel:add', '#', 'admin', '2023-01-18 16:58:55', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2110, '编辑', 2020, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:cancel:edit', '#', 'admin', '2023-01-18 16:59:11', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2111, '删除', 2020, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:cancel:delete', '#', 'admin', '2023-01-18 16:59:22', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2112, '查询供应商名称', 2010, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:getProviderName', '#', 'admin', '2023-01-18 17:15:43', 'admin', '2023-01-18 17:15:54', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2113, '导出', 2024, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:export', '#', 'admin', '2023-01-18 17:27:39', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2114, '导出', 2025, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-records:export', '#', 'admin', '2023-01-18 17:28:03', 'admin', '2023-01-18 17:28:15', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2115, '项目详情', 2002, 32, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:detail', '#', 'admin', '2023-01-19 10:54:47', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2116, '审批管理（备份）', 0, 6, 'sxsd-approval', NULL, NULL, 1, 0, 'M', '0', '1', '', 'checkbox', 'admin', '2023-02-14 14:34:15', 'admin', '2023-02-23 10:00:13', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2117, '发起申请', 2116, 1, 'send-application', 'sxsd-approval/send-application', NULL, 1, 1, 'C', '0', '0', 'sxsd-approval:send-application', 'list', 'admin', '2023-02-14 14:35:52', 'admin', '2023-02-14 14:41:26', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2118, '我的申请', 2116, 2, 'my-application', 'sxsd-approval/my-application', NULL, 1, 1, 'C', '0', '0', 'sxsd-approval:my-application', 'list', 'admin', '2023-02-14 14:38:24', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2119, '我审批的', 2116, 3, 'I-approve', 'sxsd-approval/I-approve', NULL, 1, 1, 'C', '0', '0', 'sxsd-approval:I-approve', 'list', 'admin', '2023-02-14 14:39:00', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2120, '审批设置', 2116, 4, 'approval-settings', 'sxsd-approval/approval-settings', NULL, 1, 1, 'C', '0', '0', 'sxsd-approval:approval-settings', 'list', 'admin', '2023-02-14 14:39:36', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2122, '审批', 2004, 15, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:process:start', '#', 'admin', '2023-03-13 15:29:47', 'admin', '2023-03-13 15:30:34', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2123, '模板列表', 2004, 16, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:queryFileList', '#', 'admin', '2023-03-13 15:35:38', 'admin', '2023-03-13 15:36:42', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2124, '模板删除', 2004, 17, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:delete', '#', 'admin', '2023-03-13 15:36:09', 'admin', '2023-03-13 15:36:37', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2125, '审批设置', 2004, 19, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:updateApprovalSet', '#', 'admin', '2023-03-13 15:41:26', 'admin', '2023-03-13 15:53:27', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2126, '流程列表', 2004, 18, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:process:startList', '#', 'admin', '2023-03-13 15:53:14', 'admin', '2023-03-13 15:53:35', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2127, '流程分类', 2004, 20, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:category:listAll', '#', 'admin', '2023-03-13 15:53:14', 'admin', '2023-03-13 15:53:35', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2128, '归还入库', 2006, 2, 'return-inbound', 'sxsd-storehouse/return-inbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-storehouse:other-inbound', 'list', 'admin', '2023-04-11 14:01:48', 'admin', '2023-04-11 14:07:46', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2129, '查询', 2128, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:list', '#', 'admin', '2023-04-11 14:03:18', 'admin', '2023-04-11 14:03:58', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2130, '新增', 2128, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:add', '#', 'admin', '2023-04-11 14:03:30', 'admin', '2023-04-11 14:04:04', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2131, '编辑', 2128, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:edit', '#', 'admin', '2023-04-11 14:03:39', 'admin', '2023-04-11 14:04:16', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2132, '删除', 2128, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:delete', '#', 'admin', '2023-04-11 14:03:47', 'admin', '2023-04-11 14:04:23', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2133, '审批设置', 2019, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:inbound:updateApprovalSet', '#', 'admin', '2023-05-05 09:29:33', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2134, '审批设置', 2020, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:outbound:updateApprovalSet', '#', 'admin', '2023-05-05 09:30:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2135, '发起审批', 2019, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:inbound:approve', '#', 'admin', '2023-05-05 09:30:44', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2136, '发起审批', 2020, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:outbound:approve', '#', 'admin', '2023-05-05 09:31:04', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2137, '审批设置', 2128, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:returnInto:updateApprovalSet', '#', 'admin', '2023-05-05 09:32:42', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2138, '审批设置', 2022, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:otherInto:updateApprovalSet', '#', 'admin', '2023-05-05 09:33:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2139, '审批设置', 2023, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:otherOut:updateApprovalSet', '#', 'admin', '2023-05-05 09:33:33', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2140, '发起审批', 2022, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:otherInto:approve', '#', 'admin', '2023-05-05 09:33:55', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2141, '发起审批', 2023, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:otherOut:approve', '#', 'admin', '2023-05-05 09:34:13', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2142, '发起审批', 2128, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:returnInto:approve', '#', 'admin', '2023-05-05 09:34:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2143, '审批设置', 2010, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', '	 sxsd-purchase:providerManage:updateApprovalSet', '#', 'admin', '2023-05-09 14:56:48', 'admin', '2023-05-09 14:57:17', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2144, '发起审批', 2010, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:approval', '#', 'admin', '2023-05-09 15:01:08', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2145, '物料报废', 2009, 4, 'materials-scrap', 'sxsd-materials/materials-scrap', NULL, 1, 1, 'C', '0', '0', 'sxsd-materials:materials-scrap', 'list', 'admin', '2023-07-04 09:16:41', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2146, '审批设置', 2145, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:approvalSet', '#', 'admin', '2023-07-07 14:49:56', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2147, '报废记录列表', 2145, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:uselessList', '#', 'admin', '2023-07-11 15:07:47', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2148, '报废记录审批', 2145, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:approve', '#', 'admin', '2023-07-11 15:08:18', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2149, '处理意见', 2145, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:opinion', '#', 'admin', '2023-07-13 19:48:54', 'admin', '2023-07-13 19:49:08', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2150, '修改责任人', 2145, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:updatePrincipalId', '#', 'zhangsan', '2023-07-13 19:51:12', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2151, '呆滞列表查询', 2145, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:list', '#', 'admin', '2023-07-13 19:53:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2152, '导入', 2025, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-records:import', '#', 'admin', '2023-07-18 16:44:41', 'admin', '2023-07-18 16:45:06', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2153, '导入', 2024, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', '	 materials:materials:import', '#', 'admin', '2023-07-19 15:53:23', 'admin', '2023-07-19 15:53:47', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2154, '流程激活或者挂起', 124, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:deploy:state', '#', 'admin', '2023-07-21 09:51:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2155, '导出记录', 2145, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:export', '#', 'zhangsan', '2023-09-11 11:52:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2156, '供应商类别', 2008, 4, 'provider-sort', 'sxsd-purchase/provider-sort', NULL, 1, 0, 'C', '0', '0', NULL, 'tree', 'admin', '2023-11-16 14:58:15', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2157, '后台任务', 3, 3, 'async', 'tool/async/index', NULL, 1, 0, 'C', '0', '0', '', 'druid', 'admin', '2023-12-22 10:27:41', 'zhangsan', '2023-12-27 16:26:24', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2158, '查询', 2156, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'codeautoflow:common-category:list', '#', 'admin', '2024-01-04 14:02:54', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2159, '新增', 2156, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'codeautoflow:common-category:add', '#', 'admin', '2024-01-04 14:03:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2160, '编辑', 2156, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'codeautoflow:common-category:edit', '#', 'admin', '2024-01-04 14:03:49', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2161, '删除', 2156, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'codeautoflow:common-category:delete', '#', 'admin', '2024-01-04 14:04:13', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2163, '超级网盘', 3, 10, 'https://nextcloud.sxsdetech.com:8083/', NULL, NULL, 0, 0, 'M', '1', '1', '', 'search', 'test_admin', '2024-01-08 10:32:10', 'admin', '2024-03-05 06:00:56', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2164, '工具管理', 3, 5, 'sxsd-tools', 'tool/sxsd-tool/index', NULL, 1, 0, 'C', '1', '1', '', 'tool', 'admin', '2024-01-12 11:17:34', 'admin', '2024-03-05 06:00:47', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2166, '修改', 2164, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:edit', '#', 'admin', '2024-01-15 15:40:23', 'admin', '2024-01-15 15:42:59', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2167, '删除', 2164, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:remove', '#', 'admin', '2024-01-15 15:40:51', 'admin', '2024-01-15 15:43:11', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2168, '新增', 2164, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:add', '#', 'admin', '2024-01-15 15:42:00', 'admin', '2024-01-15 15:42:43', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2169, '列表', 2164, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:list', '#', 'admin', '2024-01-15 15:46:11', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2170, '详情', 2164, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:query', '#', 'admin', '2024-01-15 15:46:37', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
                              `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
                              `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
                              `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
                              `notice_content` longblob COMMENT '公告内容',
                              `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
                              `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '温馨提醒：2018-07-01 pmhub新版本发布啦', '2', 0x3C703E3C696D67207372633D222F6465762D6170692F70726F66696C652F75706C6F61642F323032332F30312F30342F77616C6C686176656E2D7A386D7A6F765F3230323330313034313730333334413030332E706E67223EE696B0E78988E69CACE58685E5AEB93C2F703E, '0', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-04 17:03:37', '管理员');
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '维护通知：2018-07-01 pmhub系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '管理员');
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '你好', '1', 0x3C703E3C696D67207372633D222F73746167652D6170692F70726F66696C652F75706C6F61642F323032332F30312F30342F346538643135666638616163623166666235316138653730356130346661665F3230323330313034313730333338413030312E6A7067223E3C2F703E, '0', 'admin', '2023-01-04 17:04:00', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
                                `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                `title` varchar(50) DEFAULT '' COMMENT '模块标题',
                                `business_type` int(11) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
                                `method` varchar(100) DEFAULT '' COMMENT '方法名称',
                                `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
                                `operator_type` int(11) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
                                `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
                                `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
                                `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
                                `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
                                `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
                                `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
                                `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
                                `status` int(11) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
                                `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
                                `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
                                PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13237 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';



-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
                            `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
                            `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
                            `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
                            `post_sort` int(11) NOT NULL COMMENT '显示顺序',
                            `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`post_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
                            `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                            `role_name` varchar(30) NOT NULL COMMENT '角色名称',
                            `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
                            `role_sort` int(11) NOT NULL COMMENT '显示顺序',
                            `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
                            `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
                            `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
                            `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '超级管理员');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2023-07-31 11:24:35', '普通角色');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, 'qyh', 'aaa', 3, '1', 1, 1, '0', '2', 'admin', '2022-12-13 10:46:36', 'admin', '2023-01-04 17:56:09', 'test2');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '测试角色', 'testRole', 4, '1', 1, 1, '0', '2', 'admin', '2023-01-04 17:35:10', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '项目经理', 'xiangmujingli', 4, '1', 1, 1, '0', '0', 'admin', '2023-01-13 11:28:31', 'admin', '2023-04-12 11:54:19', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '供应链', 'gongyinglian', 5, '1', 1, 1, '0', '0', 'admin', '2023-01-13 11:51:44', 'admin', '2023-01-19 10:38:47', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '仓库管理员', 'cangkuguanliyuan', 6, '1', 1, 1, '0', '0', 'admin', '2023-01-13 13:43:37', 'admin', '2023-07-06 18:12:51', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '测试首页', 'index', 0, '1', 1, 1, '0', '2', 'admin', '2023-01-13 15:37:57', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '部门负责人', 'bumenfuzeren', 7, '1', 1, 1, '0', '0', 'admin', '2023-01-19 11:07:43', 'lala', '2023-07-31 14:25:47', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '测试审批', 'flowable', 0, '1', 1, 1, '0', '0', 'admin', '2023-02-24 10:00:32', 'admin', '2023-07-20 09:33:24', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '测试首页', 'test_index', 0, '1', 1, 1, '0', '2', 'admin', '2023-03-13 15:21:30', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '测试管理员', 'test_admin', 0, '1', 1, 1, '0', '0', 'admin', '2023-03-22 11:02:18', 'admin', '2024-01-15 15:50:04', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '菜单按钮权限测试', 'caidananniu', 0, '1', 1, 1, '0', '0', 'zy', '2023-05-04 14:47:38', 'zy', '2023-05-04 15:00:58', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '敏感信息查看工程师', 'CLASSIFIED_INQUIRER', 10, '1', 0, 0, '0', '0', 'admin', '2023-07-18 11:51:56', 'admin', '2023-12-22 16:07:51', '拥有此权限可以查看敏感信息');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '权限刷新角色', '666', 0, '1', 0, 0, '0', '2', 'admin', '2023-07-31 11:25:09', 'admin', '2023-07-31 11:37:09', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '不敏感信息查看工程师', 'CLASSIFIED_INQUIRER1', 0, '1', 1, 1, '0', '2', 'zy', '2023-08-02 16:42:01', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '体验角色', 'tiyanjuese', 0, '1', 1, 1, '0', '0', 'admin', '2024-04-03 17:38:44', 'admin', '2024-04-03 17:41:28', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
                                 PRIMARY KEY (`role_id`,`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 100);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 101);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 105);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
                                 PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2063);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2065);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 121);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1162);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1163);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1165);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1171);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1172);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1180);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1191);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1192);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1193);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1210);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1211);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1220);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1221);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1230);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2063);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2065);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2118);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2119);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2120);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2091);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2093);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2094);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2082);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2091);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2093);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2094);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2096);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2097);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2098);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2099);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2131);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2132);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2082);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2096);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2097);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2098);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2099);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2131);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2132);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2146);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2147);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2148);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2149);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 121);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1162);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1163);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1165);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1171);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1172);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1180);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1191);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1192);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1193);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1210);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1211);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1220);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1221);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1230);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2063);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2065);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2082);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2091);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2093);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2094);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2096);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2097);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2098);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2099);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2118);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2119);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2120);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2131);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2132);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2133);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2134);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2135);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2136);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2137);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2138);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2139);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 121);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1162);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1163);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1165);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1171);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1172);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1180);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1191);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1192);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1193);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1210);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1211);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1220);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1221);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1230);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2063);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2065);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2082);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2091);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2093);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2094);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2096);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2097);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2098);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2099);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2118);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2119);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2120);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2131);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2132);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2133);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2134);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2135);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2136);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2137);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2138);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2139);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2146);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2147);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2148);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2149);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2155);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2156);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2157);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2158);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2159);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2163);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2169);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (111, 2157);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 121);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1165);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1180);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1192);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1193);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1210);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1211);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1220);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1221);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1230);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2154);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
                            `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                            `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
                            `leader_id` varchar(200) DEFAULT NULL COMMENT '直属上级id',
                            `user_name` varchar(30) NOT NULL COMMENT '用户账号',
                            `user_wx_name` varchar(64) DEFAULT NULL COMMENT '企微用户id',
                            `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
                            `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
                            `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
                            `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
                            `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
                            `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
                            `password` varchar(100) DEFAULT '' COMMENT '密码',
                            `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
                            `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`user_id`) USING BTREE,
                            UNIQUE KEY `sys_user_pk` (`user_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 100, NULL, 'admin', NULL, '超级管理员', '00', 'admin@163.com', '13928442309', '0', '', '$2a$10$l4yTu8mRkOs9uHn54wZ5Zu3eQeghcTJQfQWa8uTF0kUMO7AmTkKkm', '0', '0', '183.69.244.46', '2024-05-22 17:04:57', 'admin', '2022-12-06 17:32:35', '', '2024-05-22 09:04:57', '管理员');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, 106, '134', 'py', 'feiji', '飞机', '00', '', '', '0', '', '$2a$10$wt/Kn5ZY3QygH98b6hOXw.A3GZ/nLNkP.zrmCylj4P1SAXGGWptBi', '0', '0', '10.0.2.100', '2023-10-11 14:39:48', 'admin', '2022-12-07 16:18:42', 'admin', '2024-03-05 06:51:05', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, 106, '132,129', 'lisi', 'pingguo', '苹果', '00', '3333333@qq.com', '13333333333', '0', '/profile/avatar/2023/01/09/blob_20230109105500A001.png', '$2a$10$2Cp0h9DX4lK0KtdLgHPeVOlvdEwMTvldvDtddzHpSrfmC8YVr/y96', '0', '0', '183.69.244.46', '2023-11-02 15:03:09', 'admin', '2022-12-09 16:51:26', 'admin', '2024-03-05 06:52:42', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, 103, '1', 'wap', NULL, 'dangao', '00', '', '', '0', '', '$2a$10$Xu0mzWNl7D7Bp0xksOoihuAwrP/bqUh1Cz6ncECJYigvo1KBYbQdC', '0', '0', '', NULL, 'admin', '2023-01-19 11:12:22', 'admin', '2024-03-05 06:52:57', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (129, 106, '1', 'zhangsan', 'mianbao', '面包', '00', '213asd@21slc.wecom.work', '17623522326', '0', '/profile/avatar/2023/02/17/e75ab488cbf84d27a7995aa042a69646_20230217165807A004.png', '$2a$10$is8ty9QeIzL6VTQhq6sfaO/FLq8j87yZpZlQnPYBJd8lK.yN0Qm86', '0', '0', '183.69.244.46', '2024-01-22 19:29:29', '企业微信', '2023-02-17 16:58:07', 'admin', '2024-03-05 06:53:25', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (132, 106, '137,132,101', 'hxq', '02a686311a6bd3ea6c7f5d17dec9c5e4', '手机', '00', '', '', '0', '/profile/avatar/2023/04/11/blob_20230411164456A001.png', '$2a$10$j.ft.Ec3.SkrQTXLeugf6ew/RvO0zAd/UhSeGHv26/ciGVZ4a5JTm', '0', '0', '183.69.244.46', '2024-02-28 10:05:55', 'admin', '2023-03-08 15:22:49', 'admin', '2024-03-05 06:53:36', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (134, 106, '1', 'canghe', 'CangHe', '苍何', '00', '268231256@qq.com', '18212382341', '0', '', '$2a$10$L7rDjeeLezuwD9vdryb3UuuyrAbXjG4MQCugRfIxnwP2EHiY3I1Cy', '0', '0', '183.69.244.46', '2024-01-10 23:01:04', 'admin', '2023-03-13 15:05:06', 'admin', '2024-03-05 06:51:27', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (136, 214, '1', 'dxj2', NULL, '苹果2', '00', '', '', '0', '', '$2a$10$7uL1kpsZKiIMZ9zYwZYBUOPY.reGirTPMIibxSprCUpbUNtvr.MiC', '0', '0', '10.0.2.100', '2023-04-19 09:34:44', 'admin', '2023-03-13 15:17:36', 'admin', '2024-03-05 06:53:46', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (137, 106, '153,132', 'zy', 'BieGuanDongQiQuNanRen', '眼镜', '00', 'bieguandongqiqunanren@sadac.wecom.work', '13981912601', '0', '/profile/avatar/2023/03/22/d376f443d4d54e4aaa4943f2945ec627_20230322105927A002.png', '$2a$10$X90nnF8G0H1CWfKqF51XHOy8UvYkHszfb5bFr1JcUlS.RkF3b9HNC', '0', '0', '183.69.244.46', '2024-01-22 19:06:34', '企业微信', '2023-03-22 10:59:27', 'admin', '2024-03-05 06:54:11', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (139, 100, '1', 'test_admin', NULL, '测试管理员', '00', '', '', '0', '', '$2a$10$DbHx3pcHI9m3maNsHkfBCexF9wStdkVUDMRUmfqtDXBDCCY3Ewhg2', '0', '0', '127.0.0.1', '2024-01-08 10:34:37', 'BieGuanDongQiQuNanRen', '2023-03-22 11:16:22', 'zy', '2024-01-08 10:34:38', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (140, 214, '1', 'maie', 'maie', '电脑', '00', 'maie@joinv.cn', '15921278507', '0', '/profile/avatar/2023/04/06/e6416faf1e6f44829b49e198c9c2d499_20230406143653A001.png', '$2a$10$uYzuIaZFBXRthZBftcZeruFNwUU5vpQWK/MOMbC3j/mlBl6.f5B/2', '0', '0', '192.168.40.34', '2023-08-04 15:45:13', '企业微信', '2023-04-06 14:36:53', 'admin', '2024-03-05 06:54:25', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (141, 214, '1', 'dxj3', NULL, 'dxj3', '00', '', '', '0', '', '$2a$10$Nh9TeJdcS6uNGxvQMvz6mO/ulFFvCxF9HUGMmjIcUoiEXa1SVjFUG', '0', '0', '', NULL, 'dxj', '2023-04-21 16:16:09', '', NULL, NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (142, 214, '1', 'dxj4', NULL, 'dxj4', '00', '', '', '0', '', '$2a$10$MsYJi8bLYe5i3LVcAMqsqOSlyadbErRRmdIxXKyZAYY11iUdiky5e', '0', '0', '', NULL, 'admin', '2023-04-21 16:21:33', 'admin', '2023-04-21 16:25:19', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (143, 214, '100', 'sjcs', NULL, '上级测试', '00', '', '', '0', '', '$2a$10$JiYqXvGnEyewJiR7WFqOkeS5IHAPNOsUqwA2pvCwe6/H6ROJ3A5PG', '0', '0', '', NULL, 'admin', '2023-04-24 14:14:04', 'admin', '2023-04-24 14:15:07', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (144, NULL, '1', '123', NULL, '13321', '00', '', '', '0', '', '$2a$10$9km6vNJ9qzwQ3F.tv7oLvudyPwlSLE3CUPQwPVWbSeJ9g9jF.Uwbq', '0', '0', '', NULL, 'test_admin', '2023-04-24 17:03:10', '', NULL, NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (147, 214, NULL, 'dxj5', NULL, 'dxj5', '00', '', '', '0', '', '$2a$10$wAKm5icsF/NBUYTeP0SNnuOZT99/SYCdg0qJ2nk7mfiqmgGssZJu2', '0', '0', '', NULL, 'dxj', '2023-04-26 09:28:16', 'zy', '2023-04-27 13:59:11', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (150, NULL, '101', 'dxj7', NULL, 'dxj7', '00', '', '', '0', '', '$2a$10$ZQQKAtThDWXLSXZKT/UAFu4.PuL1wOLBeOHpykfmw0sffuD11OuCy', '0', '0', '', NULL, 'admin', '2023-04-27 10:58:21', 'dxj', '2023-04-27 14:31:58', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (151, 214, '137', 'test', NULL, 'test', '00', '', '', '1', '/profile/avatar/2023/04/28/blob_20230428101834A001.png', '$2a$10$yxgpm/ld1djz1qwmrdTbqOJGD5Zo4iU0/T5EQzxLMjH1XNKDu4dX.', '0', '0', '183.69.244.46', '2023-09-28 18:04:39', 'hxq', '2023-04-27 11:00:02', 'zy', '2023-09-28 18:04:38', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (153, 106, NULL, 'lala', 'erji', '耳机', '00', 'noname@joinv.cn', '15071219112', '0', '/profile/avatar/2023/07/06/4d71becafc094639bcde2a66d7a81005_20230706185253A001.png', '$2a$10$ta5s/Iy/3vEQezhsa7EXleRcSFrgR3qhY4X8kHkQ4Cg3sNdDIvIFe', '0', '0', '183.69.244.46', '2024-02-27 15:57:18', '企业微信', '2023-07-06 18:52:53', 'admin', '2024-03-05 06:55:04', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (154, NULL, NULL, 'test2', NULL, 'test2', '00', '', '', '0', '', '$2a$10$P4pImPNSAP9RVuEaWK1OoeOVFwZY9l0rcdkbMkhQqoO55rmbpGnVS', '0', '0', '120.11.22.3', '2023-08-13 12:01:34', 'admin', '2023-07-07 17:38:55', '', '2023-08-13 12:01:33', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (155, 106, NULL, 'qyh', NULL, 'qyh', '00', '', '', '0', '', '$2a$10$wCLOCpE9v.hMYhyLKODK8Ok.FTPAeAibMbXgW2Xjvqljq7R8Y.mHa', '0', '0', '127.0.0.1', '2024-01-22 18:40:09', 'test_admin', '2023-07-11 15:17:59', 'zhangsan', '2024-01-22 18:40:09', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (156, 100, NULL, 'NPC', NULL, '呆滞物料自动报废', '00', '', '', '0', '', '$2a$10$LhQuRKoCs.dkOK.G/SAmnuvob9g.eTgFHsztNHsMQPy8U2VqmMXjG', '0', '0', '', NULL, 'zhangsan', '2023-07-24 14:27:21', 'zy', '2023-07-24 15:06:05', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (167, NULL, NULL, 'zhaosi', NULL, '2123', '00', '', '15927721027', '0', '', '$2a$10$BjS1tnsQ1t7CRZ8s32gFOurOorNjhQxWSu1IPrrTEzumTSCZCOBea', '0', '0', '', NULL, '泛微', '2023-09-26 16:12:23', 'admin', '2024-03-05 06:55:21', '泛微快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (173, 100, NULL, 'laige', NULL, '体验账号', '00', '', '', '0', '', '$2a$10$ekjnC2vdG8YjfvFgkY4HMu1Pu7IiRhFV/MlPVXxjhgc.taq694.C2', '0', '0', '39.144.92.214', '2024-05-25 15:29:39', 'admin', '2024-04-03 17:34:32', 'admin', '2024-05-25 07:29:39', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
                                 `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                 `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
                                 PRIMARY KEY (`user_id`,`post_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (137, 1);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (137, 2);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (137, 3);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (137, 4);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (140, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
                                 `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (100, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (100, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (101, 107);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (101, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (101, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (129, 107);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (129, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (129, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (132, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (134, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (136, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (137, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (137, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (139, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (140, 107);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (140, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (140, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (143, 107);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (151, 110);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (153, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (153, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (155, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (173, 114);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;


 Date: 31/05/2024 16:08:12
*/

CREATE DATABASE  `laigeoffer-pmhub` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;



SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `laigeoffer-pmhub`;

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log` (
                               `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
                               `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                               `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DATA_` longblob,
                               `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `IS_PROCESSED_` tinyint(4) DEFAULT '0',
                               PRIMARY KEY (`LOG_NR_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_evt_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `BYTES_` longblob,
                                    `GENERATED_` tinyint(4) DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------
BEGIN;
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('f7cf0e4e-18af-11ef-bdc0-0242ac110002', 1, 'source', NULL, 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220786D6C6E733A62706D6E323D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A64633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22313233343536222069643D226469616772616D5F50726F636573735F3137313634333239343734343022207873693A736368656D614C6F636174696F6E3D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2042504D4E32302E787364223E0A20203C70726F636573732069643D2250726F636573735F3137313634333239343734343022206E616D653D22E4B89AE58AA1E6B581E7A88B5F313731363433323934373434302220697345786563757461626C653D2274727565223E0A202020203C73746172744576656E742069643D2273746172745F6576656E74223E3C2F73746172744576656E743E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F50726F636573735F31373136343332393437343430223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D2250726F636573735F31373136343332393437343430222069643D2242504D4E506C616E655F50726F636573735F31373136343332393437343430223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2273746172745F6576656E74222069643D2242504D4E53686170655F73746172745F6576656E74223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223630322E302220793D223131322E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property` (
                                   `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
BEGIN;
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('batch.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('common.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('entitylink.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('eventsubscription.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('identitylink.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('job.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('next.dbid', '1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.history', 'create(6.7.2.0)', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('task.schema.version', '6.7.2.0', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('variable.schema.version', '6.7.2.0', 1);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `START_TIME_` datetime(3) NOT NULL,
                                  `END_TIME_` datetime(3) DEFAULT NULL,
                                  `TRANSACTION_ORDER_` int(11) DEFAULT NULL,
                                  `DURATION_` bigint(20) DEFAULT NULL,
                                  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`) USING BTREE,
                                  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`) USING BTREE,
                                  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                     `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                     `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TIME_` datetime(3) DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TIME_` datetime(3) NOT NULL,
                                  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `FULL_MSG_` longblob,
                                  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail` (
                                 `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                 `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                 `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                 `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                 `REV_` int(11) DEFAULT NULL,
                                 `TIME_` datetime(3) NOT NULL,
                                 `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                 `DOUBLE_` double DEFAULT NULL,
                                 `LONG_` bigint(20) DEFAULT NULL,
                                 `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                 `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                 PRIMARY KEY (`ID_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`) USING BTREE,
                                 KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_entitylink`;
CREATE TABLE `act_hi_entitylink` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     KEY `ACT_IDX_HI_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_HI_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_HI_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_HI_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_entitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`) USING BTREE,
                                       KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT '1',
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `END_TIME_` datetime(3) DEFAULT NULL,
                                   `DURATION_` bigint(20) DEFAULT NULL,
                                   `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                   `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `REFERENCE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `REFERENCE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `BUSINESS_STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`) USING BTREE,
                                   KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`) USING BTREE,
                                   KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT '1',
                                   `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `START_TIME_` datetime(3) NOT NULL,
                                   `CLAIM_TIME_` datetime(3) DEFAULT NULL,
                                   `END_TIME_` datetime(3) DEFAULT NULL,
                                   `DURATION_` bigint(20) DEFAULT NULL,
                                   `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `PRIORITY_` int(11) DEFAULT NULL,
                                   `DUE_DATE_` datetime(3) DEFAULT NULL,
                                   `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                   `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   KEY `ACT_IDX_HI_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_IDX_HI_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_IDX_HI_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_tsk_log
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_tsk_log`;
CREATE TABLE `act_hi_tsk_log` (
                                  `ID_` bigint(20) NOT NULL AUTO_INCREMENT,
                                  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
                                  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `DATA_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_tsk_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DOUBLE_` double DEFAULT NULL,
                                  `LONG_` bigint(20) DEFAULT NULL,
                                  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`) USING BTREE,
                                  KEY `ACT_IDX_HI_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                  KEY `ACT_IDX_HI_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`) USING BTREE,
                                  KEY `ACT_IDX_HI_PROCVAR_EXE` (`EXECUTION_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_id_bytearray`;
CREATE TABLE `act_id_bytearray` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `BYTES_` longblob,
                                    PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_bytearray
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_priv
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv`;
CREATE TABLE `act_id_priv` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                               PRIMARY KEY (`ID_`) USING BTREE,
                               UNIQUE KEY `ACT_UNIQ_PRIV_NAME` (`NAME_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_priv
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_priv_mapping
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv_mapping`;
CREATE TABLE `act_id_priv_mapping` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `PRIV_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_FK_PRIV_MAPPING` (`PRIV_ID_`) USING BTREE,
                                       KEY `ACT_IDX_PRIV_USER` (`USER_ID_`) USING BTREE,
                                       KEY `ACT_IDX_PRIV_GROUP` (`GROUP_ID_`) USING BTREE,
                                       CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_priv_mapping
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_property
-- ----------------------------
DROP TABLE IF EXISTS `act_id_property`;
CREATE TABLE `act_id_property` (
                                   `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   PRIMARY KEY (`NAME_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_property
-- ----------------------------
BEGIN;
INSERT INTO `act_id_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.7.2.0', 1);
COMMIT;

-- ----------------------------
-- Table structure for act_id_token
-- ----------------------------
DROP TABLE IF EXISTS `act_id_token`;
CREATE TABLE `act_id_token` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `TOKEN_VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TOKEN_DATE_` timestamp(3) NULL DEFAULT NULL,
                                `IP_ADDRESS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `USER_AGENT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `TOKEN_DATA_` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
                                PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
                                    KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
                                    KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_procdef_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                     `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
                                     `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_DEPLOYMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                `VERSION_` int(11) DEFAULT NULL,
                                `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                PRIMARY KEY (`ID_`) USING BTREE,
                                KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`) USING BTREE,
                                KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) USING BTREE,
                                KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`) USING BTREE,
                                CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
                                CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------
BEGIN;
INSERT INTO `act_re_model` (`ID_`, `REV_`, `NAME_`, `KEY_`, `CATEGORY_`, `CREATE_TIME_`, `LAST_UPDATE_TIME_`, `VERSION_`, `META_INFO_`, `DEPLOYMENT_ID_`, `EDITOR_SOURCE_VALUE_ID_`, `EDITOR_SOURCE_EXTRA_VALUE_ID_`, `TENANT_ID_`) VALUES ('f7ba4dcd-18af-11ef-bdc0-0242ac110002', 2, '业务流程_1716432947440', 'Process_1716432947440', '123456', '2024-05-23 10:55:52.630', '2024-05-23 10:55:52.767', 1, '{\"createUser\":\"laige\",\"description\":null,\"formType\":null,\"formId\":null}', NULL, 'f7cf0e4e-18af-11ef-bdc0-0242ac110002', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT NULL,
                                  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `VERSION_` int(11) NOT NULL,
                                  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
                                  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
                                  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `DERIVED_VERSION_` int(11) NOT NULL DEFAULT '0',
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`DERIVED_VERSION_`,`TENANT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_actinst`;
CREATE TABLE `act_ru_actinst` (
                                  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `REV_` int(11) DEFAULT '1',
                                  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                  `START_TIME_` datetime(3) NOT NULL,
                                  `END_TIME_` datetime(3) DEFAULT NULL,
                                  `DURATION_` bigint(20) DEFAULT NULL,
                                  `TRANSACTION_ORDER_` int(11) DEFAULT NULL,
                                  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                  PRIMARY KEY (`ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_START` (`START_TIME_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_END` (`END_TIME_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_PROC` (`PROC_INST_ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_PROC_ACT` (`PROC_INST_ID_`,`ACT_ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_EXEC` (`EXECUTION_ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_EXEC_ACT` (`EXECUTION_ID_`,`ACT_ID_`) USING BTREE,
                                  KEY `ACT_IDX_RU_ACTI_TASK` (`TASK_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_actinst
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_deadletter_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_deadletter_job`;
CREATE TABLE `act_ru_deadletter_job` (
                                         `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                         `REV_` int(11) DEFAULT NULL,
                                         `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                         `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                         `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                         `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                         `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                         `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                         `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                         `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                         `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                         PRIMARY KEY (`ID_`) USING BTREE,
                                         KEY `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                                         KEY `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                                         KEY `ACT_IDX_DEADLETTER_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                                         KEY `ACT_IDX_DJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                         KEY `ACT_IDX_DJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                         KEY `ACT_IDX_DJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                         KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`) USING BTREE,
                                         KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`) USING BTREE,
                                         KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`) USING BTREE,
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                         CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_deadletter_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_entitylink`;
CREATE TABLE `act_ru_entitylink` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                     `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `PARENT_ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `ROOT_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     KEY `ACT_IDX_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_ENT_LNK_REF_SCOPE` (`REF_SCOPE_ID_`,`REF_SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_ENT_LNK_ROOT_SCOPE` (`ROOT_SCOPE_ID_`,`ROOT_SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE,
                                     KEY `ACT_IDX_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_entitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                       `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`) USING BTREE,
                                       KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`) USING BTREE,
                                       CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
                                    `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
                                    `IS_SCOPE_` tinyint(4) DEFAULT NULL,
                                    `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
                                    `IS_MI_ROOT_` tinyint(4) DEFAULT NULL,
                                    `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                                    `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                    `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `START_TIME_` datetime(3) DEFAULT NULL,
                                    `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
                                    `EVT_SUBSCR_COUNT_` int(11) DEFAULT NULL,
                                    `TASK_COUNT_` int(11) DEFAULT NULL,
                                    `JOB_COUNT_` int(11) DEFAULT NULL,
                                    `TIMER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `SUSP_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `DEADLETTER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `EXTERNAL_WORKER_JOB_COUNT_` int(11) DEFAULT NULL,
                                    `VAR_COUNT_` int(11) DEFAULT NULL,
                                    `ID_LINK_COUNT_` int(11) DEFAULT NULL,
                                    `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `REFERENCE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `REFERENCE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `BUSINESS_STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`) USING BTREE,
                                    KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`) USING BTREE,
                                    KEY `ACT_IDX_EXEC_REF_ID_` (`REFERENCE_ID_`) USING BTREE,
                                    KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`) USING BTREE,
                                    KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`) USING BTREE,
                                    KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`) USING BTREE,
                                    KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE,
                                    CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                    CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
                                    CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_external_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_external_job`;
CREATE TABLE `act_ru_external_job` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                       `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                       `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `RETRIES_` int(11) DEFAULT NULL,
                                       `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                       `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                       `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                       `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                       `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_IDX_EXTERNAL_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                                       KEY `ACT_IDX_EXTERNAL_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                                       KEY `ACT_IDX_EXTERNAL_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                                       KEY `ACT_IDX_EJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_EJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_EJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       CONSTRAINT `ACT_FK_EXTERNAL_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                       CONSTRAINT `ACT_FK_EXTERNAL_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_external_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_history_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_history_job`;
CREATE TABLE `act_ru_history_job` (
                                      `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                      `REV_` int(11) DEFAULT NULL,
                                      `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `RETRIES_` int(11) DEFAULT NULL,
                                      `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                      `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                      `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `ADV_HANDLER_CFG_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                      `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                      `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                      `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                      PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_history_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink` (
                                       `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                       `REV_` int(11) DEFAULT NULL,
                                       `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                       PRIMARY KEY (`ID_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                       KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`) USING BTREE,
                                       KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`) USING BTREE,
                                       KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`) USING BTREE,
                                       CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                                       CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                       CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job` (
                              `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                              `REV_` int(11) DEFAULT NULL,
                              `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                              `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                              `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                              `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `RETRIES_` int(11) DEFAULT NULL,
                              `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                              `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                              `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                              `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                              `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                              `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                              `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                              PRIMARY KEY (`ID_`) USING BTREE,
                              KEY `ACT_IDX_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                              KEY `ACT_IDX_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                              KEY `ACT_IDX_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                              KEY `ACT_IDX_JOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                              KEY `ACT_IDX_JOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                              KEY `ACT_IDX_JOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                              KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`) USING BTREE,
                              KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`) USING BTREE,
                              KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`) USING BTREE,
                              CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                              CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_suspended_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_suspended_job`;
CREATE TABLE `act_ru_suspended_job` (
                                        `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                        `REV_` int(11) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                        `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                        `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `RETRIES_` int(11) DEFAULT NULL,
                                        `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                        `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                        `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                        `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                        `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                        `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        KEY `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                                        KEY `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                                        KEY `ACT_IDX_SUSPENDED_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                                        KEY `ACT_IDX_SJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                        KEY `ACT_IDX_SJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                        KEY `ACT_IDX_SJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                        KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`) USING BTREE,
                                        KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`) USING BTREE,
                                        KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`) USING BTREE,
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                        CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_suspended_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task` (
                               `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                               `REV_` int(11) DEFAULT NULL,
                               `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PROPAGATED_STAGE_INST_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                               `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                               `PRIORITY_` int(11) DEFAULT NULL,
                               `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                               `DUE_DATE_` datetime(3) DEFAULT NULL,
                               `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `SUSPENSION_STATE_` int(11) DEFAULT NULL,
                               `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                               `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                               `CLAIM_TIME_` datetime(3) DEFAULT NULL,
                               `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
                               `VAR_COUNT_` int(11) DEFAULT NULL,
                               `ID_LINK_COUNT_` int(11) DEFAULT NULL,
                               `SUB_TASK_COUNT_` int(11) DEFAULT NULL,
                               PRIMARY KEY (`ID_`) USING BTREE,
                               KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`) USING BTREE,
                               KEY `ACT_IDX_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                               KEY `ACT_IDX_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                               KEY `ACT_IDX_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                               KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`) USING BTREE,
                               KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`) USING BTREE,
                               KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`) USING BTREE,
                               CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                               CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
                               CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_timer_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_timer_job`;
CREATE TABLE `act_ru_timer_job` (
                                    `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                    `REV_` int(11) DEFAULT NULL,
                                    `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                    `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
                                    `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `CORRELATION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `RETRIES_` int(11) DEFAULT NULL,
                                    `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                    `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
                                    `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                    `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                    `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                    `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
                                    `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                    PRIMARY KEY (`ID_`) USING BTREE,
                                    KEY `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`) USING BTREE,
                                    KEY `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`) USING BTREE,
                                    KEY `ACT_IDX_TIMER_JOB_CORRELATION_ID` (`CORRELATION_ID_`) USING BTREE,
                                    KEY `ACT_IDX_TIMER_JOB_DUEDATE` (`DUEDATE_`) USING BTREE,
                                    KEY `ACT_IDX_TJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                    KEY `ACT_IDX_TJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                    KEY `ACT_IDX_TJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                    KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`) USING BTREE,
                                    KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`) USING BTREE,
                                    KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`) USING BTREE,
                                    CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                    CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_timer_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable` (
                                   `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                   `REV_` int(11) DEFAULT NULL,
                                   `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
                                   `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
                                   `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                   `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                   `DOUBLE_` double DEFAULT NULL,
                                   `LONG_` bigint(20) DEFAULT NULL,
                                   `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
                                   PRIMARY KEY (`ID_`) USING BTREE,
                                   KEY `ACT_IDX_RU_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_IDX_RU_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`) USING BTREE,
                                   KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`) USING BTREE,
                                   KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`) USING BTREE,
                                   KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`) USING BTREE,
                                   KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`) USING BTREE,
                                   CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
                                   CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
                                   CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_channel_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_channel_definition`;
CREATE TABLE `flw_channel_definition` (
                                          `ID_` varchar(255) NOT NULL,
                                          `NAME_` varchar(255) DEFAULT NULL,
                                          `VERSION_` int(11) DEFAULT NULL,
                                          `KEY_` varchar(255) DEFAULT NULL,
                                          `CATEGORY_` varchar(255) DEFAULT NULL,
                                          `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                          `CREATE_TIME_` datetime(3) DEFAULT NULL,
                                          `TENANT_ID_` varchar(255) DEFAULT NULL,
                                          `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                          `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                          `TYPE_` varchar(255) DEFAULT NULL,
                                          `IMPLEMENTATION_` varchar(255) DEFAULT NULL,
                                          PRIMARY KEY (`ID_`) USING BTREE,
                                          UNIQUE KEY `ACT_IDX_CHANNEL_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_channel_definition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ev_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangelog`;
CREATE TABLE `flw_ev_databasechangelog` (
                                            `ID` varchar(255) NOT NULL,
                                            `AUTHOR` varchar(255) NOT NULL,
                                            `FILENAME` varchar(255) NOT NULL,
                                            `DATEEXECUTED` datetime NOT NULL,
                                            `ORDEREXECUTED` int(11) NOT NULL,
                                            `EXECTYPE` varchar(10) NOT NULL,
                                            `MD5SUM` varchar(35) DEFAULT NULL,
                                            `DESCRIPTION` varchar(255) DEFAULT NULL,
                                            `COMMENTS` varchar(255) DEFAULT NULL,
                                            `TAG` varchar(255) DEFAULT NULL,
                                            `LIQUIBASE` varchar(20) DEFAULT NULL,
                                            `CONTEXTS` varchar(255) DEFAULT NULL,
                                            `LABELS` varchar(255) DEFAULT NULL,
                                            `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_ev_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda', 'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('2', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 2, 'EXECUTED', '8:0ea825feb8e470558f0b5754352b9cda', 'addColumn tableName=FLW_CHANNEL_DEFINITION; addColumn tableName=FLW_CHANNEL_DEFINITION', '', NULL, '4.3.5', NULL, NULL, '8259922348');
INSERT INTO `flw_ev_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-08 15:18:42', 3, 'EXECUTED', '8:3c2bb293350b5cbe6504331980c9dcee', 'customChange', '', NULL, '4.3.5', NULL, NULL, '8259922348');
COMMIT;

-- ----------------------------
-- Table structure for flw_ev_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `flw_ev_databasechangeloglock`;
CREATE TABLE `flw_ev_databasechangeloglock` (
                                                `ID` int(11) NOT NULL,
                                                `LOCKED` bit(1) NOT NULL,
                                                `LOCKGRANTED` datetime DEFAULT NULL,
                                                `LOCKEDBY` varchar(255) DEFAULT NULL,
                                                PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_ev_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `flw_ev_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for flw_event_definition
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_definition`;
CREATE TABLE `flw_event_definition` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `VERSION_` int(11) DEFAULT NULL,
                                        `KEY_` varchar(255) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) DEFAULT NULL,
                                        `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `RESOURCE_NAME_` varchar(255) DEFAULT NULL,
                                        `DESCRIPTION_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`) USING BTREE,
                                        UNIQUE KEY `ACT_IDX_EVENT_DEF_UNIQ` (`KEY_`,`VERSION_`,`TENANT_ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_event_definition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_event_deployment
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_deployment`;
CREATE TABLE `flw_event_deployment` (
                                        `ID_` varchar(255) NOT NULL,
                                        `NAME_` varchar(255) DEFAULT NULL,
                                        `CATEGORY_` varchar(255) DEFAULT NULL,
                                        `DEPLOY_TIME_` datetime(3) DEFAULT NULL,
                                        `TENANT_ID_` varchar(255) DEFAULT NULL,
                                        `PARENT_DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                        PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_event_deployment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_event_resource
-- ----------------------------
DROP TABLE IF EXISTS `flw_event_resource`;
CREATE TABLE `flw_event_resource` (
                                      `ID_` varchar(255) NOT NULL,
                                      `NAME_` varchar(255) DEFAULT NULL,
                                      `DEPLOYMENT_ID_` varchar(255) DEFAULT NULL,
                                      `RESOURCE_BYTES_` longblob,
                                      PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of flw_event_resource
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ru_batch
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch`;
CREATE TABLE `flw_ru_batch` (
                                `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `REV_` int(11) DEFAULT NULL,
                                `TYPE_` varchar(64) COLLATE utf8_bin NOT NULL,
                                `SEARCH_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `SEARCH_KEY2_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `CREATE_TIME_` datetime(3) NOT NULL,
                                `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
                                `STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                `BATCH_DOC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                PRIMARY KEY (`ID_`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of flw_ru_batch
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for flw_ru_batch_part
-- ----------------------------
DROP TABLE IF EXISTS `flw_ru_batch_part`;
CREATE TABLE `flw_ru_batch_part` (
                                     `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `REV_` int(11) DEFAULT NULL,
                                     `BATCH_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TYPE_` varchar(64) COLLATE utf8_bin NOT NULL,
                                     `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `SEARCH_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `SEARCH_KEY2_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `CREATE_TIME_` datetime(3) NOT NULL,
                                     `COMPLETE_TIME_` datetime(3) DEFAULT NULL,
                                     `STATUS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
                                     `RESULT_DOC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
                                     `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
                                     PRIMARY KEY (`ID_`) USING BTREE,
                                     KEY `FLW_IDX_BATCH_PART` (`BATCH_ID_`) USING BTREE,
                                     CONSTRAINT `FLW_FK_BATCH_PART_PARENT` FOREIGN KEY (`BATCH_ID_`) REFERENCES `flw_ru_batch` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of flw_ru_batch_part
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
                             `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                             `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
                             `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
                             `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
                             `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
                             `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
                             `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
                             `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
                             `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
                             `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
                             `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
                             `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
                             `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
                             `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
                             `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
                             `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                             `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                             `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                             `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                             `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                             PRIMARY KEY (`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
                                    `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
                                    `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
                                    `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
                                    `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
                                    `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
                                    `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
                                    `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
                                    `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
                                    `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
                                    `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
                                    `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
                                    `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
                                    `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
                                    `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
                                    `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
                                    `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
                                    `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
                                    `sort` int(11) DEFAULT NULL COMMENT '排序',
                                    `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                    `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                    PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_approval_template
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_approval_template`;
CREATE TABLE `pmhub_approval_template` (
                                           `id` varchar(64) NOT NULL,
                                           `template_id` varchar(64) NOT NULL COMMENT '审批模板id',
                                           `template_name` varchar(255) NOT NULL COMMENT '审批模板名称',
                                           `file_url` varchar(255) DEFAULT NULL,
                                           `path_name` varchar(255) DEFAULT NULL,
                                           `created_by` varchar(64) DEFAULT NULL,
                                           `created_time` datetime DEFAULT NULL,
                                           `updated_by` varchar(64) DEFAULT NULL,
                                           `updated_time` datetime DEFAULT NULL,
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_approval_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_async
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_async`;
CREATE TABLE `pmhub_async` (
                               `id` varchar(64) NOT NULL COMMENT '任务id',
                               `async_type` varchar(64) NOT NULL COMMENT '任务类型',
                               `async_name` varchar(512) NOT NULL COMMENT '任务名称',
                               `async_desc` varchar(2048) DEFAULT NULL COMMENT '任务描述',
                               `create_time` datetime NOT NULL COMMENT '任务创建时间',
                               `create_by` varchar(64) NOT NULL COMMENT '创建者',
                               `update_time` datetime NOT NULL COMMENT '最后汇报时间',
                               `update_by` varchar(64) DEFAULT NULL,
                               `async_schedule` decimal(10,0) DEFAULT NULL COMMENT '进度（0-100）',
                               `finish_time` datetime DEFAULT NULL COMMENT '结束时间',
                               `async_status` int(11) NOT NULL COMMENT '任务当前状态（0 进行中 1 已失败 2 已完成）',
                               `async_log` json DEFAULT NULL COMMENT '任务执行信息',
                               `file` varchar(10240) DEFAULT NULL COMMENT '附件地址',
                               `deleted` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='离线任务';

-- ----------------------------
-- Records of pmhub_async
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_document_data
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_document_data`;
CREATE TABLE `pmhub_document_data` (
                                       `id` varchar(64) NOT NULL,
                                       `module_name` varchar(64) DEFAULT NULL COMMENT '模块名称',
                                       `module_type` int(11) DEFAULT NULL COMMENT '模块类型',
                                       `document_type` varchar(64) DEFAULT NULL COMMENT '单据类型',
                                       `document_name` varchar(64) DEFAULT NULL COMMENT '单据名称',
                                       `sort` int(11) DEFAULT NULL COMMENT '排序',
                                       `audited` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
                                       `template_id` varchar(64) DEFAULT NULL COMMENT '审批模板id',
                                       `created_by` varchar(64) DEFAULT NULL,
                                       `created_time` datetime DEFAULT NULL,
                                       `updated_by` varchar(64) DEFAULT NULL,
                                       `updated_time` datetime DEFAULT NULL,
                                       `type` varchar(32) NOT NULL COMMENT '类型',
                                       `document_type_id` varchar(64) NOT NULL COMMENT '单据类型id',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_document_data
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_document_type
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_document_type`;
CREATE TABLE `pmhub_document_type` (
                                       `id` varchar(64) NOT NULL,
                                       `type_name` varchar(64) DEFAULT NULL COMMENT '分类名称',
                                       `pid` varchar(64) DEFAULT NULL COMMENT '父id',
                                       `sort` int(11) DEFAULT NULL COMMENT '排序',
                                       `created_by` varchar(64) DEFAULT NULL,
                                       `created_time` datetime DEFAULT NULL,
                                       `updated_by` varchar(64) DEFAULT NULL,
                                       `updated_time` datetime DEFAULT NULL,
                                       `joint_name` varchar(100) DEFAULT NULL,
                                       `type` varchar(64) DEFAULT NULL,
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='单据分类';

-- ----------------------------
-- Records of pmhub_document_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_materials
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_materials`;
CREATE TABLE `pmhub_materials` (
                                   `id` varchar(64) NOT NULL COMMENT '记录id',
                                   `code` int(11) DEFAULT NULL COMMENT '五级代码-物料流水编号',
                                   `materials_name` varchar(64) NOT NULL COMMENT '物料名称',
                                   `project_id` varchar(64) DEFAULT NULL COMMENT '项目id',
                                   `materials_type_id` varchar(64) NOT NULL COMMENT '物料类别id',
                                   `norms` varchar(64) DEFAULT NULL COMMENT '规格',
                                   `model` varchar(128) DEFAULT NULL COMMENT '型号',
                                   `unit` varchar(64) DEFAULT NULL COMMENT '型号',
                                   `unit_price` decimal(15,3) NOT NULL COMMENT '单价',
                                   `color` varchar(16) DEFAULT NULL COMMENT '颜色',
                                   `weight` varchar(64) DEFAULT NULL COMMENT '重量',
                                   `quality_guarantee_period` int(11) DEFAULT NULL COMMENT '质保期（天）',
                                   `lot_number` tinyint(1) DEFAULT NULL COMMENT '是否有批号',
                                   `base_storehouse_count` decimal(15,3) NOT NULL COMMENT '期初库存',
                                   `remarks` varchar(2048) DEFAULT NULL COMMENT '备注',
                                   `part_code` varchar(64) DEFAULT NULL COMMENT '零件编码',
                                   `create_by` varchar(64) NOT NULL COMMENT '创建者',
                                   `create_time` datetime NOT NULL COMMENT '创建时间',
                                   `update_by` varchar(64) NOT NULL COMMENT '更新者',
                                   `update_time` datetime NOT NULL COMMENT '更新时间',
                                   `deleted` int(11) NOT NULL COMMENT '是否删除（1：已删除，0：未删除）',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE KEY `code_and_type_pk` (`code`,`materials_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='物料明细';

-- ----------------------------
-- Records of pmhub_materials
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_materials_approval_set
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_materials_approval_set`;
CREATE TABLE `pmhub_materials_approval_set` (
                                                `id` varchar(32) NOT NULL,
                                                `type` varchar(32) DEFAULT NULL,
                                                `approved` varchar(10) DEFAULT NULL,
                                                `deployment_id` varchar(64) DEFAULT NULL,
                                                `definition_id` varchar(64) DEFAULT NULL,
                                                `created_by` varchar(64) DEFAULT NULL,
                                                `created_time` datetime DEFAULT NULL,
                                                `updated_by` varchar(64) DEFAULT NULL,
                                                `updated_time` datetime DEFAULT NULL,
                                                `extra_id` varchar(32) DEFAULT NULL,
                                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_materials_approval_set
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_my_apply
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_my_apply`;
CREATE TABLE `pmhub_my_apply` (
                                  `id` varchar(64) NOT NULL,
                                  `sp_no` varchar(64) NOT NULL COMMENT '审批编号',
                                  `data_name` varchar(100) NOT NULL COMMENT '单据标题',
                                  `data_type` varchar(100) NOT NULL COMMENT '单据类型',
                                  `data_type_id` varchar(64) NOT NULL COMMENT '单据类型id',
                                  `template_id` varchar(64) NOT NULL COMMENT '模板id',
                                  `sp_status` int(11) NOT NULL COMMENT '审批状态',
                                  `apply_time` datetime DEFAULT NULL COMMENT '提交日期',
                                  `created_by` varchar(64) DEFAULT NULL,
                                  `created_time` datetime DEFAULT NULL,
                                  `updated_by` varchar(64) DEFAULT NULL,
                                  `updated_time` datetime DEFAULT NULL,
                                  `extra_id` varchar(64) DEFAULT NULL COMMENT '项目id、任务id等',
                                  `type` varchar(32) DEFAULT NULL COMMENT '类型project、task',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_my_apply
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_oauth2_agree
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_oauth2_agree`;
CREATE TABLE `pmhub_oauth2_agree` (
                                      `id` varchar(64) DEFAULT NULL,
                                      `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
                                      `client_id` varchar(64) DEFAULT NULL COMMENT '应用id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='已允许单点登录的用户及对应应用';

-- ----------------------------
-- Records of pmhub_oauth2_agree
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_oauth2_client
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_oauth2_client`;
CREATE TABLE `pmhub_oauth2_client` (
                                       `id` varchar(64) DEFAULT NULL,
                                       `client_name` varchar(128) DEFAULT NULL COMMENT '应用名称',
                                       `client_id` varchar(64) DEFAULT NULL COMMENT '应用id',
                                       `client_secret` varchar(1024) DEFAULT NULL COMMENT '应用secret',
                                       `img` varchar(2048) DEFAULT NULL COMMENT '应用图标'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_oauth2_client
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project`;
CREATE TABLE `pmhub_project` (
                                 `id` varchar(64) NOT NULL COMMENT '主键id',
                                 `project_code` varchar(32) NOT NULL COMMENT '项目编码',
                                 `project_name` varchar(200) NOT NULL COMMENT '项目名称',
                                 `description` varchar(500) DEFAULT NULL COMMENT '描述',
                                 `close_begin_time` datetime DEFAULT NULL COMMENT '项目开始时间',
                                 `close_end_time` datetime DEFAULT NULL COMMENT '项目结束时间',
                                 `cover` varchar(255) DEFAULT NULL COMMENT '封面',
                                 `stage_code` int(11) NOT NULL DEFAULT '0' COMMENT '项目阶段 默认是0',
                                 `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目类型 是否私有 0-公开 1-私有',
                                 `prefix` varchar(20) DEFAULT NULL COMMENT '项目编号前缀',
                                 `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                 `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
                                 `archived` tinyint(1) DEFAULT NULL COMMENT '是否归档 0-否 1-归档',
                                 `archived_time` datetime DEFAULT NULL COMMENT '归档时间',
                                 `published` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发布 0-否 1-发布',
                                 `project_process` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '项目进度',
                                 `created_by` varchar(100) DEFAULT NULL COMMENT '创建人',
                                 `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `updated_by` varchar(100) DEFAULT NULL COMMENT '更新人',
                                 `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `user_id` bigint(20) DEFAULT NULL COMMENT '项目负责人',
                                 `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '项目状态 默认0-未开始',
                                 `auto_update_process` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自动更新进度 0-否 1-是',
                                 `open_begin_time` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启任务开始时间',
                                 `open_task_private` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启新任务默认开启隐私模式',
                                 `msg_notify` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启消息提醒',
                                 `notify_day` int(11) NOT NULL DEFAULT '2' COMMENT '提醒的天数',
                                 `open_prefix` tinyint(1) DEFAULT '0' COMMENT '是否开启项目前缀',
                                 `project_stage_id` varchar(64) DEFAULT NULL COMMENT '阶段id',
                                 PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目表';

-- ----------------------------
-- Records of pmhub_project
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project` (`id`, `project_code`, `project_name`, `description`, `close_begin_time`, `close_end_time`, `cover`, `stage_code`, `type`, `prefix`, `deleted`, `deleted_time`, `archived`, `archived_time`, `published`, `project_process`, `created_by`, `created_time`, `updated_by`, `updated_time`, `user_id`, `status`, `auto_update_process`, `open_begin_time`, `open_task_private`, `msg_notify`, `notify_day`, `open_prefix`, `project_stage_id`) VALUES ('aa3a0a9c72c6322d893768c3b05615fa', 'P20240401145842A001', '来个offer', '🔥🔥 来个offer-开源实战项目,助力学生党和工作党拿个更好的offer💪🏻', '2024-04-01 00:00:00', '2024-05-08 00:00:00', '/profile/cover/admin/20240530/laigeoffer大图.pic.jpg', 0, 0, NULL, 0, NULL, NULL, NULL, 1, 2.00, 'admin', '2024-04-01 14:58:43', 'admin', '2024-05-31 15:26:47', 1, 1, 0, 0, 0, 0, 2, 0, '936cf8a130ce76e39b73e6e0ebe36800');
INSERT INTO `pmhub_project` (`id`, `project_code`, `project_name`, `description`, `close_begin_time`, `close_end_time`, `cover`, `stage_code`, `type`, `prefix`, `deleted`, `deleted_time`, `archived`, `archived_time`, `published`, `project_process`, `created_by`, `created_time`, `updated_by`, `updated_time`, `user_id`, `status`, `auto_update_process`, `open_begin_time`, `open_task_private`, `msg_notify`, `notify_day`, `open_prefix`, `project_stage_id`) VALUES ('c3e462c400f66fe0b68d9d2c1bef9ffc', 'P20240401160110A002', '222', '', NULL, NULL, NULL, 0, 0, NULL, 1, '2024-04-02 14:52:01', NULL, NULL, 0, 0.00, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-02 14:52:01', 1, 0, 0, 0, 0, 0, 2, 0, '5a3eda6d32b85df82964021a7a042159');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_collection
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_collection`;
CREATE TABLE `pmhub_project_collection` (
                                            `id` varchar(64) NOT NULL COMMENT '主键id',
                                            `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                            `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                            `updated_by` varchar(64) DEFAULT NULL COMMENT '更新人',
                                            `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                            `project_id` varchar(64) DEFAULT NULL COMMENT '项目id',
                                            `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目-收藏表';

-- ----------------------------
-- Records of pmhub_project_collection
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_file
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_file`;
CREATE TABLE `pmhub_project_file` (
                                      `id` varchar(64) NOT NULL COMMENT '主键id',
                                      `type` varchar(20) DEFAULT NULL COMMENT '文件归属类型 task 或者 project',
                                      `pt_id` varchar(64) NOT NULL COMMENT 'type是task 对应就是task的id type是project 对应就是project的id',
                                      `file_name` varchar(100) NOT NULL COMMENT '文件名称',
                                      `file_size` decimal(11,2) DEFAULT NULL COMMENT '文件大小',
                                      `extension` varchar(32) NOT NULL COMMENT '扩展名',
                                      `file_url` varchar(200) NOT NULL COMMENT '文件完整地址',
                                      `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                      `deleted_time` datetime DEFAULT NULL COMMENT '删除时间',
                                      `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                      `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                      `updated_by` varchar(64) DEFAULT NULL COMMENT '更新人',
                                      `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                      `user_id` bigint(20) DEFAULT NULL COMMENT '上传人id',
                                      `project_id` varchar(64) NOT NULL COMMENT '项目id',
                                      `path_name` varchar(200) DEFAULT NULL,
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目或任务附件表';

-- ----------------------------
-- Records of pmhub_project_file
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_log
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_log`;
CREATE TABLE `pmhub_project_log` (
                                     `id` varchar(64) NOT NULL COMMENT '主键id',
                                     `user_id` bigint(20) NOT NULL COMMENT '操作人id',
                                     `type` varchar(16) NOT NULL COMMENT '类型 project 或者 task',
                                     `operate_type` varchar(32) NOT NULL COMMENT '操作类型',
                                     `content` text COMMENT '操作内容',
                                     `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                     `pt_id` varchar(64) NOT NULL COMMENT '项目或者任务id',
                                     `to_user_id` bigint(20) DEFAULT NULL,
                                     `created_by` varchar(64) DEFAULT NULL,
                                     `created_time` datetime DEFAULT NULL,
                                     `updated_by` varchar(64) DEFAULT NULL,
                                     `updated_time` datetime DEFAULT NULL,
                                     `log_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1-动态 2-交付物 3-评论',
                                     `file_url` varchar(500) DEFAULT NULL COMMENT '文件地址',
                                     `icon` varchar(20) DEFAULT NULL,
                                     `project_id` varchar(64) NOT NULL COMMENT '项目id',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目-任务日志';

-- ----------------------------
-- Records of pmhub_project_log
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('032fac95f33172ae8df72333ba257e6d', 173, 'task', 'addTask', 'f', '参与了任务', '0414ef914297d4bef45bf55ec6bba599', NULL, 'laige', '2024-05-31 13:58:25', 'laige', '2024-05-31 13:58:25', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('07b1a38dfae7d38f8abbff308551f813', 1, 'task', 'editTask', '[{\"field\":\"status\",\"fieldName\":\"任务状态\",\"newValue\":\"进行中\",\"oldValue\":\"未开始\"}]', '更新了任务状态', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-07 16:31:35', 'admin', '2024-04-07 16:31:35', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('0a05e2fdbfa543eb51ec5a1088643c8c', 1, 'project', 'delete', '222', '删除了项目', 'c3e462c400f66fe0b68d9d2c1bef9ffc', NULL, 'admin', '2024-04-02 14:52:01', 'admin', '2024-04-02 14:52:01', 1, NULL, NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('0b22aabfc66eb9f88fff7e07d2254876', 1, 'project', 'create', '来个offer', '创建了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('13b05ecff09164e096706c40ff392dde', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-05-31 15:26:47', 'admin', '2024-05-31 15:26:47', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('1a99bd82bc42b36359b4e97a2d21963b', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-05-30 19:56:54', 'admin', '2024-05-30 19:56:54', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('2aca1b1eb3854281ad02b3bbd68343c5', 1, 'task', 'addTask', '212', '参与了任务', '99b6803d35b3b474568bebf0f97722dc', NULL, 'admin', '2024-04-01 16:01:33', 'admin', '2024-04-01 16:01:33', 1, NULL, NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('31d5cec856454899238054b485e3f66f', 1, 'task', 'editTask', '[{\"field\":\"description\",\"fieldName\":\"描述\",\"newValue\":\"<p><span style=\\\"color: rgb(99, 108, 118);\\\">🚀来个offer，民间开源实战项目，助力学生党和工作党拿个更好的offer💪🏻，欢迎 Follow 关注我们 👉</span></p>\",\"oldValue\":\"<p><br></p>\"}]', '更新了描述', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-07 16:30:54', 'admin', '2024-04-07 16:30:54', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('49d8fe1c298a2fdc21499907e6aa47e1', 1, 'task', 'addTask', '第一个任务', '参与了任务', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-01 15:15:40', 'admin', '2024-04-01 15:15:40', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('4b686f7ab59f8a13eb84853b7f472a40', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-05-30 19:56:17', 'admin', '2024-05-30 19:56:17', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('6176f2e8aed6113671c092d23f352708', 1, 'task', 'editTask', '[{\"field\":\"description\",\"fieldName\":\"描述\",\"newValue\":\"<p><br></p>\",\"oldValue\":\"<p>测试任务</p>\"}]', '更新了描述', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-07 16:30:39', 'admin', '2024-04-07 16:30:39', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('77e6f86d17e5d41428de8bc5c9455b02', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-04-04 01:33:11', 'admin', '2024-04-04 01:33:11', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('78fa3f7c80ca583f09b2c4883dcdf54f', 1, 'project', 'inviteMember', '超级管理员', '加入了项目', 'c3e462c400f66fe0b68d9d2c1bef9ffc', 1, 'admin', '2024-04-01 16:01:11', 'admin', '2024-04-01 16:01:11', 1, NULL, NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('8ff312302c1a4ffc52665d8ef79f619d', 1, 'project', 'inviteMember', '超级管理员', '加入了项目', 'aa3a0a9c72c6322d893768c3b05615fa', 1, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('cbeb538a3ec25086f13927283967aa54', 1, 'project', 'create', '222', '创建了项目', 'c3e462c400f66fe0b68d9d2c1bef9ffc', NULL, 'admin', '2024-04-01 16:01:11', 'admin', '2024-04-01 16:01:11', 1, NULL, NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('d22127f1e8baea4efb1706f923537f4a', 1, 'task', 'editTask', '[{\"field\":\"executeStatus\",\"fieldName\":\"执行状态\",\"newValue\":\"进行中\",\"oldValue\":\"未开始\"}]', '更新了执行状态', '6dab92bed8d03d904962cca5dace9893', NULL, 'admin', '2024-04-07 16:31:32', 'admin', '2024-04-07 16:31:32', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('de5710715cfd8793518e9ef69f5f64de', 1, 'task', 'addTask', '第一个任务', '参与了任务', 'f0ddb49790bba0cc58b833470de0d48c', NULL, 'admin', '2024-04-01 14:59:21', 'admin', '2024-04-01 14:59:21', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('f3583a743885d0c707a2154bbb868f9a', 1, 'task', 'addTask', '第一个任务', '参与了任务', '4b3c00afaf7a6358b2108d465e0db48a', NULL, 'admin', '2024-04-01 14:59:40', 'admin', '2024-04-01 14:59:40', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
INSERT INTO `pmhub_project_log` (`id`, `user_id`, `type`, `operate_type`, `content`, `remark`, `pt_id`, `to_user_id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `log_type`, `file_url`, `icon`, `project_id`) VALUES ('f4d694793d04a4b12944517272b56862', 1, 'project', 'edit', '来个offer', '编辑了项目', 'aa3a0a9c72c6322d893768c3b05615fa', NULL, 'admin', '2024-04-04 01:32:44', 'admin', '2024-04-04 01:32:44', 1, NULL, NULL, 'aa3a0a9c72c6322d893768c3b05615fa');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_member
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_member`;
CREATE TABLE `pmhub_project_member` (
                                        `id` varchar(64) NOT NULL COMMENT '主键id',
                                        `pt_id` varchar(64) NOT NULL COMMENT '项目或者任务id',
                                        `user_id` bigint(20) NOT NULL COMMENT '用户id',
                                        `joined_time` datetime DEFAULT NULL COMMENT '加入时间',
                                        `created_by` varchar(100) DEFAULT NULL COMMENT '创建人',
                                        `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                        `updated_by` varchar(100) DEFAULT NULL COMMENT '更新人',
                                        `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                        `type` varchar(32) NOT NULL COMMENT '类型是项目还是任务 task project',
                                        `creator` tinyint(1) DEFAULT '0' COMMENT '是否创建者',
                                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目-任务成员';

-- ----------------------------
-- Records of pmhub_project_member
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('0c1d0483413d800a972f8f8598acc3d6', 'f0ddb49790bba0cc58b833470de0d48c', 1, '2024-04-01 14:59:21', 'admin', '2024-04-01 14:59:21', 'admin', '2024-04-01 14:59:21', 'task', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('3de03dda428830dde4e8a573d293aa79', 'c3e462c400f66fe0b68d9d2c1bef9ffc', 1, '2024-04-01 16:01:11', 'admin', '2024-04-01 16:01:11', 'admin', '2024-04-01 16:01:11', 'project', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('42c2b685177dd040587626f3f206325e', 'aa3a0a9c72c6322d893768c3b05615fa', 1, '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43', 'project', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('5d64e940bb99f2fa3f649df30104b614', 'aa3a0a9c72c6322d893768c3b05615fa', 173, '2024-04-04 01:39:16', 'admin', '2024-04-04 01:39:16', 'admin', '2024-04-04 01:39:16', 'project', 0);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('8e3c1b48af1608c12b49b004c7580dc5', '0414ef914297d4bef45bf55ec6bba599', 173, '2024-05-31 13:58:25', 'laige', '2024-05-31 13:58:25', 'laige', '2024-05-31 13:58:25', 'task', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('9142a2503746eb0dd082c8b9ef466df9', '6dab92bed8d03d904962cca5dace9893', 1, '2024-04-01 15:15:40', 'admin', '2024-04-01 15:15:40', 'admin', '2024-04-01 15:15:40', 'task', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('936489d30d610e048cc4b9f8fd644401', '99b6803d35b3b474568bebf0f97722dc', 1, '2024-04-01 16:01:33', 'admin', '2024-04-01 16:01:33', 'admin', '2024-04-01 16:01:33', 'task', 1);
INSERT INTO `pmhub_project_member` (`id`, `pt_id`, `user_id`, `joined_time`, `created_by`, `created_time`, `updated_by`, `updated_time`, `type`, `creator`) VALUES ('9dac17d94f07e0db7e9a41b9774825ad', '4b3c00afaf7a6358b2108d465e0db48a', 1, '2024-04-01 14:59:40', 'admin', '2024-04-01 14:59:40', 'admin', '2024-04-01 14:59:40', 'task', 1);
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_stage
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_stage`;
CREATE TABLE `pmhub_project_stage` (
                                       `id` varchar(64) NOT NULL COMMENT '主键id',
                                       `stage_code` int(11) NOT NULL COMMENT '阶段编码',
                                       `stage_name` varchar(100) NOT NULL COMMENT '阶段名称',
                                       `description` varchar(255) DEFAULT NULL COMMENT '阶段描述',
                                       `project_id` varchar(64) NOT NULL COMMENT '项目id',
                                       `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                       `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                       `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                       `updated_by` varchar(64) DEFAULT NULL COMMENT '更新人',
                                       `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                       PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目阶段';

-- ----------------------------
-- Records of pmhub_project_stage
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('0daaf2b9de2b3c9bcb9d7c89eeff9c03', 3, '交付验收阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('4325973a30ce9b9d7d5f1e4fa074891f', 2, '研发实施阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('5a3eda6d32b85df82964021a7a042159', 0, '项目立项阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('5c40e5da93bd6fc343a0909a9f01c73c', 3, '交付验收阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('6359652deefcbc760893e79f55b23a20', 4, '新产品导出阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('64a586191a41de633fba33976af476ca', 1, '研发设计输入阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('83641c127c6514ff68222eb666f3cadf', 1, '研发设计输入阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('8c7441c41bcc7e824a7a4b3c1cd72d24', 2, '研发实施阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('936cf8a130ce76e39b73e6e0ebe36800', 0, '项目立项阶段', NULL, 'aa3a0a9c72c6322d893768c3b05615fa', 0, 'admin', '2024-04-01 14:58:43', 'admin', '2024-04-01 14:58:43');
INSERT INTO `pmhub_project_stage` (`id`, `stage_code`, `stage_name`, `description`, `project_id`, `deleted`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('c459c5b373983888cf0a98055a95451f', 4, '新产品导出阶段', NULL, 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 'admin', '2024-04-01 16:01:10', 'admin', '2024-04-01 16:01:10');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_task
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_task`;
CREATE TABLE `pmhub_project_task` (
                                      `id` varchar(64) NOT NULL COMMENT '主键id',
                                      `created_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                      `created_time` datetime DEFAULT NULL COMMENT '创建时间',
                                      `updated_by` varchar(64) DEFAULT NULL COMMENT '更新人',
                                      `updated_time` datetime DEFAULT NULL COMMENT '更新时间',
                                      `task_name` varchar(100) DEFAULT NULL COMMENT '任务名称',
                                      `project_id` varchar(64) DEFAULT NULL COMMENT '项目id',
                                      `task_priority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务优先级',
                                      `user_id` bigint(20) NOT NULL COMMENT '用户id',
                                      `project_stage_id` varchar(64) NOT NULL COMMENT '项目阶段id',
                                      `description` varchar(500) DEFAULT NULL COMMENT '任务描述',
                                      `begin_time` datetime DEFAULT NULL COMMENT '预计开始时间',
                                      `end_time` datetime DEFAULT NULL COMMENT '预计结束时间',
                                      `close_time` datetime DEFAULT NULL COMMENT '截止时间',
                                      `task_pid` varchar(64) DEFAULT NULL COMMENT '任务父节点',
                                      `assign_to` varchar(64) DEFAULT NULL COMMENT '指派给谁',
                                      `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务状态',
                                      `execute_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '执行状态',
                                      `task_process` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '任务进度',
                                      `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
                                      `deleted_time` datetime DEFAULT NULL,
                                      `task_flow` varchar(200) DEFAULT NULL COMMENT '所属流程',
                                      `task_type_id` varchar(64) DEFAULT NULL COMMENT '任务类型id',
                                      PRIMARY KEY (`id`) USING BTREE,
                                      KEY `idx` (`id`,`project_id`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目-任务表';

-- ----------------------------
-- Records of pmhub_project_task
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('0414ef914297d4bef45bf55ec6bba599', 'laige', '2024-05-31 13:58:25', 'laige', '2024-05-31 13:58:25', 'f', 'aa3a0a9c72c6322d893768c3b05615fa', 4, 173, '', '', NULL, NULL, NULL, NULL, NULL, 0, 0, 0.00, 0, NULL, '', NULL);
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('4b3c00afaf7a6358b2108d465e0db48a', 'admin', '2024-04-01 14:59:40', 'admin', '2024-04-01 14:59:40', '第一个任务', 'aa3a0a9c72c6322d893768c3b05615fa', 0, 1, '936cf8a130ce76e39b73e6e0ebe36800', '<p>测试任务</p>', NULL, NULL, NULL, NULL, NULL, 0, 0, 0.00, 1, '2024-04-04 01:39:26', '', NULL);
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('6dab92bed8d03d904962cca5dace9893', 'admin', '2024-04-01 15:15:40', 'admin', '2024-04-07 16:31:35', '第一个任务', 'aa3a0a9c72c6322d893768c3b05615fa', 0, 1, '936cf8a130ce76e39b73e6e0ebe36800', '<p><span style=\"color: rgb(99, 108, 118);\">🚀来个offer，民间开源实战项目，助力学生党和工作党拿个更好的offer💪🏻，欢迎 Follow 关注我们 👉</span></p>', NULL, NULL, NULL, NULL, NULL, 1, 1, 0.00, 0, NULL, '', NULL);
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('99b6803d35b3b474568bebf0f97722dc', 'admin', '2024-04-01 16:01:33', 'admin', '2024-04-01 16:01:33', '212', 'c3e462c400f66fe0b68d9d2c1bef9ffc', 0, 1, '', '<p>12121</p>', NULL, NULL, NULL, NULL, NULL, 0, 0, 0.00, 1, '2024-04-02 14:51:49', '', NULL);
INSERT INTO `pmhub_project_task` (`id`, `created_by`, `created_time`, `updated_by`, `updated_time`, `task_name`, `project_id`, `task_priority`, `user_id`, `project_stage_id`, `description`, `begin_time`, `end_time`, `close_time`, `task_pid`, `assign_to`, `status`, `execute_status`, `task_process`, `deleted`, `deleted_time`, `task_flow`, `task_type_id`) VALUES ('f0ddb49790bba0cc58b833470de0d48c', 'admin', '2024-04-01 14:59:21', 'admin', '2024-04-01 14:59:21', '第一个任务', 'aa3a0a9c72c6322d893768c3b05615fa', 0, 1, '936cf8a130ce76e39b73e6e0ebe36800', '<p>测试任务</p>', NULL, NULL, NULL, NULL, NULL, 0, 0, 0.00, 1, '2024-04-04 01:39:33', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_task_notify
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_task_notify`;
CREATE TABLE `pmhub_project_task_notify` (
                                             `id` varchar(64) NOT NULL,
                                             `task_id` varchar(64) DEFAULT NULL COMMENT '任务id',
                                             `user_id` int(11) DEFAULT NULL COMMENT '用户id',
                                             `user_wx_name` varchar(64) DEFAULT NULL COMMENT '企业微信id',
                                             `project_id` varchar(64) DEFAULT NULL COMMENT '项目id',
                                             `overdue` tinyint(1) DEFAULT NULL COMMENT '是否逾期 0-否 1-是',
                                             `close_time` datetime DEFAULT NULL,
                                             `task_name` varchar(255) DEFAULT NULL,
                                             PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务提醒表';

-- ----------------------------
-- Records of pmhub_project_task_notify
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_task_process
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_task_process`;
CREATE TABLE `pmhub_project_task_process` (
                                              `id` varchar(64) NOT NULL,
                                              `extra_id` varchar(64) DEFAULT NULL COMMENT '项目任务id',
                                              `approved` varchar(10) DEFAULT NULL COMMENT '是否需要审批',
                                              `instance_id` varchar(64) DEFAULT NULL COMMENT '流程实例id',
                                              `deployment_id` varchar(64) DEFAULT NULL COMMENT '部署id',
                                              `definition_id` varchar(64) DEFAULT NULL COMMENT '流程定义id',
                                              `created_by` varchar(64) DEFAULT NULL,
                                              `created_time` datetime DEFAULT NULL,
                                              `updated_by` varchar(64) DEFAULT NULL,
                                              `updated_time` datetime DEFAULT NULL,
                                              `type` varchar(64) DEFAULT NULL COMMENT '类型task/project等',
                                              `task_id` varchar(64) DEFAULT NULL COMMENT '流程任务id',
                                              `url` varchar(1000) DEFAULT NULL COMMENT '详情地址',
                                              PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_project_task_process
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_project_task_work_time
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_project_task_work_time`;
CREATE TABLE `pmhub_project_task_work_time` (
                                                `id` varchar(64) NOT NULL COMMENT '主键id',
                                                `project_task_id` varchar(64) NOT NULL COMMENT '任务id',
                                                `user_id` varchar(64) NOT NULL COMMENT '用户id',
                                                `work_time` decimal(5,2) DEFAULT NULL COMMENT '工时',
                                                `project_id` varchar(64) NOT NULL COMMENT '项目id',
                                                `created_by` varchar(64) DEFAULT NULL,
                                                `created_time` datetime DEFAULT NULL,
                                                `updated_by` varchar(64) DEFAULT NULL,
                                                `updated_time` datetime DEFAULT NULL,
                                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务工时表';

-- ----------------------------
-- Records of pmhub_project_task_work_time
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_public_file
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_public_file`;
CREATE TABLE `pmhub_public_file` (
                                     `id` varchar(64) NOT NULL COMMENT '主键id',
                                     `file_name` varchar(100) NOT NULL COMMENT '文件名称',
                                     `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
                                     `extension` varchar(128) NOT NULL COMMENT '扩展名',
                                     `file_url` varchar(200) NOT NULL COMMENT '文件下载地址',
                                     `path_name` varchar(200) NOT NULL COMMENT '文件物理路径',
                                     `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                     `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                     `update_by` varchar(64) DEFAULT NULL COMMENT '更新、删除人',
                                     `update_time` datetime DEFAULT NULL COMMENT '更新、删除时间',
                                     `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                     PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不指定目标的上传文件';

-- ----------------------------
-- Records of pmhub_public_file
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_public_file_cache
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_public_file_cache`;
CREATE TABLE `pmhub_public_file_cache` (
                                           `id` varchar(64) NOT NULL COMMENT '主键id',
                                           `file_name` varchar(100) NOT NULL COMMENT '文件名称',
                                           `file_size` bigint(20) DEFAULT NULL COMMENT '文件大小',
                                           `extension` varchar(32) NOT NULL COMMENT '扩展名',
                                           `file_url` varchar(200) NOT NULL COMMENT '文件下载地址',
                                           `path_name` varchar(200) NOT NULL COMMENT '文件物理路径',
                                           `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                           `update_by` varchar(64) DEFAULT NULL COMMENT '更新、删除人',
                                           `update_time` datetime DEFAULT NULL COMMENT '更新、删除时间',
                                           `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='不指定目标的上传文件缓存表';

-- ----------------------------
-- Records of pmhub_public_file_cache
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_public_file_link
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_public_file_link`;
CREATE TABLE `pmhub_public_file_link` (
                                          `id` varchar(64) NOT NULL COMMENT '主键id',
                                          `object_id` varchar(64) NOT NULL COMMENT '文件名称',
                                          `object_type` varchar(16) DEFAULT NULL COMMENT '关联对象类型',
                                          `file_id` varchar(64) NOT NULL COMMENT '扩展名',
                                          `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
                                          `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                          `update_by` varchar(64) DEFAULT NULL COMMENT '更新、删除人',
                                          `update_time` datetime DEFAULT NULL COMMENT '更新、删除时间',
                                          `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0-否 1-删除',
                                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件引用关联表，所有未指定关系的上传文件都应该在这里指定关联关系，如果有文件在这个关联表中没有任何关联关系，则会被定时任务物理删除';

-- ----------------------------
-- Records of pmhub_public_file_link
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_task_message_deal
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_task_message_deal`;
CREATE TABLE `pmhub_task_message_deal` (
                                           `id` varchar(64) NOT NULL,
                                           `task_id` varchar(64) DEFAULT NULL,
                                           `instance_id` varchar(64) DEFAULT NULL,
                                           `assignee` varchar(64) DEFAULT NULL,
                                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_task_message_deal
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_task_type
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_task_type`;
CREATE TABLE `pmhub_task_type` (
                                   `id` varchar(64) NOT NULL,
                                   `type_name` varchar(64) DEFAULT NULL COMMENT '类型名称',
                                   `sort` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
                                   `created_by` varchar(64) DEFAULT NULL,
                                   `created_time` datetime DEFAULT NULL,
                                   `updated_by` varchar(64) DEFAULT NULL,
                                   `updated_time` datetime DEFAULT NULL,
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_task_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_template
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_template`;
CREATE TABLE `pmhub_template` (
                                  `id` varchar(64) NOT NULL,
                                  `file` longblob NOT NULL COMMENT '文件二进制数据',
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='模板文件';

-- ----------------------------
-- Records of pmhub_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_cancel
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_cancel`;
CREATE TABLE `pmhub_wf_cancel` (
                                   `id` varchar(64) DEFAULT NULL COMMENT 'id',
                                   `inst_id` varchar(128) DEFAULT NULL COMMENT 'inst_id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户发起取消流程';

-- ----------------------------
-- Records of pmhub_wf_cancel
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_category
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_category`;
CREATE TABLE `pmhub_wf_category` (
                                     `category_id` bigint(20) NOT NULL COMMENT '流程分类id',
                                     `category_name` varchar(64) DEFAULT '' COMMENT '流程分类名称',
                                     `code` varchar(64) DEFAULT '' COMMENT '分类编码',
                                     `remark` varchar(500) DEFAULT '' COMMENT '备注',
                                     `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                     `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                     `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                     `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                     `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                     PRIMARY KEY (`category_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程分类表';

-- ----------------------------
-- Records of pmhub_wf_category
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_wf_category` (`category_id`, `category_name`, `code`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`) VALUES (1793475859094540290, '信息流转流程', '123456', '123456', '', NULL, '', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_copy
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_copy`;
CREATE TABLE `pmhub_wf_copy` (
                                 `copy_id` varchar(64) NOT NULL COMMENT '抄送主键',
                                 `title` varchar(255) DEFAULT '' COMMENT '抄送标题',
                                 `process_id` varchar(64) DEFAULT '' COMMENT '流程主键',
                                 `process_name` varchar(255) DEFAULT '' COMMENT '流程名称',
                                 `category_id` varchar(255) DEFAULT '' COMMENT '流程分类主键',
                                 `deployment_id` varchar(64) DEFAULT '' COMMENT '部署主键',
                                 `instance_id` varchar(64) DEFAULT '' COMMENT '流程实例主键',
                                 `task_id` varchar(64) DEFAULT '' COMMENT '任务主键',
                                 `user_id` bigint(20) DEFAULT NULL COMMENT '用户主键',
                                 `originator_id` bigint(20) DEFAULT NULL COMMENT '发起人主键',
                                 `originator_name` varchar(64) DEFAULT '' COMMENT '发起人名称',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                 PRIMARY KEY (`copy_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程抄送表';

-- ----------------------------
-- Records of pmhub_wf_copy
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_deploy_form
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_deploy_form`;
CREATE TABLE `pmhub_wf_deploy_form` (
                                        `deploy_id` varchar(64) NOT NULL COMMENT '流程实例主键',
                                        `form_key` varchar(64) NOT NULL COMMENT '表单Key',
                                        `node_key` varchar(64) NOT NULL COMMENT '节点Key',
                                        `form_name` varchar(64) DEFAULT '' COMMENT '表单名称',
                                        `node_name` varchar(255) DEFAULT '' COMMENT '节点名称',
                                        `content` longtext COMMENT '表单内容',
                                        PRIMARY KEY (`deploy_id`,`form_key`,`node_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程实例关联表单';

-- ----------------------------
-- Records of pmhub_wf_deploy_form
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_form
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_form`;
CREATE TABLE `pmhub_wf_form` (
                                 `form_id` bigint(20) NOT NULL COMMENT '表单主键',
                                 `form_name` varchar(64) DEFAULT '' COMMENT '表单名称',
                                 `content` longtext COMMENT '表单内容',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                 `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                                 PRIMARY KEY (`form_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流程表单信息表';

-- ----------------------------
-- Records of pmhub_wf_form
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_wf_form` (`form_id`, `form_name`, `content`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`, `del_flag`) VALUES (1794270355885494273, '民意测评', '{\"formRef\":\"elForm\",\"formModel\":\"formData\",\"size\":\"medium\",\"labelPosition\":\"right\",\"labelWidth\":100,\"formRules\":\"rules\",\"gutter\":15,\"disabled\":false,\"span\":24,\"formBtns\":true,\"fields\":[{\"__config__\":{\"label\":\"单行文本\",\"labelWidth\":null,\"showLabel\":true,\"changeTag\":true,\"tag\":\"el-input\",\"tagIcon\":\"input\",\"defaultValue\":\"民意测评\",\"required\":true,\"layout\":\"colFormItem\",\"span\":24,\"document\":\"https://element.eleme.cn/#/zh-CN/component/input\",\"regList\":[],\"formId\":1716622210876,\"renderKey\":\"17166222108761716622210876\"},\"__slot__\":{\"prepend\":\"\",\"append\":\"\"},\"placeholder\":\"请输入单行文本\",\"style\":{\"width\":\"100%\"},\"clearable\":true,\"prefix-icon\":\"\",\"suffix-icon\":\"\",\"maxlength\":null,\"show-word-limit\":false,\"readonly\":false,\"disabled\":false,\"__vModel__\":\"field1716622210876\"},{\"__config__\":{\"label\":\"下拉选择\",\"showLabel\":true,\"labelWidth\":null,\"tag\":\"el-select\",\"tagIcon\":\"select\",\"layout\":\"colFormItem\",\"span\":24,\"required\":true,\"regList\":[],\"changeTag\":true,\"document\":\"https://element.eleme.cn/#/zh-CN/component/select\",\"formId\":1716622303124,\"renderKey\":\"17166223031241716622303124\"},\"__slot__\":{\"options\":[{\"label\":\"选项一\",\"value\":5},{\"label\":\"选项二\",\"value\":10},{\"label\":\"选项三\",\"value\":15}]},\"placeholder\":\"请选择下拉选择\",\"style\":{\"width\":\"100%\"},\"clearable\":true,\"disabled\":false,\"filterable\":false,\"multiple\":false,\"__vModel__\":\"field1716622303124\"}]}', 'laige', '2024-05-25 15:32:43', 'laige', '2024-05-25 15:32:43', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for pmhub_wf_model_deploy
-- ----------------------------
DROP TABLE IF EXISTS `pmhub_wf_model_deploy`;
CREATE TABLE `pmhub_wf_model_deploy` (
                                         `id` varchar(64) NOT NULL,
                                         `model_id` varchar(64) NOT NULL COMMENT '模型id',
                                         `deployed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-未部署 1-已部署',
                                         `created_by` varchar(64) DEFAULT NULL,
                                         `created_time` datetime DEFAULT NULL,
                                         `updated_by` varchar(64) DEFAULT NULL,
                                         `updated_time` datetime DEFAULT NULL,
                                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pmhub_wf_model_deploy
-- ----------------------------
BEGIN;
INSERT INTO `pmhub_wf_model_deploy` (`id`, `model_id`, `deployed`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES ('0d752fa5a7981ae3ee28ca290482449c', 'f7ba4dcd-18af-11ef-bdc0-0242ac110002', 0, 'laige', '2024-05-23 10:55:53', 'laige', '2024-05-23 10:55:53');
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
                              `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
                              `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
                              `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
                              `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
                              `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
                              `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-12-06 17:32:35', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
                            `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
                            `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
                            `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
                            `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
                            `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
                            `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
                            `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
                            `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
                            `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (100, 0, '0', '来个offer科技有限公司', 0, '苍何', '15833888121', 'ry@qq.com', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2024-03-05 06:48:31');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (101, 211, '0,100,211', 'offer技术研究院', 9, '苍何', '', 'ry@qq.com', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2024-03-05 06:48:56');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (102, 100, '0,100', '长沙分公司', 2, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (103, 101, '0,100,211,101', '研发设计部', 2, '', '', '', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-18 17:43:16');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (104, 101, '0,100,211,101', '实验室', 3, '', '', '', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2024-03-05 06:49:46');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (105, 101, '0,100,211,101', '测试部门', 12, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-19 09:31:23');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (106, 101, '0,100,211,101', '数据中心', 4, '', '', '', '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2024-03-05 06:49:52');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (107, 101, '0,100,211,101', '运维部门', 5, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (108, 102, '0,100,102', '市场部门', 1, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (109, 102, '0,100,102', '财务部门', 2, '苍何', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-06 17:32:35', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (200, 101, '0,100,211,101', '测试', 6, NULL, NULL, NULL, '0', '2', 'admin', '2023-01-13 14:05:12', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (201, 101, '0,100,211,101', '技术探讨部', 1, '', '', NULL, '0', '0', 'admin', '2023-01-18 15:28:33', 'admin', '2024-03-05 06:49:39');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (202, 102, '0,100,102', '测试', 3, NULL, NULL, NULL, '0', '2', 'admin', '2023-01-18 15:41:47', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (203, 211, '0,100,211', '董事会办公司', 1, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:24:29', 'admin', '2023-01-18 17:30:57');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (204, 211, '0,100,211', '综合管理部', 2, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:25:09', 'admin', '2023-01-18 17:31:23');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (205, 211, '0,100,211', '人力资源部', 3, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:25:42', 'admin', '2023-01-18 17:32:33');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (206, 211, '0,100,211', '资产财务部', 4, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:26:33', 'admin', '2023-01-18 17:32:56');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (207, 211, '0,100,211', '审计法务部', 5, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:27:06', 'admin', '2023-01-18 17:33:14');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (208, 211, '0,100,211', '投资发展部', 6, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:27:40', 'admin', '2023-01-18 17:33:34');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (209, 211, '0,100,211', '市场营销部', 7, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:28:16', 'admin', '2023-01-18 17:33:51');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (210, 211, '0,100,211', '供应链管理部', 8, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:29:04', 'admin', '2023-01-18 17:34:03');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (211, 100, '0,100', '重庆总公司', 1, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:30:22', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (212, 211, '0,100,211', '生产管理部', 10, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:46:50', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (213, 211, '0,100,211', '项目管理部', 11, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-18 17:47:15', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (214, 101, '0,100,211,101', '测试部门', 5, '李四', NULL, NULL, '0', '0', 'dxj', '2023-03-29 14:33:13', 'admin', '2023-04-21 14:49:41');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (215, 101, '0,100,211,101', '顶顶顶顶', 6, NULL, NULL, NULL, '0', '2', 'dxj', '2023-08-31 18:09:59', 'admin', '2023-08-31 18:10:06');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (216, 106, '0,100,211,101,106', 'eee', 1, NULL, NULL, NULL, '0', '2', 'canghe', '2023-09-22 09:28:22', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
                                 `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
                                 `dict_sort` int(11) DEFAULT '0' COMMENT '字典排序',
                                 `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
                                 `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
                                 `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
                                 `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
                                 `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
                                 `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
                                 `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                 PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '性别男');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '性别女');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '通知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '公告');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, 1, '未开始', '0', 'project_task_execute_status', NULL, 'default', 'N', '0', 'admin', '2022-12-14 17:04:59', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, 2, '进行中', '1', 'project_task_execute_status', NULL, 'default', 'N', '0', 'admin', '2022-12-14 17:05:12', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, 3, '已完成', '2', 'project_task_execute_status', NULL, 'default', 'N', '0', 'admin', '2022-12-14 17:05:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, 4, '直属上级', '${startUserLeaderList}', 'var', NULL, 'default', 'N', '0', 'dxj', '2023-04-21 14:00:21', 'dxj', '2023-04-26 09:39:17', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, 0, '进行中', '0', 'async_status', NULL, 'primary', 'N', '0', 'admin', '2023-12-22 11:15:07', 'admin', '2023-12-22 11:16:34', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, 2, '已完成', '2', 'async_status', NULL, 'success', 'N', '0', 'admin', '2023-12-22 11:15:52', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, 1, '已失败', '1', 'async_status', NULL, 'danger', 'N', '0', 'admin', '2023-12-22 11:16:14', '', NULL, NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (118, 0, '启用', '1', 'sxsd_status', NULL, 'primary', 'N', '0', 'admin', '2024-01-15 10:06:45', 'qyh', '2024-01-16 16:47:18', NULL);
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (119, 1, '停用', '0', 'sxsd_status', NULL, 'danger', 'N', '0', 'admin', '2024-01-15 10:07:28', 'admin', '2024-01-15 10:09:34', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
                                 `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
                                 `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
                                 `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
                                 `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
                                 `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                                 `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                                 `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                                 `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                                 `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                 PRIMARY KEY (`dict_id`) USING BTREE,
                                 UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '项目-任务执行状态', 'project_task_execute_status', '0', 'admin', '2022-12-14 17:04:40', '', NULL, '项目-任务执行状态');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '审批人变量', 'var', '0', 'dxj', '2023-04-18 11:28:52', 'dxj', '2023-04-21 13:58:44', '未知审批人变量');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '异步任务状态', 'async_status', '0', 'admin', '2023-12-22 11:14:35', '', NULL, NULL);
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, 'sxsd-status', 'sxsd_status', '0', 'admin', '2024-01-15 10:05:47', '', NULL, '三峡时代通用状态');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
                           `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
                           `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
                           `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
                           `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
                           `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
                           `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
                           `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
                           `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
                           `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                           `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
                           PRIMARY KEY (`job_id`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '任务待逾期提醒', 'DEFAULT', 'com.sxsd.quartz.task.TaskNotifyTask.taskNotify()', '0 0 9 * * ?', '1', '1', '1', 'admin', '2023-10-12 09:50:01', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '任务已逾期提醒', 'DEFAULT', 'com.sxsd.quartz.task.TaskOverdueNotifyTask.taskNotify()', '0 0 9 * * ?', '1', '1', '1', 'admin', '2023-10-12 09:57:14', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '任务已逾期状态修改', 'DEFAULT', 'com.sxsd.quartz.task.TaskOverdueStatusTask.taskNotify()', '0 0 1 * * ?', '1', '1', '1', 'admin', '2023-10-12 09:58:12', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '任务已逾期周提醒', 'DEFAULT', 'com.sxsd.quartz.task.TaskOverdueWeekNotifyTask.taskNotify()', '0 0 10 ? * MON', '1', '1', '1', 'admin', '2023-10-12 09:59:12', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '代办任务提醒', 'DEFAULT', 'com.sxsd.quartz.task.TodoRemindTask.sayWord()', '0 0 9 1/2 * ?', '1', '1', '1', 'admin', '2023-10-12 10:00:24', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '计算物料批次存量', 'DEFAULT', 'com.sxsd.quartz.task.MaterialsCountCalcTask.countCalc()', '0 0 3 * * ?', '1', '1', '1', 'admin', '2023-10-12 10:08:14', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '计算分类编码头', 'DEFAULT', 'com.sxsd.quartz.task.MaterialsTypeCodeHeadCalcTask.countCalc()', '0 0 1 1 * ?', '1', '1', '1', 'admin', '2023-10-12 10:09:15', 'lisi', '2023-10-23 16:31:03', '');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
                               `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
                               `job_name` varchar(64) NOT NULL COMMENT '任务名称',
                               `job_group` varchar(64) NOT NULL COMMENT '任务组名',
                               `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
                               `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
                               `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
                               `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
                               `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                               PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
                                  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
                                  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
                                  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
                                  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
                                  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
                                  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
                                  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
                                  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
                                  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
                                  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8994 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8873, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-05 09:18:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8874, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-13 15:09:28');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8875, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-15 07:04:46');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8876, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '密码输入错误1次', '2024-03-28 09:38:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8877, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '用户不存在/密码错误', '2024-03-28 09:38:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8878, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2024-03-28 09:38:13');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8879, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-29 09:40:33');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8880, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2024-03-29 10:05:11');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8881, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-01 06:07:45');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8882, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-01 06:08:21');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8883, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-01 06:19:02');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8884, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-01 06:40:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8885, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-01 06:40:55');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8886, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-02 06:42:12');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8887, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '密码输入错误1次', '2024-04-02 08:52:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8888, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '用户不存在/密码错误', '2024-04-02 08:52:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8889, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2024-04-02 08:52:54');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8890, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2024-04-02 08:53:48');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8891, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-04-03 17:29:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8892, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-04-03 17:29:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8893, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:29:31');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8894, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-03 17:40:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8895, 'laige', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:40:25');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8896, 'laige', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-03 17:41:12');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8897, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:41:15');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8898, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-03 17:41:32');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8899, 'laige', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:41:35');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8900, 'laige', '164.92.117.137', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-03 17:44:20');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8901, 'laige', '125.62.3.184', 'XX XX', 'Chrome Mobile', 'Mac OS X (iPhone)', '0', '登录成功', '2024-04-04 00:32:22');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8902, 'laige', '164.92.117.137', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-04 05:06:45');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8903, 'laige', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-04 14:38:58');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8904, 'admin', '43.132.98.47', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-04-07 02:31:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8905, 'admin', '43.132.98.47', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-04-07 02:31:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8906, 'admin', '43.132.98.47', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误2次', '2024-04-07 02:31:17');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8907, 'admin', '43.132.98.47', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-04-07 02:31:17');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8908, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-07 06:58:34');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8909, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-07 08:29:29');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8910, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-07 08:29:37');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8911, 'admin', '125.62.3.184', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-07 15:05:49');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8912, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-16 03:34:09');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8913, 'admin', '125.62.3.167', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-16 13:13:04');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8914, 'admin', '125.62.3.167', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-04-16 13:14:08');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8915, 'admin', '125.62.3.167', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-04-16 13:20:53');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8916, 'admin', '123.147.251.185', 'XX XX', 'Mobile Safari', 'Mac OS X (iPhone)', '0', '登录成功', '2024-04-18 10:53:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8917, 'root', '27.148.97.168', 'XX XX', 'Chrome 12', 'Windows 10', '1', '登录用户：root 不存在', '2024-04-24 04:03:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8918, 'admin', '27.148.97.168', 'XX XX', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2024-04-24 04:39:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8919, 'admin', '27.148.97.168', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-04-24 04:39:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8920, 'laige', '27.148.97.168', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-04-24 04:40:11');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8921, 'laige', '112.97.87.85', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-10 02:45:17');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8922, 'admin', '42.224.165.45', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-05-14 03:49:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8923, 'admin', '42.224.165.45', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-05-14 03:49:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8924, 'laige', '113.64.74.144', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-15 13:22:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8925, 'admin', '125.62.3.222', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-15 13:31:47');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8926, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-05-17 08:28:50');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8927, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-05-17 08:28:50');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8928, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '密码输入错误1次', '2024-05-17 08:43:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8929, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '1', '用户不存在/密码错误', '2024-05-17 08:43:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8930, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-17 08:47:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8931, 'laige', '222.178.212.82', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-22 08:17:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8932, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-22 08:42:04');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8933, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-05-22 08:59:32');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8934, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-22 09:02:18');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8935, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-05-22 09:04:40');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8936, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-22 09:04:47');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8937, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '退出成功', '2024-05-22 09:04:53');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8938, 'admin', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-22 09:04:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8939, 'admin', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2024-05-23 00:39:20');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8940, 'admin', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 00:39:20');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8941, 'laige', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-23 00:39:37');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8942, 'laige', '61.52.222.189', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-05-23 01:20:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8943, 'laige', '183.69.244.46', 'XX XX', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-05-23 01:30:30');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8944, 'laige', '36.21.144.154', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2024-05-23 01:42:08');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8945, 'laige', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '0', '退出成功', '2024-05-23 02:12:45');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8946, 'laige', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-23 02:13:06');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8947, '111', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '登录用户：111 不存在', '2024-05-23 04:22:07');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8948, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2024-05-23 04:22:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8949, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 04:22:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8950, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误2次', '2024-05-23 04:22:25');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8951, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 04:22:25');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8952, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2024-05-23 04:34:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8953, 'admin', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 04:34:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8954, 'laige', '58.213.12.146', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2024-05-23 04:38:50');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8955, 'admin', '180.169.244.190', 'XX XX', 'Chrome 12', 'Windows 10', '1', '密码输入错误1次', '2024-05-23 05:35:52');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8956, 'admin', '180.169.244.190', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 05:35:52');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8957, 'admin', '180.169.244.190', 'XX XX', 'Chrome 12', 'Windows 10', '1', '密码输入错误2次', '2024-05-23 05:35:55');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8958, 'admin', '180.169.244.190', 'XX XX', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2024-05-23 05:35:55');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8959, 'laige', '1.180.149.94', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-23 07:01:41');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8960, 'laige', '115.60.12.103', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-25 06:42:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8961, 'laige', '39.144.92.214', 'XX XX', 'Chrome 12', 'Windows 10', '0', '登录成功', '2024-05-25 07:29:39');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8962, 'admin', '125.62.3.155', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-27 22:00:27');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8963, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '登录成功', '2024-05-27 22:00:46');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8964, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '退出成功', '2024-05-27 22:16:33');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8965, 'admin', '183.69.244.46', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-28 16:24:08');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8966, 'admin', '183.69.244.46', NULL, NULL, NULL, '0', '登录成功', '2024-05-28 16:24:16');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8967, 'admin', '183.69.244.46', NULL, NULL, NULL, '0', '退出成功', '2024-05-28 17:00:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8968, 'admin', '183.69.244.46', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-29 16:58:54');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8969, 'admin', '183.69.244.46', NULL, NULL, NULL, '0', '登录成功', '2024-05-29 16:59:00');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8970, 'laige', '1.180.149.94', NULL, NULL, NULL, '0', '登录成功', '2024-05-29 16:59:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8971, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '退出成功', '2024-05-30 06:15:33');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8972, 'admin', '118.81.149.129', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-30 11:34:53');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8973, 'laige', '118.81.149.129', NULL, NULL, NULL, '0', '登录成功', '2024-05-30 11:35:44');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8974, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '登录成功', '2024-05-30 19:55:42');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8975, 'admin', '125.62.3.155', NULL, NULL, NULL, '0', '退出成功', '2024-05-30 19:56:59');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8976, 'laige', '117.158.45.71', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 01:19:39');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8977, 'laige', '180.213.169.203', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:27:36');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8978, 'laige', '122.192.82.87', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:28:27');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8979, 'laige', '172.82.190.203', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:33:22');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8980, 'laige', '183.63.222.250', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:42:13');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8981, 'laige', '117.61.17.205', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:48:14');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8982, 'admin', '36.152.116.214', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-31 09:53:22');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8983, 'laige', '36.152.116.214', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-31 09:56:19');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8984, 'laige', '36.152.116.214', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 09:56:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8985, 'laige', '120.227.20.134', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 10:02:43');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8986, 'laige', '171.221.148.248', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 10:16:03');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8987, 'laige', '171.221.148.248', NULL, NULL, NULL, '0', '退出成功', '2024-05-31 10:16:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8988, 'admin', '171.221.148.248', NULL, NULL, NULL, '1', '密码输入错误1次', '2024-05-31 10:18:05');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8989, 'laige', '171.221.148.248', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 10:18:21');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8990, 'laige', '14.153.32.4', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 10:18:23');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8991, 'laige', '180.167.148.2', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 13:52:26');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8992, 'laige', '222.92.146.66', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 13:57:54');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8993, 'admin', '183.69.244.46', NULL, NULL, NULL, '0', '登录成功', '2024-05-31 15:26:00');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
                            `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
                            `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
                            `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
                            `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
                            `path` varchar(200) DEFAULT '' COMMENT '路由地址',
                            `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
                            `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
                            `is_frame` int(11) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
                            `is_cache` int(11) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
                            `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
                            `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
                            `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
                            `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
                            `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT '' COMMENT '备注',
                            PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2171 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统管理', 0, 100, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-12-06 17:32:35', 'admin', '2023-02-23 13:53:29', '系统管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统监控', 0, 101, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-12-06 17:32:35', 'admin', '2023-02-23 13:53:35', '系统监控目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统工具', 0, 102, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-12-06 17:32:35', 'admin', '2023-02-23 13:53:40', '系统工具目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 1, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-18 15:41:08', '用户管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-12-06 17:32:35', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 1, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-18 15:41:12', '菜单管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-12-06 17:32:35', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-12-06 17:32:35', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-12-06 17:32:35', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-12-06 17:32:35', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-12-06 17:32:35', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-12-06 17:32:35', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-12-06 17:32:35', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-12-06 17:32:35', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '1', '1', 'monitor:druid:list', 'druid', 'admin', '2022-12-06 17:32:35', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-12-06 17:32:35', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-12-06 17:32:35', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-12-06 17:32:35', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, '表单构建（别删）', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '1', '0', 'tool:build:list', 'build', 'admin', '2022-12-06 17:32:35', 'admin', '2023-02-23 17:35:15', '表单构建菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-12-06 17:32:35', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-12-06 17:32:35', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (121, '流程分类', 1061, 1, 'category', 'workflow/category/index', '', 1, 0, 'C', '0', '0', 'workflow:category:list', 'nested', 'admin', '2023-02-23 13:39:32', '', NULL, '流程分类菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (122, '表单设计', 1061, 2, 'form', 'workflow/form/index', '', 1, 0, 'C', '0', '0', 'workflow:form:list', 'form', 'admin', '2023-02-23 13:39:32', 'admin', '2023-03-02 17:21:19', '表单配置菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (123, '流程设计', 1061, 3, 'model', 'workflow/model/index', '', 1, 1, 'C', '0', '0', 'workflow:model:list', 'component', 'admin', '2023-02-23 13:39:32', 'admin', '2023-03-06 14:44:37', '流程模型菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (124, '部署管理', 1061, 4, 'deploy', 'workflow/deploy/index', '', 1, 0, 'C', '0', '0', 'workflow:deploy:list', 'example', 'admin', '2023-02-23 13:39:32', '', NULL, '部署管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (125, '发起流程', 1062, 1, 'create', 'workflow/work/index', '', 1, 0, 'C', '0', '0', 'workflow:process:startList', 'guide', 'admin', '2023-02-23 13:39:32', 'admin', '2023-03-02 17:24:01', '新建流程菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (126, '我的流程', 1062, 2, 'own', 'workflow/work/own', '', 1, 0, 'C', '0', '0', 'workflow:process:ownList', 'cascader', 'admin', '2023-02-23 13:39:32', '', NULL, '我的流程菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (127, '待办任务', 1062, 3, 'todo', 'workflow/work/todo', '', 1, 0, 'C', '0', '0', 'workflow:process:todoList', 'time-range', 'admin', '2023-02-23 13:39:32', '', NULL, '待办任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (128, '待签任务', 1062, 4, 'claim', 'workflow/work/claim', '', 1, 0, 'C', '0', '0', 'workflow:process:claimList', 'checkbox', 'admin', '2023-02-23 13:39:32', '', NULL, '待签任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (129, '已办任务', 1062, 5, 'finished', 'workflow/work/finished', '', 1, 0, 'C', '0', '0', 'workflow:process:finishedList', 'checkbox', 'admin', '2023-02-23 13:39:32', '', NULL, '已办任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (130, '抄送我的', 1062, 6, 'copy', 'workflow/work/copy', '', 1, 0, 'C', '0', '0', 'workflow:process:copyList', 'checkbox', 'admin', '2023-02-23 13:39:32', '', NULL, '抄送我的菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-12-06 17:32:35', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-12-06 17:32:35', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1061, '流程管理', 0, 8, 'process', NULL, '', 1, 0, 'M', '0', '0', '', 'skill', 'admin', '2023-02-23 13:39:32', 'admin', '2023-02-23 14:32:47', '流程管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1062, '我的事务', 0, 7, 'work', NULL, '', 1, 0, 'M', '0', '0', '', 'job', 'admin', '2023-02-23 13:39:32', 'admin', '2023-02-23 14:32:42', '我的事务目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1140, '分类查询', 121, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1141, '分类新增', 121, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:add', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1142, '分类编辑', 121, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:edit', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1143, '分类删除', 121, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1144, '所有分类', 121, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:category:listAll', '#', 'admin', '2023-02-24 10:27:30', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1150, '表单查询', 122, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1151, '表单新增', 122, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:add', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1152, '表单修改', 122, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:edit', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1153, '表单删除', 122, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1154, '表单导出', 122, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:form:export', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1160, '模型查询', 123, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1161, '模型新增', 123, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:add', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1162, '模型修改', 123, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:edit', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1163, '模型删除', 123, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1164, '模型导出', 123, 5, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:export', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1165, '模型导入', 123, 6, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:import', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1166, '模型设计', 123, 7, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:designer', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1167, '模型保存', 123, 8, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:save', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1168, '流程部署', 123, 9, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:model:deploy', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1170, '部署查询', 124, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:deploy:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1171, '部署删除', 124, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:deploy:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1172, '更新状态', 124, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:deploy:status', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1180, '发起流程', 125, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:start', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1181, '新建流程导出', 125, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:startExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1190, '流程详情', 126, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:query', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1191, '流程删除', 126, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:remove', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1192, '流程取消', 126, 3, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:cancel', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1193, '我的流程导出', 126, 4, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:ownExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1200, '流程办理', 127, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:approval', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1201, '待办流程导出', 127, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:todoExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1210, '流程签收', 128, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:claim', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1211, '待签流程导出', 128, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:claimExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1220, '流程撤回', 129, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:revoke', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1221, '已办流程导出', 129, 2, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:finishedExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1230, '抄送流程导出', 130, 1, '#', '', '', 1, 0, 'F', '0', '0', 'workflow:process:copyExport', '#', 'admin', '2023-02-23 13:39:32', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2001, '项目管理', 0, 2, 'pmhub-project', NULL, NULL, 1, 0, 'M', '0', '0', '', 'tab', 'admin', '2022-12-08 09:54:31', 'admin', '2024-03-05 06:02:10', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2002, '我的项目', 2001, 1, 'my-project', 'pmhub-project/my-project', NULL, 1, 1, 'C', '0', '0', 'pmhub-project:my-project', 'list', 'admin', '2022-12-08 09:57:17', 'admin', '2024-03-05 06:02:00', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2003, '我的收藏', 2001, 3, 'my-collection', 'pmhub-project/my-collection', NULL, 1, 1, 'C', '0', '0', 'pmhub-project:my-collection', 'list', 'admin', '2022-12-08 10:01:23', 'admin', '2024-03-05 06:02:30', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2004, '我的任务', 2001, 2, 'my-task', 'pmhub-project/my-task', NULL, 1, 1, 'C', '0', '0', 'pmhub-project:my-task', 'list', 'admin', '2022-12-08 10:02:19', 'admin', '2024-03-05 06:02:23', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2005, '回收站', 2001, 4, 'recycle-bin', 'pmhub-project/recycle-bin', NULL, 1, 1, 'C', '0', '0', 'pmhub-project:recycle-bin', 'list', 'admin', '2022-12-08 10:03:09', 'admin', '2024-03-05 06:02:38', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2006, '库存管理', 0, 4, 'sxsd-storehouse', NULL, NULL, 1, 0, 'M', '1', '1', '', 'tool', 'admin', '2022-12-08 15:00:39', 'admin', '2024-03-05 06:00:26', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2007, '仓库管理', 2006, 1, 'storehouse-manage', 'sxsd-storehouse/storehouse-manage', NULL, 1, 1, 'C', '0', '0', '', 'list', 'admin', '2022-12-08 15:20:00', 'admin', '2022-12-21 11:31:54', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2008, '采购管理', 0, 3, 'sxsd-purchase', NULL, NULL, 1, 0, 'M', '1', '1', '', 'shopping', 'admin', '2022-12-09 15:41:24', 'admin', '2024-03-05 06:00:16', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2009, '物料管理', 0, 5, 'sxsd-materials', NULL, NULL, 1, 0, 'M', '1', '1', '', 'documentation', 'admin', '2022-12-09 15:42:17', 'admin', '2024-03-05 06:00:32', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2010, '供应商管理', 2008, 3, 'supplier-manage', 'sxsd-purchase/provider-manage', NULL, 1, 0, 'C', '0', '0', '', 'list', 'admin', '2022-12-09 16:06:34', 'admin', '2022-12-13 09:10:04', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2011, '供应商详情', 2010, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:query', '#', 'admin', '2022-12-09 16:10:05', 'admin', '2023-01-18 16:45:42', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2012, '仓库新增', 2007, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse-manage:storemanage:add', '#', 'admin', '2022-12-09 17:59:38', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2013, '仓库删除', 2007, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse-manage:storemanage:remove', '#', 'admin', '2022-12-09 18:08:46', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2014, '仓库修改', 2007, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse-manage:storemanage:edit', '#', 'admin', '2022-12-09 18:10:23', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2015, '列表', 2007, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse-manage:storemanage:list', '#', 'admin', '2022-12-09 18:18:50', 'admin', '2022-12-09 18:30:55', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2016, '详情', 2002, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'pmhub-project:my-project:info', '#', 'admin', '2022-12-12 10:33:04', 'admin', '2024-04-03 17:40:11', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2017, '物料类别', 2009, 2, 'materials-sort', 'sxsd-materials/materials-sort', NULL, 1, 0, 'C', '0', '0', '', 'list', 'admin', '2022-12-20 09:13:16', 'admin', '2022-12-21 11:32:17', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2018, '详情', 2004, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-project:my-task:info', '#', 'admin', '2022-12-20 09:42:12', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2019, '采购入库', 2008, 1, 'purchase-inbound', 'sxsd-purchase/purchase-inbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-purchase:purchase-inbound', 'list', 'admin', '2022-12-20 17:30:05', 'admin', '2022-12-20 17:30:38', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2020, '采购退货出库', 2008, 2, 'purchase-return-outbound', 'sxsd-purchase/purchase-return-outbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-purchase:purchase-return-outbound', 'list', 'admin', '2022-12-20 17:31:38', 'admin', '2022-12-20 17:32:00', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2022, '其他入库', 2006, 3, 'other-inbound', 'sxsd-storehouse/other-inbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-storehouse:other-inbound', 'list', 'admin', '2022-12-21 11:55:11', 'admin', '2023-04-11 14:02:01', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2023, '其他出库', 2006, 4, 'other-outbound', 'sxsd-storehouse/other-outbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-storehouse:other-outbound', 'list', 'admin', '2022-12-21 11:55:50', 'admin', '2023-04-11 14:02:06', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2024, '物料明细', 2009, 1, 'materials-details', 'sxsd-materials/materials-details', NULL, 1, 1, 'C', '0', '0', 'sxsd-materials:materials-details', 'list', 'admin', '2022-12-21 13:42:46', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2025, '物料台账', 2009, 3, 'materials-bill', 'sxsd-materials/materials-bill', NULL, 1, 1, 'C', '0', '0', 'sxsd-materials:materials-bill', 'list', 'admin', '2022-12-21 13:43:26', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2028, '文件上传', 2016, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:upload', '#', 'admin', '2023-01-04 17:31:41', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2029, '新增项目', 2002, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:add', '#', 'admin', '2023-01-04 17:49:54', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2030, '首页统计', 2002, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:statistics', '#', 'admin', '2023-01-04 17:50:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2031, '与我有关的项目', 2002, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:select', '#', 'admin', '2023-01-04 17:50:49', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2033, '查询所有项目', 2002, 18, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:queryAllProject', '#', 'admin', '2023-01-04 17:52:38', 'admin', '2023-01-05 14:37:04', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2034, '进行中的项目', 2002, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:doing', '#', 'admin', '2023-01-04 17:53:03', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2035, '首页-我的任务', 2002, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryMyTaskList', '#', 'admin', '2023-01-04 17:55:48', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2036, '项目列表', 2002, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:list', '#', 'admin', '2023-01-04 18:02:59', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2037, '修改项目', 2002, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:edit', '#', 'admin', '2023-01-04 18:03:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2038, '删除项目', 2002, 9, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:delete', '#', 'admin', '2023-01-04 18:03:58', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2039, '项目归档', 2002, 10, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:archive', '#', 'admin', '2023-01-04 18:04:24', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2040, '退出项目', 2002, 11, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:quit', '#', 'admin', '2023-01-04 18:04:44', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2041, '概况-任务每日新增趋势', 2002, 12, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:taskStatisticsByDate', '#', 'admin', '2023-01-04 18:05:03', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2042, '项目详情-任务列表', 2002, 13, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:detail:taskList', '#', 'admin', '2023-01-04 18:05:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2043, '文件上传', 2002, 14, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:upload', '#', 'admin', '2023-01-04 18:08:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2044, '文件列表', 2002, 15, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:queryFileList', '#', 'admin', '2023-01-04 18:08:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2045, '文件重命名', 2002, 16, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:rename', '#', 'admin', '2023-01-04 18:09:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2046, '文件删除', 2002, 17, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:delete', '#', 'admin', '2023-01-04 18:09:34', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2047, '首页-我的任务', 2004, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryMyTaskList', '#', 'admin', '2023-01-05 14:54:23', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2048, '概况-任务概况', 2004, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:situation', '#', 'admin', '2023-01-05 15:31:15', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2049, '删除任务', 2004, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:delete', '#', 'admin', '2023-01-05 15:31:44', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2050, '任务详情', 2004, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:detail', '#', 'admin', '2023-01-05 15:32:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2051, '任务详情-查询执行人', 2004, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryExecutorList', '#', 'admin', '2023-01-05 15:33:07', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2052, '添加任务', 2004, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:add', '#', 'admin', '2023-01-05 15:34:44', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2053, '添加子任务', 2004, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:addChildTask', '#', 'admin', '2023-01-05 15:35:08', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2054, '修改任务', 2004, 9, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:edit', '#', 'admin', '2023-01-05 15:40:33', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2055, '我的任务列表', 2004, 10, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:list', '#', 'admin', '2023-01-05 15:40:56', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2056, '查询子任务', 2004, 11, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryChildTask', '#', 'admin', '2023-01-05 15:44:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2057, '添加评论', 2004, 12, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:addComment', '#', 'admin', '2023-01-05 15:46:02', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2058, '任务动态', 2004, 13, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:logList', '#', 'admin', '2023-01-05 15:46:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2059, '导入任务', 2004, 14, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:import', '#', 'admin', '2023-01-05 15:47:31', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2060, '项目阶段列表', 2002, 19, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:stage:list', '#', 'admin', '2023-01-05 15:53:02', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2061, '添加项目阶段', 2002, 20, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:stage:add', '#', 'admin', '2023-01-05 15:53:33', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2062, '编辑项目阶段', 2002, 21, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:stage:edit', '#', 'admin', '2023-01-05 15:53:56', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2063, '删除项目阶段', 2002, 22, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:stage:delete', '#', 'admin', '2023-01-05 15:54:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2064, '添加成员', 2002, 23, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:inviteMemberList', '#', 'admin', '2023-01-05 15:56:00', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2065, '移除成员', 2002, 24, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:removeMemberList', '#', 'admin', '2023-01-05 15:56:22', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2066, '搜索成员', 2002, 25, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:list', '#', 'admin', '2023-01-05 15:56:39', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2067, '获取用户列表', 2002, 26, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:queryUserList', '#', 'admin', '2023-01-05 15:57:03', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2068, '获取已加入项目成员', 2002, 27, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:member:queryUserListById', '#', 'admin', '2023-01-05 15:57:37', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2069, '项目动态', 2002, 28, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:log:list', '#', 'admin', '2023-01-05 15:58:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2070, '收藏项目', 2002, 30, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:collect', '#', 'admin', '2023-01-05 15:59:10', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2071, '取消收藏项目', 2002, 31, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:cancelCollect', '#', 'admin', '2023-01-05 15:59:29', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2074, '首页（别删）', 0, 1, '虚拟首页不用配置', NULL, NULL, 1, 0, 'M', '1', '1', '', 'dashboard', 'admin', '2023-01-13 15:33:05', 'admin', '2023-02-23 14:26:08', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2075, '首页统计', 2074, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:statistics', '#', 'admin', '2023-01-13 15:35:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2076, '与我有关的项目', 2074, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:select', '#', 'admin', '2023-01-13 15:35:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2077, '进行中的项目', 2074, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:doing', '#', 'admin', '2023-01-13 15:36:13', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2078, '首页-我的任务列表', 2074, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:queryMyTaskList', '#', 'admin', '2023-01-13 15:37:15', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2079, '查询', 2024, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:list', '#', 'admin', '2023-01-18 16:35:00', 'admin', '2023-01-18 16:44:41', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2080, '新增', 2024, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:add', '#', 'admin', '2023-01-18 16:37:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2081, '编辑', 2024, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:edit', '#', 'admin', '2023-01-18 16:37:34', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2082, '删除', 2024, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:delete', '#', 'admin', '2023-01-18 16:37:54', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2083, '查询', 2017, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-type:list', '#', 'admin', '2023-01-18 16:42:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2084, '新增', 2017, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-type:add', '#', 'admin', '2023-01-18 16:42:28', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2086, '删除', 2017, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-type:delete', '#', 'admin', '2023-01-18 16:42:59', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2087, '供应商列表', 2010, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:list', '#', 'admin', '2023-01-18 16:44:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2088, '查询', 2025, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-records:list', '#', 'admin', '2023-01-18 16:45:03', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2091, '新增供应商', 2010, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:add', '#', 'admin', '2023-01-18 16:46:05', 'admin', '2023-04-06 14:56:16', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2093, '修改供应商', 2010, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:edit', '#', 'admin', '2023-01-18 16:46:23', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2094, '删除供应商', 2010, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:remove', '#', 'admin', '2023-01-18 16:46:50', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2095, '编辑', 2017, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-type:edit', '#', 'admin', '2023-01-18 16:46:50', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2096, '查询', 2022, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:list', '#', 'admin', '2023-01-18 16:50:52', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2097, '新增', 2022, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:add', '#', 'admin', '2023-01-18 16:51:08', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2098, '编辑', 2022, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:edit', '#', 'admin', '2023-01-18 16:51:24', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2099, '删除', 2022, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:delete', '#', 'admin', '2023-01-18 16:51:50', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2100, '查询', 2023, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-take-out:list', '#', 'admin', '2023-01-18 16:53:37', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2101, '新增', 2023, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-take-out:add', '#', 'admin', '2023-01-18 16:54:09', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2102, '编辑', 2023, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-take-out:edit', '#', 'admin', '2023-01-18 16:54:49', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2103, '删除', 2023, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-take-out:delete', '#', 'admin', '2023-01-18 16:55:15', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2104, '查询', 2019, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:purchase:list', '#', 'admin', '2023-01-18 16:56:41', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2105, '新增', 2019, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:purchase:add', '#', 'admin', '2023-01-18 16:57:01', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2106, '编辑', 2019, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:purchase:edit', '#', 'admin', '2023-01-18 16:57:19', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2107, '删除', 2019, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:purchase:delete', '#', 'admin', '2023-01-18 16:57:37', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2108, '查询', 2020, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:cancel:list', '#', 'admin', '2023-01-18 16:58:40', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2109, '新增', 2020, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:cancel:add', '#', 'admin', '2023-01-18 16:58:55', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2110, '编辑', 2020, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:cancel:edit', '#', 'admin', '2023-01-18 16:59:11', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2111, '删除', 2020, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:cancel:delete', '#', 'admin', '2023-01-18 16:59:22', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2112, '查询供应商名称', 2010, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:getProviderName', '#', 'admin', '2023-01-18 17:15:43', 'admin', '2023-01-18 17:15:54', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2113, '导出', 2024, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials:export', '#', 'admin', '2023-01-18 17:27:39', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2114, '导出', 2025, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-records:export', '#', 'admin', '2023-01-18 17:28:03', 'admin', '2023-01-18 17:28:15', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2115, '项目详情', 2002, 32, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:detail', '#', 'admin', '2023-01-19 10:54:47', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2116, '审批管理（备份）', 0, 6, 'sxsd-approval', NULL, NULL, 1, 0, 'M', '0', '1', '', 'checkbox', 'admin', '2023-02-14 14:34:15', 'admin', '2023-02-23 10:00:13', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2117, '发起申请', 2116, 1, 'send-application', 'sxsd-approval/send-application', NULL, 1, 1, 'C', '0', '0', 'sxsd-approval:send-application', 'list', 'admin', '2023-02-14 14:35:52', 'admin', '2023-02-14 14:41:26', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2118, '我的申请', 2116, 2, 'my-application', 'sxsd-approval/my-application', NULL, 1, 1, 'C', '0', '0', 'sxsd-approval:my-application', 'list', 'admin', '2023-02-14 14:38:24', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2119, '我审批的', 2116, 3, 'I-approve', 'sxsd-approval/I-approve', NULL, 1, 1, 'C', '0', '0', 'sxsd-approval:I-approve', 'list', 'admin', '2023-02-14 14:39:00', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2120, '审批设置', 2116, 4, 'approval-settings', 'sxsd-approval/approval-settings', NULL, 1, 1, 'C', '0', '0', 'sxsd-approval:approval-settings', 'list', 'admin', '2023-02-14 14:39:36', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2122, '审批', 2004, 15, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:process:start', '#', 'admin', '2023-03-13 15:29:47', 'admin', '2023-03-13 15:30:34', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2123, '模板列表', 2004, 16, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:queryFileList', '#', 'admin', '2023-03-13 15:35:38', 'admin', '2023-03-13 15:36:42', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2124, '模板删除', 2004, 17, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:delete', '#', 'admin', '2023-03-13 15:36:09', 'admin', '2023-03-13 15:36:37', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2125, '审批设置', 2004, 19, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:updateApprovalSet', '#', 'admin', '2023-03-13 15:41:26', 'admin', '2023-03-13 15:53:27', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2126, '流程列表', 2004, 18, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:process:startList', '#', 'admin', '2023-03-13 15:53:14', 'admin', '2023-03-13 15:53:35', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2127, '流程分类', 2004, 20, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:category:listAll', '#', 'admin', '2023-03-13 15:53:14', 'admin', '2023-03-13 15:53:35', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2128, '归还入库', 2006, 2, 'return-inbound', 'sxsd-storehouse/return-inbound', NULL, 1, 1, 'C', '0', '0', 'sxsd-storehouse:other-inbound', 'list', 'admin', '2023-04-11 14:01:48', 'admin', '2023-04-11 14:07:46', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2129, '查询', 2128, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:list', '#', 'admin', '2023-04-11 14:03:18', 'admin', '2023-04-11 14:03:58', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2130, '新增', 2128, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:add', '#', 'admin', '2023-04-11 14:03:30', 'admin', '2023-04-11 14:04:04', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2131, '编辑', 2128, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:edit', '#', 'admin', '2023-04-11 14:03:39', 'admin', '2023-04-11 14:04:16', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2132, '删除', 2128, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:other-into:delete', '#', 'admin', '2023-04-11 14:03:47', 'admin', '2023-04-11 14:04:23', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2133, '审批设置', 2019, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:inbound:updateApprovalSet', '#', 'admin', '2023-05-05 09:29:33', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2134, '审批设置', 2020, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:outbound:updateApprovalSet', '#', 'admin', '2023-05-05 09:30:16', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2135, '发起审批', 2019, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:inbound:approve', '#', 'admin', '2023-05-05 09:30:44', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2136, '发起审批', 2020, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'purchase:outbound:approve', '#', 'admin', '2023-05-05 09:31:04', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2137, '审批设置', 2128, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:returnInto:updateApprovalSet', '#', 'admin', '2023-05-05 09:32:42', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2138, '审批设置', 2022, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:otherInto:updateApprovalSet', '#', 'admin', '2023-05-05 09:33:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2139, '审批设置', 2023, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:otherOut:updateApprovalSet', '#', 'admin', '2023-05-05 09:33:33', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2140, '发起审批', 2022, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:otherInto:approve', '#', 'admin', '2023-05-05 09:33:55', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2141, '发起审批', 2023, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:otherOut:approve', '#', 'admin', '2023-05-05 09:34:13', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2142, '发起审批', 2128, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'storehouse:returnInto:approve', '#', 'admin', '2023-05-05 09:34:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2143, '审批设置', 2010, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', '	 sxsd-purchase:providerManage:updateApprovalSet', '#', 'admin', '2023-05-09 14:56:48', 'admin', '2023-05-09 14:57:17', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2144, '发起审批', 2010, 8, '', NULL, NULL, 1, 0, 'F', '0', '0', 'sxsd-purchase:providerManage:approval', '#', 'admin', '2023-05-09 15:01:08', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2145, '物料报废', 2009, 4, 'materials-scrap', 'sxsd-materials/materials-scrap', NULL, 1, 1, 'C', '0', '0', 'sxsd-materials:materials-scrap', 'list', 'admin', '2023-07-04 09:16:41', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2146, '审批设置', 2145, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:approvalSet', '#', 'admin', '2023-07-07 14:49:56', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2147, '报废记录列表', 2145, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:uselessList', '#', 'admin', '2023-07-11 15:07:47', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2148, '报废记录审批', 2145, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:approve', '#', 'admin', '2023-07-11 15:08:18', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2149, '处理意见', 2145, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:opinion', '#', 'admin', '2023-07-13 19:48:54', 'admin', '2023-07-13 19:49:08', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2150, '修改责任人', 2145, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:updatePrincipalId', '#', 'zhangsan', '2023-07-13 19:51:12', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2151, '呆滞列表查询', 2145, 6, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:list', '#', 'admin', '2023-07-13 19:53:53', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2152, '导入', 2025, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:materials-records:import', '#', 'admin', '2023-07-18 16:44:41', 'admin', '2023-07-18 16:45:06', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2153, '导入', 2024, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', '	 materials:materials:import', '#', 'admin', '2023-07-19 15:53:23', 'admin', '2023-07-19 15:53:47', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2154, '流程激活或者挂起', 124, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:deploy:state', '#', 'admin', '2023-07-21 09:51:06', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2155, '导出记录', 2145, 7, '', NULL, NULL, 1, 0, 'F', '0', '0', 'materials:useless:export', '#', 'zhangsan', '2023-09-11 11:52:35', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2156, '供应商类别', 2008, 4, 'provider-sort', 'sxsd-purchase/provider-sort', NULL, 1, 0, 'C', '0', '0', NULL, 'tree', 'admin', '2023-11-16 14:58:15', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2157, '后台任务', 3, 3, 'async', 'tool/async/index', NULL, 1, 0, 'C', '0', '0', '', 'druid', 'admin', '2023-12-22 10:27:41', 'zhangsan', '2023-12-27 16:26:24', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2158, '查询', 2156, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'codeautoflow:common-category:list', '#', 'admin', '2024-01-04 14:02:54', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2159, '新增', 2156, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'codeautoflow:common-category:add', '#', 'admin', '2024-01-04 14:03:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2160, '编辑', 2156, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'codeautoflow:common-category:edit', '#', 'admin', '2024-01-04 14:03:49', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2161, '删除', 2156, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'codeautoflow:common-category:delete', '#', 'admin', '2024-01-04 14:04:13', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2163, '超级网盘', 3, 10, 'https://nextcloud.sxsdetech.com:8083/', NULL, NULL, 0, 0, 'M', '1', '1', '', 'search', 'test_admin', '2024-01-08 10:32:10', 'admin', '2024-03-05 06:00:56', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2164, '工具管理', 3, 5, 'sxsd-tools', 'tool/sxsd-tool/index', NULL, 1, 0, 'C', '1', '1', '', 'tool', 'admin', '2024-01-12 11:17:34', 'admin', '2024-03-05 06:00:47', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2166, '修改', 2164, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:edit', '#', 'admin', '2024-01-15 15:40:23', 'admin', '2024-01-15 15:42:59', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2167, '删除', 2164, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:remove', '#', 'admin', '2024-01-15 15:40:51', 'admin', '2024-01-15 15:43:11', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2168, '新增', 2164, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:add', '#', 'admin', '2024-01-15 15:42:00', 'admin', '2024-01-15 15:42:43', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2169, '列表', 2164, 5, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:list', '#', 'admin', '2024-01-15 15:46:11', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2170, '详情', 2164, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'toolManage:toolManage:query', '#', 'admin', '2024-01-15 15:46:37', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
                              `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
                              `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
                              `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
                              `notice_content` longblob COMMENT '公告内容',
                              `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
                              `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                              `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                              `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                              PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '温馨提醒：2018-07-01 pmhub新版本发布啦', '2', 0x3C703E3C696D67207372633D222F6465762D6170692F70726F66696C652F75706C6F61642F323032332F30312F30342F77616C6C686176656E2D7A386D7A6F765F3230323330313034313730333334413030332E706E67223EE696B0E78988E69CACE58685E5AEB93C2F703E, '0', 'admin', '2022-12-06 17:32:35', 'admin', '2023-01-04 17:03:37', '管理员');
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '维护通知：2018-07-01 pmhub系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '管理员');
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '你好', '1', 0x3C703E3C696D67207372633D222F73746167652D6170692F70726F66696C652F75706C6F61642F323032332F30312F30342F346538643135666638616163623166666235316138653730356130346661665F3230323330313034313730333338413030312E6A7067223E3C2F703E, '0', 'admin', '2023-01-04 17:04:00', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
                                `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
                                `title` varchar(50) DEFAULT '' COMMENT '模块标题',
                                `business_type` int(11) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
                                `method` varchar(100) DEFAULT '' COMMENT '方法名称',
                                `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
                                `operator_type` int(11) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
                                `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
                                `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
                                `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
                                `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
                                `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
                                `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
                                `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
                                `status` int(11) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
                                `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
                                `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
                                PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13237 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';



-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
                            `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
                            `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
                            `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
                            `post_sort` int(11) NOT NULL COMMENT '显示顺序',
                            `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`post_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-12-06 17:32:35', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
                            `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                            `role_name` varchar(30) NOT NULL COMMENT '角色名称',
                            `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
                            `role_sort` int(11) NOT NULL COMMENT '显示顺序',
                            `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
                            `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
                            `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
                            `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-12-06 17:32:35', '', NULL, '超级管理员');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2022-12-06 17:32:35', 'admin', '2023-07-31 11:24:35', '普通角色');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, 'qyh', 'aaa', 3, '1', 1, 1, '0', '2', 'admin', '2022-12-13 10:46:36', 'admin', '2023-01-04 17:56:09', 'test2');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '测试角色', 'testRole', 4, '1', 1, 1, '0', '2', 'admin', '2023-01-04 17:35:10', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '项目经理', 'xiangmujingli', 4, '1', 1, 1, '0', '0', 'admin', '2023-01-13 11:28:31', 'admin', '2023-04-12 11:54:19', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '供应链', 'gongyinglian', 5, '1', 1, 1, '0', '0', 'admin', '2023-01-13 11:51:44', 'admin', '2023-01-19 10:38:47', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '仓库管理员', 'cangkuguanliyuan', 6, '1', 1, 1, '0', '0', 'admin', '2023-01-13 13:43:37', 'admin', '2023-07-06 18:12:51', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '测试首页', 'index', 0, '1', 1, 1, '0', '2', 'admin', '2023-01-13 15:37:57', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '部门负责人', 'bumenfuzeren', 7, '1', 1, 1, '0', '0', 'admin', '2023-01-19 11:07:43', 'lala', '2023-07-31 14:25:47', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '测试审批', 'flowable', 0, '1', 1, 1, '0', '0', 'admin', '2023-02-24 10:00:32', 'admin', '2023-07-20 09:33:24', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '测试首页', 'test_index', 0, '1', 1, 1, '0', '2', 'admin', '2023-03-13 15:21:30', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '测试管理员', 'test_admin', 0, '1', 1, 1, '0', '0', 'admin', '2023-03-22 11:02:18', 'admin', '2024-01-15 15:50:04', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '菜单按钮权限测试', 'caidananniu', 0, '1', 1, 1, '0', '0', 'zy', '2023-05-04 14:47:38', 'zy', '2023-05-04 15:00:58', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '敏感信息查看工程师', 'CLASSIFIED_INQUIRER', 10, '1', 0, 0, '0', '0', 'admin', '2023-07-18 11:51:56', 'admin', '2023-12-22 16:07:51', '拥有此权限可以查看敏感信息');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '权限刷新角色', '666', 0, '1', 0, 0, '0', '2', 'admin', '2023-07-31 11:25:09', 'admin', '2023-07-31 11:37:09', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '不敏感信息查看工程师', 'CLASSIFIED_INQUIRER1', 0, '1', 1, 1, '0', '2', 'zy', '2023-08-02 16:42:01', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '体验角色', 'tiyanjuese', 0, '1', 1, 1, '0', '0', 'admin', '2024-04-03 17:38:44', 'admin', '2024-04-03 17:41:28', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
                                 PRIMARY KEY (`role_id`,`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 100);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 101);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 105);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
                                 PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2063);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2065);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 121);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1162);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1163);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1165);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1171);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1172);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1180);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1191);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1192);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1193);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1210);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1211);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1220);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1221);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 1230);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2063);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2065);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2118);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2119);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (102, 2120);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2091);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2093);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2094);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (103, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2082);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2091);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2093);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2094);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2096);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2097);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2098);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2099);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2131);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2132);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (104, 2145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2082);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2096);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2097);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2098);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2099);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2131);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2132);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2146);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2147);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2148);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2149);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (106, 2153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 121);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1162);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1163);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1165);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1171);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1172);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1180);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1191);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1192);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1193);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1210);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1211);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1220);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1221);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 1230);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2063);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2065);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2082);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2091);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2093);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2094);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2096);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2097);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2098);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2099);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2118);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2119);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2120);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2131);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2132);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2133);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2134);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2135);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2136);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2137);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2138);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2139);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (107, 2145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 121);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1162);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1163);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1165);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1171);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1172);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1180);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1191);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1192);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1193);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1210);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1211);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1220);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1221);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 1230);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2063);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2065);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2074);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2075);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2076);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2077);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2078);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2079);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2080);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2081);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2082);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2083);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2084);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2086);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2087);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2088);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2091);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2093);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2094);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2095);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2096);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2097);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2098);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2099);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2118);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2119);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2120);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2131);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2132);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2133);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2134);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2135);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2136);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2137);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2138);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2139);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2146);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2147);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2148);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2149);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2152);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2153);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2155);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2156);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2157);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2158);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2159);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2163);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2169);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (109, 2170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (110, 2112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (111, 2157);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 121);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 124);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 128);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 129);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 130);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1062);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1154);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1161);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1165);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1167);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1168);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1180);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1192);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1193);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1210);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1211);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1220);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1221);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1230);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2061);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2064);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2070);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2071);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2122);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2123);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2125);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2126);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2127);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2154);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
                            `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                            `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
                            `leader_id` varchar(200) DEFAULT NULL COMMENT '直属上级id',
                            `user_name` varchar(30) NOT NULL COMMENT '用户账号',
                            `user_wx_name` varchar(64) DEFAULT NULL COMMENT '企微用户id',
                            `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
                            `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
                            `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
                            `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
                            `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
                            `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
                            `password` varchar(100) DEFAULT '' COMMENT '密码',
                            `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
                            `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
                            `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
                            `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
                            `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                            PRIMARY KEY (`user_id`) USING BTREE,
                            UNIQUE KEY `sys_user_pk` (`user_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 100, NULL, 'admin', NULL, '超级管理员', '00', 'admin@163.com', '13928442309', '0', '', '$2a$10$l4yTu8mRkOs9uHn54wZ5Zu3eQeghcTJQfQWa8uTF0kUMO7AmTkKkm', '0', '0', '183.69.244.46', '2024-05-22 17:04:57', 'admin', '2022-12-06 17:32:35', '', '2024-05-22 09:04:57', '管理员');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, 106, '134', 'py', 'feiji', '飞机', '00', '', '', '0', '', '$2a$10$wt/Kn5ZY3QygH98b6hOXw.A3GZ/nLNkP.zrmCylj4P1SAXGGWptBi', '0', '0', '10.0.2.100', '2023-10-11 14:39:48', 'admin', '2022-12-07 16:18:42', 'admin', '2024-03-05 06:51:05', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, 106, '132,129', 'lisi', 'pingguo', '苹果', '00', '3333333@qq.com', '13333333333', '0', '/profile/avatar/2023/01/09/blob_20230109105500A001.png', '$2a$10$2Cp0h9DX4lK0KtdLgHPeVOlvdEwMTvldvDtddzHpSrfmC8YVr/y96', '0', '0', '183.69.244.46', '2023-11-02 15:03:09', 'admin', '2022-12-09 16:51:26', 'admin', '2024-03-05 06:52:42', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, 103, '1', 'wap', NULL, 'dangao', '00', '', '', '0', '', '$2a$10$Xu0mzWNl7D7Bp0xksOoihuAwrP/bqUh1Cz6ncECJYigvo1KBYbQdC', '0', '0', '', NULL, 'admin', '2023-01-19 11:12:22', 'admin', '2024-03-05 06:52:57', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (129, 106, '1', 'zhangsan', 'mianbao', '面包', '00', '213asd@21slc.wecom.work', '17623522326', '0', '/profile/avatar/2023/02/17/e75ab488cbf84d27a7995aa042a69646_20230217165807A004.png', '$2a$10$is8ty9QeIzL6VTQhq6sfaO/FLq8j87yZpZlQnPYBJd8lK.yN0Qm86', '0', '0', '183.69.244.46', '2024-01-22 19:29:29', '企业微信', '2023-02-17 16:58:07', 'admin', '2024-03-05 06:53:25', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (132, 106, '137,132,101', 'hxq', '02a686311a6bd3ea6c7f5d17dec9c5e4', '手机', '00', '', '', '0', '/profile/avatar/2023/04/11/blob_20230411164456A001.png', '$2a$10$j.ft.Ec3.SkrQTXLeugf6ew/RvO0zAd/UhSeGHv26/ciGVZ4a5JTm', '0', '0', '183.69.244.46', '2024-02-28 10:05:55', 'admin', '2023-03-08 15:22:49', 'admin', '2024-03-05 06:53:36', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (134, 106, '1', 'canghe', 'CangHe', '苍何', '00', '268231256@qq.com', '18212382341', '0', '', '$2a$10$L7rDjeeLezuwD9vdryb3UuuyrAbXjG4MQCugRfIxnwP2EHiY3I1Cy', '0', '0', '183.69.244.46', '2024-01-10 23:01:04', 'admin', '2023-03-13 15:05:06', 'admin', '2024-03-05 06:51:27', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (136, 214, '1', 'dxj2', NULL, '苹果2', '00', '', '', '0', '', '$2a$10$7uL1kpsZKiIMZ9zYwZYBUOPY.reGirTPMIibxSprCUpbUNtvr.MiC', '0', '0', '10.0.2.100', '2023-04-19 09:34:44', 'admin', '2023-03-13 15:17:36', 'admin', '2024-03-05 06:53:46', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (137, 106, '153,132', 'zy', 'BieGuanDongQiQuNanRen', '眼镜', '00', 'bieguandongqiqunanren@sadac.wecom.work', '13981912601', '0', '/profile/avatar/2023/03/22/d376f443d4d54e4aaa4943f2945ec627_20230322105927A002.png', '$2a$10$X90nnF8G0H1CWfKqF51XHOy8UvYkHszfb5bFr1JcUlS.RkF3b9HNC', '0', '0', '183.69.244.46', '2024-01-22 19:06:34', '企业微信', '2023-03-22 10:59:27', 'admin', '2024-03-05 06:54:11', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (139, 100, '1', 'test_admin', NULL, '测试管理员', '00', '', '', '0', '', '$2a$10$DbHx3pcHI9m3maNsHkfBCexF9wStdkVUDMRUmfqtDXBDCCY3Ewhg2', '0', '0', '127.0.0.1', '2024-01-08 10:34:37', 'BieGuanDongQiQuNanRen', '2023-03-22 11:16:22', 'zy', '2024-01-08 10:34:38', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (140, 214, '1', 'maie', 'maie', '电脑', '00', 'maie@joinv.cn', '15921278507', '0', '/profile/avatar/2023/04/06/e6416faf1e6f44829b49e198c9c2d499_20230406143653A001.png', '$2a$10$uYzuIaZFBXRthZBftcZeruFNwUU5vpQWK/MOMbC3j/mlBl6.f5B/2', '0', '0', '192.168.40.34', '2023-08-04 15:45:13', '企业微信', '2023-04-06 14:36:53', 'admin', '2024-03-05 06:54:25', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (141, 214, '1', 'dxj3', NULL, 'dxj3', '00', '', '', '0', '', '$2a$10$Nh9TeJdcS6uNGxvQMvz6mO/ulFFvCxF9HUGMmjIcUoiEXa1SVjFUG', '0', '0', '', NULL, 'dxj', '2023-04-21 16:16:09', '', NULL, NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (142, 214, '1', 'dxj4', NULL, 'dxj4', '00', '', '', '0', '', '$2a$10$MsYJi8bLYe5i3LVcAMqsqOSlyadbErRRmdIxXKyZAYY11iUdiky5e', '0', '0', '', NULL, 'admin', '2023-04-21 16:21:33', 'admin', '2023-04-21 16:25:19', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (143, 214, '100', 'sjcs', NULL, '上级测试', '00', '', '', '0', '', '$2a$10$JiYqXvGnEyewJiR7WFqOkeS5IHAPNOsUqwA2pvCwe6/H6ROJ3A5PG', '0', '0', '', NULL, 'admin', '2023-04-24 14:14:04', 'admin', '2023-04-24 14:15:07', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (144, NULL, '1', '123', NULL, '13321', '00', '', '', '0', '', '$2a$10$9km6vNJ9qzwQ3F.tv7oLvudyPwlSLE3CUPQwPVWbSeJ9g9jF.Uwbq', '0', '0', '', NULL, 'test_admin', '2023-04-24 17:03:10', '', NULL, NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (147, 214, NULL, 'dxj5', NULL, 'dxj5', '00', '', '', '0', '', '$2a$10$wAKm5icsF/NBUYTeP0SNnuOZT99/SYCdg0qJ2nk7mfiqmgGssZJu2', '0', '0', '', NULL, 'dxj', '2023-04-26 09:28:16', 'zy', '2023-04-27 13:59:11', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (150, NULL, '101', 'dxj7', NULL, 'dxj7', '00', '', '', '0', '', '$2a$10$ZQQKAtThDWXLSXZKT/UAFu4.PuL1wOLBeOHpykfmw0sffuD11OuCy', '0', '0', '', NULL, 'admin', '2023-04-27 10:58:21', 'dxj', '2023-04-27 14:31:58', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (151, 214, '137', 'test', NULL, 'test', '00', '', '', '1', '/profile/avatar/2023/04/28/blob_20230428101834A001.png', '$2a$10$yxgpm/ld1djz1qwmrdTbqOJGD5Zo4iU0/T5EQzxLMjH1XNKDu4dX.', '0', '0', '183.69.244.46', '2023-09-28 18:04:39', 'hxq', '2023-04-27 11:00:02', 'zy', '2023-09-28 18:04:38', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (153, 106, NULL, 'lala', 'erji', '耳机', '00', 'noname@joinv.cn', '15071219112', '0', '/profile/avatar/2023/07/06/4d71becafc094639bcde2a66d7a81005_20230706185253A001.png', '$2a$10$ta5s/Iy/3vEQezhsa7EXleRcSFrgR3qhY4X8kHkQ4Cg3sNdDIvIFe', '0', '0', '183.69.244.46', '2024-02-27 15:57:18', '企业微信', '2023-07-06 18:52:53', 'admin', '2024-03-05 06:55:04', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (154, NULL, NULL, 'test2', NULL, 'test2', '00', '', '', '0', '', '$2a$10$P4pImPNSAP9RVuEaWK1OoeOVFwZY9l0rcdkbMkhQqoO55rmbpGnVS', '0', '0', '120.11.22.3', '2023-08-13 12:01:34', 'admin', '2023-07-07 17:38:55', '', '2023-08-13 12:01:33', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (155, 106, NULL, 'qyh', NULL, 'qyh', '00', '', '', '0', '', '$2a$10$wCLOCpE9v.hMYhyLKODK8Ok.FTPAeAibMbXgW2Xjvqljq7R8Y.mHa', '0', '0', '127.0.0.1', '2024-01-22 18:40:09', 'test_admin', '2023-07-11 15:17:59', 'zhangsan', '2024-01-22 18:40:09', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (156, 100, NULL, 'NPC', NULL, '呆滞物料自动报废', '00', '', '', '0', '', '$2a$10$LhQuRKoCs.dkOK.G/SAmnuvob9g.eTgFHsztNHsMQPy8U2VqmMXjG', '0', '0', '', NULL, 'zhangsan', '2023-07-24 14:27:21', 'zy', '2023-07-24 15:06:05', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (167, NULL, NULL, 'zhaosi', NULL, '2123', '00', '', '15927721027', '0', '', '$2a$10$BjS1tnsQ1t7CRZ8s32gFOurOorNjhQxWSu1IPrrTEzumTSCZCOBea', '0', '0', '', NULL, '泛微', '2023-09-26 16:12:23', 'admin', '2024-03-05 06:55:21', '泛微快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (173, 100, NULL, 'laige', NULL, '体验账号', '00', '', '', '0', '', '$2a$10$ekjnC2vdG8YjfvFgkY4HMu1Pu7IiRhFV/MlPVXxjhgc.taq694.C2', '0', '0', '39.144.92.214', '2024-05-25 15:29:39', 'admin', '2024-04-03 17:34:32', 'admin', '2024-05-25 07:29:39', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
                                 `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                 `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
                                 PRIMARY KEY (`user_id`,`post_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (137, 1);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (137, 2);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (137, 3);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (137, 4);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (140, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
                                 `user_id` bigint(20) NOT NULL COMMENT '用户ID',
                                 `role_id` bigint(20) NOT NULL COMMENT '角色ID',
                                 PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (100, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (100, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (101, 107);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (101, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (101, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (129, 107);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (129, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (129, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (132, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (134, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (136, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (137, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (137, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (139, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (140, 107);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (140, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (140, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (143, 107);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (151, 110);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (153, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (153, 111);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (155, 109);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (173, 114);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
