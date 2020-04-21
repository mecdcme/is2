/**
 * Copyright 2019 ISTAT
 *
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 *
 * http://ec.europa.eu/idabc/eupl5
 *
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

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.workflow.dao.BusinessProcessDao;
import it.istat.is2.workflow.domain.BusinessFunction;
import it.istat.is2.workflow.domain.BusinessProcess;

@Service
public class BusinessProcessService {

    @Autowired
    BusinessProcessDao businessProcessDao;

    public List<BusinessProcess> findBProcessByIdFunction(Long idfunction) {
        List<BusinessFunction> businessFunctions = new ArrayList<>();
        businessFunctions.add(new BusinessFunction(idfunction));
        return businessProcessDao.findByBusinessFunctionsIn(businessFunctions);
    }
    
    public BusinessProcess findBProcessById(long idprocess) {
        return businessProcessDao.findById(idprocess).orElse(null);
    }
    public List<BusinessProcess>  findAllProcesses() {
        return businessProcessDao.findAllProcesses();
    }
	
    public List<BusinessProcess>  findAllSubProcesses() {
        return businessProcessDao.findAllSubProcesses();
    }
	public List<BusinessProcess> findAll() {
		return businessProcessDao.findAll();
	}
	public BusinessProcess updateBProcess(BusinessProcess process) {
   	 
    	return businessProcessDao.save(process);
    }

	public void deleteBProcess(BusinessProcess process) {
		// TODO Auto-generated method stub
		businessProcessDao.delete(process);
	}

	public BusinessProcess findBProcessByName(String name) {
		
		return businessProcessDao.findBProcessByName(name);
	}
}

