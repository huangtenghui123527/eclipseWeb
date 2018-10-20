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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.loy.e.basic.data.domain.DictionaryJQTreeNode;
import com.loy.e.basic.data.domain.DictionaryQueryParam;
import com.loy.e.basic.data.domain.entity.DictionaryEntity;
import com.loy.e.basic.data.domain.entity.I18nEntity;
import com.loy.e.basic.data.repository.DictionaryRepository;
import com.loy.e.basic.data.repository.I18nRepository;
import com.loy.e.basic.data.service.BasicDataCacheService;
import com.loy.e.common.annotation.Author;
import com.loy.e.common.vo.KN;
import com.loy.e.core.annotation.ControllerLogExeTime;
import com.loy.e.core.util.TableToExcelUtil;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
@Transactional
@RestController

public class DictionaryServiceImpl {

    protected final Log logger = LogFactory.getLog(DictionaryServiceImpl.class);

    @Autowired
    DictionaryRepository dictionaryRepository;
    @Autowired
    I18nRepository i18nRepository;
    @Autowired
    BasicDataCacheService basicDataCacheService;
    @RequestMapping(value = "**/dict", method = { RequestMethod.GET, RequestMethod.POST })
    public List<KN> getByGroupId(String groupId, String lang) {
        if (StringUtils.isBlank(groupId)) {
            logger.warn("Dictionary parent id is null");
            return null;
        }
        List<DictionaryEntity> list = dictionaryRepository.findByParentId(groupId);
        List<KN> result = null;
        if (list != null) {
            result = new ArrayList<KN>();
            for (DictionaryEntity dictionaryEntity : list) {
                KN kn = new KN();
                String i18nKey = dictionaryEntity.getI18nKey();
                I18nEntity i18nEntity = i18nRepository.findByKeyAndLang(i18nKey, lang);
                if (i18nEntity != null) {
                    kn.setName(i18nEntity.getValue());
                } else {
                    kn.setName(dictionaryEntity.getName());
                }
                kn.setId(dictionaryEntity.getId());
                result.add(kn);
            }
        }
        return result;
    }

    @RequestMapping(value = "**/dicts", method = { RequestMethod.GET, RequestMethod.POST })
    public Map<String, List<KN>> getByGroupIds(String groups, String lang) {
        Map<String, List<KN>> result = new HashMap<String, List<KN>>();
        if (StringUtils.isBlank(groups)) {
            logger.warn("Dictionary parent ids is null");
            return null;
        }

        String[] groupIdArr = groups.split(",");
        for (String groupId : groupIdArr) {
            List<KN> list = this.getByGroupId(groupId, lang);
            result.put(groupId, list);
        }
        return result;
    }

    @RequestMapping({ "**/dictionary/page" })
    @ControllerLogExeTime(description = "查询数据字典", log = false)
    public Page<DictionaryJQTreeNode> queryPage(DictionaryQueryParam dictionaryQueryParam, Pageable pageable) {

        List<DictionaryEntity> list = null;
        if (dictionaryQueryParam == null || StringUtils.isEmpty(dictionaryQueryParam.getNodeid())) {
            list = this.dictionaryRepository.findDictionaryPage(dictionaryQueryParam);
        } else {
            list = this.dictionaryRepository.findByParentId(dictionaryQueryParam.getNodeid());
        }

        List<DictionaryJQTreeNode> nodes = new ArrayList<DictionaryJQTreeNode>();
        if (list != null) {
            for (DictionaryEntity entity : list) {
                DictionaryJQTreeNode node = new DictionaryJQTreeNode();
                node.setId(entity.getId());
                node.setCode(entity.getCode());
                node.setName(entity.getName());
                node.setI18nKey(entity.getI18nKey());
                node.setSortNum(entity.getSortNum());
                String parentId = entity.getParentId();
                if (parentId != null) {
                    node.setIsLeaf(true);
                    node.setLevel(1);
                }
                node.setParentId(parentId);
                node.setParent(parentId);
                nodes.add(node);
            }
        }
        Page<DictionaryJQTreeNode> page = new PageImpl<DictionaryJQTreeNode>(nodes);
        return page;
    }

    @RequestMapping(value = "**/dictionary/save", method = { RequestMethod.POST, RequestMethod.PUT })
    @ControllerLogExeTime(description = "新增数据字典")

    public DictionaryEntity save(DictionaryEntity dictionaryEntity) {
        dictionaryRepository.save(dictionaryEntity);
        return dictionaryEntity;
    }

    @RequestMapping(value = "**/dictionary/update", method = { RequestMethod.POST, RequestMethod.PUT })
    @ControllerLogExeTime(description = "修改数据字典")
    
    public void update(DictionaryEntity dictionaryEntity) {
        String id = dictionaryEntity.getId();
        DictionaryEntity entity = dictionaryRepository.get(id);
        entity.setCode(dictionaryEntity.getCode());
        entity.setI18nKey(dictionaryEntity.getI18nKey());
        entity.setName(dictionaryEntity.getName());
        entity.setSortNum(dictionaryEntity.getSortNum());
        basicDataCacheService.updateDictionaryCache(entity);
    }

    @ControllerLogExeTime(description = "删除数据字典")
    @RequestMapping({ "**/dictionary/del" })
    public void del(String id) {
        if (StringUtils.isNotEmpty(id)) {
            String[] idsArr = id.split(",");
            if (idsArr != null) {
                for (String idd : idsArr) {
                    DictionaryEntity entity = this.get(idd);
                    if(entity != null){
                        basicDataCacheService.delDictionaryCache(entity);
                        List<DictionaryEntity> list = dictionaryRepository.findByParentId(idd);
                        if (list != null) {
                            for (DictionaryEntity child : list) {
                                basicDataCacheService.delDictionaryCache(child);
                            }
                        }
                    }   
                }
            }
        }
    }

    @ControllerLogExeTime(description = "获取数据字典", log = false)
    @RequestMapping({ "**/dictionary/get" })
    public DictionaryEntity get(String id) {
        DictionaryEntity dictionaryRepository = basicDataCacheService.getDictionaryCache(id);
        return dictionaryRepository;
    }

    @ControllerLogExeTime(description = "查看数据字典", log = false)
    @RequestMapping({ "**/dictionary/detail" })
    public DictionaryEntity detail(String id) {
        DictionaryEntity dictionaryRepository = basicDataCacheService.getDictionaryCache(id);
        return dictionaryRepository;
    }

    @RequestMapping(value = { "**/dictionary/excel" }, method = { RequestMethod.POST })
    @ControllerLogExeTime(description = "导出数据字典", log = false)
    public void excel(String html, HttpServletResponse response) throws IOException {
        response.setContentType("application/msexcel;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=dictionaries.xls");
        OutputStream out = response.getOutputStream();
        TableToExcelUtil.createExcelFormTable("timedTask", html, 1, out);
        out.flush();
        out.close();
    }
}