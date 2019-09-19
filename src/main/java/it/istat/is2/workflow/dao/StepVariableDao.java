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

import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.TipoCampo;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.StepVariable;
import it.istat.is2.workflow.domain.SxTipoVar;

@Repository
public interface StepVariableDao extends CrudRepository<StepVariable, Integer> {

	List<StepVariable> findByElaborazione(Elaborazione elaborazione);
	List<StepVariable> findByElaborazioneAndAppRoleIn(Elaborazione elaborazione,List<AppRole> roles);

	Optional<StepVariable> findById(Integer idvar);

	List<StepVariable> findByAppRole(AppRole appRole);

	@Query("SELECT sw.nome, st from StepVariable st, Workset sw where st.workset.id =sw.id and st.elaborazione=:elab ORDER BY st.ordine ASC")
	Map<String, StepVariable> findByElaborazioneMap(@Param("elab") Long elaborazione);

	@Query("SELECT new it.istat.is2.workflow.domain.StepVariable(st.id, st.appRole, st.elaborazione,st.tipoCampo,st.ordine, st.flagRicerca, st.workset.id, st.workset.nome,st.workset.valoriSize) from StepVariable st where st.elaborazione=:elab and st.workset.sxTipoVar=:tipoVar ORDER BY st.ordine ASC")
	List<StepVariable> findByElaborazioneNoValori(@Param("elab") Elaborazione elaborazione,
			@Param("tipoVar") SxTipoVar sxTipoVar);
	
	@Query("SELECT new it.istat.is2.workflow.domain.StepVariable(st.id, st.appRole, st.elaborazione,st.tipoCampo,st.ordine, st.flagRicerca, st.workset.id, st.workset.nome,st.workset.valoriSize) from StepVariable st where st.elaborazione=:elab and st.workset.sxTipoVar=:tipoVar and st.tipoCampo=:tipoCampo and (:roleGroup IS NULL OR st.sxRuoloGruppo=:roleGroup) ORDER BY st.ordine ASC")
	List<StepVariable> findByElaborazioneTipoCampoNoValori(@Param("elab") Elaborazione elaborazione,
			@Param("tipoVar") SxTipoVar sxTipoVar, @Param("tipoCampo") TipoCampo sxTipoCampo,@Param("roleGroup") AppRole appRole);
	
	@Query("SELECT st from StepVariable st where st.elaborazione=:elab and st.workset.sxTipoVar!=:tipoVar ORDER BY st.ordine ASC")
	List<StepVariable> findStepVariables(@Param("elab") Elaborazione elaborazione,
			@Param("tipoVar") SxTipoVar sxTipoVar);

	@Query("SELECT distinct sr from AppRole sr,StepVariable st where st.elaborazione.id=:elab and st.workset.sxTipoVar=:tipoVar and st.tipoCampo=:tipoCampo and st.sxRuoloGruppo=sr ORDER BY st.ordine desc")
	List<AppRole> getOutputRoleGroupsStepVariables(@Param("elab")Long idElaborazione,@Param("tipoVar") SxTipoVar sxTipoVar,@Param("tipoCampo") TipoCampo sxTipoCampo);
	
}
