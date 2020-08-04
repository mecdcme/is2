/**
 * Copyright 2019 ISTAT
 * <p>
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 * <p>
 * http://ec.europa.eu/idabc/eupl5
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * Licence for the specific language governing permissions and limitations under
 * the Licence.
 *
 * @author Francesco Amato <framato @ istat.it>
 * @author Mauro Bruno <mbruno @ istat.it>
 * @author Paolo Francescangeli  <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
package it.istat.is2.workflow.service;

import it.istat.is2.workflow.dao.AppServiceDao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.workflow.dao.BusinessServiceDao;
import it.istat.is2.workflow.dao.GsbpmProcessDao;
import it.istat.is2.workflow.dao.StepInstanceDao;
import it.istat.is2.workflow.domain.AppService;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.domain.GsbpmProcess;
import it.istat.is2.workflow.domain.StepInstance;

import java.util.ArrayList;

@Service
public class BusinessServiceService {

    @Autowired
    BusinessServiceDao businessServiceDao;

    @Autowired
    GsbpmProcessDao gsbpmProcessDao;

    @Autowired
    AppServiceDao appServiceDao;

    @Autowired
    StepInstanceDao stepInstanceDao;

    public List<BusinessService> findBusinessServices() {
        return (List<BusinessService>) businessServiceDao.findAll();
    }

    public BusinessService findBusinessServiceById(Long l) {
        return businessServiceDao.findById(l).orElse(null);
    }

    public BusinessService save(BusinessService businessService) {
        BusinessService bs = businessServiceDao.save(businessService);
        return bs;
    }

    public List<BusinessService> findBusinessServiceByIdGsbpm(Long idGsbpm) {
        List<BusinessService> businessServices = null;
        GsbpmProcess gsbpmProcess = gsbpmProcessDao.findById(idGsbpm).orElse(null);
        if (gsbpmProcess != null) {
            businessServices = businessServiceDao.findByGsbpmProcess(gsbpmProcess);
        }
        return businessServices;
    }

    public List<StepInstance> findStepInstances(Long idBusinessService) {

        List<StepInstance> stepInstances = new ArrayList<>();

        BusinessService businessService = businessServiceDao.findById(idBusinessService).orElse(null);
        if (businessService != null) {
            List<AppService> appServiceList = appServiceDao.findByBusinessService(businessService);
            for (AppService appService : appServiceList) {
                stepInstances.addAll(stepInstanceDao.findByAppService(appService));
            }
        }

        return stepInstances;
    }

    public List<AppService> findAppServices(Long idBusinessService) {
        List<AppService> appServiceList = new ArrayList<>();
        BusinessService businessService = businessServiceDao.findById(idBusinessService).orElse(null);
        if (businessService != null) {
            appServiceList = appServiceDao.findByBusinessService(businessService);
        }
        return appServiceList;
    }

    public void deleteBusinessServiceById(Long idbs) {
        businessServiceDao.deleteById(idbs);
    }

    public void deleteBusinessService(BusinessService bs) {
        businessServiceDao.delete(bs);
    }
}
