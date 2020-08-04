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
package it.istat.is2.catalogue.relais.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RelaisGenericDao {

    @Autowired
    private EntityManager em;

    // Return a Map Values
    public Map<?, ?> crossTable(Long idelaborazione, LinkedHashMap<String, ArrayList<String>> ruoliVariabileNome)
            throws Exception {

        Map<String, ArrayList<String>> worksetOut = new LinkedHashMap<String, ArrayList<String>>();
        // <codRuolo,[namevar1,namevar2..]

        ArrayList<String> variabileNomeList = new ArrayList<>();

        final StringBuilder selectFieldsbuilder = new StringBuilder();
        ruoliVariabileNome.values().forEach((list) -> {
            selectFieldsbuilder.append(String.join(",", list));
            selectFieldsbuilder.append(",");
            variabileNomeList.addAll(list);
        });

        String selectFields = selectFieldsbuilder.substring(0, selectFieldsbuilder.length() - 1);

        // init worksetOut
        variabileNomeList.forEach(name -> {
            worksetOut.put(name, new ArrayList<>());
        });

        HashMap<String, Object> paramsQuery = new HashMap<>();
        paramsQuery.put("idelaborazione", idelaborazione);

        String query = " SELECT  " + selectFields + " FROM  ";
        int indexRole = 0;
        for (Iterator<String> iterator = ruoliVariabileNome.keySet().iterator(); iterator.hasNext(); ) {
            String codRole = (String) iterator.next();
            indexRole++;
            String paramCodRole = "codRole" + indexRole;
            paramsQuery.put(paramCodRole, codRole);

            ArrayList<String> variableList = ruoliVariabileNome.get(codRole);
            query += " ( SELECT " + String.join(",", variableList) + " FROM  ";
            int indexVariableName = 0;
            for (Iterator<String> iterator2 = variableList.iterator(); iterator2.hasNext(); ) {
                String variableName = (String) iterator2.next();
                indexVariableName++;
                String paramVariableName = "variabilename" + indexRole + "_" + indexVariableName;
                paramsQuery.put(paramVariableName, variableName);
                query += " ( SELECT t.r, t.v as " + variableName
                        + " FROM  SX_WORKSET ss, SX_STEP_VARIABLE sv,SX_RUOLI sr,  json_table(CONVERT(  ss.valori USING utf8), '$.valori[*]'  columns ( idx FOR ORDINALITY,r int path '$.r', v varchar(100) path '$.v') ) t "
                        + "  where  sv.elaborazione=:idelaborazione  and sv.var=ss.id and ss.TIPO_VAR=1 and sv.ruolo=sr.id and sr.cod=:"
                        + paramCodRole + " and ss.nome=:" + paramVariableName + "   ) subqvn" + indexVariableName;
                if (variableList.size() > 1 && indexVariableName < variableList.size()) {
                    query += ",";
                }

            }
            if (variableList.size() > 1) {
                query += " where ";
                for (int i = 1; i < variableList.size(); i++) {
                    query += " subqvn" + i + ".r=subqvn" + (i + 1) + ".r ";
                    if (i < variableList.size() - 1)
                        query += " and ";
                }

            }

            query += " ) subqr" + indexRole;
            if (ruoliVariabileNome.size() > 1 && indexRole < ruoliVariabileNome.size()) {
                query += ",";
            }

        }

        Query q = em.createNativeQuery(query);

        paramsQuery.forEach((key, value) -> {
            q.setParameter(key, value);
        });

        List<Object[]> risList = q.getResultList();

        for (Iterator<Object[]> iterator = risList.iterator(); iterator.hasNext(); ) {
            Object[] ris = (Object[]) iterator.next();
            int indexValues = 0;
            for (Iterator<String> iterator2 = variabileNomeList.iterator(); iterator2.hasNext(); ) {
                String name = (String) iterator2.next();
                ArrayList<String> valueList = worksetOut.get(name);
                valueList.add(ris[indexValues].toString());
                indexValues++;
                worksetOut.put(name, valueList);
            }

        }

        return worksetOut;
    }

    /**
     * @param idWorKsetDB
     * @param indexAllItems JSON_MERGE_PRESERVE('["a", 1]', '{"key": "value"}');
     * @param values
     */
    @Transactional
    public int appendValuesWorkset(Long idWorKsetDB, String valuesToAppend, long indexAllItems) {
        // TODO Auto-generated method stub

        int ret = 0;
//		System.out.println("idWorKsetDB: " + idWorKsetDB + " valuesToAppend  " + valuesToAppend);
        String query = "UPDATE SX_WORKSET sw  SET  sw.valori_size=:indexAllItems, sw.valori= JSON_MERGE_PRESERVE(sw.valori, :valuesToAppend) where sw.id=:idWorKsetDB ";
        em.clear();

        Query q = em.createNativeQuery(query);
        q.setParameter("indexAllItems", Long.valueOf(indexAllItems));
        q.setParameter("valuesToAppend", valuesToAppend);
        q.setParameter("idWorKsetDB", idWorKsetDB);

        ret = q.executeUpdate();

        return ret;

    }

    @Transactional
    public int appendValuesWorkset_old(Long idWorKsetDB, String jsonValues, long indexAllItems) {
        // TODO Auto-generated method stub
        String valuesToAppend = jsonValues + "]}";
        int ret = 0;
//		System.out.println("idWorKsetDB: " + idWorKsetDB + " valuesToAppend  " + valuesToAppend);
        String query = "UPDATE SX_WORKSET sw  SET  sw.valori_size=:indexAllItems, sw.valori= CONCAT( SUBSTRING(sw.valori,1,LENGTH(sw.valori)-2 ), :valuesToAppend) where sw.id=:idWorKsetDB ";
        em.clear();

        Query q = em.createNativeQuery(query);
        q.setParameter("indexAllItems", Long.valueOf(indexAllItems));
        q.setParameter("valuesToAppend", valuesToAppend);
        q.setParameter("idWorKsetDB", idWorKsetDB);

        ret = q.executeUpdate();

        return ret;

    }
}
