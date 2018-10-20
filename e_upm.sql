/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : e_upm

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-02-28 18:55:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for demo_company
-- ----------------------------
DROP TABLE IF EXISTS `demo_company`;
CREATE TABLE `demo_company` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `register_date` datetime DEFAULT NULL,
  `registered_capital` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demo_company
-- ----------------------------
INSERT INTO `demo_company` VALUES ('cfc7f189-cec4-4d6c-9a8c-71b46e2e41fe', '2018-02-07 17:13:51', 'ADMIN', '2018-02-07 17:13:51', 'ADMIN', '阿斯蒂芬第三方', '阿什顿发多少', '胜多负少的', '斯蒂芬斯蒂芬', '2018-01-30 00:00:00', '0');

-- ----------------------------
-- Table structure for demo_customer
-- ----------------------------
DROP TABLE IF EXISTS `demo_customer`;
CREATE TABLE `demo_customer` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `dob` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `vip` bit(1) DEFAULT NULL,
  `company_id` varchar(36) DEFAULT NULL,
  `sex_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK10ci8ndqyc62yr7afy3tq2mbq` (`company_id`),
  KEY `FK2j37ktx3prn9mxqoxkeehjses` (`sex_id`),
  CONSTRAINT `FK10ci8ndqyc62yr7afy3tq2mbq` FOREIGN KEY (`company_id`) REFERENCES `demo_company` (`id`),
  CONSTRAINT `FK2j37ktx3prn9mxqoxkeehjses` FOREIGN KEY (`sex_id`) REFERENCES `e_dictionary` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demo_customer
-- ----------------------------
INSERT INTO `demo_customer` VALUES ('c9af9d49-e9e7-47be-84a7-2db8e53c3261', '2018-02-07 17:13:19', 'ADMIN', '2018-02-07 17:13:19', 'ADMIN', '手动阀地方', '2018-02-06 00:00:00', '张三', '胜多负少的法定', '\0', null, null);

