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
import it.istat.is2.workflow.domain.Workset;

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

	public List<Workset> findWorkSetDatasetColonnaByElaborazioneQuery(Long idelaborazione, Integer tipoCampo, Integer groupRole,
			Integer riga_inf, Integer riga_sup, HashMap<String, String> paramsFilter) {

		String query = " " 
				+ "SELECT rs1.id as id, "
				+ "   rs1.nome as nome, "
				+ "	  rs1.ORDINE as ordine, "
				+ "   rs1.tipo_var as tipo_var, "
				+ "   rs1.param_value as param_value, "
				+ "   rs1.paginationTotalRows as valori_size,"
				+ "   concat('[', group_concat( concat('\"',rs1.v,'\"')" 
				+ "   ORDER BY rs1.idx ASC),']' ) AS valori "
				+ "FROM ("
				+ "   select rs.*, max(rs.adx) OVER( PARTITION BY rs.id)  as paginationTotalRows  "
				+ "      FROM ("
				+ "         select  ss.id as id, "
				+ "         ss.nome as nome, "
				+ "         ss.ordine, "
				+ "         ss.tipo_var as tipo_var, " 
				+ "         ss.param_value as param_value, "  
				+ "         ss.valori_size, "
				+ "         t.idx, "
				+ "         t.v,"
				+ "         DENSE_RANK() OVER(ORDER BY t.idx) as adx  "
				+ "         from "
				+"              SX_WORKSET ss, "
				+ "             SX_STEP_VARIABLE sv, "
				+ "             json_table(ss.valori , '$[*]' columns( idx FOR ORDINALITY,  v TEXT  path '$[0]')"
				+ "     ) t"
				+ "	where  sv.elaborazione=:idelaborazione and (:groupRole is null ||sv.ROLE_GROUP=:groupRole) and sv.tipo_campo=:tipoCampo and sv.var=ss.id and ss.TIPO_VAR=1 ";
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {

				query += " and t.idx in( select f.idx from SX_WORKSET si, SX_STEP_VARIABLE ssv,json_table( si.valori, '$[*]'  columns "
						+ "(  idx FOR ORDINALITY, v TEXT path '$[0]') ) f "
						+ " where  ssv.elaborazione=:idelaborazione  and (:groupRole is null ||ssv.ROLE_GROUP=:groupRole)  and ssv.tipo_campo=:tipoCampo and ssv.var=si.id  and si.nome=:n_"
						+ key + " and f.v=:v_" + key + " ) ";
			}
		}
		query += "  order by t.idx asc " + "  ) rs " + " ) rs1 "
				+ "  where  rs1.adx    >:riga_inf     and  rs1.adx <= :riga_sup"
				+ "	   group by rs1.id,rs1.nome, rs1.ORDINE  , rs1.tipo_var  ,rs1.param_value, rs1.paginationTotalRows ";

		Query q = em.createNativeQuery(query, Workset.class);
		q.setParameter("idelaborazione", idelaborazione);
		q.setParameter("tipoCampo", tipoCampo);
		q.setParameter("riga_inf", riga_inf);
		q.setParameter("riga_sup", riga_sup);
		q.setParameter("groupRole", groupRole);
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {
				String value = paramsFilter.get(key);
				q.setParameter("n_" + key, key);
				q.setParameter("v_" + key, value);
			}
		}

		@SuppressWarnings("unchecked")
		List<Workset> resultList = (List<Workset>) q.getResultList();
		return resultList;
	}



	public List<DatasetColonna> findDatasetColonnaParamsbyQuery(@Param("dFile") Long dFile,
			@Param("riga_inf") Integer rigaInf, @Param("riga_sup") Integer rigaSup,
			HashMap<String, String> paramsFilter, @Param("nameColumnToOrder") String nameColumnToOrder,
			@Param("dirColumnOrder") String dirColumnOrder) {

		String query = " "
				+ "SELECT "
				+ "   ss1.idcol AS idcol, "
				+ "   ss1.nome AS nome,  "
				+ "   ss1.ORDINE AS ordine, "
				+ "   ss1.FILTRO AS filtro, "
				+ "   ss1.DATASET_FILE AS dataset_file, "
				+ "   ss1.TIPO_VARIABILE AS TIPO_VARIABILE, "
				+ "   ss1.paginationTotalRows AS valori_size, "
				+ "   concat('[', group_concat( concat('\"',ss1.v,'\"')"
				+ "	  ORDER BY ss1.idx ASC),']' ) AS   daticolonna "
				+ "   FROM ( "
				+ "      SELECT rs.*, max(rs.adx) OVER() AS paginationTotalRows"
				+ "         FROM ("
				+ "           SELECT ss.idcol AS idcol, "
				+ "                  ss.nome AS nome,    "
				+ "                  ss.ordine,    "
				+ "                  ss.FILTRO AS filtro, "
				+ "                  ss.DATASET_FILE AS dataset_file, "
				+ "                  ss.TIPO_VARIABILE AS TIPO_VARIABILE,   "
				+ "                  t.idx, "
				+ "                  t.v, "
				+ "                  DENSE_RANK () OVER (ORDER BY t.idx) AS adx "
				+ "          FROM "
				+ "                 SX_DATASET_COLONNA ss, "
				+ "                 json_table( CONVERT(  ss.daticolonna USING utf8), '$[*]'  columns ( idx FOR ORDINALITY, v text path '$[0]')"
				+ "    )t "
				+ "where  ss.dataset_file=:dFile";

		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {  

				query += "  and t.idx in( select f.idx  FROM   SX_DATASET_COLONNA si, json_table( CONVERT( si.daticolonna USING utf8), '$[*]' columns ( idx FOR ORDINALITY, v text path '$[0]'))f "
						+ "  where si.dataset_file=:dFile   and si.nome=:n_" + key + " and f.v=:v_" + key + ")";

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

	public List<String> findTablesDB(String table_schema) {
		// TODO Auto-generated method stub
		Query q = em.createNativeQuery("SELECT table_name FROM information_schema.tables WHERE table_schema = :table_schema");
		q.setParameter("table_schema", table_schema);
		@SuppressWarnings("unchecked")
		List<String> resultList = (List<String>) q.getResultList();
		return resultList;
	}
	
	public List<String> findFieldsTableDB(String table_schema, String table_name) {
		// TODO Auto-generated method stub
		Query q = em.createNativeQuery("SELECT COLUMN_NAME  FROM information_schema.columns  WHERE table_schema = :table_schema  AND table_name=:table_name");
		q.setParameter("table_schema", table_schema);
		q.setParameter("table_name", table_name);
		@SuppressWarnings("unchecked")
		List<String> resultList = (List<String>) q.getResultList();
		return resultList;
	}

	public List<String> loadFieldValuesTable(String dbschema, String tablename, String field) {
		// TODO Auto-generated method stub
	
		Query q = em.createNativeQuery("SELECT "+field+"  FROM "+dbschema+"."+tablename );
	  	@SuppressWarnings("unchecked")
		List<String> resultList = (List<String>) q.getResultList();
		return resultList;
	}

}
