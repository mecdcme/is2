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
package it.istat.is2.dataset.dao;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.dataset.domain.DatasetFile;

@Repository
public interface DatasetColonnaDao extends JpaRepository<DatasetColonna, Long> {

	@Query(value = " SELECT  ss.idcol as idcol,ss.nome as nome, ss.ORDINE as ordine, ss.FILTRO as filtro,ss.valori_size as valori_size, ss.DATASET_FILE as dataset_file, ss.TIPO_VARIABILE as TIPO_VARIABILE,   '{\"valori\":[' || dbms_xmlgen.convert( "
			+ " RTRIM(XMLAGG(XMLELEMENT(E,'{\"r\":' || t.r  || ',\"v\":\"' || t.v || '\"}',',').EXTRACT('//text()') ORDER BY t.r).GetClobVal(),','), 1) || ']}'"
			+ " AS daticolonna from SX_DATASET_COLONNA ss, "
			+ "json_table(ss.daticolonna, '$.valori[*]'  columns ( idx FOR ORDINALITY,r integer path '$.r', v varchar2 path '$.v')"
			+ " ) t" + "	where t.idx > :riga_inf " + " and t.idx <= :riga_sup  " + "  and ss.dataset_file=:dFile "
			+ "	group by ss.idcol,ss.nome, ss.ORDINE, ss.FILTRO , ss.valori_size  , ss.DATASET_FILE, ss.TIPO_VARIABILE  ", nativeQuery = true)
	List<DatasetColonna> findDatasetColonnabyQuery(@Param("dFile") Long dFile, @Param("riga_inf") Integer rigaInf,
			@Param("riga_sup") Integer rigaSup);

	@Query(value = "SELECT  new it.istat.is2.dataset.domain.DatasetColonna(dc.id, dc.nome,dc.ordine,dc.filtro,dc.datasetFile,tv)  from DatasetColonna dc    LEFT JOIN   dc.tipoVariabile tv      where dc.datasetFile=:dFile  ORDER BY dc.ordine ASC")
	List<DatasetColonna> findNomebyfile(@Param("dFile") DatasetFile dFile);

	List<DatasetColonna> findByDatasetFile(@Param("dFile") DatasetFile dFile);

	@Query(value = " SELECT  ss.idcol as idcol,ss.nome as nome, ss.ORDINE as ordine, ss.FILTRO as filtro, ss.DATASET_FILE  as dataset_file,ss.tipo_variabile as tipo_variabile,  '{\"valori\":[' || dbms_xmlgen.convert(  "
			+ " RTRIM(XMLAGG(XMLELEMENT(E,'{\"r\":' || t.r  || ',\"v\":\"' || t.v || '\"}',',').EXTRACT('//text()') "
			+ " ORDER BY t.r).GetClobVal(),',') , 1) || ']}' AS daticolonna "
			+ " from SX_DATASET_COLONNA ss, json_table(ss.daticolonna, '$.valori[*]' "
			+ " columns ( idx FOR ORDINALITY, r integer path '$.r', v varchar2 path '$.v' )" + "  ) t"
			+ " where  ss.dataset_file=:dFile " + " and t.idx >(:riga_inf)  and t.idx <=  :riga_sup "
			+ " and ((:fieldSelect is NULL) OR (ss.nome in :fieldSelect)) "
			+ " and t.r in  ( select f.r from SX_DATASET_COLONNA si, json_table(si.daticolonna, '$.valori[*]'  columns ( r integer path '$.r',  v varchar2 path '$.v') ) f "
			+ "   where  si.dataset_file=:dFile  and si.nome=:filterFieldName  and f.valore=:filterFieldValue) "
			+ "	group by ss.idcol,ss.nome, ss.ORDINE ,ss.FILTRO, ss.DATASET_FILE, ss.TIPO_VARIABILE ", nativeQuery = true)
	List<DatasetColonna> findDatasetColonnabyQueryFilter(@Param("dFile") Long dFile, @Param("riga_inf") Integer rigaInf,
			@Param("riga_sup") Integer rigaSup, @Param("filterFieldName") String filterFieldName,
			@Param("filterFieldValue") String filterFieldValue, @Param("fieldSelect") List<String> fieldSelect);

	@Query(value = " SELECT  ss.idcol as idcol,ss.nome as nome, ss.ORDINE as ordine, ss.DATASET_FILE  as dataset_file,ss.tipo_variabile as tipo_variabile,  '{\"valori\":[' || dbms_xmlgen.convert(  "
			+ " RTRIM(XMLAGG(XMLELEMENT(E,'{\"r\":' || t.r  || ',\"v\":\"' || t.v || '\"}',',').EXTRACT('//text()') "
			+ " ORDER BY t.r).GetClobVal(),',') , 1) || ']}' AS daticolonna "
			+ " from SX_DATASET_COLONNA ss, json_table(ss.daticolonna, '$.valori[*]' "
			+ " columns ( idx FOR ORDINALITY, r integer path '$.r', v varchar2 path '$.v' )" + "  ) t"
			+ " where  ss.dataset_file=:dFile "
			+ "	group by ss.idcol,ss.nome, ss.ORDINE , ss.DATASET_FILE, ss.TIPO_VARIABILE ", nativeQuery = true)
	List<DatasetColonna> findDatasetColonnabyQueryAll(@Param("dFile") Long dFile);
        
	@Transactional
	@Modifying
	@Query(value = "delete from DatasetColonna dc   where dc.datasetFile=:dFile ")
	void deleteByDatasetFile(@Param("dFile") DatasetFile datasetFile);

	 

}
