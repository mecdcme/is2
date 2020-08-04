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

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import it.istat.is2.workflow.dao.StepInstanceDao;
import it.istat.is2.workflow.domain.StepInstance;

@Service
public class StepInstanceService {

    @Autowired
    StepInstanceDao sepInstanceDao;

    public List<StepInstance> findAllStepInstance() {
        return (List<StepInstance>) sepInstanceDao.findAll();
    }

    public void save(StepInstance stepInstance) {
        sepInstanceDao.save(stepInstance);
    }

    public void deleteStepInstance(StepInstance stepInstance) {
        sepInstanceDao.delete(stepInstance);
    }

    public StepInstance findStepInstanceById(Long id) {
        return (StepInstance) sepInstanceDao.findById(id).orElse(null);
    }

    public void deleteStepInstance(Long id) {
        sepInstanceDao.deleteById(id);
    }
}
