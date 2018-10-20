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
import javax.persistence.Table;

import com.loy.e.common.annotation.Author;
import com.loy.e.core.entity.AbstractEntity;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

@Entity
@Table(name = "e_dictionary")
public class DictionaryEntity extends AbstractEntity<String> {

    private static final long serialVersionUID = 542162235729891334L;

    @Column(length = 100)
    private String i18nKey;
    @Column(length = 100)
    private String code;
    @Column(length = 255)
    private String name;
    @Column
    private Integer sortNum = 0;
    @Column(length = 36)
    private String parentId;

    public String getI18nKey() {
        return i18nKey;
    }

    public void setI18nKey(String i18nKey) {
        this.i18nKey = i18nKey;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSortNum() {
		return sortNum;
	}

	public void setSortNum(Integer sortNum) {
		this.sortNum = sortNum;
	}

	public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
}
