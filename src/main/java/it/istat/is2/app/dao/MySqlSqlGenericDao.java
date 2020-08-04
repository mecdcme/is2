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

public class MySqlSqlGenericDao extends SqlGenericDao {

    public MySqlSqlGenericDao() {
        super();
    }

    @Override
    public List<Object[]> findWorKSetDataViewParamsbyQuery(List<Object[]> resulFieldstList, Long idDataProcessing,
                                                           Integer typeIO, Integer groupRole, Integer rigaInf, Integer length, Map<String, String> paramsFilter,
                                                           String nameColumnToOrder, String dirColumnOrder) {

        String query = "with ss_model as (" + " SELECT " + "        ss.id AS idwscol, " + "        ss.name AS name, "
                + "        ss.order_code," + "		   ss.CLS_DATA_TYPE_ID as CLS_DATA_TYPE_ID,"
                + "        ss.value_parameter as value_parameter," + "		   ss.content_size, "
                + "        t.idx, t.v " + " FROM   "
                + "      IS2_WORKSET ss,  IS2_STEP_RUNTIME sv, json_table(ss.content , '$[*]' columns( idx FOR ORDINALITY,  v TEXT  path '$[0]')     ) t	 "
                + " WHERE  "
                + "        sv.data_processing_id=:idDataProcessing and (:groupRole is null ||sv.ROLE_GROUP=:groupRole) and sv.CLS_TYPE_IO_ID=:typeIO and sv.WORKSET_ID=ss.id and ss.CLS_DATA_TYPE_ID=1 "
                + " ) ," + " ss_pivot as (" + "  SELECT " + "        ss_model.idx," + "        ss_model.idwscol, ";

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
        if (nameColumnToOrder != null && !"".equals(nameColumnToOrder)) {
            query += " ORDER BY tabres." + nameColumnToOrder + " " + dirColumnOrder;
        }
        query += " LIMIT " + rigaInf + ", " + length;

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

        String query = "with ss_model as (" + " SELECT " + "        ss.id AS iddscol, " + "        ss.name AS name, "
                + "        ss.order_code, " + "        t.idx, t.v " + " FROM   "
                + "        IS2_DATASET_COLUMN ss, json_table( CONVERT(  ss.content USING utf8), '$[*]' columns ( idx FOR ORDINALITY, v text path '$[0]') ) t "
                + " WHERE  " + "        ss.dataset_file_id=:dFile)," + " ss_pivot as (" + "  SELECT "
                + "        ss_model.idx," + "        ss_model.iddscol, ";

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
        if (nameColumnToOrder != null && !"".equals(nameColumnToOrder)) {
            query += " ORDER BY tabres." + nameColumnToOrder + " " + dirColumnOrder;
        }
        query += " LIMIT " + rigaInf + "," + length;

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
                "SELECT table_name FROM information_schema.tables WHERE table_schema = :table_schema");
        q.setParameter("table_schema", tableSchema);
        @SuppressWarnings("unchecked")
        List<String> resultList = (List<String>) q.getResultList();
        return resultList;
    }

    @Override
    public List<String> findFieldsTableDB(String tableSchema, String tableName) {

        Query q = em.createNativeQuery(
                "SELECT COLUMN_NAME  FROM information_schema.columns  WHERE table_schema = :table_schema  AND table_name=:table_name");
        q.setParameter("table_schema", tableSchema);
        q.setParameter("table_name", tableName);
        @SuppressWarnings("unchecked")
        List<String> resultList = (List<String>) q.getResultList();
        return resultList;
    }

}