-- ----------------------------
-- Table structure for e_client_role
-- ----------------------------
DROP TABLE IF EXISTS `e_client_role`;
CREATE TABLE `e_client_role` (
  `client_id` varchar(255) NOT NULL,
  `role_id` varchar(36) NOT NULL,
  PRIMARY KEY (`client_id`,`role_id`),
  KEY `FKlwrt4dbv4wsb3fg76m6s4sp98` (`role_id`),
  CONSTRAINT `FKlwrt4dbv4wsb3fg76m6s4sp98` FOREIGN KEY (`role_id`) REFERENCES `e_role` (`id`),
  CONSTRAINT `FKt2vqcrrxt970sfoy4nyaohg3t` FOREIGN KEY (`client_id`) REFERENCES `oauth_client_details` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_client_role
-- ----------------------------
INSERT INTO `e_client_role` VALUES ('acme', 'SERVICE_CLIENT');

-- ----------------------------
-- Table structure for e_config_param
-- ----------------------------
DROP TABLE IF EXISTS `e_config_param`;
CREATE TABLE `e_config_param` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `error_msg` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL,
  `param_key` varchar(255) NOT NULL,
  `regular_expression` varchar(255) DEFAULT NULL,
  `val` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_param_key` (`param_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_config_param
-- ----------------------------

-- ----------------------------
-- Table structure for e_data_strategy
-- ----------------------------
DROP TABLE IF EXISTS `e_data_strategy`;
CREATE TABLE `e_data_strategy` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `effective` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ql` longtext NOT NULL,
  `unique_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_data_strategy
-- ----------------------------
INSERT INTO `e_data_strategy` VALUES ('dc1f1785-9589-40df-a424-3edbda8d1344', '2018-02-07 17:15:36', 'ADMIN', '2018-02-28 18:00:54', 'ADMIN', '描述', '', '名称', 'QL', '方法标识');

-- ----------------------------
-- Table structure for e_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `e_dictionary`;
CREATE TABLE `e_dictionary` (
  `id` varchar(36) NOT NULL,
  `code` varchar(100) DEFAULT NULL,
  `i18n_key` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_dictionary
-- ----------------------------

-- ----------------------------
-- Table structure for e_exception
-- ----------------------------
DROP TABLE IF EXISTS `e_exception`;
CREATE TABLE `e_exception` (
  `id` varchar(36) NOT NULL,
  `exception_name` varchar(200) DEFAULT NULL,
  `execute_time` datetime DEFAULT NULL,
  `stack_trace_msg` longtext,
  `system_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_exception
-- ----------------------------

-- ----------------------------
-- Table structure for e_i18n
-- ----------------------------
DROP TABLE IF EXISTS `e_i18n`;
CREATE TABLE `e_i18n` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `key_` varchar(100) DEFAULT NULL,
  `lang_` varchar(20) DEFAULT NULL,
  `system_code` varchar(50) DEFAULT NULL,
  `value_` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_i18n
-- ----------------------------

-- ----------------------------
-- Table structure for e_menu_i18n
-- ----------------------------
DROP TABLE IF EXISTS `e_menu_i18n`;
CREATE TABLE `e_menu_i18n` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `key_` varchar(100) DEFAULT NULL,
  `lang_` varchar(20) DEFAULT NULL,
  `system_code` varchar(50) DEFAULT NULL,
  `value_` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_menu_i18n
-- ----------------------------
INSERT INTO `e_menu_i18n` VALUES ('menu.add', null, null, null, null, 'menu.add', '', null, '新增');
INSERT INTO `e_menu_i18n` VALUES ('menu.add_en_US', null, null, null, null, 'menu.add', 'en_US', null, 'ADD');
INSERT INTO `e_menu_i18n` VALUES ('menu.add_zh_CN', null, null, null, null, 'menu.add', 'zh_CN', null, '新增');
INSERT INTO `e_menu_i18n` VALUES ('menu.delete', null, null, null, null, 'menu.delete', '', null, '删除');
INSERT INTO `e_menu_i18n` VALUES ('menu.delete_en_US', null, null, null, null, 'menu.delete', 'en_US', null, 'DELETE');
INSERT INTO `e_menu_i18n` VALUES ('menu.delete_zh_CN', null, null, null, null, 'menu.delete', 'zh_CN', null, '删除');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.example_manage', null, null, null, null, 'menu.demo.example_manage', '', 'demo', '例子');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.example_manage_en_US', null, null, null, null, 'menu.demo.example_manage', 'en_US', 'demo', 'EXAMPLE');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.example_manage_zh_CN', null, null, null, null, 'menu.demo.example_manage', 'zh_CN', 'demo', '例子');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.test.company_manage', null, null, null, null, 'menu.demo.test.company_manage', '', 'demo', '公司管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.test.company_manage_en_US', null, null, null, null, 'menu.demo.test.company_manage', 'en_US', 'demo', 'Company MGT');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.test.company_manage_zh_CN', null, null, null, null, 'menu.demo.test.company_manage', 'zh_CN', 'demo', '公司管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.test.customer_manage', null, null, null, null, 'menu.demo.test.customer_manage', '', 'demo', '客户管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.test.customer_manage_en_US', null, null, null, null, 'menu.demo.test.customer_manage', 'en_US', 'demo', 'Customer MGT');
INSERT INTO `e_menu_i18n` VALUES ('menu.demo.test.customer_manage_zh_CN', null, null, null, null, 'menu.demo.test.customer_manage', 'zh_CN', 'demo', '客户管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.edit', null, null, null, null, 'menu.edit', '', null, '编辑');
INSERT INTO `e_menu_i18n` VALUES ('menu.edit_en_US', null, null, null, null, 'menu.edit', 'en_US', null, 'EDIT');
INSERT INTO `e_menu_i18n` VALUES ('menu.edit_zh_CN', null, null, null, null, 'menu.edit', 'zh_CN', null, '编辑');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.log_manage', null, null, null, null, 'menu.log.log_manage', '', 'log', '操作日志');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.log_manage_en_US', null, null, null, null, 'menu.log.log_manage', 'en_US', 'log', 'OPERATE LOG');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.log_manage_zh_CN', null, null, null, null, 'menu.log.log_manage', 'zh_CN', 'log', '操作日志');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.monitor_manage', null, null, null, null, 'menu.log.monitor_manage', '', 'log', '监控管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.monitor_manage_en_US', null, null, null, null, 'menu.log.monitor_manage', 'en_US', 'log', 'MONITOR MGT');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.monitor_manage_zh_CN', null, null, null, null, 'menu.log.monitor_manage', 'zh_CN', 'log', '监控管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.trace_manage', null, null, null, null, 'menu.log.trace_manage', '', 'log', '跟踪管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.trace_manage_en_US', null, null, null, null, 'menu.log.trace_manage', 'en_US', 'log', 'TRACKING MGT');
INSERT INTO `e_menu_i18n` VALUES ('menu.log.trace_manage_zh_CN', null, null, null, null, 'menu.log.trace_manage', 'zh_CN', 'log', '跟踪管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.page_search', null, null, null, null, 'menu.page_search', '', null, '分页查询');
INSERT INTO `e_menu_i18n` VALUES ('menu.page_search_en_US', null, null, null, null, 'menu.page_search', 'en_US', null, 'PAGE SEARCH');
INSERT INTO `e_menu_i18n` VALUES ('menu.page_search_zh_CN', null, null, null, null, 'menu.page_search', 'zh_CN', null, '分页查询');
INSERT INTO `e_menu_i18n` VALUES ('menu.save', null, null, null, null, 'menu.save', '', null, '保存');
INSERT INTO `e_menu_i18n` VALUES ('menu.save_en_US', null, null, null, null, 'menu.save', 'en_US', null, 'SAVE');
INSERT INTO `e_menu_i18n` VALUES ('menu.save_zh_CN', null, null, null, null, 'menu.save', 'zh_CN', null, '保存');
INSERT INTO `e_menu_i18n` VALUES ('menu.update', null, null, null, null, 'menu.update', '', null, '修改');
INSERT INTO `e_menu_i18n` VALUES ('menu.update_en_US', null, null, null, null, 'menu.update', 'en_US', null, 'UPDATE');
INSERT INTO `e_menu_i18n` VALUES ('menu.update_zh_CN', null, null, null, null, 'menu.update', 'zh_CN', null, '修改');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.authority_resource', null, null, null, null, 'menu.upm.authority_resource', '', 'upm', '查授权资源');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.authority_resource_en_US', null, null, null, null, 'menu.upm.authority_resource', 'en_US', 'upm', 'SEARCH AUTHORITY RESOURCE');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.authority_resource_zh_CN', null, null, null, null, 'menu.upm.authority_resource', 'zh_CN', 'upm', '查授权资源');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.resource_button', null, null, null, null, 'menu.upm.resource_button', '', 'upm', '按钮');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.resource_button_en_US', null, null, null, null, 'menu.upm.resource_button', 'en_US', 'upm', 'BUTTON');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.resource_button_zh_CN', null, null, null, null, 'menu.upm.resource_button', 'zh_CN', 'upm', '按钮');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.resource_client', null, null, null, null, 'menu.upm.resource_client', '', 'upm', '客户端');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.resource_client_en_US', null, null, null, null, 'menu.upm.resource_client', 'en_US', 'upm', 'CLIENT');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.resource_client_zh_CN', null, null, null, null, 'menu.upm.resource_client', 'zh_CN', 'upm', '客户端');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.role_authority', null, null, null, null, 'menu.upm.role_authority', '', 'upm', '授权');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.role_authority_en_US', null, null, null, null, 'menu.upm.role_authority', 'en_US', 'upm', 'AUTHORITY');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.role_authority_zh_CN', null, null, null, null, 'menu.upm.role_authority', 'zh_CN', 'upm', '授权');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.role_manage', null, null, null, null, 'menu.upm.role_manage', '', 'upm', '角色管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.role_manage_en_US', null, null, null, null, 'menu.upm.role_manage', 'en_US', 'upm', 'ROLE MGT');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.role_manage_zh_CN', null, null, null, null, 'menu.upm.role_manage', 'zh_CN', 'upm', '角色管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.strategy_manage', null, null, null, null, 'menu.upm.strategy_manage', '', 'upm', '数据权限');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.strategy_manage_en_US', null, null, null, null, 'menu.upm.strategy_manage', 'en_US', 'upm', 'DATA PERMISSION');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.strategy_manage_zh_CN', null, null, null, null, 'menu.upm.strategy_manage', 'zh_CN', 'upm', '数据权限');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.sys_manage', null, null, null, null, 'menu.upm.sys_manage', '', 'upm', '系统管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.sys_manage_en_US', null, null, null, null, 'menu.upm.sys_manage', 'en_US', 'upm', 'SYSTEM MGT');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.sys_manage_zh_CN', null, null, null, null, 'menu.upm.sys_manage', 'zh_CN', 'upm', '系统管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.user_manage', null, null, null, null, 'menu.upm.user_manage', '', 'upm', '用户管理');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.user_manage_en_US', null, null, null, null, 'menu.upm.user_manage', 'en_US', 'upm', 'USER MGT');
INSERT INTO `e_menu_i18n` VALUES ('menu.upm.user_manage_zh_CN', null, null, null, null, 'menu.upm.user_manage', 'zh_CN', 'upm', '用户管理');
INSERT INTO `e_menu_i18n` VALUES ('system.upm', null, null, null, null, 'system.upm', '', null, '用户权限管理');
INSERT INTO `e_menu_i18n` VALUES ('system.upm_en_US', null, null, null, null, 'system.upm', 'en_US', null, 'UPM');
INSERT INTO `e_menu_i18n` VALUES ('system.upm_zh_CN', null, null, null, null, 'system.upm', 'zh_CN', null, '用户权限管理');

-- ----------------------------
-- Table structure for e_operator_log
-- ----------------------------
DROP TABLE IF EXISTS `e_operator_log`;
CREATE TABLE `e_operator_log` (
  `id` varchar(36) NOT NULL,
  `data` longtext,
  `op_name` varchar(200) DEFAULT NULL,
  `op_time` datetime DEFAULT NULL,
  `operator` varchar(100) DEFAULT NULL,
  `system_code` varchar(50) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_operator_log
-- ----------------------------
INSERT INTO `e_operator_log` VALUES ('04bc64e3-7798-4067-97fe-7a84aa9b685f', '[{\"id\":\"ADMIN\",\"createdTime\":1519812101629,\"modifiedTime\":1519812101629,\"creatorId\":null,\"modifierId\":null,\"username\":\"admin\",\"name\":\"Loy\",\"email\":\"\",\"phone\":\"\",\"deleted\":false,\"enabled\":true,\"salt\":null,\"roleNames\":null,\"roleIds\":\"ADMIN,SERVICE_CLIENT\",\"photo\":false,\"operator\":null,\"new\":false}]', '修改用户', '2018-02-28 18:01:41', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('0b9fe518-af7e-47cb-9d7e-f126fcce9461', '[{\"id\":\"dc1f1785-9589-40df-a424-3edbda8d1344\",\"createdTime\":1519812040646,\"modifiedTime\":1519812040646,\"creatorId\":null,\"modifierId\":null,\"name\":\"名称\",\"ql\":\"QL\",\"uniqueKey\":\"方法标识\",\"effective\":true,\"description\":\"描述\",\"operator\":null,\"new\":false}]', '修改权限策略', '2018-02-28 18:00:40', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('2247d728-db00-480e-b69d-a510e043ed4c', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login?logout\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=412847235E87A91616F086941B101006\"}]', '登录', '2018-02-28 13:23:42', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('2524c798-91a0-4351-910c-cd720eaec249', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.104 Safari/537.36 Core/1.53.4620.400 QQBrowser/9.7.13014.400\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate\",\"accept-language\":\"zh-CN,zh;q=0.8\",\"cookie\":\"LANG=zh_CN; JSESSIONID=6173CF8A53B114BABE8243A8AB30E68F\"}]', '登录', '2018-02-07 17:11:57', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('272db779-8ffb-4830-84d6-2d6dd701a713', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=7501A38D38C4D3773CFA9BD29BF6F68B\"}]', '登录', '2018-02-28 12:02:49', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('2de6e651-2c15-48cc-b078-fbdaefd82db1', '[\"dc1f1785-9589-40df-a424-3edbda8d1344\",\"ADMIN,SERVICE_CLIENT\"]', '数据授权于角色', '2018-02-28 18:00:54', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('3706c9f3-046f-458a-a2b4-700f300fc708', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=8C52D960FF9981287116B9626A1A8BC8\"}]', '登录', '2018-02-27 20:24:12', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('37c389a2-cc87-4d16-8e84-41f2e607dc83', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=894E42DACFD8B61E7ACE54B51C91ECEB\"}]', '登录', '2018-02-28 17:59:45', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('3d3d8caf-06d0-433b-ae7a-ae7ed4eed13e', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=A282047663F0B874CEE58334F3CC64F8\"}]', '登录', '2018-02-28 12:05:24', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('463a536b-8398-4e5c-a135-dc9b07368fe2', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=1A37B11CC93455BC1BE474B3714539E0\"}]', '登录', '2018-02-28 13:18:13', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('59af18c7-3292-45ab-9b78-aa7b8f4f4bef', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=45352A384EB39A70F80DBE25CFBD138B\"}]', '登录', '2018-02-28 11:33:27', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('69a3070b-e9f1-457e-acf0-13aa0d60cfa0', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=155AA20DE72E6BA1537ADE97C7FC97CF\"}]', '登录', '2018-02-28 14:13:33', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('6a21713b-efb7-43d8-9cf1-e151e06cce23', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=A0B33D89285BB152FF27EBA6BB77FF1C\"}]', '登录', '2018-02-28 11:42:05', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('7bc2756b-3007-4c82-9bbe-998b291100a4', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=2FA35AA2C92BE1009929978EC8CBBBC7\"}]', '登录', '2018-02-28 15:04:51', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('7f171f98-95f5-4631-af04-71a0ad0bc844', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login?logout\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=ED2CA89F487A7487C698EA0783A05EE1\"}]', '登录', '2018-02-28 11:46:42', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('82393c60-b76d-4e5f-a478-1dda1c6bd17e', '[\"ADMIN\",\"01,0101,0102,010201,010202,010203,authority_resource,strategy,strategy_01,strategy_02,strategy_03,strategy_04,02,0201,0202,020201,demo,com_xx_demo_test_company,com_xx_demo_test_company_add,com_xx_demo_test_company_edit,com_xx_demo_test_company_delete,com_xx_demo_test_customer,com_xx_demo_test_customer_add,com_xx_demo_test_customer_edit,com_xx_demo_test_customer_delete\"]', '角色授权', '2018-02-07 17:14:28', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('bb48c74c-c401-4882-a354-b16af07bc899', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=5557D92178862B51A95FFB98DF542ABD\"}]', '登录', '2018-02-27 15:49:05', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('bc05d575-2ea1-45c3-a09a-b0feb0f57b76', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=BEA6C0F903E3B104858F8581ADEFC7BC\"}]', '登录', '2018-02-28 14:56:22', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('bc6a8cb5-a6bd-42d9-b330-2933d2ac2d39', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=3EC4F73312645416655C84E565503ACF\"}]', '登录', '2018-02-28 12:07:28', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('bdb6bfc3-099d-4b8c-891e-7fa13f462ae4', '[{\"id\":\"\",\"createdTime\":1517994831736,\"modifiedTime\":1517994831736,\"creatorId\":null,\"modifierId\":null,\"name\":\"胜多负少的\",\"registeredCapital\":0,\"registerDate\":1517241600000,\"contactName\":\"阿什顿发多少\",\"phone\":\"斯蒂芬斯蒂芬\",\"address\":\"阿斯蒂芬第三方\",\"operator\":null,\"new\":true}]', '保存公司', '2018-02-07 17:13:51', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('dd37bad0-e182-47b0-b763-0156de2de0d8', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=1C40918BF8F2E1CE100A333596E7F1DA\"}]', '登录', '2018-02-28 13:29:01', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('f6b48a3c-c535-4dc4-aa2c-19036fc3d834', '[{\"id\":\"\",\"createdTime\":1517994936234,\"modifiedTime\":1517994936234,\"creatorId\":null,\"modifierId\":null,\"name\":\"官方\",\"ql\":\"sdfa\",\"uniqueKey\":\"收到发多少\",\"effective\":true,\"description\":\" 胜多负少\",\"operator\":null,\"new\":true}]', '保存权限策略', '2018-02-07 17:15:36', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('f77b2d61-3996-4484-9da0-49eeb9155b25', '[{\"id\":\"\",\"createdTime\":1517994799677,\"modifiedTime\":1517994799677,\"creatorId\":null,\"modifierId\":null,\"name\":\"张三\",\"sex\":{\"id\":\"\",\"i18nKey\":null,\"code\":null,\"name\":null,\"sortNum\":0,\"parentId\":null,\"new\":true},\"company\":{\"id\":\"\",\"createdTime\":1517994799683,\"modifiedTime\":1517994799683,\"creatorId\":null,\"modifierId\":null,\"name\":null,\"registeredCapital\":null,\"registerDate\":null,\"contactName\":null,\"phone\":null,\"address\":null,\"operator\":null,\"new\":true},\"vip\":false,\"dob\":1517846400000,\"phone\":\"胜多负少的法定\",\"address\":\"手动阀地方\",\"operator\":null,\"new\":true}]', '保存客户', '2018-02-07 17:13:19', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('fbbd1d85-4845-44c5-a20a-e0c9b4904141', '[{\"host\":\"localhost:8080\",\"connection\":\"keep-alive\",\"content-length\":\"30\",\"accept\":\"application/json, text/javascript, */*; q=0.01\",\"origin\":\"http://localhost:8080\",\"x-requested-with\":\"XMLHttpRequest\",\"user-agent\":\"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36\",\"ajax\":\"true\",\"content-type\":\"application/x-www-form-urlencoded; charset=UTF-8\",\"referer\":\"http://localhost:8080/login\",\"accept-encoding\":\"gzip, deflate, br\",\"accept-language\":\"zh-CN,zh;q=0.9\",\"cookie\":\"LANG=zh_CN; JSESSIONID=70D43431D1E8F038DA1518E616690D1C\"}]', '登录', '2018-02-28 13:27:29', 'Loy', 'upm', 'ADMIN', 'admin');
INSERT INTO `e_operator_log` VALUES ('fe6d7b38-2cb7-40ec-85ae-af79b5b701e9', '[\"ADMIN\",\"01,0101,0102,010201,010202,010203,02,0201,0202,demo,com_xx_demo_test_company,com_xx_demo_test_company_add,com_xx_demo_test_company_edit,com_xx_demo_test_company_delete,com_xx_demo_test_customer,com_xx_demo_test_customer_add,com_xx_demo_test_customer_edit,com_xx_demo_test_customer_delete\"]', '角色授权', '2018-02-07 17:12:33', 'Loy', 'upm', 'ADMIN', 'admin');

-- ----------------------------
-- Table structure for e_performance
-- ----------------------------
DROP TABLE IF EXISTS `e_performance`;
CREATE TABLE `e_performance` (
  `id` varchar(36) NOT NULL,
  `execute_time` datetime DEFAULT NULL,
  `method` varchar(400) DEFAULT NULL,
  `op_name` varchar(255) DEFAULT NULL,
  `system_code` varchar(50) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `use_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_performance
-- ----------------------------
INSERT INTO `e_performance` VALUES ('022327f9-9e43-438e-949d-db9be242a2e9', '2018-02-28 13:18:26', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.UserServiceImpl.queryPage(com.loy.upm.sys.domain.UserQueryParam,org.springframework.data.domain.Pageable)', '查询用户', 'upm', '**/user/page', '50');
INSERT INTO `e_performance` VALUES ('0242e706-4c1b-4074-8295-0912275af63a', '2018-02-27 20:24:23', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '47');
INSERT INTO `e_performance` VALUES ('035ee6cc-0cb2-42bb-89cf-95814ea17eeb', '2018-02-28 12:05:24', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '129');
INSERT INTO `e_performance` VALUES ('06e06a4a-8244-4754-a1f6-dfb03f1592cf', '2018-02-28 13:23:42', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '111');
INSERT INTO `e_performance` VALUES ('07f6963b-31fb-47bc-abba-d1df30b3e746', '2018-02-28 11:47:51', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '33');
INSERT INTO `e_performance` VALUES ('0b54b7aa-7c80-46f9-b552-17174c877ee6', '2018-02-07 17:14:36', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '14');
INSERT INTO `e_performance` VALUES ('0d0500d2-542f-48ff-bb2c-e896e2552db7', '2018-02-28 12:04:34', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '14');
INSERT INTO `e_performance` VALUES ('0f25cf2b-41cf-49d3-ab5f-c541da0fc803', '2018-02-07 17:12:34', 'public void com.loy.upm.sys.service.impl.RoleServiceImpl.authority(java.lang.String,java.lang.String)', '角色授权', 'upm', '**/role/authority', '258');
INSERT INTO `e_performance` VALUES ('0ff89e25-b5ec-4b11-ab70-228e5b1f09b3', '2018-02-07 17:14:39', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.UserServiceImpl.queryPage(com.loy.upm.sys.domain.UserQueryParam,org.springframework.data.domain.Pageable)', '查询用户', 'upm', '**/user/page', '12');
INSERT INTO `e_performance` VALUES ('116ddf4f-20ae-4b5c-b3f1-6b0374d88563', '2018-02-28 18:00:54', 'public void com.loy.e.data.permission.service.impl.DataStrategyServiceImpl.authorityToRole(java.lang.String,java.lang.String)', '数据授权于角色', 'upm', '**/strategy/authority/role', '66');
INSERT INTO `e_performance` VALUES ('13562fff-da12-426a-a0b3-6cdcba25c28e', '2018-02-07 17:13:19', 'public com.xx.demo.test.domain.entity.CustomerEntity com.xx.demo.test.service.impl.CustomerServiceImpl.save(com.xx.demo.test.domain.entity.CustomerEntity)', '保存客户', 'upm', '**/customer/save', '23');
INSERT INTO `e_performance` VALUES ('14093ca1-6c5c-4b8d-9d89-61711fe27893', '2018-02-28 13:27:30', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '128');
INSERT INTO `e_performance` VALUES ('1427779c-5d89-4946-beed-3085f9526828', '2018-02-28 18:01:49', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '11');
INSERT INTO `e_performance` VALUES ('176efc0d-ebc1-4d76-b44c-a719035359e2', '2018-02-07 17:14:33', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '3');
INSERT INTO `e_performance` VALUES ('19e44a17-2416-4ed9-a156-bb092a073ac4', '2018-02-28 18:01:37', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.all()', '获取角色树', 'upm', '**/role/all', '10');
INSERT INTO `e_performance` VALUES ('1a85f77f-6cf6-479b-839b-178932ea805d', '2018-02-28 18:00:49', 'public java.util.List com.loy.e.data.permission.service.impl.DataStrategyServiceImpl.roles(java.lang.String)', '权限策略角色', 'upm', '**/strategy/roles', '29');
INSERT INTO `e_performance` VALUES ('1c0e8f8a-f35b-4c75-8d9e-74575caea748', '2018-02-28 15:05:18', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.resource(java.lang.String,java.lang.String)', '角色权限', 'upm', '**/role/resource', '22');
INSERT INTO `e_performance` VALUES ('1c8416fe-eb4c-439e-a8f8-38087d0bee01', '2018-02-28 11:46:42', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '33');
INSERT INTO `e_performance` VALUES ('1cda75ae-dde6-45f5-a66d-516fc4db6a6a', '2018-02-28 15:09:32', 'public com.xx.demo.test.domain.entity.CustomerEntity com.xx.demo.test.service.impl.CustomerServiceImpl.get(java.lang.String)', '获取客户', 'upm', '**/customer/get', '5');
INSERT INTO `e_performance` VALUES ('1f412355-069f-4974-8fb2-81441c757e1e', '2018-02-07 17:12:03', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '57');
INSERT INTO `e_performance` VALUES ('2059bea2-99ff-4290-8cd3-6a011bdb61f5', '2018-02-28 12:07:28', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '110');
INSERT INTO `e_performance` VALUES ('21d01871-cdcf-420d-bb17-efc7a78caafb', '2018-02-28 13:26:27', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '25');
INSERT INTO `e_performance` VALUES ('2368edbc-4d62-4413-aef3-925d9a337e12', '2018-02-28 12:02:50', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '108');
INSERT INTO `e_performance` VALUES ('25d1d819-2a37-41f6-b7c4-a7393962c591', '2018-02-07 17:14:29', 'public void com.loy.upm.sys.service.impl.RoleServiceImpl.authority(java.lang.String,java.lang.String)', '角色授权', 'upm', '**/role/authority', '118');
INSERT INTO `e_performance` VALUES ('26a4d5aa-986a-477d-a189-78546145c099', '2018-02-28 12:04:35', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '47');
INSERT INTO `e_performance` VALUES ('2ace55c6-22bf-4095-9e3a-a7226306fc41', '2018-02-07 17:12:20', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.UserServiceImpl.queryPage(com.loy.upm.sys.domain.UserQueryParam,org.springframework.data.domain.Pageable)', '查询用户', 'upm', '**/user/page', '28');
INSERT INTO `e_performance` VALUES ('316c1dbc-7543-4f60-afed-ef35ceb1295b', '2018-02-07 17:14:18', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.resource(java.lang.String,java.lang.String)', '角色权限', 'upm', '**/role/resource', '11');
INSERT INTO `e_performance` VALUES ('38d80e5e-4cb7-4920-84e4-4739db7457a2', '2018-02-28 15:04:52', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '114');
INSERT INTO `e_performance` VALUES ('39e1473d-93c2-46a0-aedb-5e62e788f569', '2018-02-28 15:05:08', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.resource(java.lang.String,java.lang.String)', '角色权限', 'upm', '**/role/resource', '43');
INSERT INTO `e_performance` VALUES ('3cee1d06-1ffd-4144-9eab-365ae11aace8', '2018-02-07 17:15:36', 'public com.loy.e.data.permission.domain.entity.DataStrategyEntity com.loy.e.data.permission.service.impl.DataStrategyServiceImpl.save(com.loy.e.data.permission.domain.entity.DataStrategyEntity)', '保存权限策略', 'upm', '**/strategy/save', '86');
INSERT INTO `e_performance` VALUES ('3dd3b51e-191e-438d-8b69-1bde30ae3d9e', '2018-02-07 17:14:15', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.RoleServiceImpl.queryPage(com.loy.upm.sys.domain.RoleQueryParam,org.springframework.data.domain.Pageable)', '分页查询角色', 'upm', '**/role/page', '7');
INSERT INTO `e_performance` VALUES ('3e5fa595-663d-44f7-b4d0-cb3c45a39686', '2018-02-28 18:01:34', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.UserServiceImpl.queryPage(com.loy.upm.sys.domain.UserQueryParam,org.springframework.data.domain.Pageable)', '查询用户', 'upm', '**/user/page', '32');
INSERT INTO `e_performance` VALUES ('40a2970a-650b-4d41-8706-0f06df9d1da5', '2018-02-07 17:12:39', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '12');
INSERT INTO `e_performance` VALUES ('466ee8cf-795c-459b-abc0-3f77ba445caa', '2018-02-28 15:06:38', 'public com.loy.e.data.permission.domain.entity.DataStrategyEntity com.loy.e.data.permission.service.impl.DataStrategyServiceImpl.get(java.lang.String)', '获取权限策略', 'upm', '**/strategy/get', '2');
INSERT INTO `e_performance` VALUES ('47bffb1e-d8ea-4af5-aec1-5062cf9d0c44', '2018-02-28 14:14:29', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '3');
INSERT INTO `e_performance` VALUES ('4c77a4ab-7b3c-4c76-a598-f94cdee9961f', '2018-02-28 14:14:07', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '7');
INSERT INTO `e_performance` VALUES ('574d8d82-03f0-47f5-baf4-2917a8f91449', '2018-02-28 15:08:00', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '66');
INSERT INTO `e_performance` VALUES ('59c83a3b-d7ed-489e-9085-3d3326cee2f4', '2018-02-28 18:01:04', 'public com.loy.e.data.permission.domain.entity.DataStrategyEntity com.loy.e.data.permission.service.impl.DataStrategyServiceImpl.get(java.lang.String)', '获取权限策略', 'upm', '**/strategy/get', '4');
INSERT INTO `e_performance` VALUES ('5d53fc84-cfda-4223-b046-61086aad9950', '2018-02-28 14:13:34', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '30');
INSERT INTO `e_performance` VALUES ('5ecb984c-adc4-456e-bc13-6cf4a60768f4', '2018-02-28 14:13:38', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '20');
INSERT INTO `e_performance` VALUES ('60078b45-eaee-496b-bf10-420aa85bcd5f', '2018-02-28 18:01:19', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.RoleServiceImpl.queryPage(com.loy.upm.sys.domain.RoleQueryParam,org.springframework.data.domain.Pageable)', '分页查询角色', 'upm', '**/role/page', '25');
INSERT INTO `e_performance` VALUES ('600a6b60-67ed-412f-a6c1-c1789fc466f5', '2018-02-28 13:29:01', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '29');
INSERT INTO `e_performance` VALUES ('6441babb-cffd-4a5b-8e3a-9a6b9b86a32e', '2018-02-28 13:18:18', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '29');
INSERT INTO `e_performance` VALUES ('648089e4-f131-4e2b-ab83-74f98250fec6', '2018-02-27 20:24:12', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '107');
INSERT INTO `e_performance` VALUES ('6642a08b-f0c8-4e68-9357-655b2937c121', '2018-02-07 17:13:51', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '11');
INSERT INTO `e_performance` VALUES ('688bdb27-37e5-4296-b278-7ec596745c9b', '2018-02-28 14:56:59', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '3');
INSERT INTO `e_performance` VALUES ('6f54caee-c2f7-4b20-9020-230d05a82ebd', '2018-02-28 18:08:20', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '9');
INSERT INTO `e_performance` VALUES ('71fda0b0-9afa-41bc-a70b-f8450e0801ed', '2018-02-28 18:00:40', 'public void com.loy.e.data.permission.service.impl.DataStrategyServiceImpl.update(com.loy.e.data.permission.domain.entity.DataStrategyEntity)', '修改权限策略', 'upm', '**/strategy/update', '79');
INSERT INTO `e_performance` VALUES ('74319f8a-a29b-4888-93fd-00abc42d67ee', '2018-02-28 14:14:24', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '28');
INSERT INTO `e_performance` VALUES ('7684f6d0-b690-4e08-94f6-1681e8123700', '2018-02-28 18:00:14', 'public com.loy.e.data.permission.domain.entity.DataStrategyEntity com.loy.e.data.permission.service.impl.DataStrategyServiceImpl.get(java.lang.String)', '获取权限策略', 'upm', '**/strategy/get', '5');
INSERT INTO `e_performance` VALUES ('794bf86a-217d-4d7b-83e0-6585f8726d43', '2018-02-07 17:13:29', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '10');
INSERT INTO `e_performance` VALUES ('81728e20-ddd8-4feb-8e57-7808a5508249', '2018-02-07 17:12:44', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '7');
INSERT INTO `e_performance` VALUES ('842ac9a7-3a11-4b98-ac5c-a16be6765d76', '2018-02-28 13:25:28', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '19');
INSERT INTO `e_performance` VALUES ('86992a1e-e645-4f8b-a4ce-6a845c723ec6', '2018-02-28 14:57:18', 'public com.xx.demo.test.domain.entity.CustomerEntity com.xx.demo.test.service.impl.CustomerServiceImpl.get(java.lang.String)', '获取客户', 'upm', '**/customer/get', '2');
INSERT INTO `e_performance` VALUES ('892e4b1b-af16-4469-ba00-4f40914216d2', '2018-02-28 12:04:34', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '26');
INSERT INTO `e_performance` VALUES ('8ed8eca1-008a-49b0-b6db-5374d9e1a809', '2018-02-28 13:29:15', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '111');
INSERT INTO `e_performance` VALUES ('8ee6a10d-e68f-4246-8420-cb4592de0636', '2018-02-28 17:59:57', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '49');
INSERT INTO `e_performance` VALUES ('9500c091-7292-41dc-a948-d967bbf8b766', '2018-02-28 11:35:19', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '34');
INSERT INTO `e_performance` VALUES ('9725d502-385e-48b4-965b-6115cf3ea12c', '2018-02-28 11:33:28', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '143');
INSERT INTO `e_performance` VALUES ('98182862-028b-420c-b9ce-f339697a3c39', '2018-02-28 18:01:22', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.resource(java.lang.String,java.lang.String)', '角色权限', 'upm', '**/role/resource', '44');
INSERT INTO `e_performance` VALUES ('982f4451-65c9-4f46-a547-9d83925f0274', '2018-02-28 18:01:41', 'public void com.loy.upm.sys.service.impl.UserServiceImpl.update(com.loy.upm.sys.domain.entity.UserEntity)', '修改用户', 'upm', '**/user/update', '122');
INSERT INTO `e_performance` VALUES ('9f1106c7-0cc0-421b-af22-e08b1e532d7f', '2018-02-28 17:59:46', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '126');
INSERT INTO `e_performance` VALUES ('a0d8fe7f-4592-416c-a076-767bdfb97e4a', '2018-02-07 17:12:21', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.RoleServiceImpl.queryPage(com.loy.upm.sys.domain.RoleQueryParam,org.springframework.data.domain.Pageable)', '分页查询角色', 'upm', '**/role/page', '20');
INSERT INTO `e_performance` VALUES ('a25f8ecb-c3f4-45f9-8566-f6cf7440529c', '2018-02-07 17:14:41', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.RoleServiceImpl.queryPage(com.loy.upm.sys.domain.RoleQueryParam,org.springframework.data.domain.Pageable)', '分页查询角色', 'upm', '**/role/page', '14');
INSERT INTO `e_performance` VALUES ('a52a5b72-595a-443d-b165-28a91fca5915', '2018-02-28 12:05:26', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '28');
INSERT INTO `e_performance` VALUES ('a5859343-5ad8-4db3-90a1-8cc335bf9215', '2018-02-28 11:44:49', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '25');
INSERT INTO `e_performance` VALUES ('a5cd9adb-038a-48e2-96de-8df5a8a0db4e', '2018-02-28 12:04:32', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '24');
INSERT INTO `e_performance` VALUES ('aacfc8e5-4ba0-4dcc-b014-38b982b7fbd7', '2018-02-28 12:04:31', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '28');
INSERT INTO `e_performance` VALUES ('ab675167-368c-41a6-897d-f80c84723bf3', '2018-02-28 15:05:00', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.UserServiceImpl.queryPage(com.loy.upm.sys.domain.UserQueryParam,org.springframework.data.domain.Pageable)', '查询用户', 'upm', '**/user/page', '18');
INSERT INTO `e_performance` VALUES ('b146c7a6-dcd5-4c15-b650-ed43a5e00cdf', '2018-02-28 14:56:23', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '29');
INSERT INTO `e_performance` VALUES ('b79ff47b-3a8d-4639-b15c-a9fa0eb1a073', '2018-02-28 15:08:06', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '12');
INSERT INTO `e_performance` VALUES ('bdf86172-1b97-423a-b6ce-bf1acf146958', '2018-02-07 17:15:01', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.all()', '获取角色树', 'upm', '**/role/all', '9');
INSERT INTO `e_performance` VALUES ('be1f736a-9c83-4476-9350-6dc24549cd6e', '2018-02-28 13:18:14', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '116');
INSERT INTO `e_performance` VALUES ('be9eb8b4-bf01-48ed-8c2f-ee59696a5f41', '2018-02-28 18:01:41', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.UserServiceImpl.queryPage(com.loy.upm.sys.domain.UserQueryParam,org.springframework.data.domain.Pageable)', '查询用户', 'upm', '**/user/page', '8');
INSERT INTO `e_performance` VALUES ('c003d8c8-e91a-4d1b-880b-0208ed43a331', '2018-02-27 15:49:06', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '129');
INSERT INTO `e_performance` VALUES ('c0520d8b-702c-4d48-a644-5dc6cc1d2a34', '2018-02-07 17:14:52', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.all()', '获取角色树', 'upm', '**/role/all', '8');
INSERT INTO `e_performance` VALUES ('c3c056bd-431c-41bf-8aae-62b4ebcd9820', '2018-02-28 12:07:30', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '16');
INSERT INTO `e_performance` VALUES ('d0aa4b77-efa4-4732-83c9-acec17bfae71', '2018-02-07 17:13:51', 'public com.xx.demo.test.domain.entity.CompanyEntity com.xx.demo.test.service.impl.CompanyServiceImpl.save(com.xx.demo.test.domain.entity.CompanyEntity)', '保存公司', 'upm', '**/company/save', '88');
INSERT INTO `e_performance` VALUES ('d108f881-8b9f-4461-8488-b64e9e62692e', '2018-02-28 14:14:26', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '8');
INSERT INTO `e_performance` VALUES ('d1d08c9f-f0ee-434a-813a-61b7b1abd747', '2018-02-07 17:14:12', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.UserServiceImpl.queryPage(com.loy.upm.sys.domain.UserQueryParam,org.springframework.data.domain.Pageable)', '查询用户', 'upm', '**/user/page', '7');
INSERT INTO `e_performance` VALUES ('d4532034-b3a3-49d5-a819-455ebd844ec6', '2018-02-28 15:04:57', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.RoleServiceImpl.queryPage(com.loy.upm.sys.domain.RoleQueryParam,org.springframework.data.domain.Pageable)', '分页查询角色', 'upm', '**/role/page', '34');
INSERT INTO `e_performance` VALUES ('d6c54a90-d6e6-4c38-9689-d3eab03a3c14', '2018-02-28 15:09:28', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '24');
INSERT INTO `e_performance` VALUES ('da34f54b-312b-4e66-bb47-5a00d0aed389', '2018-02-28 13:24:16', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '25');
INSERT INTO `e_performance` VALUES ('dc604c1a-0d88-4abc-a148-929f15e10239', '2018-02-07 17:12:42', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '19');
INSERT INTO `e_performance` VALUES ('e015901f-61ed-4d75-a342-e24554c59603', '2018-02-07 17:14:31', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '12');
INSERT INTO `e_performance` VALUES ('e1bfb0e7-0a22-48d1-96fe-295fc6485ea5', '2018-02-28 15:06:35', 'public java.util.List com.loy.e.data.permission.service.impl.DataStrategyServiceImpl.roles(java.lang.String)', '权限策略角色', 'upm', '**/strategy/roles', '35');
INSERT INTO `e_performance` VALUES ('e3618af2-d21b-4a6e-8db7-d220834602ca', '2018-02-28 11:42:05', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '111');
INSERT INTO `e_performance` VALUES ('e422d97f-adb2-4f81-b570-91ce6e3ab753', '2018-02-28 14:56:28', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.UserServiceImpl.queryPage(com.loy.upm.sys.domain.UserQueryParam,org.springframework.data.domain.Pageable)', '查询用户', 'upm', '**/user/page', '23');
INSERT INTO `e_performance` VALUES ('e4cb7337-a81e-4e6d-b199-bc5d09adfb83', '2018-02-28 15:06:23', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.resource(java.lang.String,java.lang.String)', '角色权限', 'upm', '**/role/resource', '27');
INSERT INTO `e_performance` VALUES ('e57a2170-7924-4ca7-9426-1ba920c626c1', '2018-02-07 17:13:19', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '5');
INSERT INTO `e_performance` VALUES ('e593970a-f6f8-48fa-b1d3-64b0373d57c3', '2018-02-27 20:24:24', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '126');
INSERT INTO `e_performance` VALUES ('e7b7cbbc-cbd0-4e5f-8ab0-878b618b389c', '2018-02-28 17:59:56', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CustomerServiceImpl.queryPage(com.xx.demo.test.domain.CustomerQueryParam,org.springframework.data.domain.Pageable)', '分页查询客户', 'upm', '**/customer/page', '209');
INSERT INTO `e_performance` VALUES ('ebb38a89-bafc-4018-9d62-b0a2cce94cb2', '2018-02-07 17:12:24', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.resource(java.lang.String,java.lang.String)', '角色权限', 'upm', '**/role/resource', '41');
INSERT INTO `e_performance` VALUES ('ecede1fc-546b-47fc-b6dc-19f5e0bbcc67', '2018-02-28 15:06:10', 'public java.util.List com.loy.upm.sys.service.impl.RoleServiceImpl.all()', '获取角色树', 'upm', '**/role/all', '15');
INSERT INTO `e_performance` VALUES ('f12a97ae-3d67-446e-a700-215fb13d1568', '2018-02-28 14:14:03', 'public com.xx.demo.test.domain.entity.CustomerEntity com.xx.demo.test.service.impl.CustomerServiceImpl.get(java.lang.String)', '获取客户', 'upm', '**/customer/get', '7');
INSERT INTO `e_performance` VALUES ('f12d2ea7-89de-4f0f-b22f-f000e114fd9c', '2018-02-28 12:06:30', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '46');
INSERT INTO `e_performance` VALUES ('f1fed802-c198-4d51-b580-03f32d2e9df9', '2018-02-28 14:56:32', 'public org.springframework.data.domain.Page com.loy.upm.sys.service.impl.RoleServiceImpl.queryPage(com.loy.upm.sys.domain.RoleQueryParam,org.springframework.data.domain.Pageable)', '分页查询角色', 'upm', '**/role/page', '23');
INSERT INTO `e_performance` VALUES ('f2d8efca-53d1-4d82-8e8e-7ce9b63f492c', '2018-02-28 14:56:58', 'public org.springframework.data.domain.Page com.xx.demo.test.service.impl.CompanyServiceImpl.queryPage(com.xx.demo.test.domain.CompanyQueryParam,org.springframework.data.domain.Pageable)', '分页查询公司', 'upm', '**/company/page', '16');
INSERT INTO `e_performance` VALUES ('f73bb25d-cb44-4b81-9fac-807d87cba240', '2018-02-07 17:11:57', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '88');
INSERT INTO `e_performance` VALUES ('fab8af6c-73b4-45a7-bc63-2dbca6c49496', '2018-02-28 13:23:44', 'public com.loy.e.common.vo.IndexData com.loy.upm.sys.service.impl.HomePageService.getIndexData(java.lang.String)', '主页数据', 'upm', '**/indexData', '33');

-- ----------------------------
-- Table structure for e_resource
-- ----------------------------
DROP TABLE IF EXISTS `e_resource`;
CREATE TABLE `e_resource` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `access_code` varchar(50) DEFAULT NULL,
  `available` bit(1) DEFAULT NULL,
  `cls` varchar(50) DEFAULT NULL,
  `lable_key` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `permission` varchar(100) DEFAULT NULL,
  `resource_type` varchar(10) DEFAULT NULL,
  `sort_num` int(11) DEFAULT NULL,
  `system_id` varchar(255) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_resource
-- ----------------------------
INSERT INTO `e_resource` VALUES ('01', null, null, null, null, null, '', 'menu-icon fa fa-desktop', 'menu.upm.sys_manage', '系统管理', null, null, 'MENU', '10', 'upm', '');
INSERT INTO `e_resource` VALUES ('0101', null, null, null, null, null, '', 'menu-icon fa fa-caret-right', 'menu.upm.user_manage', '用户管理', '01', null, 'MENU', '10', 'upm', 'upm-ui/sys/user_index.html');
INSERT INTO `e_resource` VALUES ('0102', null, null, null, null, null, '', 'menu-icon fa fa-caret-right', 'menu.upm.role_manage', '角色管理', '01', null, 'MENU', '20', 'upm', 'upm-ui/sys/role_index.html');
INSERT INTO `e_resource` VALUES ('010201', null, null, null, null, 'role:save', '', null, 'menu.add', '新增', '0102', null, 'BUTTON', null, 'upm', 'role/save');
INSERT INTO `e_resource` VALUES ('010202', null, null, null, null, 'role:update', '', null, 'menu.edit', '编辑', '0102', null, 'BUTTON', null, 'upm', 'role/update');
INSERT INTO `e_resource` VALUES ('010203', null, null, null, null, 'role:authority', '', null, 'menu.upm.role_authority', '授权', '0102', null, 'BUTTON', null, 'upm', 'role/authority');
INSERT INTO `e_resource` VALUES ('02', null, null, null, null, null, '', 'menu-icon fa fa-list', 'menu.log.trace_manage', '跟踪管理', null, null, 'MENU', '20', 'log', '');
INSERT INTO `e_resource` VALUES ('0201', null, null, null, null, null, '', 'menu-icon fa fa-caret-right', 'menu.log.monitor_manage', '监控管理', '02', null, 'MENU', '20', 'log', 'log-ui/log/monitor_index.html');
INSERT INTO `e_resource` VALUES ('0202', null, null, null, null, null, '', 'menu-icon fa fa-caret-right', 'menu.log.log_manage', '操作日志', '02', null, 'MENU', '30', 'log', 'log-ui/log/log_index.html');
INSERT INTO `e_resource` VALUES ('020201', null, null, null, null, 'operation:page', '', null, 'menu.page_search', '分页查询', '0202', null, 'BUTTON', null, 'log', 'operation/page');
INSERT INTO `e_resource` VALUES ('authority_resource', null, null, null, null, 'authority:resource', '', null, 'menu.upm.authority_resource', '授权资源', '0102', null, 'CLIENT', null, 'upm', 'authority/resource');
INSERT INTO `e_resource` VALUES ('com_xx_demo_test_company', null, null, null, null, null, '', 'menu-icon fa fa-caret-right', 'menu.demo.test.company_manage', '公司', 'demo', null, 'MENU', '20', 'demo', 'demo-ui/demo/test/company_index.html');
INSERT INTO `e_resource` VALUES ('com_xx_demo_test_company_add', null, null, null, null, 'company:save', '', null, 'menu.add', '新增', 'com_xx_demo_test_company', null, 'BUTTON', null, 'demo', 'company/save');
INSERT INTO `e_resource` VALUES ('com_xx_demo_test_company_delete', null, null, null, null, 'company:delete', '', null, 'menu.delete', '删除', 'com_xx_demo_test_company', null, 'BUTTON', null, 'demo', 'company/delete');
INSERT INTO `e_resource` VALUES ('com_xx_demo_test_company_edit', null, null, null, null, 'company:update', '', null, 'menu.edit', '编辑', 'com_xx_demo_test_company', null, 'BUTTON', null, 'demo', 'company/update');
INSERT INTO `e_resource` VALUES ('com_xx_demo_test_customer', null, null, null, null, null, '', 'menu-icon fa fa-caret-right', 'menu.demo.test.customer_manage', '客户', 'demo', null, 'MENU', '20', 'demo', 'demo-ui/demo/test/customer_index.html');
INSERT INTO `e_resource` VALUES ('com_xx_demo_test_customer_add', null, null, null, null, 'customer:save', '', null, 'menu.add', '新增', 'com_xx_demo_test_customer', null, 'BUTTON', null, 'demo', 'customer/save');
INSERT INTO `e_resource` VALUES ('com_xx_demo_test_customer_delete', null, null, null, null, 'customer:delete', '', null, 'menu.delete', '删除', 'com_xx_demo_test_customer', null, 'BUTTON', null, 'demo', 'customer/delete');
INSERT INTO `e_resource` VALUES ('com_xx_demo_test_customer_edit', null, null, null, null, 'customer:update', '', null, 'menu.edit', '编辑', 'com_xx_demo_test_customer', null, 'BUTTON', null, 'demo', 'customer/update');
INSERT INTO `e_resource` VALUES ('demo', null, null, null, null, null, '', 'menu-icon fa fa-book', 'menu.demo.example_manage', '例子', null, null, 'MENU', '30', 'demo', '');
INSERT INTO `e_resource` VALUES ('strategy', null, null, null, null, null, '', 'menu-icon fa fa-caret-right', 'menu.upm.strategy_manage', '数据权限', '01', null, 'MENU', '50', 'upm', 'upm-ui/data_permission/strategy_index.html');
INSERT INTO `e_resource` VALUES ('strategy_01', null, null, null, null, 'strategy:save', '', null, 'menu.add', '新增', 'strategy', null, 'BUTTON', null, 'upm', 'strategy/save');
INSERT INTO `e_resource` VALUES ('strategy_02', null, null, null, null, 'strategy:update', '', null, 'menu.edit', '编辑', 'strategy', null, 'BUTTON', null, 'upm', 'strategy/update');
INSERT INTO `e_resource` VALUES ('strategy_03', null, null, null, null, 'strategy:authority:role', '', null, 'menu.upm.role_authority', '授权', 'strategy', null, 'BUTTON', null, 'upm', 'strategy/role/authority');
INSERT INTO `e_resource` VALUES ('strategy_04', null, null, null, null, 'strategy:del', '', null, 'menu.delete', '删除', 'strategy', null, 'BUTTON', null, 'upm', 'strategy/del');

-- ----------------------------
-- Table structure for e_role
-- ----------------------------
DROP TABLE IF EXISTS `e_role`;
CREATE TABLE `e_role` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_role
-- ----------------------------
INSERT INTO `e_role` VALUES ('ADMIN', null, null, '2018-02-07 17:14:28', null, 'ADMIN', 'ADMIN');
INSERT INTO `e_role` VALUES ('SERVICE_CLIENT', null, null, null, null, 'SERVICE CLIENT', 'SERVICE CLIENT');

-- ----------------------------
-- Table structure for e_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `e_role_resource`;
CREATE TABLE `e_role_resource` (
  `role_id` varchar(36) NOT NULL,
  `resource_id` varchar(36) NOT NULL,
  PRIMARY KEY (`role_id`,`resource_id`),
  KEY `FKkykuf0ioe3j0uctgtbqrqggmn` (`resource_id`),
  CONSTRAINT `FK4ph318le8xneo832xo8hkkhqv` FOREIGN KEY (`role_id`) REFERENCES `e_role` (`id`),
  CONSTRAINT `FKkykuf0ioe3j0uctgtbqrqggmn` FOREIGN KEY (`resource_id`) REFERENCES `e_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_role_resource
-- ----------------------------
INSERT INTO `e_role_resource` VALUES ('ADMIN', '01');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '0101');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '0102');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '010201');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '010202');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '010203');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '02');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '0201');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '0202');
INSERT INTO `e_role_resource` VALUES ('ADMIN', '020201');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'authority_resource');
INSERT INTO `e_role_resource` VALUES ('SERVICE_CLIENT', 'authority_resource');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'com_xx_demo_test_company');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'com_xx_demo_test_company_add');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'com_xx_demo_test_company_delete');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'com_xx_demo_test_company_edit');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'com_xx_demo_test_customer');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'com_xx_demo_test_customer_add');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'com_xx_demo_test_customer_delete');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'com_xx_demo_test_customer_edit');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'demo');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'strategy');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'strategy_01');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'strategy_02');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'strategy_03');
INSERT INTO `e_role_resource` VALUES ('ADMIN', 'strategy_04');

-- ----------------------------
-- Table structure for e_seq
-- ----------------------------
DROP TABLE IF EXISTS `e_seq`;
CREATE TABLE `e_seq` (
  `id` varchar(36) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `seq_key` varchar(36) NOT NULL,
  `seq_num` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_seq_key` (`seq_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_seq
-- ----------------------------

-- ----------------------------
-- Table structure for e_strategy_role
-- ----------------------------
DROP TABLE IF EXISTS `e_strategy_role`;
CREATE TABLE `e_strategy_role` (
  `strategy_id` varchar(36) NOT NULL,
  `role_id` varchar(36) NOT NULL,
  PRIMARY KEY (`strategy_id`,`role_id`),
  KEY `FKne7quroxwsoubm75y5fu6bq2s` (`role_id`),
  CONSTRAINT `FKne7quroxwsoubm75y5fu6bq2s` FOREIGN KEY (`role_id`) REFERENCES `e_role` (`id`),
  CONSTRAINT `FKryumo3pj6c7n52f9ulk05908k` FOREIGN KEY (`strategy_id`) REFERENCES `e_data_strategy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_strategy_role
-- ----------------------------
INSERT INTO `e_strategy_role` VALUES ('dc1f1785-9589-40df-a424-3edbda8d1344', 'ADMIN');
INSERT INTO `e_strategy_role` VALUES ('dc1f1785-9589-40df-a424-3edbda8d1344', 'SERVICE_CLIENT');

-- ----------------------------
-- Table structure for e_strategy_user
-- ----------------------------
DROP TABLE IF EXISTS `e_strategy_user`;
CREATE TABLE `e_strategy_user` (
  `strategy_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`strategy_id`,`user_id`),
  KEY `FKtj5a1j64as9fmg65s4ly2umu0` (`user_id`),
  CONSTRAINT `FK72wbas3v2t9go596vshd9bj3k` FOREIGN KEY (`strategy_id`) REFERENCES `e_data_strategy` (`id`),
  CONSTRAINT `FKtj5a1j64as9fmg65s4ly2umu0` FOREIGN KEY (`user_id`) REFERENCES `e_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_strategy_user
-- ----------------------------

-- ----------------------------
-- Table structure for e_timed_task
-- ----------------------------
DROP TABLE IF EXISTS `e_timed_task`;
CREATE TABLE `e_timed_task` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `cron` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `exe_method` varchar(255) DEFAULT NULL,
  `init_status` varchar(255) DEFAULT NULL,
  `service_name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `task_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_timed_task
-- ----------------------------

-- ----------------------------
-- Table structure for e_user
-- ----------------------------
DROP TABLE IF EXISTS `e_user`;
CREATE TABLE `e_user` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `deleted` bit(1) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `enabled` bit(1) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `photo_data` longblob,
  `salt` varchar(50) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_user_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_user
-- ----------------------------
INSERT INTO `e_user` VALUES ('ADMIN', '2015-12-15 12:59:33', null, '2018-02-28 18:01:41', null, '\0', '', '', 'Loy', '662a764fe348cb9f2153eef98b1732f5d9ac3233c78409a76ce1f39fbc42ad660ab10322aea38351', '', null, null, 'admin');

-- ----------------------------
-- Table structure for e_user_role
-- ----------------------------
DROP TABLE IF EXISTS `e_user_role`;
CREATE TABLE `e_user_role` (
  `user_id` varchar(36) NOT NULL,
  `role_id` varchar(36) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FKcjdium26n4nifd99y4oh6aglp` (`role_id`),
  CONSTRAINT `FKcjdium26n4nifd99y4oh6aglp` FOREIGN KEY (`role_id`) REFERENCES `e_role` (`id`),
  CONSTRAINT `FKne6fk4kdvk2gqc1luq8jhon20` FOREIGN KEY (`user_id`) REFERENCES `e_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of e_user_role
-- ----------------------------
INSERT INTO `e_user_role` VALUES ('ADMIN', 'ADMIN');
INSERT INTO `e_user_role` VALUES ('ADMIN', 'SERVICE_CLIENT');

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(255) NOT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `authorities` varchar(255) DEFAULT NULL,
  `authorized_grant_types` varchar(255) DEFAULT NULL,
  `autoapprove` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `resource_ids` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `web_server_redirect_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO `oauth_client_details` VALUES ('acme', null, null, null, 'authorization_code,client_credentials,refresh_token', 'true', 'acmesecret', null, null, 'openid', null);

-- ----------------------------
-- Table structure for wc_site
-- ----------------------------
DROP TABLE IF EXISTS `wc_site`;
CREATE TABLE `wc_site` (
  `id` varchar(36) NOT NULL,
  `created_time` datetime DEFAULT NULL,
  `creator_id` varchar(36) DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `modifier_id` varchar(36) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `register_date` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wc_site
-- ----------------------------
