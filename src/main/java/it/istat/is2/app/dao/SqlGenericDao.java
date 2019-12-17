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
import it.istat.is2.dataset.domain.DatasetColumn;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.workflow.domain.Workset;

@Repository
public class SqlGenericDao {

	@Autowired
	private EntityManager em;

	public List<DatasetFile> findGenericDatasetFileAll() {

		Query q = em.createNativeQuery("select * from IS2_DATASET_FILE", DatasetFile.class);

		@SuppressWarnings("unchecked")
		List<DatasetFile> resultList = (List<DatasetFile>) q.getResultList();
		return resultList;
	}

	public DatasetFile findGenericDatasetFileOne(Long id) {

		Query q = em.createNativeQuery("select * from IS2_DATASET_FILE df where df.id=?", DatasetFile.class);
		q.setParameter(1, id);
		DatasetFile result = (DatasetFile) q.getSingleResult();
		return result;
	}

	public List<Object[]> findWorKSetDataViewParamsbyQuery( List<Object[]>  resulFieldstList,  Long idDataProcessing, Integer typeIO, Integer groupRole, Integer rigaInf, Integer length,
			HashMap<String, String> paramsFilter,   String nameColumnToOrder,String dirColumnOrder) {
 
	 	String query = "with ss_model as ("
			+ " SELECT "
			+ "        ss.id AS idwscol, "
			+ "        ss.name AS name, "
			+ "        ss.order_code,"
			+ "		   ss.CLS_DATA_TYPE_ID as CLS_DATA_TYPE_ID,"
			+ "        ss.value_parameter as value_parameter,"
			+ "		   ss.content_size, "
			+ "        t.idx, t.v "
			+ " FROM   "
			+ "      IS2_WORKSET ss,  IS2_STEP_RUNTIME sv, json_table(ss.content , '$[*]' columns( idx FOR ORDINALITY,  v TEXT  path '$[0]')     ) t	 " 
			+ " WHERE  "
			+ "        sv.data_processing_id=:idDataProcessing and (:groupRole is null ||sv.ROLE_GROUP=:groupRole) and sv.CLS_TYPE_IO_ID=:typeIO and sv.WORKSET_ID=ss.id and ss.CLS_DATA_TYPE_ID=1 "
			+ " ) ,"
			+ " ss_pivot as ("
			+ "  SELECT "
			+ "        ss_model.idx,"
			+ "        ss_model.idwscol, ";
	
		for (Object[] field : resulFieldstList) {
			query += " MAX(IF(ss_model.idwscol = " + field[0] + ", ss_model.v, NULL )) AS `" + field[1] + "`,";
		}
		
		query = query.substring(0, query.length() - 1);
		
		query += " FROM ss_model GROUP BY ss_model.idx) "
				+ " SELECT tabres.*, COUNT(*) OVER() AS total_rows from ss_pivot tabres";

		if (paramsFilter != null) {
			String where = " WHERE ";
			for (String key : paramsFilter.keySet()) {
				where += " tabres." + key + "=:" + key + " AND";
			}
			query += where.substring(0, where.length() - 3);
		}
		
		// SORT
		if (nameColumnToOrder != null && !"".equals(nameColumnToOrder))
			query += " ORDER BY tabres." + nameColumnToOrder + " " + dirColumnOrder;
		query += " LIMIT " + rigaInf + ", "+length ;

		Query q = em.createNativeQuery(query);
		q.setParameter("idDataProcessing", idDataProcessing);
		q.setParameter("groupRole", groupRole);
		q.setParameter("typeIO", typeIO);
		
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {
				String value = paramsFilter.get(key);
				q.setParameter(key, value);
			}
		}
		@SuppressWarnings("unchecked")
		List<Object[]> resultList = (List<Object[]>) q.getResultList();
		return resultList;
	}
	
	
	public List<Workset> findWorkSetDatasetColumnByQuery_old(Long idDataProcessing, Integer typeIO, Integer groupRole,
			Integer row_inf, Integer row_sup, HashMap<String, String> paramsFilter) {

		String query = " " 
				+ "SELECT rs1.id as id, "
				+ "   rs1.name as name, "
				+ "	  rs1.order_code as order_code, "
				+ "   rs1.CLS_DATA_TYPE_ID as CLS_DATA_TYPE_ID, "
				+ "   rs1.value_parameter as value_parameter, "
				+ "   rs1.paginationTotalRows as content_size,"
				+ "   concat('[', group_concat( concat('\"',rs1.v,'\"')" 
				+ "   ORDER BY rs1.idx ASC),']' ) AS content "
				+ "FROM ("
				+ "   select rs.*, max(rs.adx) OVER( PARTITION BY rs.id)  as paginationTotalRows  "
				+ "      FROM ("
				+ "         select  ss.id as id, "
				+ "         ss.name as name, "
				+ "         ss.order_code, "
				+ "         ss.CLS_DATA_TYPE_ID as CLS_DATA_TYPE_ID, " 
				+ "         ss.value_parameter as value_parameter, "  
				+ "         ss.content_size, "
				+ "         t.idx, "
				+ "         t.v,"
				+ "         DENSE_RANK() OVER(ORDER BY t.idx) as adx  "
				+ "         from "
				+"              IS2_WORKSET ss, "
				+ "             IS2_STEP_RUNTIME sv, "
				+ "             json_table(ss.content , '$[*]' columns( idx FOR ORDINALITY,  v TEXT  path '$[0]')"
				+ "     ) t"
				+ "	where  sv.data_processing_id=:idDataProcessing and (:groupRole is null ||sv.ROLE_GROUP=:groupRole) and sv.CLS_TYPE_IO_ID=:typeIO and sv.WORKSET_ID=ss.id and ss.CLS_DATA_TYPE_ID=1 ";
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {

				query += " and t.idx in( select f.idx from IS2_WORKSET si, IS2_STEP_RUNTIME ssv,json_table( si.content, '$[*]'  columns "
						+ "(  idx FOR ORDINALITY, v TEXT path '$[0]') ) f "
						+ " where  ssv.data_processing_id=:idDataProcessing  and (:groupRole is null ||ssv.ROLE_GROUP=:groupRole)  and ssv.CLS_TYPE_IO_ID=:typeIO and ssv.WORKSET_ID=si.id  and si.name=:n_"
						+ key + " and f.v=:v_" + key + " ) ";
			}
		}
		query += "  order by t.idx asc " + "  ) rs " + " ) rs1 "
				+ "  where  rs1.adx    >:row_inf     and  rs1.adx <= :row_sup"
				+ "	   group by rs1.id,rs1.name, rs1.order_code  , rs1.CLS_DATA_TYPE_ID  ,rs1.value_parameter, rs1.paginationTotalRows ";

		Query q = em.createNativeQuery(query, Workset.class);
		q.setParameter("idDataProcessing", idDataProcessing);
		q.setParameter("typeIO", typeIO);
		q.setParameter("row_inf", row_inf);
		q.setParameter("row_sup", row_sup);
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

	
	public List<Object[]> findDatasetIdColAndName(Long dFile) {

	    Query qf = em.createNativeQuery("SELECT id,name FROM IS2_DATASET_COLUMN ss WHERE ss.dataset_file_ID=:dFile order by 1 asc ");
	    qf.setParameter("dFile", dFile);
	    @SuppressWarnings("unchecked")
	    List<Object[]>  resulFieldstList = (List<Object[]>) qf.getResultList();
		return resulFieldstList;
	}
	
	public List<Object[]> findWorsetIdColAndName(Long idDataProcessing,Integer typeIO, Integer groupRole) {

	    Query qf = em.createNativeQuery("SELECT ss.ID,ss.NAME from   IS2_WORKSET ss,  IS2_STEP_RUNTIME sv  where  sv.data_processing_id=:idDataProcessing and (:groupRole is null ||sv.ROLE_GROUP=:groupRole) and sv.CLS_TYPE_IO_ID=:typeIO and sv.WORKSET_ID=ss.id and ss.CLS_DATA_TYPE_ID=1  order by 1 asc ");
	    qf.setParameter("idDataProcessing", idDataProcessing);
	    qf.setParameter("typeIO", typeIO);
	    qf.setParameter("groupRole", groupRole);
	    @SuppressWarnings("unchecked")
	    List<Object[]>  resulFieldstList = (List<Object[]>) qf.getResultList();
		return resulFieldstList;
	}


	public List<Object[]> findDatasetDataViewParamsbyQuery( List<Object[]>  resulFieldstList,  Long dFile, Integer rigaInf, Integer length,
			HashMap<String, String> paramsFilter,   String nameColumnToOrder,String dirColumnOrder) {
 
	 	String query = "with ss_model as ("
			+ " SELECT "
			+ "        ss.id AS iddscol, "
			+ "        ss.name AS name, "
			+ "        ss.order_code, "
			+ "        t.idx, t.v "
			+ " FROM   "
			+ "        IS2_DATASET_COLUMN ss, json_table( CONVERT(  ss.content USING utf8), '$[*]' columns ( idx FOR ORDINALITY, v text path '$[0]') ) t " 
			+ " WHERE  "
			+ "        ss.dataset_file_id=:dFile),"
			+ " ss_pivot as ("
			+ "  SELECT "
			+ "        ss_model.idx,"
			+ "        ss_model.iddscol, ";
	
		for (Object[] field : resulFieldstList) {
			query += " MAX(IF(ss_model.iddscol = " + field[0] + ", ss_model.v, NULL )) AS `" + field[1] + "`,";
		}
		
		query = query.substring(0, query.length() - 1);
		
		query += " FROM ss_model GROUP BY ss_model.idx) "
				+ " SELECT tabres.*, COUNT(*) OVER() AS total_rows from ss_pivot tabres";

		if (paramsFilter != null) {
			String where = " WHERE ";
			for (String key : paramsFilter.keySet()) {
				where += " tabres." + key + "=:" + key + " AND";
			}
			query += where.substring(0, where.length() - 3);
		}
		
		// SORT
		if (nameColumnToOrder != null && !"".equals(nameColumnToOrder))
			query += " ORDER BY tabres." + nameColumnToOrder + " " + dirColumnOrder;
		query += " LIMIT " + rigaInf + ","+length ;

		Query q = em.createNativeQuery(query);
		q.setParameter("dFile", dFile);
		if (paramsFilter != null) {
			for (String key : paramsFilter.keySet()) {
				String value = paramsFilter.get(key);
				q.setParameter(key, value);
			}
		}
		@SuppressWarnings("unchecked")
		List<Object[]> resultList = (List<Object[]>) q.getResultList();
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
