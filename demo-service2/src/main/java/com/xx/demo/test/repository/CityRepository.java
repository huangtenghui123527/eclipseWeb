package com.xx.demo.test.repository;

import org.springframework.data.jpa.repository.Query;
import com.loy.e.core.query.annotation.DynamicQuery;
import com.xx.demo.test.domain.entity.CityEntity;
import com.xx.demo.test.domain.CityQueryParam;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;
import com.loy.e.core.repository.GenericRepository;

/**
 * 
 */
public interface CityRepository extends GenericRepository<CityEntity, String> {

    @Query(value=" from CityEntity x where  1=1  ${permissionQL} <notEmpty name='name'> and x.name like  '%${name}%' </notEmpty><notEmpty name='registerDateStart'> and x.registerDate &gt;=  :registerDateStart </notEmpty><notEmpty name='registerDateEnd'> and x.registerDate &lt;=  :registerDateEnd </notEmpty><notEmpty name='phone'> and x.phone like  '%${phone}%' </notEmpty><notEmpty name='orderProperty'>   order by x.${orderProperty} ${direction} </notEmpty>")
    @DynamicQuery
    Page<CityEntity> findCityPage(CityQueryParam siteQueryParam, Pageable pageable);

}