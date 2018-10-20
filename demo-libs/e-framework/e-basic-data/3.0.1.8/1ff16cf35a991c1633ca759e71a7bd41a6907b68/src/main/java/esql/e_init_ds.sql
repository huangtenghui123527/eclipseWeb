INSERT INTO e_resource (id,created_time,creator_id,modified_time,modifier_id,available,name,parent_id,permission,resource_type,url,cls,lable_key,sort_num,access_code,system_id)  VALUES ('basic',NULL,NULL,NULL,NULL,1,'系统设置',NULL,NULL,'MENU',NULL,'menu-icon fa fa-cog','menu.basic.data_manage',20,NULL,'basic');
INSERT INTO e_menu_i18n (id,key_,lang_,value_,system_code) VALUES ('menu.basic.data','menu.basic.data_manage','','系统设置','basic');
INSERT INTO e_menu_i18n (id,key_,lang_,value_,system_code) VALUES ('menu.basic.data_manage_zh_CN','menu.basic.data_manage','zh_CN','系统设置','basic');
INSERT INTO e_menu_i18n (id,key_,lang_,value_,system_code) VALUES ('menu.basic.data_manage_en_US','menu.basic.data_manage','en_US','BasicData MGT','basic');
