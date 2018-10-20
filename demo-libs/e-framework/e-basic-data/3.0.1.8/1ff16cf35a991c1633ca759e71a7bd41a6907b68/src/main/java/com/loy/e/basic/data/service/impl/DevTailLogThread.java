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

import java.util.Date;

import org.springframework.messaging.simp.SimpMessageSendingOperations;

import com.loy.e.basic.data.domain.TailLogMessage;
import com.loy.e.common.annotation.Author;
@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
public class DevTailLogThread extends Thread {
	private SimpMessageSendingOperations template;

	public DevTailLogThread(SimpMessageSendingOperations template) {
		this.template = template;
	}

	@Override
	public void run() {
		while(true){
			TailLogMessage tailLogMessage = new TailLogMessage();
			tailLogMessage.setLineMsg("dev test "+new Date());
			template.convertAndSend("/topic/tailLog", tailLogMessage);
			try {
				Thread.sleep(100*10);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}

}
