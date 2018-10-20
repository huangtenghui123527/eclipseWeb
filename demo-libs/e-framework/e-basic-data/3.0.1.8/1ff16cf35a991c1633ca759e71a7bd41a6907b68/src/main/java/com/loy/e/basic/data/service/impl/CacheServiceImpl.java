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

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.loy.e.basic.data.domain.CacheVO;
import com.loy.e.common.annotation.Author;
import com.loy.e.core.annotation.ControllerLogExeTime;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

@RestController
@RequestMapping(value = { "**/cache" }, method = { RequestMethod.POST, RequestMethod.GET })
public class CacheServiceImpl {

	@Autowired(required = false)
	CacheManager cacheManager;

	@RequestMapping({ "/page" })
	@ControllerLogExeTime(description = "分页查询缓存", log = false)
	public Page<CacheVO> queryPage(Pageable pageable) {
		Collection<String> list = cacheManager.getCacheNames();
		List<CacheVO> rs = new ArrayList<CacheVO>();
		if (list != null) {
			for (String name : list) {
				CacheVO vo = new CacheVO();
				vo.setId(name);
				vo.setName(name);
				Cache cache = cacheManager.getCache(name);
				if(cache != null){
					Object nativeCache = cache.getNativeCache();
					Object value = null;
					if(nativeCache != null){
						Class<? extends Object> clazz = nativeCache.getClass();
						try {
							Method method = clazz.getMethod("size");
							method.setAccessible(true);
							Method m = method;
							value = m.invoke(nativeCache);
						} catch (Throwable e) {
						} 
					}
					if(value != null){
						vo.setInfo("Size:"+value);
					}
				}
				rs.add(vo);
			}
		}
		Page<CacheVO> page = new PageImpl<CacheVO>(rs);
		return page;
	}

	@RequestMapping({ "/clear" })
	@ControllerLogExeTime(description = "分页查询缓存", log = false)
	public void clear(String name) {
		Cache cache = cacheManager.getCache(name);
		if (cache != null) {
			cache.clear();
		}
	}
}
