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
import java.io.InputStream;

import javax.annotation.PostConstruct;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import com.loy.e.common.annotation.Author;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

@Controller
public class TailLogServiceImpl {
	protected final Log logger = LogFactory.getLog(TailLogServiceImpl.class);
	@Value(value = "${e.conf.logFile:/apache-tomcat-8.5.6/logs/catalina.out}")
	private String logFile = "/apache-tomcat-8.5.6/logs/catalina.out";
	@Value(value = "${e.conf.tailDevFlag:true}")
	private boolean tailDevFlag = true;
	@Value(value = "${e.conf.enabledTailProcess:false}")
	private boolean enabledTailProcess = false;
	@Autowired
	private SimpMessageSendingOperations template;
	private Boolean status = false;

	public TailLogServiceImpl(SimpMessageSendingOperations template) {
		this.template = template;
	}

	@PostConstruct
	void init() {
		Process process = null;
		if (!enabledTailProcess) {
			return;
		}
		try {
			if (!tailDevFlag) {
				process = Runtime.getRuntime().exec("tail -500f " + logFile);
				TailLogThread tailLogThread = new TailLogThread(template, process);
				tailLogThread.start();
			} else {
				DevTailLogThread devTailLogThread = new DevTailLogThread(template);
				devTailLogThread.start();
			}
			status = true;
		} catch (Exception e) {
			logger.error("", e);
			if (process != null) {
				InputStream in = process.getInputStream();
				if (in != null) {
					try {
						in.close();
					} catch (IOException ee) {
						logger.error("", ee);
					}
				}
				process.destroy();
			}
		}
	}

	public Boolean getStatus() {
		return status;
	}
}
