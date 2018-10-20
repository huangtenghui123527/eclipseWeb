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

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import com.loy.e.common.annotation.Author;
@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
@Component(value="timeTaskTestService")
public class TimeTaskTestServiceImpl {
	protected final Log logger = LogFactory.getLog(TimeTaskTestServiceImpl.class);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss S");
	public void  hello(){
	    String time = sdf.format(new Date());
		System.out.println("timed task hello world test....."+time);
		//logger.info("timed task hello world test....."+time);
	}
	
	
	public void  test2(){
	    String time = sdf.format(new Date());
        System.out.println("timed task hello world test2....."+time);
        //logger.info("timed task hello world test....."+time);
    }
}
