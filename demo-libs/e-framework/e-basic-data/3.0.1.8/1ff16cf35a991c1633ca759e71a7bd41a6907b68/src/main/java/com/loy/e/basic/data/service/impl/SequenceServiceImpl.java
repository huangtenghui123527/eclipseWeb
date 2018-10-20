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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.loy.e.basic.data.domain.entity.SequenceEntity;
import com.loy.e.basic.data.repository.SequenceRepository;
import com.loy.e.basic.data.service.SequenceService;
import com.loy.e.common.annotation.Author;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
@Service(value="sequenceService")
@Transactional(propagation=Propagation.REQUIRES_NEW)
public class SequenceServiceImpl implements SequenceService {
	@Autowired
	SequenceRepository sequenceRepository;
	
	@Override
	public long getNextSequenceNum(String seqKey) {
		SequenceEntity sequenceEntity = sequenceRepository.getSequenceLockBySeqKey(seqKey);
		long seqNum = sequenceEntity.getSeqNum()+1;
		sequenceEntity.setSeqNum(seqNum);
		sequenceRepository.save(sequenceEntity);
		return seqNum;
	}
	@Override
	public long getNextSequenceNum() {
		SequenceEntity sequenceEntity = sequenceRepository.getSequenceLockBySeqKey("COMMON_SEQ");
		if(sequenceEntity == null) {
			sequenceEntity = new SequenceEntity();
			sequenceEntity.setSeqKey("COMMON_SEQ");
			sequenceEntity.setName("公共序列");
			sequenceEntity.setSeqNum(0L);
		}
		long seqNum = sequenceEntity.getSeqNum()+1;
		sequenceEntity.setSeqNum(seqNum);
		sequenceRepository.save(sequenceEntity);
		return seqNum;
	}

}
