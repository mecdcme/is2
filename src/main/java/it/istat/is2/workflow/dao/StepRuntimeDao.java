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
import java.util.Map;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.workflow.domain.StepRuntime;
import it.istat.is2.workflow.domain.TypeIO;
 

@Repository
public interface StepRuntimeDao extends CrudRepository<StepRuntime, Integer> {

	List<StepRuntime> findByDataProcessing(DataProcessing dataProcessing);
	List<StepRuntime> findByDataProcessingAndAppRoleIn(DataProcessing dataProcessing,List<AppRole> roles);

	Optional<StepRuntime> findById(Integer idvar);

	List<StepRuntime> findByAppRole(AppRole appRole);

	@Query("SELECT sw.name, st from StepRuntime st, Workset sw where st.workset.id =sw.id and st.dataProcessing=:elab ORDER BY st.orderCode ASC")
	Map<String, StepRuntime> findByDataProcessingMap(@Param("elab") Long dataProcessing);

	@Query("SELECT new it.istat.is2.workflow.domain.StepRuntime(st.id, st.appRole, st.dataProcessing,st.typeIO,st.orderCode, st.workset.id, st.workset.datasetColumnId, st.workset.name,st.workset.contentSize,st.workset.paramValue) from StepRuntime st where st.dataProcessing=:elab and (:dataType IS NULL OR st.workset.dataType=:dataType) ORDER BY st.orderCode, st.id ASC")
	List<StepRuntime> findByDataProcessingNoValues(@Param("elab") DataProcessing dataProcessing,
			@Param("dataType") DataTypeCls dataTypeCls);
	
	@Query("SELECT new it.istat.is2.workflow.domain.StepRuntime(st.id, st.appRole, st.dataProcessing,st.typeIO,st.orderCode, st.workset.id, st.workset.datasetColumnId, st.workset.name,st.workset.contentSize,st.workset.paramValue) from StepRuntime st where st.dataProcessing=:elab and (:dataType IS NULL OR st.workset.dataType=:dataType) and st.typeIO=:typeIO and (:roleGroup IS NULL OR st.roleGroup=:roleGroup) ORDER BY st.orderCode,st.id ASC")
	List<StepRuntime> findByDataProcessingStatusNoValues(@Param("elab") DataProcessing dataProcessing,
			@Param("dataType") DataTypeCls dataType, @Param("typeIO") TypeIO typeIO,@Param("roleGroup") AppRole appRole);
	
	@Query("SELECT st from StepRuntime st where st.dataProcessing=:dataProcessing and st.workset.dataType=:dataType ORDER BY st.orderCode ASC")
	List<StepRuntime> findStepRuntimes(@Param("dataProcessing") DataProcessing dataProcessing,
			@Param("dataType") DataTypeCls dataType);

	@Query("SELECT distinct sr from AppRole sr,StepRuntime st where st.dataProcessing.id=:elab and (:dataType IS NULL OR  st.workset.dataType=:dataType) and st.typeIO=:typeIO and st.roleGroup=sr ")
	List<AppRole> getOutputRoleGroupsStepRuntimes(@Param("elab")Long idDataProcessing,@Param("dataType") DataTypeCls dataTypeCls,@Param("typeIO") TypeIO typeIO);
	
}
