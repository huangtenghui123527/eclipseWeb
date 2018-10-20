package com.loy.e.basic.data.service;

import com.loy.e.basic.data.domain.entity.ConfigParamEntity;
import com.loy.e.basic.data.domain.entity.DictionaryEntity;

public interface BasicDataCacheService {

    public DictionaryEntity getDictionaryCache(String id);

    public DictionaryEntity updateDictionaryCache(DictionaryEntity dictionaryEntity);

    public void delDictionaryCache(DictionaryEntity dictionaryEntity);

    ConfigParamEntity getConfigParamCacheByParamKey(String paramKey);
    
    public ConfigParamEntity updateConfigParamCache(ConfigParamEntity configParamEntity);
}
