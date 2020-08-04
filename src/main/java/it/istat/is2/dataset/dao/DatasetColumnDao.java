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
 * @author Paolo Francescangeli  <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
package it.istat.is2.dataset.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.is2.dataset.domain.DatasetColumn;
import it.istat.is2.dataset.domain.DatasetFile;

@Repository
public interface DatasetColumnDao extends JpaRepository<DatasetColumn, Long> {

    @Query(value = " SELECT  ss.id as id,ss.name as name, ss.ORDER_CODE as order_code,ss.content_size as content_size, ss.DATASET_FILE as dataset_file, ss.CLS_STATISTICAL_VARIABLE_ID as CLS_STATISTICAL_VARIABLE_ID,   '{\"value\":[' || dbms_xmlgen.convert( "
            + " RTRIM(XMLAGG(XMLELEMENT(E,'{\"r\":' || t.r  || ',\"v\":\"' || t.v || '\"}',',').EXTRACT('//text()') ORDER BY t.r).GetClobVal(),','), 1) || ']}'"
            + " AS content from IS2_DATASET_COLUMN ss, "
            + "json_table(ss.content, '$.value[*]'  columns ( idx FOR ORDINALITY,r integer path '$.r', v varchar2 path '$.v')"
            + " ) t" + "	where t.idx > :riga_inf " + " and t.idx <= :riga_sup  " + "  and ss.dataset_file=:dFile "
            + "	group by ss.id,ss.name, ss.ORDER_CODE,  ss.content_size  , ss.DATASET_FILE, ss.CLS_STATISTICAL_VARIABLE_ID  ", nativeQuery = true)
    List<DatasetColumn> findDatasetColumnbyQuery(@Param("dFile") Long dFile, @Param("riga_inf") Integer rigaInf,
                                                 @Param("riga_sup") Integer rigaSup);

    @Query(value = "SELECT  new it.istat.is2.dataset.domain.DatasetColumn(dc.id, dc.name,dc.orderCode,dc.datasetFile,tv)  from DatasetColumn dc    LEFT JOIN   dc.variabileType tv      where dc.datasetFile=:dFile  ORDER BY dc.orderCode ASC")
    List<DatasetColumn> findNamebyFile(@Param("dFile") DatasetFile dFile);

    List<DatasetColumn> findByDatasetFile(@Param("dFile") DatasetFile dFile);

    @Query(value = " SELECT  ss.id as id,ss.name as name, ss.ORDER_CODE as order_code,  ss.DATASET_FILE  as dataset_file,ss.CLS_STATISTICAL_VARIABLE_ID as CLS_STATISTICAL_VARIABLE_ID,  '{\"value\":[' || dbms_xmlgen.convert(  "
            + " RTRIM(XMLAGG(XMLELEMENT(E,'{\"r\":' || t.r  || ',\"v\":\"' || t.v || '\"}',',').EXTRACT('//text()') "
            + " ORDER BY t.r).GetClobVal(),',') , 1) || ']}' AS content "
            + " from IS2_DATASET_COLUMN ss, json_table(ss.content, '$.value[*]' "
            + " columns ( idx FOR ORDINALITY, r integer path '$.r', v varchar2 path '$.v' )" + "  ) t"
            + " where  ss.dataset_file=:dFile " + " and t.idx >(:riga_inf)  and t.idx <=  :riga_sup "
            + " and ((:fieldSelect is NULL) OR (ss.name in :fieldSelect)) "
            + " and t.r in  ( select f.r from IS2_DATASET_COLUMN si, json_table(si.content, '$.value[*]'  columns ( r integer path '$.r',  v varchar2 path '$.v') ) f "
            + "   where  si.dataset_file=:dFile  and si.name=:filterFieldName  and f.valore=:filterFieldValue) "
            + "	group by ss.id,ss.name, ss.ORDER_CODE , ss.DATASET_FILE, ss.CLS_STATISTICAL_VARIABLE_ID ", nativeQuery = true)
    List<DatasetColumn> findDatasetColumnbyQueryFilter(@Param("dFile") Long dFile, @Param("riga_inf") Integer rigaInf,
                                                       @Param("riga_sup") Integer rigaSup, @Param("filterFieldName") String filterFieldName,
                                                       @Param("filterFieldValue") String filterFieldValue, @Param("fieldSelect") List<String> fieldSelect);

    @Query(value = " SELECT  ss.id as id,ss.name as name, ss.ORDER_CODE as order_code, ss.DATASET_FILE  as dataset_file,ss.CLS_STATISTICAL_VARIABLE_ID as CLS_STATISTICAL_VARIABLE_ID,  '{\"content\":[' || dbms_xmlgen.convert(  "
            + " RTRIM(XMLAGG(XMLELEMENT(E,'{\"r\":' || t.r  || ',\"v\":\"' || t.v || '\"}',',').EXTRACT('//text()') "
            + " ORDER BY t.r).GetClobVal(),',') , 1) || ']}' AS content "
            + " from IS2_DATASET_COLUMN ss, json_table(ss.content, '$.value[*]' "
            + " columns ( idx FOR ORDINALITY, r integer path '$.r', v varchar2 path '$.v' )" + "  ) t"
            + " where  ss.dataset_file=:dFile "
            + "	group by ss.id,ss.name, ss.ORDER_CODE , ss.DATASET_FILE, ss.CLS_STATISTICAL_VARIABLE_ID ", nativeQuery = true)
    List<DatasetColumn> findDatasetColumnbyQueryAll(@Param("dFile") Long dFile);

    @Transactional
    @Modifying
    @Query(value = "delete from DatasetColumn dc   where dc.datasetFile=:dFile ")
    void deleteByDatasetFile(@Param("dFile") DatasetFile datasetFile);


}
