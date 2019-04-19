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
package it.istat.rservice.workflow.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.rservice.workflow.domain.SxParPattern;
import it.istat.rservice.workflow.domain.SxStepInstance;
import it.istat.rservice.workflow.domain.SxTipoIO;
import it.istat.rservice.workflow.domain.SxTipoVar;

@Repository
public interface SxParPatternDao extends CrudRepository<SxParPattern, Long> {

	/**
	 * @param businessFunction
	 * @param codiceAppServiceR
	 * @return
	 */

	@Query("SELECT spar from SxStepInstance si join si.sxParPatterns spar join spar.sxRuoli sr join sr.sxStepPatterns sp   where si=sp.sxStepInstance and  si=:sxStepInstance  and sp.tipoIO=:sxTipoIO and sr.sxTipoVar<>:sxTipoVar ORDER BY spar.id ASC ")
	List<SxParPattern> findAllSxParPatternByStepAndTypeIOVar(@Param("sxStepInstance") SxStepInstance sxStepInstance,
			@Param("sxTipoIO") SxTipoIO sxTipoIO, @Param("sxTipoVar") SxTipoVar sxTipoVar);

}
