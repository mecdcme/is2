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
 * @version 0.1.1
 */
/**
 *
 */
package it.istat.is2.workflow.batch;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.workflow.dao.BusinessProcessDao;
import it.istat.is2.workflow.engine.EngineFactory;
import it.istat.is2.workflow.service.WorkflowService;

@Service
@Transactional
public class WorkFlowBatchService {


    @Autowired
    private WorkFlowBatchDao workFlowBatchDao;

    @Autowired
    EngineFactory engineFactory;

    @Autowired
    WorkflowService workflowService;

    @Autowired
    BusinessProcessDao businessProcessDao;

    public Batch save(Batch batch) throws Exception {
        return this.workFlowBatchDao.save(batch);
    }

    public List<Batch> findByIdSessione(Long id) {
        return this.workFlowBatchDao.findByIdSessione(id);
    }

    public List<Batch> findByIdSessioneAndIdElaborazione(Long idSess, Long idEl) {
        return this.workFlowBatchDao.findByIdSessioneAndIdElaborazione(idSess, idEl);
    }


    public Optional<Batch> findById(Long id) {
        return this.workFlowBatchDao.findById(id);
    }

}
