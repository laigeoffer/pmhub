/*
 Navicat Premium Data Transfer

 Source Server         : canghe-local
 Source Server Type    : MySQL
 Source Server Version : 50742 (5.7.42)
 Source Host           : localhost:3306
 Source Schema         : pmhub-system

 Target Server Type    : MySQL
 Target Server Version : 50742 (5.7.42)
 File Encoding         : 65001

 Date: 21/06/2024 16:43:12
*/

CREATE DATABASE  `pmhub-system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE `pmhub-system`;

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
) ENGINE=InnoDB AUTO_INCREMENT=9050 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (8873, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Mac OS X', '0', '登录成功', '2024-03-05 09:18:26');
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
) ENGINE=InnoDB AUTO_INCREMENT=2155 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

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
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2016, '详情', 2002, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'pmhub-project:my-project:info', '#', 'admin', '2022-12-12 10:33:04', 'admin', '2024-04-03 17:40:11', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2018, '详情', 2004, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'pmhub-project:my-task:info', '#', 'admin', '2022-12-20 09:42:12', 'admin', '2024-06-01 15:45:21', '');
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
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2115, '项目详情', 2002, 32, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:manage:detail', '#', 'admin', '2023-01-19 10:54:47', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2122, '审批', 2004, 15, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:process:start', '#', 'admin', '2023-03-13 15:29:47', 'admin', '2023-03-13 15:30:34', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2123, '模板列表', 2004, 16, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:queryFileList', '#', 'admin', '2023-03-13 15:35:38', 'admin', '2023-03-13 15:36:42', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2124, '模板删除', 2004, 17, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:file:delete', '#', 'admin', '2023-03-13 15:36:09', 'admin', '2023-03-13 15:36:37', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2125, '审批设置', 2004, 19, '', NULL, NULL, 1, 0, 'F', '0', '0', 'project:task:updateApprovalSet', '#', 'admin', '2023-03-13 15:41:26', 'admin', '2023-03-13 15:53:27', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2126, '流程列表', 2004, 18, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:process:startList', '#', 'admin', '2023-03-13 15:53:14', 'admin', '2023-03-13 15:53:35', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2127, '流程分类', 2004, 20, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:category:listAll', '#', 'admin', '2023-03-13 15:53:14', 'admin', '2023-03-13 15:53:35', '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2154, '流程激活或者挂起', 124, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'workflow:deploy:state', '#', 'admin', '2023-07-21 09:51:06', '', NULL, '');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
COMMIT;

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
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '项目经理', 'xiangmujingli', 4, '1', 1, 1, '0', '2', 'admin', '2023-01-13 11:28:31', 'admin', '2023-04-12 11:54:19', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '供应链', 'gongyinglian', 5, '1', 1, 1, '0', '2', 'admin', '2023-01-13 11:51:44', 'admin', '2023-01-19 10:38:47', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '仓库管理员', 'cangkuguanliyuan', 6, '1', 1, 1, '0', '2', 'admin', '2023-01-13 13:43:37', 'admin', '2023-07-06 18:12:51', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '测试首页', 'index', 0, '1', 1, 1, '0', '2', 'admin', '2023-01-13 15:37:57', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '部门负责人', 'bumenfuzeren', 7, '1', 1, 1, '0', '2', 'admin', '2023-01-19 11:07:43', 'lala', '2023-07-31 14:25:47', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '测试审批', 'flowable', 0, '1', 1, 1, '0', '2', 'admin', '2023-02-24 10:00:32', 'admin', '2023-07-20 09:33:24', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '测试首页', 'test_index', 0, '1', 1, 1, '0', '2', 'admin', '2023-03-13 15:21:30', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '测试管理员', 'test_admin', 0, '1', 1, 1, '0', '2', 'admin', '2023-03-22 11:02:18', 'admin', '2024-01-15 15:50:04', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '菜单按钮权限测试', 'caidananniu', 0, '1', 1, 1, '0', '2', 'zy', '2023-05-04 14:47:38', 'zy', '2023-05-04 15:00:58', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '敏感信息查看工程师', 'CLASSIFIED_INQUIRER', 10, '1', 0, 0, '0', '2', 'admin', '2023-07-18 11:51:56', 'admin', '2023-12-22 16:07:51', '拥有此权限可以查看敏感信息');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '权限刷新角色', '666', 0, '1', 0, 0, '0', '2', 'admin', '2023-07-31 11:25:09', 'admin', '2023-07-31 11:37:09', NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '不敏感信息查看工程师', 'CLASSIFIED_INQUIRER1', 0, '1', 1, 1, '0', '2', 'zy', '2023-08-02 16:42:01', '', NULL, NULL);
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '体验角色', 'tiyanjuese', 0, '1', 1, 1, '0', '0', 'admin', '2024-04-03 17:38:44', 'admin', '2024-06-02 06:58:41', '线上体验，只有查看权限');
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
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1164);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1166);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1170);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1181);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1190);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 1210);
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
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2066);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2067);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2068);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2069);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (114, 2123);
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
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, 106, '134', 'py', 'feiji', '飞机', '00', '', '', '0', '', '$2a$10$wt/Kn5ZY3QygH98b6hOXw.A3GZ/nLNkP.zrmCylj4P1SAXGGWptBi', '0', '2', '10.0.2.100', '2023-10-11 14:39:48', 'admin', '2022-12-07 16:18:42', 'admin', '2024-03-05 06:51:05', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, 106, '132,129', 'lisi', 'pingguo', '苹果', '00', '3333333@qq.com', '13333333333', '0', '/profile/avatar/2023/01/09/blob_20230109105500A001.png', '$2a$10$2Cp0h9DX4lK0KtdLgHPeVOlvdEwMTvldvDtddzHpSrfmC8YVr/y96', '0', '2', '183.69.244.46', '2023-11-02 15:03:09', 'admin', '2022-12-09 16:51:26', 'admin', '2024-03-05 06:52:42', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, 103, '1', 'wap', NULL, 'dangao', '00', '', '', '0', '', '$2a$10$Xu0mzWNl7D7Bp0xksOoihuAwrP/bqUh1Cz6ncECJYigvo1KBYbQdC', '0', '2', '', NULL, 'admin', '2023-01-19 11:12:22', 'admin', '2024-03-05 06:52:57', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (129, 106, '1', 'zhangsan', 'mianbao', '面包', '00', '213asd@21slc.wecom.work', '17623522326', '0', '/profile/avatar/2023/02/17/e75ab488cbf84d27a7995aa042a69646_20230217165807A004.png', '$2a$10$is8ty9QeIzL6VTQhq6sfaO/FLq8j87yZpZlQnPYBJd8lK.yN0Qm86', '0', '2', '183.69.244.46', '2024-01-22 19:29:29', '企业微信', '2023-02-17 16:58:07', 'admin', '2024-03-05 06:53:25', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (132, 106, '137,132,101', 'hxq', '02a686311a6bd3ea6c7f5d17dec9c5e4', '手机', '00', '', '', '0', '/profile/avatar/2023/04/11/blob_20230411164456A001.png', '$2a$10$j.ft.Ec3.SkrQTXLeugf6ew/RvO0zAd/UhSeGHv26/ciGVZ4a5JTm', '0', '2', '183.69.244.46', '2024-02-28 10:05:55', 'admin', '2023-03-08 15:22:49', 'admin', '2024-03-05 06:53:36', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (134, 106, '1', 'canghe', 'CangHe', '苍何', '00', '268231256@qq.com', '18212382341', '0', '', '$2a$10$L7rDjeeLezuwD9vdryb3UuuyrAbXjG4MQCugRfIxnwP2EHiY3I1Cy', '0', '2', '183.69.244.46', '2024-01-10 23:01:04', 'admin', '2023-03-13 15:05:06', 'admin', '2024-03-05 06:51:27', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (136, 214, '1', 'dxj2', NULL, '苹果2', '00', '', '', '0', '', '$2a$10$7uL1kpsZKiIMZ9zYwZYBUOPY.reGirTPMIibxSprCUpbUNtvr.MiC', '0', '2', '10.0.2.100', '2023-04-19 09:34:44', 'admin', '2023-03-13 15:17:36', 'admin', '2024-03-05 06:53:46', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (137, 106, '153,132', 'zy', 'BieGuanDongQiQuNanRen', '眼镜', '00', 'bieguandongqiqunanren@sadac.wecom.work', '13981912601', '0', '/profile/avatar/2023/03/22/d376f443d4d54e4aaa4943f2945ec627_20230322105927A002.png', '$2a$10$X90nnF8G0H1CWfKqF51XHOy8UvYkHszfb5bFr1JcUlS.RkF3b9HNC', '0', '2', '183.69.244.46', '2024-01-22 19:06:34', '企业微信', '2023-03-22 10:59:27', 'admin', '2024-03-05 06:54:11', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (139, 100, '1', 'test_admin', NULL, '测试管理员', '00', '', '', '0', '', '$2a$10$DbHx3pcHI9m3maNsHkfBCexF9wStdkVUDMRUmfqtDXBDCCY3Ewhg2', '0', '2', '127.0.0.1', '2024-01-08 10:34:37', 'BieGuanDongQiQuNanRen', '2023-03-22 11:16:22', 'zy', '2024-01-08 10:34:38', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (140, 214, '1', 'maie', 'maie', '电脑', '00', 'maie@joinv.cn', '15921278507', '0', '/profile/avatar/2023/04/06/e6416faf1e6f44829b49e198c9c2d499_20230406143653A001.png', '$2a$10$uYzuIaZFBXRthZBftcZeruFNwUU5vpQWK/MOMbC3j/mlBl6.f5B/2', '0', '2', '192.168.40.34', '2023-08-04 15:45:13', '企业微信', '2023-04-06 14:36:53', 'admin', '2024-03-05 06:54:25', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (141, 214, '1', 'dxj3', NULL, 'dxj3', '00', '', '', '0', '', '$2a$10$Nh9TeJdcS6uNGxvQMvz6mO/ulFFvCxF9HUGMmjIcUoiEXa1SVjFUG', '0', '2', '', NULL, 'dxj', '2023-04-21 16:16:09', '', NULL, NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (142, 214, '1', 'dxj4', NULL, 'dxj4', '00', '', '', '0', '', '$2a$10$MsYJi8bLYe5i3LVcAMqsqOSlyadbErRRmdIxXKyZAYY11iUdiky5e', '0', '2', '', NULL, 'admin', '2023-04-21 16:21:33', 'admin', '2023-04-21 16:25:19', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (143, 214, '100', 'sjcs', NULL, '上级测试', '00', '', '', '0', '', '$2a$10$JiYqXvGnEyewJiR7WFqOkeS5IHAPNOsUqwA2pvCwe6/H6ROJ3A5PG', '0', '2', '', NULL, 'admin', '2023-04-24 14:14:04', 'admin', '2023-04-24 14:15:07', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (144, NULL, '1', '123', NULL, '13321', '00', '', '', '0', '', '$2a$10$9km6vNJ9qzwQ3F.tv7oLvudyPwlSLE3CUPQwPVWbSeJ9g9jF.Uwbq', '0', '2', '', NULL, 'test_admin', '2023-04-24 17:03:10', '', NULL, NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (147, 214, NULL, 'dxj5', NULL, 'dxj5', '00', '', '', '0', '', '$2a$10$wAKm5icsF/NBUYTeP0SNnuOZT99/SYCdg0qJ2nk7mfiqmgGssZJu2', '0', '2', '', NULL, 'dxj', '2023-04-26 09:28:16', 'zy', '2023-04-27 13:59:11', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (150, NULL, '101', 'dxj7', NULL, 'dxj7', '00', '', '', '0', '', '$2a$10$ZQQKAtThDWXLSXZKT/UAFu4.PuL1wOLBeOHpykfmw0sffuD11OuCy', '0', '2', '', NULL, 'admin', '2023-04-27 10:58:21', 'dxj', '2023-04-27 14:31:58', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (151, 214, '137', 'test', NULL, 'test', '00', '', '', '1', '/profile/avatar/2023/04/28/blob_20230428101834A001.png', '$2a$10$yxgpm/ld1djz1qwmrdTbqOJGD5Zo4iU0/T5EQzxLMjH1XNKDu4dX.', '0', '2', '183.69.244.46', '2023-09-28 18:04:39', 'hxq', '2023-04-27 11:00:02', 'zy', '2023-09-28 18:04:38', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (153, 106, NULL, 'lala', 'erji', '耳机', '00', 'noname@joinv.cn', '15071219112', '0', '/profile/avatar/2023/07/06/4d71becafc094639bcde2a66d7a81005_20230706185253A001.png', '$2a$10$ta5s/Iy/3vEQezhsa7EXleRcSFrgR3qhY4X8kHkQ4Cg3sNdDIvIFe', '0', '2', '183.69.244.46', '2024-02-27 15:57:18', '企业微信', '2023-07-06 18:52:53', 'admin', '2024-03-05 06:55:04', '企业微信快捷新增用户');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (154, NULL, NULL, 'test2', NULL, 'test2', '00', '', '', '0', '', '$2a$10$P4pImPNSAP9RVuEaWK1OoeOVFwZY9l0rcdkbMkhQqoO55rmbpGnVS', '0', '2', '120.11.22.3', '2023-08-13 12:01:34', 'admin', '2023-07-07 17:38:55', '', '2023-08-13 12:01:33', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (155, 106, NULL, 'qyh', NULL, 'qyh', '00', '', '', '0', '', '$2a$10$wCLOCpE9v.hMYhyLKODK8Ok.FTPAeAibMbXgW2Xjvqljq7R8Y.mHa', '0', '2', '127.0.0.1', '2024-01-22 18:40:09', 'test_admin', '2023-07-11 15:17:59', 'zhangsan', '2024-01-22 18:40:09', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (156, 100, NULL, 'NPC', NULL, '呆滞物料自动报废', '00', '', '', '0', '', '$2a$10$LhQuRKoCs.dkOK.G/SAmnuvob9g.eTgFHsztNHsMQPy8U2VqmMXjG', '0', '2', '', NULL, 'zhangsan', '2023-07-24 14:27:21', 'zy', '2023-07-24 15:06:05', NULL);
INSERT INTO `sys_user` (`user_id`, `dept_id`, `leader_id`, `user_name`, `user_wx_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (167, NULL, NULL, 'zhaosi', NULL, '2123', '00', '', '15927721027', '0', '', '$2a$10$BjS1tnsQ1t7CRZ8s32gFOurOorNjhQxWSu1IPrrTEzumTSCZCOBea', '0', '2', '', NULL, '泛微', '2023-09-26 16:12:23', 'admin', '2024-03-05 06:55:21', '泛微快捷新增用户');
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
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (173, 114);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
