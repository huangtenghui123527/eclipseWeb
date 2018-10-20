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
package com.loy.e.basic.data.domain.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import com.loy.e.common.annotation.Author;
import com.loy.e.core.entity.AbstractEntity;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

@Entity
@Table(name = "e_seq",indexes = {
        @Index(columnList = "seqKey", unique = true, name = "index_seq_key") })
public class SequenceEntity extends AbstractEntity<String>{

	private static final long serialVersionUID = -5940309271340763073L;
	@Column(length = 36, nullable = false)
	private String seqKey;
	@Column(length = 100)
	private String name;
	
	private Long seqNum;

	public Long getSeqNum() {
		return seqNum;
	}
	public void setSeqNum(Long seqNum) {
		this.seqNum = seqNum;
	}
	public String getSeqKey() {
		return seqKey;
	}
	public void setSeqKey(String seqKey) {
		this.seqKey = seqKey;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
