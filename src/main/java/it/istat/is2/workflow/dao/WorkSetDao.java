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

import it.istat.is2.workflow.domain.Workset;

@Repository
public interface WorkSetDao extends CrudRepository<Workset, Long> {

	@Query(value = " SELECT  ss.id as id,ss.nome as nome,   ss.tipo_var as tipo_var,  '{\"valori\":[' || dbms_xmlgen.convert( "
			+ " RTRIM(XMLAGG(XMLELEMENT(E,'{\"r\":' || t.r  || ',\"v\":\"' || t.v || '\"}',',').EXTRACT('//text()') ORDER BY t.r).GetClobVal(),','), 1) || ']}'"
			+ " AS valori from SX_WORKSET ss, "
			+ "json_table(ss.valori, '$.valori[*]'  columns ( idx FOR ORDINALITY,r integer path '$.r', v varchar2 path '$.v')"
			+ " ) t"
			+ "	where t.idx > :riga_inf  and  t.idx <= :riga_sup   and ss.elaborazione=:idelaborazione and ss.TIPO_VAR=1  "
			+ "	group by ss.id,ss.nome, ss.ORDINE  ,ss.tipo_var  ", nativeQuery = true)
	List<Workset> findWorkSetDatasetColonnabyQuery(Long idelaborazione, Integer riga_inf, Integer riga_sup);

	/**
	 * @param idelaborazione
	 * @param start
	 * @param i
	 * @return
	 */
	@Query(value = " SELECT  ss.id as id,ss.nome as nome,   ss.tipo_var as tipo_var, ss.valori_size,  '{\"valori\":[' || dbms_xmlgen.convert( "
			+ " RTRIM(XMLAGG(XMLELEMENT(E,'{\"r\":' || t.r  || ',\"v\":\"' || t.v || '\"}',',').EXTRACT('//text()') ORDER BY t.r).GetClobVal(),','), 1) || ']}'"
			+ " AS valori from SX_WORKSET ss, SX_STEP_VARIABLE sv, "
			+ "json_table(ss.valori, '$.valori[*]'  columns ( idx FOR ORDINALITY,r integer path '$.r', v varchar2 path '$.v')"
			+ " ) t"
			+ "	where t.idx > :riga_inf    and t.idx <= :riga_sup     and sv.elaborazione=:idelaborazione  and sv.var=ss.id and ss.TIPO_VAR=1 "
			+ " and 1= :param_filter  "
			+ "	group by ss.id,ss.nome, ss.ORDINE  , ss.tipo_var  , ss.valori_size", nativeQuery = true)
	List<Workset> findWorkSetDatasetColonnaByElaborazioneQuery(@Param("idelaborazione") Long idelaborazione,
			@Param("riga_inf") Integer riga_inf, @Param("riga_sup") Integer riga_sup,
			@Param("param_filter") String param_filter);

}
