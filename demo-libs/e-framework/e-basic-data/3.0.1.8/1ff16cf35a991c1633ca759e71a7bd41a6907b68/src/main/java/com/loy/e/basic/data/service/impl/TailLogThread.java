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

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.messaging.simp.SimpMessageSendingOperations;

import com.loy.e.basic.data.domain.TailLogMessage;
import com.loy.e.common.annotation.Author;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
public class TailLogThread  extends Thread {
	protected final Log logger = LogFactory.getLog(TailLogThread.class);
    private BufferedReader reader;
    private SimpMessageSendingOperations  template;
    public TailLogThread(SimpMessageSendingOperations  template,Process process) {
        this.reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
        this.template = template;
    }
    @Override
    public void run() {
        String line;
        try {
            while((line = reader.readLine()) != null) {
            	TailLogMessage tailLogMessage = new TailLogMessage();
    			tailLogMessage.setLineMsg(line);
    			template.convertAndSend("/topic/tailLog", tailLogMessage);
            }
        } catch (Exception e) {
        	logger.error("", e);
        }
    }
}
