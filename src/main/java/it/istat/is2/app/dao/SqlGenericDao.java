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

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import it.istat.is2.dataset.domain.DatasetFile;

@Repository
public abstract class SqlGenericDao {

    public static final String MYSQL = "mysql";
    public static final String POSTGRESSQL = "postgresql";

    @Autowired
    protected EntityManager em;

    @SuppressWarnings("unchecked")
    public List<DatasetFile> findGenericDatasetFileAll() {

        Query q = em.createNativeQuery("select * from IS2_DATASET_FILE", DatasetFile.class);
        List<?> resultList = q.getResultList();
        return (List<DatasetFile>) resultList;
    }

    public DatasetFile findGenericDatasetFileOne(Long id) {

        Query q = em.createNativeQuery("select * from IS2_DATASET_FILE df where df.id=?", DatasetFile.class);
        q.setParameter(1, id);
        return (DatasetFile) q.getSingleResult();

    }

    @SuppressWarnings("unchecked")
    public List<Object[]> findDatasetIdColAndName(Long dFile) {
        Query qf = em.createNativeQuery(
                "SELECT id,name FROM IS2_DATASET_COLUMN ss WHERE ss.dataset_file_ID=:dFile order by 1 asc ");
        qf.setParameter("dFile", dFile);
        return qf.getResultList();

    }

    @SuppressWarnings("unchecked")
    public List<Object[]> findWorsetIdColAndName(Long idDataProcessing, Integer typeIO, Integer groupRole) {

        Query qf = em.createNativeQuery(
                "SELECT ss.ID,ss.NAME from   IS2_WORKSET ss,  IS2_STEP_RUNTIME sv  where  sv.data_processing_id=:idDataProcessing and (:groupRole is null OR sv.ROLE_GROUP= :groupRole) and sv.CLS_TYPE_IO_ID=:typeIO and sv.WORKSET_ID=ss.id  order by 1 asc ");
        qf.setParameter("idDataProcessing", idDataProcessing);
        qf.setParameter("typeIO", typeIO);
        qf.setParameter("groupRole", groupRole);
        return qf.getResultList();

    }

    @SuppressWarnings("unchecked")
    public List<String> loadFieldValuesTable(String dbschema, String tablename, String field) {

        String table = dbschema + "." + tablename;
        String query = "SELECT  ?  FROM (%s)";
        String sql = String.format(query, table);
        Query q = em.createNativeQuery(sql);
        q.setParameter(1, field);

        return q.getResultList();

    }

    public abstract List<Object[]> findWorKSetDataViewParamsbyQuery(List<Object[]> resulFieldstList,
                                                                    Long idDataProcessing, Integer typeIO, Integer groupRole, Integer rigaInf, Integer length,
                                                                    Map<String, String> paramsFilter, String nameColumnToOrder, String dirColumnOrder);

    public abstract List<Object[]> findDatasetDataViewParamsbyQuery(List<Object[]> resulFieldstList, Long dFile,
                                                                    Integer rigaInf, Integer length, Map<String, String> paramsFilter, String nameColumnToOrder,
                                                                    String dirColumnOrder);

    public abstract List<String> findTablesDB(String tableSchema);

    public abstract List<String> findFieldsTableDB(String tableSchema, String tableName);

    public static SqlGenericDao getSqlGenericDAOFactory(String database) {
        switch (database.toLowerCase()) {
            case MYSQL:
                return new MySqlSqlGenericDao();
            case POSTGRESSQL:
                return new PostgreSQLSqlGenericDao();
            default:
                return null;
        }
    }
}
