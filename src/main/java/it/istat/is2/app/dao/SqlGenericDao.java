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
package it.istat.is2.app.dao;

import java.util.HashMap;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.workflow.domain.SxWorkset;

@Repository
public class SqlGenericDao {

	@Autowired
	private EntityManager em;

	public List<DatasetFile> findGenericDatasetFileAll() {

		Query q = em.createNativeQuery("select * from SX_DATASET_FILE", DatasetFile.class);

		@SuppressWarnings("unchecked")
		List<DatasetFile> resultList = (List<DatasetFile>) q.getResultList();
		return resultList;
	}

	public DatasetFile findGenericDatasetFileOne(Long id) {

		Query q = em.createNativeQuery("select * from SX_DATASET_FILE df where df.id=?", DatasetFile.class);
		q.setParameter(1, id);
		DatasetFile result = (DatasetFile) q.getSingleResult();
		return result;
	}

	public List<SxWorkset> findWorkSetDatasetColonnaByElaborazioneQuery(Long idelaborazione, Integer tipoCampo,
			Integer riga_inf, Integer riga_sup, HashMap<String, String> paramsFilter) {

		String query = " SELECT  rs1.id as id,rs1.nome as nome,  rs1.ORDINE as ordine, rs1.tipo_var as tipo_var, rs1.paginationTotalRows as valori_size,   "
				+ "      JSON_ARRAYAGG( json_object( 'r', rs1.r ,'v', rs1.v )  )      AS valori from "
				+ "  (  select rs.*,   max(rs.adx) OVER( PARTITION BY rs.id)  as paginationTotalRows  from "
				+ " (select  ss.id as id,ss.nome as nome,  ss.ordine,  ss.tipo_var as tipo_var,   ss.valori_size,t.r,t.v,"
				+ " DENSE_RANK() OVER(ORDER BY t.idx) as adx  from " + " SX_WORKSET ss, SX_STEP_VARIABLE sv, "
				+ " json_table(  ss.valori , '$[*]'  columns ( idx FOR ORDINALITY,r int path '$.r', v varchar(100)  path '$.v')"
				+ " ) t"
				+ "	where  sv.elaborazione=:idelaborazione  and sv.tipo_campo=:tipoCampo and sv.var=ss.id and ss.TIPO_VAR=1 ";
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {

				query += " and t.r in( select f.r from SX_WORKSET si, SX_STEP_VARIABLE ssv,json_table( si.valori, '$[*]'  columns "
						+ "(  idx FOR ORDINALITY,r int path '$.r', v varchar(100) path '$.v') ) f "
						+ " where  ssv.elaborazione=:idelaborazione and ssv.tipo_campo=:tipoCampo and ssv.var=si.id  and si.nome=:n_"
						+ key + " and f.v=:v_" + key + " ) ";
			}
		}
		query += "  order by t.idx asc " + "  ) rs " + " ) rs1 "
				+ "  where  rs1.adx    >:riga_inf     and  rs1.adx <= :riga_sup"
				+ "	   group by rs1.id,rs1.nome, rs1.ORDINE  , rs1.tipo_var  , rs1.paginationTotalRows ";

