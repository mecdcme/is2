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
package it.istat.is2.app.dao;

import java.util.List;
import java.util.Map;

import javax.persistence.Query;

public class PostgreSQLSqlGenericDao extends SqlGenericDao {

    public PostgreSQLSqlGenericDao() {
        super();
    }

    @Override
    public List<Object[]> findWorKSetDataViewParamsbyQuery(List<Object[]> resulFieldstList, Long idDataProcessing,
                                                           Integer typeIO, Integer groupRole, Integer rigaInf, Integer length, Map<String, String> paramsFilter,
                                                           String nameColumnToOrder, String dirColumnOrder) {

        String query = "with ss_model as (" + " SELECT " + "        ss.id AS idwscol, " + "        ss.name AS name, "
                + "        ss.order_code," + "		   ss.CLS_DATA_TYPE_ID as CLS_DATA_TYPE_ID,"
                + "        ss.value_parameter as value_parameter," + "		   ss.content_size, "
                + "        t.idx, trim(both '\"' from cast(t.v as text)) as v " + " FROM   "
                + "      IS2_WORKSET ss,  IS2_STEP_RUNTIME sv, jsonb_array_elements(cast(ss.content as jsonb)) WITH ORDINALITY AS t(v,idx)	 "
                + " WHERE  "
                + "        sv.data_processing_id=:idDataProcessing and (:groupRole is null OR sv.ROLE_GROUP=:groupRole) and sv.CLS_TYPE_IO_ID=:typeIO and sv.WORKSET_ID=ss.id and ss.CLS_DATA_TYPE_ID=1 "
                + " ) ," + " ss_pivot as (  SELECT  ss_model.idx,   ss_model.idx idwscol, ";

        for (Object[] field : resulFieldstList) {
            query += " MAX( CASE WHEN (ss_model.idwscol = " + field[0] + ") THEN ss_model.v ELSE  NULL END) AS \""
                    + field[1] + "\",";
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
        else {
            query += " ORDER BY tabres.idx  ASC";
        }
        query += " OFFSET " + rigaInf + " LIMIT " + length;

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

    @Override
    public List<Object[]> findDatasetDataViewParamsbyQuery(List<Object[]> resulFieldstList, Long dFile, Integer rigaInf,
                                                           Integer length, Map<String, String> paramsFilter, String nameColumnToOrder, String dirColumnOrder) {

        String query = "with ss_model as (  SELECT   ss.id AS iddscol,    ss.name AS name, "
                + "        ss.order_code,    t.idx, trim(both '\"' from cast(t.v as text)) as v   FROM   "
                + "        IS2_DATASET_COLUMN ss, jsonb_array_elements(cast(ss.content as jsonb)) WITH ORDINALITY AS t(v,idx) "
                + " WHERE     ss.dataset_file_id=:dFile order by t.idx),  ss_pivot as (  SELECT "
                + "        ss_model.idx,  ss_model.idx AS idx2 ,";

        for (Object[] field : resulFieldstList) {
            query += " MAX(CASE WHEN ss_model.iddscol = " + field[0] + " THEN ss_model.v END) AS " + field[1] + ",";
        }

        query = query.substring(0, query.length() - 1);

        query += " FROM ss_model GROUP BY ss_model.idx  ) "
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

        else {
            query += " ORDER BY tabres.idx  ASC";
        }
        query += " OFFSET " + rigaInf + " LIMIT " + length;

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

    @Override
    public List<String> findTablesDB(String tableSchema) {

        Query q = em.createNativeQuery(
                "SELECT table_name FROM information_schema.tables WHERE LOWER (table_schema) = LOWER (:table_schema)");
        q.setParameter("table_schema", tableSchema);
        @SuppressWarnings("unchecked")
        List<String> resultList = (List<String>) q.getResultList();
        return resultList;
    }

    @Override
    public List<String> findFieldsTableDB(String tableSchema, String tableName) {

        Query q = em.createNativeQuery(
                "SELECT COLUMN_NAME  FROM information_schema.columns  WHERE LOWER (table_schema) = LOWER (:table_schema)  AND LOWER(table_name)=LOWER(:table_name)");
        q.setParameter("table_schema", tableSchema);
        q.setParameter("table_name", tableName);
        @SuppressWarnings("unchecked")
        List<String> resultList = (List<String>) q.getResultList();
        return resultList;
    }
}
