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
package com.loy.e.basic.data.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.loy.e.common.annotation.Author;
@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
@Controller
public class BasicHtmlController {

	@Value(value = "${spring.application.name:}")
	private String applicationName;

	@Value(value = "${server.context-path:#{null}}")
	private String serviceContext;

	@Value(value = "${e.conf.tailLogUrl:ws://www.17jww.com/websocket/tailLog}")
	private String tailLogUrl;

	@RequestMapping(value = { "configParam_index.html", "**/configParam_index.html" })
	public String configParamHtml(Map<String, Object> attr) {
		String serviceContext = this.serviceContext != null?this.serviceContext:applicationName;
		attr.put("serviceContext", serviceContext);
		return "configParam_index";
	}

	@RequestMapping(value = { "timedTask_index.html", "**/timedTask_index.html" })
	public String timedTaskHtml(Map<String, Object> attr) {
		String serviceContext = this.serviceContext != null?this.serviceContext:applicationName;
		attr.put("serviceContext", serviceContext);
		return "timedTask_index";
	}

	@RequestMapping(value = { "tailLog_index.html", "**/tailLog_index.html" })
	public String tailLogHtml(Map<String, Object> attr) {
		attr.put("tailLogUrl", tailLogUrl);
		return "tailLog_index";
	}

	@RequestMapping(value = { "api_index.html", "**/api_index.html" })
	public String apiHtml(Map<String, Object> attr) {
		String serviceContext = this.serviceContext != null?this.serviceContext:applicationName;
		attr.put("serviceContext", serviceContext);
		return "api_index";
	}
	
	@RequestMapping(value = { "cache_index.html", "**/cache_index.html" })
	public String cacheHtml(Map<String, Object> attr) {
		String serviceContext = this.serviceContext != null?this.serviceContext:applicationName;
		attr.put("serviceContext", serviceContext);
		return "cache_index";
	}
	@RequestMapping(value = { "dictionary_index.html", "**/dictionary_index.html" })
	public String dictionaryHtml(Map<String, Object> attr) {
		String serviceContext = this.serviceContext != null?this.serviceContext:applicationName;
		attr.put("serviceContext", serviceContext);
		return "dictionary_index";
	}
}
