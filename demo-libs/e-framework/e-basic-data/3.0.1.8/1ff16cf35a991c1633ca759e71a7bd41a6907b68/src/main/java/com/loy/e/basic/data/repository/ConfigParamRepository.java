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
package com.loy.e.basic.data.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

import com.loy.e.basic.data.domain.ConfigParamQueryParam;
import com.loy.e.basic.data.domain.entity.ConfigParamEntity;
import com.loy.e.common.annotation.Author;
import com.loy.e.core.query.annotation.DynamicQuery;
import com.loy.e.core.repository.GenericRepository;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
public interface ConfigParamRepository extends GenericRepository<ConfigParamEntity, String> {

    @Query(value=" from ConfigParamEntity x where  1=1<notEmpty name='name'> and x.name =  :name </notEmpty>  order by  x.orderNum asc")
    @DynamicQuery
    Page<ConfigParamEntity> findConfigParamPage(ConfigParamQueryParam configParamQueryParam, Pageable pageable);
    
    ConfigParamEntity getByParamKey(String paramKey);
    
	ConfigParamEntity save(ConfigParamEntity entity);
}