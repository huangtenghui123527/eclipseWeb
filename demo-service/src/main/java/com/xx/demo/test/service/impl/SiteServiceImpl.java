package com.xx.demo.test.service.impl;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.loy.e.common.util.DateUtil;
import com.loy.e.core.annotation.ControllerLogExeTime;
import com.loy.e.core.query.Direction;
import com.loy.e.core.util.TableToExcelUtil;
import com.loy.e.data.permission.annotation.DataPermission;
import com.xx.demo.test.domain.SiteQueryParam;
import com.xx.demo.test.domain.entity.SiteEntity;
import com.xx.demo.test.repository.SiteRepository;
/**
 * 
 */
@RestController
@RequestMapping(value={"**/site"}, method={RequestMethod.POST, RequestMethod.GET})
@Transactional
public class SiteServiceImpl{

    @Autowired
    SiteRepository siteRepository;
    @RequestMapping({ "/page" })
    @ControllerLogExeTime(description = "分页查询站点", log = false)
    @DataPermission(uniqueKey="SiteServiceImpl.queryPage",findAll=true)
    public Page<SiteEntity> queryPage(SiteQueryParam siteQueryParam, Pageable pageable) {
        if (siteQueryParam != null) {
            processSort(siteQueryParam);
            Date registerDateEnd = siteQueryParam.getRegisterDateEnd();
            if (registerDateEnd != null) {
                registerDateEnd = DateUtil.addOneDay(registerDateEnd);
                siteQueryParam.setRegisterDateEnd(registerDateEnd);
            }
        }
        Page<SiteEntity> page = this.siteRepository.findSitePage((siteQueryParam), pageable);
        return page;
    }
  
  
	@ControllerLogExeTime(description="获取站点", log=false)
	@RequestMapping({"/get"})
	public SiteEntity get(String id) {
		SiteEntity companyEntity = (SiteEntity)this.siteRepository.get(id);
		return companyEntity;
	}
	@ControllerLogExeTime(description="查看公司", log=false)
	@RequestMapping({"/detail"})
	public SiteEntity detail(String id) {
		SiteEntity siteEntity = (SiteEntity)this.siteRepository.get(id);
		return siteEntity;
	}
	@ControllerLogExeTime(description="删除公司")
	@RequestMapping({"/del"})
	public void del(String id) {
		if (StringUtils.isNotEmpty(id)) {
			String[] idsArr = id.split(",");
			if (idsArr != null) {
				for (String idd : idsArr) {
					SiteEntity siteEntity = (SiteEntity)this.siteRepository.get(idd);
					if (siteEntity != null) {
						this.siteRepository.delete(siteEntity);
					}
				}
			}
		}
	}

	@RequestMapping({"/save"})
	@ControllerLogExeTime(description="保存站点")
	public SiteEntity save(SiteEntity siteEntity) {
		siteEntity.setId(null);
		this.siteRepository.save(siteEntity);
		return siteEntity;
	}
	@RequestMapping({"/update"})
	@ControllerLogExeTime(description="修改站点")
	public void update(SiteEntity siteEntity) {
		this.siteRepository.save(siteEntity);
	}
  
  
	@RequestMapping(value={"/excel"}, method={RequestMethod.POST})
	@ControllerLogExeTime(description="导出站点", log=false)
	public void excel(String html, HttpServletResponse response) throws IOException {
		response.setContentType("application/msexcel;charset=UTF-8");
		response.addHeader("Content-Disposition", "attachment;filename=sites.xls");
		OutputStream out = response.getOutputStream();
		TableToExcelUtil.createExcelFormTable("company", html, 1, out);
		out.flush();
		out.close();
	}
	private void processSort(SiteQueryParam siteQueryParam){
		String orderProperity = siteQueryParam.getOrderProperty();
		if (StringUtils.isNotEmpty(orderProperity)) {
			String[] orderProperties = {"registerDate"};
			if (ArrayUtils.contains(orderProperties, orderProperity)) {
				String direction = siteQueryParam.getDirection();
				if ((!Direction.ASC.getInfo().equalsIgnoreCase(direction)) && 
					(!Direction.DESC.getInfo().equalsIgnoreCase(direction))) {
					siteQueryParam.setDirection(Direction.DESC.getInfo());
				}
			}
		}else {
			siteQueryParam.setOrderProperty("");
			siteQueryParam.setDirection("");
		}
	}
}