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
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.loy.e.basic.data.domain.TimedTaskQueryParam;
import com.loy.e.basic.data.domain.entity.TimedTaskEntity;
import com.loy.e.basic.data.repository.TimedTaskRepository;
import com.loy.e.basic.data.service.DynamicScheduledTaskService;
import com.loy.e.common.annotation.Author;
import com.loy.e.core.annotation.ControllerLogExeTime;
import com.loy.e.core.util.TableToExcelUtil;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
@RestController
@RequestMapping(value={"**/timedTask"}, method={RequestMethod.POST, RequestMethod.GET})
@Transactional
public class TimedTaskServiceImpl {
    @Value(value = "${e.conf.scheduledTaskEnabled:false}")
    Boolean scheduledTaskEnabled = false;
	@Autowired
	DynamicScheduledTaskService dynamicScheduledTaskService;
    @Autowired
    TimedTaskRepository timedTaskRepository;
    @RequestMapping({ "/page" })
    @ControllerLogExeTime(description = "分页查询定时任务", log = false)
    public Page<TimedTaskEntity> queryPage(TimedTaskQueryParam timedTaskQueryParam, Pageable pageable) {
        if (timedTaskQueryParam != null) {
        }
        Page<TimedTaskEntity> page = this.timedTaskRepository.findTimedTaskPage((timedTaskQueryParam), pageable);
        List<TimedTaskEntity> list = page.getContent();
        if(list != null){
            for(TimedTaskEntity timedTaskEntity : list){
                timedTaskEntity.setScheduledTaskEnabled(this.scheduledTaskEnabled);
            }
        }
        return page;
    }
  
  
	@ControllerLogExeTime(description="获取定时任务", log=false)
	@RequestMapping({"/get"})
	public TimedTaskEntity get(String id) {
		TimedTaskEntity timedTaskEntity = (TimedTaskEntity)this.timedTaskRepository.get(id);
		return timedTaskEntity;
	}
	@ControllerLogExeTime(description="查看定时任务", log=false)
	@RequestMapping({"/detail"})
	public TimedTaskEntity detail(String id) {
		TimedTaskEntity timedTaskEntity = (TimedTaskEntity)this.timedTaskRepository.get(id);
		return timedTaskEntity;
	}
	@ControllerLogExeTime(description="删除定时任务")
	@RequestMapping({"/del"})
	public void del(String id) {
		if (StringUtils.isNotEmpty(id)) {
			String[] idsArr = id.split(",");
			if (idsArr != null) {
				for (String idd : idsArr) {
					dynamicScheduledTaskService.delete(idd);
				}
			}
		}
	}
	public void delOne(String id) {
		if (StringUtils.isNotEmpty(id)) {
			TimedTaskEntity timedTaskEntity = (TimedTaskEntity)this.timedTaskRepository.get(id);
			if (timedTaskEntity != null) {
				this.timedTaskRepository.delete(timedTaskEntity);
			}
		}
	}
	
	@RequestMapping({"/save"})
	@ControllerLogExeTime(description="保存定时任务")
	public TimedTaskEntity save(TimedTaskEntity timedTaskEntity) {
		dynamicScheduledTaskService.check(timedTaskEntity);
		timedTaskEntity.setId(null);
		timedTaskEntity.setStatus(TimedTaskEntity.STATUS_STOP);
		if(StringUtils.isEmpty(timedTaskEntity.getInitStatus())){
		    timedTaskEntity.setInitStatus(TimedTaskEntity.STATUS_START);
		}
		this.timedTaskRepository.save(timedTaskEntity);
		return timedTaskEntity;
	}
	@RequestMapping({"/update"})
	@ControllerLogExeTime(description="修改定时任务")
	public void update(TimedTaskEntity timedTaskEntity) {
		dynamicScheduledTaskService.check(timedTaskEntity);
		TimedTaskEntity old = this.timedTaskRepository.get(timedTaskEntity.getId());
		timedTaskEntity.setStatus(old.getStatus());
		this.timedTaskRepository.save(timedTaskEntity);
		if(StringUtils.isEmpty(timedTaskEntity.getInitStatus())){
		    old.setInitStatus(TimedTaskEntity.STATUS_START);
        }else{
            old.setInitStatus(timedTaskEntity.getInitStatus());
        }
		old.setCron(timedTaskEntity.getCron());
		old.setDescription(timedTaskEntity.getDescription());
		old.setExeMethod(timedTaskEntity.getExeMethod());
		old.setServiceName(timedTaskEntity.getServiceName());
        this.timedTaskRepository.save(old);
        
		TimedTaskEntity timedTask = dynamicScheduledTaskService.get(timedTaskEntity.getId());
		if(timedTask != null){
		    timedTask.setExeMethod(timedTaskEntity.getExeMethod());
	        timedTask.setServiceName(timedTaskEntity.getServiceName());
	        timedTask.setCron(timedTaskEntity.getCron());
		}	
	}
  
	@RequestMapping({"/start"})
	@ControllerLogExeTime(description="开启定时任务")
	public void start(String id ) {
		dynamicScheduledTaskService.start(id);
	}
	@RequestMapping({"/stop"})
	@ControllerLogExeTime(description="停止定时任务")
	public void stop(String id ) {
		dynamicScheduledTaskService.stop(id);
	}
	@RequestMapping(value={"/excel"}, method={RequestMethod.POST})
	@ControllerLogExeTime(description="导出定时任务", log=false)
	public void excel(String html, HttpServletResponse response) throws IOException {
		response.setContentType("application/msexcel;charset=UTF-8");
		response.addHeader("Content-Disposition", "attachment;filename=timedTasks.xls");
		OutputStream out = response.getOutputStream();
		TableToExcelUtil.createExcelFormTable("timedTask", html, 1, out);
		out.flush();
		out.close();
	}
}