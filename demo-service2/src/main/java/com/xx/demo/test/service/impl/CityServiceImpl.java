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
import com.xx.demo.test.domain.CityQueryParam;
import com.xx.demo.test.domain.entity.CityEntity;
import com.xx.demo.test.repository.CityRepository;
/**
 * 
 */
@RestController
@RequestMapping(value={"**/city"}, method={RequestMethod.POST, RequestMethod.GET})
@Transactional
public class CityServiceImpl{

    @Autowired
    CityRepository cityRepository;
    @RequestMapping({ "/page" })
    @ControllerLogExeTime(description = "分页查询站点", log = false)
    @DataPermission(uniqueKey="CityServiceImpl.queryPage",findAll=true)
    public Page<CityEntity> queryPage(CityQueryParam cityQueryParam, Pageable pageable) {
        if (cityQueryParam != null) {
            processSort(cityQueryParam);
            Date registerDateEnd = cityQueryParam.getRegisterDateEnd();
            if (registerDateEnd != null) {
                registerDateEnd = DateUtil.addOneDay(registerDateEnd);
                cityQueryParam.setRegisterDateEnd(registerDateEnd);
            }
        }
        Page<CityEntity> page = this.cityRepository.findCityPage((cityQueryParam), pageable);
        return page;
    }
  
  
	@ControllerLogExeTime(description="获取区域", log=false)
	@RequestMapping({"/get"})
	public CityEntity get(String id) {
		CityEntity companyEntity = (CityEntity)this.cityRepository.get(id);
		return companyEntity;
	}
	@ControllerLogExeTime(description="查看区域", log=false)
	@RequestMapping({"/detail"})
	public CityEntity detail(String id) {
		CityEntity cityEntity = (CityEntity)this.cityRepository.get(id);
		return cityEntity;
	}
	@ControllerLogExeTime(description="删除区域")
	@RequestMapping({"/del"})
	public void del(String id) {
		if (StringUtils.isNotEmpty(id)) {
			String[] idsArr = id.split(",");
			if (idsArr != null) {
				for (String idd : idsArr) {
					CityEntity cityEntity = (CityEntity)this.cityRepository.get(idd);
					if (cityEntity != null) {
						this.cityRepository.delete(cityEntity);
					}
				}
			}
		}
	}

	@RequestMapping({"/save"})
	@ControllerLogExeTime(description="保存区域")
	public CityEntity save(CityEntity cityEntity) {
		cityEntity.setId(null);
		this.cityRepository.save(cityEntity);
		return cityEntity;
	}
	@RequestMapping({"/update"})
	@ControllerLogExeTime(description="修改区域")
	public void update(CityEntity cityEntity) {
		this.cityRepository.save(cityEntity);
	}
  
  
	@RequestMapping(value={"/excel"}, method={RequestMethod.POST})
	@ControllerLogExeTime(description="导出区域", log=false)
	public void excel(String html, HttpServletResponse response) throws IOException {
		response.setContentType("application/msexcel;charset=UTF-8");
		response.addHeader("Content-Disposition", "attachment;filename=cities.xls");
		OutputStream out = response.getOutputStream();
		TableToExcelUtil.createExcelFormTable("company", html, 1, out);
		out.flush();
		out.close();
	}
	private void processSort(CityQueryParam cityQueryParam){
		String orderProperity = cityQueryParam.getOrderProperty();
		if (StringUtils.isNotEmpty(orderProperity)) {
			String[] orderProperties = {"registerDate"};
			if (ArrayUtils.contains(orderProperties, orderProperity)) {
				String direction = cityQueryParam.getDirection();
				if ((!Direction.ASC.getInfo().equalsIgnoreCase(direction)) && 
					(!Direction.DESC.getInfo().equalsIgnoreCase(direction))) {
					cityQueryParam.setDirection(Direction.DESC.getInfo());
				}
			}
		}else {
			cityQueryParam.setOrderProperty("");
			cityQueryParam.setDirection("");
		}
	}
}