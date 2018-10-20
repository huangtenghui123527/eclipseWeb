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
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.TriggerContext;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.config.ScheduledTask;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.scheduling.config.TriggerTask;
import org.springframework.scheduling.support.CronSequenceGenerator;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Component;

import com.loy.e.basic.data.domain.entity.TimedTaskEntity;
import com.loy.e.basic.data.repository.TimedTaskRepository;
import com.loy.e.basic.data.service.DynamicScheduledTaskService;
import com.loy.e.common.annotation.Author;
import com.loy.e.common.util.Assert;

@Author(author = "Loy Fu", website = "http://www.17jee.com", contact = "qq群 540553957")

@Component(value = "dynamicScheduledTaskService")
public class DynamicScheduledTaskServiceImpl
        implements SchedulingConfigurer, ApplicationContextAware, DynamicScheduledTaskService {

    protected final Log logger = LogFactory.getLog(DynamicScheduledTaskServiceImpl.class);

    private ApplicationContext applicationContext;

    private Map<String, TimedTaskEntity> taskMap = new ConcurrentHashMap<String, TimedTaskEntity>();

    @Autowired
    TimedTaskRepository timedTaskRepository;
    @Autowired
    TimedTaskServiceImpl timedTaskService;

    ScheduledTaskRegistrar taskRegistrar;

    @Value(value = "${e.conf.scheduledTaskEnabled:false}")
    Boolean scheduledTaskEnabled = false;

    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        this.taskRegistrar = taskRegistrar;
        
        if (!scheduledTaskEnabled) { 
            return;
        }
        List<TimedTaskEntity> tasks = timedTaskRepository.findAll();
        if (tasks != null) {
            for (TimedTaskEntity timedTaskEntity : tasks) {
                timedTaskEntity.setStatus(TimedTaskEntity.STATUS_STOP);
                timedTaskRepository.save(timedTaskEntity);
                TimedTaskEntity transientTimedTaskEntity = timedTaskEntity.clone();
                if (timedTaskEntity.getInitStatus().equals(TimedTaskEntity.STATUS_STOP)) {
                    continue;
                }
                scheduleTriggerTask(transientTimedTaskEntity);
                transientTimedTaskEntity.setInitStatus(TimedTaskEntity.STATUS_START);
                taskMap.put(timedTaskEntity.getId(), transientTimedTaskEntity);
            }
        }
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    @Override
    synchronized public TimedTaskEntity get(String id) {
        return this.taskMap.get(id);
    }

    @Override
    synchronized public void start(String id) {
        TimedTaskEntity transientTimedTaskEntity = this.taskMap.get(id);
        TimedTaskEntity timedTaskEntity = null;
        if (transientTimedTaskEntity == null) {
            timedTaskEntity = timedTaskService.get(id);
            if (timedTaskEntity != null) {
                transientTimedTaskEntity = timedTaskEntity.clone();
                transientTimedTaskEntity.setStatus(TimedTaskEntity.STATUS_STOP);
            }
        }
        if (transientTimedTaskEntity != null) {
            if (transientTimedTaskEntity.getStatus().equals(TimedTaskEntity.STATUS_STOP)) {
                scheduleTriggerTask(transientTimedTaskEntity);
                transientTimedTaskEntity.setStatus(TimedTaskEntity.STATUS_START);
            }
        }
    }

    @Override
    synchronized public void stop(String id) {
        TimedTaskEntity transientTimedTaskEntity = this.taskMap.get(id);
        if (transientTimedTaskEntity != null) {
            ScheduledTask scheduledTask = transientTimedTaskEntity.getScheduledTask();
            if (scheduledTask != null) {
                scheduledTask.cancel();
            }
            this.taskMap.remove(id);
            TimedTaskEntity timedTaskEntity = timedTaskService
                    .get(transientTimedTaskEntity.getId());
            if (timedTaskEntity != null) {
                timedTaskEntity.setStatus(TimedTaskEntity.STATUS_STOP);
                this.timedTaskRepository.save(timedTaskEntity);
            }
        }
    }

    @Override
    synchronized public void delete(String id) {
        this.stop(id);
        timedTaskService.delOne(id);
    }

    private void scheduleTriggerTask(TimedTaskEntity timedTaskEntity) {
        check(timedTaskEntity);
        this.taskMap.put(timedTaskEntity.getId(), timedTaskEntity);
        TriggerTask triggerTask = new TriggerTask(new Runnable() {
            @Override
            public void run() {
                Object serviceObject = applicationContext
                        .getBean(timedTaskEntity.getServiceName());
                try {
                    Method method = serviceObject.getClass()
                            .getMethod(timedTaskEntity.getExeMethod());
                    try {
                        method.invoke(serviceObject);
                    } catch (Throwable e) {
                        logger.error("invode service method  error", e);
                    }
                } catch (Throwable e) {
                    logger.error("get service method  error", e);
                }
            }
        }, new Trigger() {
            @Override
            public Date nextExecutionTime(TriggerContext triggerContext) {
                TimedTaskEntity entity = taskMap.get(timedTaskEntity.getId());
                CronTrigger trigger = new CronTrigger(entity.getCron());
                Date nextExecDate = trigger.nextExecutionTime(triggerContext);
                return nextExecDate;
            }
        });
        ScheduledTask scheduledTask = null;
        try {
            scheduledTask = taskRegistrar.scheduleTriggerTask(triggerTask);
        } catch (Throwable e) {
            logger.error("schedule trigger task error", e);
            if(scheduledTask != null){
                this.taskMap.remove(timedTaskEntity.getId());
                scheduledTask.cancel();
            }
        }
        if(scheduledTask != null){
            timedTaskEntity.setScheduledTask(scheduledTask);
            TimedTaskEntity entity = timedTaskRepository.get(timedTaskEntity.getId());
            entity.setStatus(TimedTaskEntity.STATUS_START);
            this.timedTaskRepository.save(entity);
        }
    }

    public void check(TimedTaskEntity timedTaskEntity) {
        String serviceName = timedTaskEntity.getServiceName();
        Object serviceObject = null;
        try {
            serviceObject = applicationContext.getBean(serviceName);
        } catch (Throwable e) {
            logger.error("can't find  service  " + serviceName);
            Assert.throwException("com.loy.e.basic.data.timedTask.notFindService", serviceName);
        }
        serviceObject.getClass();
        String methodName = timedTaskEntity.getExeMethod();
        try {
            serviceObject.getClass().getMethod(methodName);
        } catch (Exception e) {
            logger.error("can't find  method " + methodName);
            Assert.throwException("com.loy.e.basic.data.timedTask.notFindMethod", methodName);
        }
        String cron = timedTaskEntity.getCron();
        boolean flag = false;
        try {
            flag = CronSequenceGenerator.isValidExpression(cron);
        } catch (Exception e) {
            logger.error("cron is error " + cron);
            Assert.throwException("com.loy.e.basic.data.timedTask.cronError", cron);
        }
        if (!flag) {
            Assert.throwException("com.loy.e.basic.data.timedTask.cronError", cron);
        }
    }
}
