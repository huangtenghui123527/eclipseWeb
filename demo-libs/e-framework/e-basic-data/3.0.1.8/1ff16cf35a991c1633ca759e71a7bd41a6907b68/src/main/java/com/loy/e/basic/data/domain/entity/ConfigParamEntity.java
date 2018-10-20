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
import com.loy.e.core.entity.BaseEntity;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

@Entity
@Table(name = "e_config_param", indexes = {
        @Index(columnList = "paramKey", unique = true, name = "index_param_key") })
public class ConfigParamEntity extends BaseEntity {
    private static final long serialVersionUID = 1L;
    @Column(nullable = false)
    private String paramKey;
    @Column(nullable = true)
    private String name;
    @Column(nullable = true)
    private String val;
    @Column(nullable = true)
    private String description;
    @Column(nullable = true)
    private String regularExpression;
    @Column(nullable = true)
    private String errorMsg;
    Integer orderNum = 0;

    public String getParamKey() {
        return paramKey;
    }

    public void setParamKey(String paramKey) {
        this.paramKey = paramKey;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRegularExpression() {
        return regularExpression;
    }

    public void setRegularExpression(String regularExpression) {
        this.regularExpression = regularExpression;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

}