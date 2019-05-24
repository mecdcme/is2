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
import java.util.Map;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.rservice.app.domain.Elaborazione;
import it.istat.rservice.workflow.domain.SXTipoCampo;
import it.istat.rservice.workflow.domain.SxRuoli;
import it.istat.rservice.workflow.domain.SxStepVariable;
import it.istat.rservice.workflow.domain.SxTipoVar;

@Repository
public interface StepVariableDao extends CrudRepository<SxStepVariable, Long> {

	List<SxStepVariable> findByElaborazione(Elaborazione elaborazione);

	Optional<SxStepVariable> findById(Long idvar);

	List<SxStepVariable> findBySxRuoli(SxRuoli ruolo);

	@Query("SELECT sw.nome, st from SxStepVariable st,SxWorkset sw where st.sxWorkset.id =sw.id and st.elaborazione=:elab  ORDER BY st.ordine ASC  ")
	Map<String, SxStepVariable> findByElaborazioneMap(@Param("elab") Long elaborazione);

	/**
	 * @param elaborazione
	 * @param sxTipoVar
	 * @return
	 */
	@Query("SELECT new it.istat.rservice.workflow.domain.SxStepVariable(st.id, st.sxRuoli, st.elaborazione,st.tipoCampo,st.ordine, st.flagRicerca, st.sxWorkset.id, st.sxWorkset.nome,st.sxWorkset.valoriSize) from SxStepVariable st  where st.elaborazione=:elab and st.sxWorkset.sxTipoVar=:tipoVar ORDER BY st.ordine ASC ")
	List<SxStepVariable> findByElaborazioneNoValori(@Param("elab") Elaborazione elaborazione,
			@Param("tipoVar") SxTipoVar sxTipoVar);
	
	/**
	 * @param elaborazione
	 * @param sxTipoVar
	 * @return
	 */
	@Query("SELECT new it.istat.rservice.workflow.domain.SxStepVariable(st.id, st.sxRuoli, st.elaborazione,st.tipoCampo,st.ordine, st.flagRicerca, st.sxWorkset.id, st.sxWorkset.nome,st.sxWorkset.valoriSize) from SxStepVariable st  where st.elaborazione=:elab and st.sxWorkset.sxTipoVar=:tipoVar and st.tipoCampo=:tipoCampo ORDER BY st.ordine ASC ")
	List<SxStepVariable> findByElaborazioneTipoCampoNoValori(@Param("elab") Elaborazione elaborazione,
			@Param("tipoVar") SxTipoVar sxTipoVar, @Param("tipoCampo") SXTipoCampo sxTipoCampo);
	

	/**
	 * @param elaborazione
	 * @param sxTipoVar
	 * @return
	 */
	@Query("SELECT st from SxStepVariable st  where st.elaborazione=:elab and st.sxWorkset.sxTipoVar!=:tipoVar ORDER BY st.ordine ASC ")
	List<SxStepVariable> findSxStepVariablesParametri(@Param("elab") Elaborazione elaborazione,
			@Param("tipoVar") SxTipoVar sxTipoVar);

	
}
