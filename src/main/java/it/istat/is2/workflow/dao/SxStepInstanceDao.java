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
package it.istat.is2.workflow.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.is2.workflow.domain.SxBusinessFunction;
import it.istat.is2.workflow.domain.SxStepInstance;

@Repository
public interface SxStepInstanceDao extends CrudRepository<SxStepInstance, Long> {

	/**
	 * @param businessFunction
	 * @param codiceAppServiceR
	 * @return
	 */

	@Query("SELECT si from SxBusinessFunction sf join sf.sxBusinessProcesses sp join sp.sxBusinessSteps ss join ss.sxStepInstances si   where sf=:businessFunction  and si.sxAppService.id=:codiceAppServiceR ORDER BY si.id ASC ")
	List<SxStepInstance> findAllSxStepInstanceByFunctionAndService(@Param("businessFunction") SxBusinessFunction businessFunction,
			@Param("codiceAppServiceR") int codiceAppServiceR);
 

	@Query("SELECT si from SxBusinessFunction sf join sf.sxBusinessProcesses sp join sp.sxBusinessSteps ss join ss.sxStepInstances si   where sf=:businessFunction ORDER BY si.id ASC ")
	List<SxStepInstance> findAllSxStepInstanceByFunction(@Param("businessFunction") SxBusinessFunction businessFunction);
 

}
