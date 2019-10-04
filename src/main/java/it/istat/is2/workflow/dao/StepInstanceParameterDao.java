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

import it.istat.is2.workflow.domain.StepInstanceParameter;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.TipoIO;
import it.istat.is2.workflow.domain.SxTipoVar;

@Repository
public interface StepInstanceParameterDao extends CrudRepository<StepInstanceParameter, Long> {

	/**
	 * @param businessFunction
	 * @param codiceAppServiceR
	 * @return
	 */

	@Query("SELECT spar from StepInstance si join si.sxParPatterns spar join spar.appRole sr join sr.sxStepPatterns sp   where si=sp.stepInstance and  si=:stepInstance  and sp.tipoIO=:sxTipoIO and sr.sxTipoVar=:sxTipoVar ORDER BY spar.id ASC ")
	List<StepInstanceParameter> findAllSxParPatternByStepAndTypeIOVar(@Param("stepInstance") StepInstance stepInstance,
			@Param("sxTipoIO") TipoIO sxTipoIO, @Param("sxTipoVar") SxTipoVar sxTipoVar);

}
