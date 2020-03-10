package it.istat.is2.workflow.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.workflow.dao.AppServiceDao;
import it.istat.is2.workflow.domain.AppService;

@Service
public class AppServiceService {

	@Autowired
    AppServiceDao appServiceDao;
	
	public List<AppService> findAllAppService() {
        return (List<AppService>) appServiceDao.findAll();
    }
}
