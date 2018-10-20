/*
 * Copyright   Loy Fu. 付厚俊
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/
package com.loy.e.basic.data.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.loy.e.basic.data.domain.entity.ConfigParamEntity;
import com.loy.e.basic.data.domain.entity.DictionaryEntity;
import com.loy.e.basic.data.repository.ConfigParamRepository;
import com.loy.e.basic.data.repository.DictionaryRepository;
import com.loy.e.basic.data.service.BasicDataCacheService;
import com.loy.e.common.annotation.Author;

@Transactional
@Service(value = "basicDataCacheService")
@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

public class BasicDataCacheServiceImpl implements BasicDataCacheService {
    @Autowired
    DictionaryRepository dictionaryRepository;

    @Autowired
    ConfigParamRepository configParamRepository;

    @Override
    @CachePut(cacheNames = "dictionaryCache", key = "#dictionaryEntity.id")
    public DictionaryEntity updateDictionaryCache(DictionaryEntity dictionaryEntity) {
        return dictionaryRepository.save(dictionaryEntity);
    }

    @Override
    @CacheEvict(cacheNames = "dictionaryCache", key = "#dictionaryEntity.id")
    public void delDictionaryCache(DictionaryEntity dictionaryEntity) {
        dictionaryRepository.delete(dictionaryEntity);
    }

    @Override
    @Cacheable(cacheNames = "dictionaryCache")
    public DictionaryEntity getDictionaryCache(String id) {
        return dictionaryRepository.get(id);
    }
    @Override
    @Cacheable(cacheNames = "confParamCache")
    public ConfigParamEntity getConfigParamCacheByParamKey(String paramKey){
        return configParamRepository.getByParamKey(paramKey);
    }
    
    @Override
    @CachePut(cacheNames = "confParamCache", key = "#configParamEntity.paramKey")
    public ConfigParamEntity updateConfigParamCache(ConfigParamEntity configParamEntity) {
        return this.configParamRepository.save(configParamEntity);
    }

   
}
