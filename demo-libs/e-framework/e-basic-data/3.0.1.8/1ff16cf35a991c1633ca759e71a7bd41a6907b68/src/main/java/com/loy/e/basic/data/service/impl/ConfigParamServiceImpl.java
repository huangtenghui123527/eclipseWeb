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

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.loy.e.basic.data.domain.ConfigParamQueryParam;
import com.loy.e.basic.data.domain.entity.ConfigParamEntity;
import com.loy.e.basic.data.repository.ConfigParamRepository;
import com.loy.e.basic.data.service.BasicDataCacheService;
import com.loy.e.basic.data.service.ConfigParamService;
import com.loy.e.common.annotation.Author;
import com.loy.e.core.annotation.ControllerLogExeTime;
import com.loy.e.core.exception.LoyException;
import com.loy.e.core.util.TableToExcelUtil;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

@RestController(value = "configParamService")
@RequestMapping(value = { "**/configParam" }, method = { RequestMethod.POST, RequestMethod.GET })
@Transactional

public class ConfigParamServiceImpl implements ConfigParamService {

    @Autowired
    ConfigParamRepository configParamRepository;
    @Autowired
    BasicDataCacheService basicDataCacheService;

    @RequestMapping({ "/page" })
    @ControllerLogExeTime(description = "分页查询参数配置", log = false)
    public Page<ConfigParamEntity> queryPage(ConfigParamQueryParam configParamQueryParam,
            Pageable pageable) {

        Page<ConfigParamEntity> page = this.configParamRepository.findConfigParamPage(
                (configParamQueryParam),
                pageable);
        return page;
    }

    @ControllerLogExeTime(description = "获取参数配置", log = false)
    @RequestMapping({ "/get" })
    public ConfigParamEntity get(String id) {
        ConfigParamEntity configParamEntity = configParamRepository.get(id);
        return configParamEntity;
    }

    @RequestMapping({ "/save" })
    @ControllerLogExeTime(description = "保存参数配置")

    public void save(ConfigParamEntity configParamEntity) {
        configParamEntity.setId(null);
        String value = configParamEntity.getVal();
        String regularExpression = configParamEntity.getRegularExpression();
        if (StringUtils.isNotEmpty(regularExpression)) {
            if (!value.matches(regularExpression)) {
                String errorMsg = "";
                if (StringUtils.isNotEmpty(configParamEntity.getErrorMsg())) {
                    errorMsg = configParamEntity.getErrorMsg();
                }
                LoyException loyException = new LoyException(
                        "com.loy.basic.data.configParam.fmtError", errorMsg);

                throw loyException;
            }
        }
        configParamRepository.save(configParamEntity);

    }
    
    @RequestMapping({ "/update" })
    @ControllerLogExeTime(description = "修改参数配置")

    public void update(ConfigParamEntity configParamEntity) {
        String id = configParamEntity.getId();
        ConfigParamEntity entity = configParamRepository.get(id);
        if (entity == null) {
            if (id == null) {
                id = "";
            }
            LoyException loyException = new LoyException("com.loy.basic.data.configParam.notParam",
                    id);
            throw loyException;
        }
        String value = configParamEntity.getVal();
        String regularExpression = entity.getRegularExpression();
        if (StringUtils.isNotEmpty(regularExpression)) {
            if (!value.matches(regularExpression)) {
                String errorMsg = "";
                if (StringUtils.isNotEmpty(entity.getErrorMsg())) {
                    errorMsg = entity.getErrorMsg();
                }
                LoyException loyException = new LoyException(
                        "com.loy.basic.data.configParam.fmtError", errorMsg);

                throw loyException;
            }
        }
        entity.setVal(value);
        basicDataCacheService.updateConfigParamCache(entity);
    }

    @RequestMapping(value = { "/excel" }, method = { RequestMethod.POST })
    @ControllerLogExeTime(description = "导出参数配置", log = false)
    public void excel(String html, HttpServletResponse response) throws IOException {
        response.setContentType("application/msexcel;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=configParams.xls");
        OutputStream out = response.getOutputStream();
        TableToExcelUtil.createExcelFormTable("configParam", html, 1, out);
        out.flush();
        out.close();
    }

    @Override
    public String getValue(String paramKey) {
        ConfigParamEntity configParamEntity = basicDataCacheService.getConfigParamCacheByParamKey(paramKey);
        if (configParamEntity != null) {
            return configParamEntity.getVal();
        } else {
            LoyException loyException = new LoyException("com.loy.basic.data.configParam.notParam",
                    paramKey);
            throw loyException;
        }
    }

}