		Query q = em.createNativeQuery(query, SxWorkset.class);
		q.setParameter("idelaborazione", idelaborazione);
		q.setParameter("tipoCampo", tipoCampo);
		q.setParameter("riga_inf", riga_inf);
		q.setParameter("riga_sup", riga_sup);
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {
				String value = paramsFilter.get(key);
				q.setParameter("n_" + key, key);
				q.setParameter("v_" + key, value);
			}
		}

		@SuppressWarnings("unchecked")
		List<SxWorkset> resultList = (List<SxWorkset>) q.getResultList();
		return resultList;
	}

	public List<SxWorkset> findWorkSetDatasetColonnaByElaborazioneQuery_old(Long idelaborazione, Integer tipoCampo,
			Integer riga_inf, Integer riga_sup, HashMap<String, String> paramsFilter) {

		String query = " SELECT  rs1.id as id,rs1.nome as nome,  rs1.ORDINE as ordine, rs1.tipo_var as tipo_var, rs1.paginationTotalRows as valori_size,   "
				+ "   concat('{\"valori\":',    concat('[', group_concat(  concat('{\"r\":\"',rs1.r,'\",\"v\":\"',rs1.v,'\"}')      ORDER BY rs1.r ASC   )    ,    ']' )   ,    '}'  ) "
				+ "     " + " AS valori from "
				+ "  (  select rs.*,   max(rs.adx) OVER( PARTITION BY rs.id)  as paginationTotalRows  from "
				+ " (select  ss.id as id,ss.nome as nome,  ss.ordine,  ss.tipo_var as tipo_var,   ss.valori_size,t.r,t.v,"
				+ " DENSE_RANK() OVER(ORDER BY t.idx) as adx  from " + " SX_WORKSET ss, SX_STEP_VARIABLE sv, "
				+ " json_table( CONVERT(  ss.valori USING utf8), '$.[*]'  columns ( idx FOR ORDINALITY,r int path '$.r', v varchar(100)  path '$.v')"
				+ " ) t"
				+ "	where  sv.elaborazione=:idelaborazione  and sv.tipo_campo=:tipoCampo and sv.var=ss.id and ss.TIPO_VAR=1 ";
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {

				query += " and t.r in( select f.r from SX_WORKSET si, SX_STEP_VARIABLE ssv,json_table( CONVERT(  si.valori USING utf8), '$.[*]'  columns "
						+ "(  idx FOR ORDINALITY,r int path '$.r', v varchar(100) path '$.v') ) f "
						+ " where  ssv.elaborazione=:idelaborazione and ssv.tipo_campo=:tipoCampo and ssv.var=si.id  and si.nome=:n_"
						+ key + " and f.v=:v_" + key + " ) ";
			}
		}
		query += "  order by t.idx asc " + "  ) rs " + " ) rs1 "
				+ "  where  rs1.adx    >:riga_inf     and  rs1.adx <= :riga_sup"
				+ "	   group by rs1.id,rs1.nome, rs1.ORDINE  , rs1.tipo_var  , rs1.paginationTotalRows ";

		Query q = em.createNativeQuery(query, SxWorkset.class);
		q.setParameter("idelaborazione", idelaborazione);
		q.setParameter("tipoCampo", tipoCampo);
		q.setParameter("riga_inf", riga_inf);
		q.setParameter("riga_sup", riga_sup);
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {
				String value = paramsFilter.get(key);
				q.setParameter("n_" + key, key);
				q.setParameter("v_" + key, value);
			}
		}

		@SuppressWarnings("unchecked")
		List<SxWorkset> resultList = (List<SxWorkset>) q.getResultList();
		return resultList;
	}

	
	public List<DatasetColonna> findDatasetColonnaParamsbyQuery(@Param("dFile") Long dFile,
			@Param("riga_inf") Integer rigaInf, @Param("riga_sup") Integer rigaSup,
			HashMap<String, String> paramsFilter, @Param("nameColumnToOrder") String nameColumnToOrder,
			@Param("dirColumnOrder") String dirColumnOrder) {

		String query = "SELECT ss1.idcol AS idcol, " + " ss1.nome AS nome, " + " ss1.ORDINE AS ordine, "
				+ " ss1.FILTRO AS filtro, " + " ss1.DATASET_FILE AS dataset_file, "
				+ " ss1.TIPO_VARIABILE AS TIPO_VARIABILE, " + " ss1.paginationTotalRows AS valori_size, "
				+ "   concat('{\"valori\":',    concat('[',    " + "   group_concat(    "
				+ "     concat('{\"r\":\"',ss1.r,'\",\"v\":\"',ss1.v,'\"}') " + "   ORDER BY ss1.r ASC   ) "
				+ "  ,    ']' )   ,    '}'  )  as  daticolonna " + "  FROM " + "  ( " + "  SELECT rs.*, "
				+ "   max(rs.adx) OVER() AS paginationTotalRows " + "    FROM ( " + "    SELECT ss.idcol AS idcol, "
				+ "     ss.nome AS nome,    ss.ordine,    ss.FILTRO AS filtro, "
				+ "     ss.DATASET_FILE AS dataset_file, " + "     ss.TIPO_VARIABILE AS TIPO_VARIABILE,   t.r, "
				+ "     t.v, " + "     DENSE_RANK () OVER (ORDER BY t.idx) AS adx "
				+ "      FROM   SX_DATASET_COLONNA ss, json_table( CONVERT(  ss.daticolonna USING utf8), '$.valori[*]'  columns ( idx FOR ORDINALITY,r int  path '$.r', v varchar(100) path '$.v')  )t "
				+ "      where  ss.dataset_file=:dFile";

		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {

				query += "  and t.r in(  select f.r     FROM   SX_DATASET_COLONNA si, json_table( CONVERT(  si.daticolonna USING utf8), '$.valori[*]'  columns ( idx FOR ORDINALITY,r int path '$.r', v varchar(100) path '$.v')  )f "
						+ "  where  si.dataset_file=:dFile   and si.nome=:n_" + key + " and f.v=:v_" + key + "   )";

			}
		}

		query += "  order by adx asc " + "  ) rs " + " ) ss1 "
				+ "  where  ss1.adx    >:riga_inf     and  ss1.adx <= :riga_sup"
				+ "	    group by ss1.idcol,ss1.nome, ss1.ORDINE, ss1.FILTRO  , ss1.DATASET_FILE, ss1.TIPO_VARIABILE, ss1.paginationTotalRows ";

		Query q = em.createNativeQuery(query, DatasetColonna.class);
		q.setParameter("dFile", dFile);
		q.setParameter("riga_inf", rigaInf);
		q.setParameter("riga_sup", rigaSup);
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {
				String value = paramsFilter.get(key);
				q.setParameter("n_" + key, key);
				q.setParameter("v_" + key, value);
			}
		}
		@SuppressWarnings("unchecked")
		List<DatasetColonna> resultList = (List<DatasetColonna>) q.getResultList();
		return resultList;
	}

}
