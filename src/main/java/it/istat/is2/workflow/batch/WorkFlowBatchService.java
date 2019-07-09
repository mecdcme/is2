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
 * @version 0.1.1
 */
/**
 * 
 */
package it.istat.is2.workflow.batch;

import java.util.List;
import java.util.Optional;

import javax.persistence.EntityManager;
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
	private EntityManager em;

	@Autowired
	private WorkFlowBatchDao workFlowBatchDao;
	
	@Autowired
	EngineFactory engineFactory;
	
	@Autowired 
	WorkflowService workflowService;
	
	@Autowired 
	BusinessProcessDao businessProcessDao;
	
	public Batch save(Batch batch)  throws Exception {
		return this.workFlowBatchDao.save(batch);
	}
	
//	public Batch update(Batch b) throws Exception {
//		Batch batch = null;
//		Query query = null;
//		String queryString = "SELECT * FROM sx_batch WHERE sessione_id=:idSessione AND elab_id=:idElaborazione AND proc_id=:idProcesso AND stato='STARTED' "; 
//		try {
//			query = em.createNativeQuery(queryString, Batch.class);
//			query.setParameter("idSessione", b.getIdSessione());
//			query.setParameter("idElaborazione", b.getIdElaborazione());
//			query.setParameter("idProcesso", b.getIdProcesso());
//			batch = (Batch) query.getSingleResult();
////			batch.setBatchTime(b.getBatchTime());
//			batch.setIdElaborazione(b.getIdElaborazione());
//			batch.setIdProcesso(b.getIdProcesso());
//			batch.setIdSessione(b.getIdSessione());
////			batch.setStato(b.getStato());
//		} catch (NonUniqueResultException e) {
//			throw (e);
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//		return this.workFlowBatchDao.save(batch);
//	}

	public List<Batch> findByIdSessione(Long id) {
		return this.workFlowBatchDao.findByIdSessione(id);
	}
	
	public Optional<Batch> findById(Long id) {
		return this.workFlowBatchDao.findById(id);
	}
	
	
	
//	public Batch updateByJobExecutionId(Long jobId, String status) {
//		Batch batch = null;
//		Query query = null;
//		String queryString = "SELECT * FROM sx_batch WHERE job_execution_id=:jobExecutionId "; 
//		try {
//			em.flush();
//			query = em.createNativeQuery(queryString, Batch.class);
//			query.setParameter("jobExecutionId", jobId);
//			batch = (Batch) query.getSingleResult();
////			batch.setStato(status);
//			em.flush();
//		} catch (NonUniqueResultException e) {
//			throw (e);
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//		return this.workFlowBatchDao.save(batch);
//	}

}
