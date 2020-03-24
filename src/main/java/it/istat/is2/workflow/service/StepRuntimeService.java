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

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.workflow.dao.StepRuntimeDao;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.StepRuntime;

@Service
public class StepRuntimeService {

    @Autowired
    StepRuntimeDao stepRuntimeDao;

    public List<StepRuntime> findBStepByIdProcess(Long idelab, Integer idstep) {
        return stepRuntimeDao.findByDataProcessing(new DataProcessing(idelab));
    }

    public StepRuntime findById(Integer idstep) {
        return stepRuntimeDao.findById(idstep).orElse(new StepRuntime());
    }

    public List<StepRuntime> findByAppRole(AppRole ruolo) {
        return stepRuntimeDao.findByAppRole(ruolo);
    }

    public void removeStepRuntimeById(Integer idstep) {
    	stepRuntimeDao.deleteById(idstep);
    }

    public void updateStepRuntime(StepRuntime stepR) {
    	stepRuntimeDao.save(stepR);
    }
}
