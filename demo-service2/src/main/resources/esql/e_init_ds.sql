--demo

--demo city
INSERT INTO e_resource (id,created_time,creator_id,modified_time,modifier_id,available,name,parent_id,permission,resource_type,url,cls,lable_key,sort_num,access_code,system_id)  VALUES ('com_xx_demo_test_city',NULL,NULL,NULL,NULL,1,'区域','demo',NULL,'MENU','demo-ui2/demo/test/city_index.html','menu-icon fa fa-caret-right','menu.demo.test.city_manage',20,NULL,'demo');
INSERT INTO e_role_resource (role_id,resource_id) VALUES ('ADMIN','com_xx_demo_test_city');
INSERT INTO e_menu_i18n (id,key_,lang_,value_,system_code) VALUES ('menu.demo.test.city_manage','menu.demo.test.city_manage','','区域管理','demo');
INSERT INTO e_menu_i18n (id,key_,lang_,value_,system_code) VALUES ('menu.demo.test.city_manage_zh_CN','menu.demo.test.city_manage','zh_CN','区域管理','demo');
INSERT INTO e_menu_i18n (id,key_,lang_,value_,system_code) VALUES ('menu.demo.test.city_manage_en_US','menu.demo.test.city_manage','en_US','City MGT','demo');


INSERT INTO e_resource (id,created_time,creator_id,modified_time,modifier_id,available,name,parent_id,permission,resource_type,url,cls,lable_key,sort_num,access_code,system_id)  VALUES ('com_xx_demo_test_city_add',NULL,NULL,NULL,NULL,1,'新增','com_xx_demo_test_city',NULL,'BUTTON','city/save',NULL,'menu.add',NULL,'city:save','demo');
INSERT INTO e_resource (id,created_time,creator_id,modified_time,modifier_id,available,name,parent_id,permission,resource_type,url,cls,lable_key,sort_num,access_code,system_id)   VALUES ('com_xx_demo_test_city_edit',NULL,NULL,NULL,NULL,1,'编辑','com_xx_demo_test_city',NULL,'BUTTON','city/update',NULL,'menu.edit',NULL,'city:update','demo');
INSERT INTO e_resource (id,created_time,creator_id,modified_time,modifier_id,available,name,parent_id,permission,resource_type,url,cls,lable_key,sort_num,access_code,system_id)   VALUES ('com_xx_demo_test_city_delete',NULL,NULL,NULL,NULL,1,'删除','com_xx_demo_test_city',NULL,'BUTTON','city/del',NULL,'menu.delete',NULL,'city:del','demo');

INSERT INTO e_role_resource (role_id,resource_id) VALUES ('ADMIN','com_xx_demo_test_city_add');
INSERT INTO e_role_resource (role_id,resource_id) VALUES ('ADMIN','com_xx_demo_test_city_edit');
INSERT INTO e_role_resource (role_id,resource_id) VALUES ('ADMIN','com_xx_demo_test_city_delete');