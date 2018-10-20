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
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.scheduling.config.ScheduledTask;

import com.loy.e.common.annotation.Author;
import com.loy.e.core.entity.BaseEntity;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")
@Entity
@Table(name = "e_timed_task")
public class TimedTaskEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;
	public static String STATUS_START = "START";
	public static String STATUS_STOP = "STOP";
	@Column(nullable = true)
	private String taskName;
	@Column(nullable = true)
	private String status = STATUS_STOP;
	private String initStatus = STATUS_START;
	@Column(nullable = true)
	private String cron;
	@Column(nullable = true,length=255)
	private String serviceName;
	@Column(nullable = true,length=255)
	private String exeMethod;
	@Column(nullable = true,length=255)
	private String description;

	@Transient
	ScheduledTask scheduledTask;
	@Transient
	Boolean scheduledTaskEnabled = false; 
	
	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCron() {
		return cron;
	}

	public void setCron(String cron) {
		this.cron = cron;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getExeMethod() {
		return exeMethod;
	}

	public void setExeMethod(String exeMethod) {
		this.exeMethod = exeMethod;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public ScheduledTask getScheduledTask() {
		return scheduledTask;
	}

	public void setScheduledTask(ScheduledTask scheduledTask) {
		this.scheduledTask = scheduledTask;
	}
	
	public String getInitStatus() {
        return initStatus;
    }

    public void setInitStatus(String initStatus) {
        this.initStatus = initStatus;
    }

    public Boolean getScheduledTaskEnabled() {
        return scheduledTaskEnabled;
    }

    public void setScheduledTaskEnabled(Boolean scheduledTaskEnabled) {
        this.scheduledTaskEnabled = scheduledTaskEnabled;
    }

    public TimedTaskEntity clone(){
	    TimedTaskEntity timedTaskEntity = new TimedTaskEntity();
	    timedTaskEntity.setId(this.getId());
	    timedTaskEntity.setCron(this.getCron());
	    timedTaskEntity.setExeMethod(this.getExeMethod());
	    timedTaskEntity.setServiceName(this.getServiceName());
	    timedTaskEntity.setScheduledTask(this.getScheduledTask());
	    return timedTaskEntity;
	}
	
}