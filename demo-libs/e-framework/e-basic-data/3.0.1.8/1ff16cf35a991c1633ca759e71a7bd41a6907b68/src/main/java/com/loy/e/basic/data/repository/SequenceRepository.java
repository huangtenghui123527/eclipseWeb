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

import javax.persistence.LockModeType;

import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;

import com.loy.e.basic.data.domain.entity.SequenceEntity;
import com.loy.e.common.annotation.Author;
import com.loy.e.core.repository.GenericRepository;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
public interface SequenceRepository extends GenericRepository<SequenceEntity, String> {

	@Query(value = "from  SequenceEntity where seqKey = ?1 ")
	@Lock(value = LockModeType.PESSIMISTIC_WRITE)
	public SequenceEntity getSequenceLockBySeqKey(String seqKey);
	
	@Query(value = "from  SequenceEntity where id = ?1 ")
	@Lock(value = LockModeType.PESSIMISTIC_WRITE)
	public SequenceEntity getSequenceLockById(String id);
}