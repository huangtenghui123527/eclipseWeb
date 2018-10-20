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

import java.util.List;

import org.springframework.data.jpa.repository.Query;

import com.loy.e.basic.data.domain.DictionaryQueryParam;
import com.loy.e.basic.data.domain.entity.DictionaryEntity;
import com.loy.e.common.annotation.Author;
import com.loy.e.core.query.annotation.DynamicQuery;
import com.loy.e.core.repository.GenericRepository;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

public interface DictionaryRepository extends GenericRepository<DictionaryEntity, String> {
	@Query(value = " from DictionaryEntity x where x.parentId = ?1  order by  x.sortNum asc")
	public List<DictionaryEntity> findByParentId(String parentId);

	DictionaryEntity get(String id);

	@Query(value = " from DictionaryEntity x where  1=1"
			+ "<notEmpty name='name'> and x.name =  :name   </notEmpty>  and x.parentId is null order by  x.sortNum asc ")
	@DynamicQuery
	List<DictionaryEntity> findDictionaryPage(DictionaryQueryParam dictionaryQueryParam);
	
	void delete(String id);

    void delete(DictionaryEntity entity);
	
	DictionaryEntity save(DictionaryEntity entity);
}
