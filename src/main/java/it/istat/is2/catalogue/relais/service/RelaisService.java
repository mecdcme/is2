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
 * @version 0.1.1
 */
/**
 *
 */
package it.istat.is2.catalogue.relais.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.catalogue.relais.dao.RelaisGenericDao;

/**
 * @author framato
 *
 */
@Service
public class RelaisService {

    @Autowired
    private RelaisGenericDao relaisGenericDao;

    public Map<?, ?> crossTable(Long idelaborazione,   Map<String, ArrayList<String>> ruoliVariabileNome,  Map<String, ArrayList<String>> worksetVariabili) throws Exception {
    	Map<String, ArrayList<String>> worksetOut = new LinkedHashMap<String, ArrayList<String>>();
      
    	// <codRuolo,[namevar1,namevar2..]
    	
    	String  codeMatchingA="X1";
    	String  codeMatchingB="X2";
    	ArrayList<String> variabileNomeListMA = new ArrayList<>();
    	ArrayList<String> variabileNomeListMB = new ArrayList<>();

        ArrayList<String> variabileNomeListOut = new ArrayList<>();
          
        ruoliVariabileNome.get(codeMatchingA).forEach((varname) -> {
        	variabileNomeListMA.add(varname);
      });
        ruoliVariabileNome.get(codeMatchingB).forEach((varname) -> {
        	variabileNomeListMB.add(varname);
      });
      
        ruoliVariabileNome.values().forEach((list) -> {
              variabileNomeListOut.addAll(list);
        });
        
       String firstFiledMA=ruoliVariabileNome.get(codeMatchingA).get(0);
       String firstFiledMB=ruoliVariabileNome.get(codeMatchingB).get(0);
       int sizeA= worksetVariabili.get(firstFiledMA).size();
       int sizeB= worksetVariabili.get(firstFiledMB).size();
       
          // init worksetOut
       variabileNomeListOut.forEach(name -> {
            worksetOut.put(name, new ArrayList<>());
        });

       
        for (int iA = 0; iA < sizeA; iA++) {
        	Map<String,String> valuesI =new HashMap<>();
        	 final Integer innerIA = new Integer(iA);
        	 variabileNomeListMA.forEach(varnameMA ->{
        		 valuesI.put(varnameMA, worksetVariabili.get(varnameMA).get(innerIA));
        	 });
        	  
        	   for (int iB = 0; iB < sizeB; iB++) {
        		   ArrayList<String> valueIB = new ArrayList<>();
        		   final Integer innerIB = new Integer(iB);
        		   variabileNomeListMB.forEach(varnameMB ->{
        			   valuesI.put(varnameMB, worksetVariabili.get(varnameMB).get(innerIB));
              	 });
        		
        		   //write to worksetout
        		     		   valuesI.forEach((key,value)->{
        		     			  worksetOut.get(key).add(value);
        		   
        		   }) ;
       		}
        	
		}
        
        
        
        
        
        
        
     /*   HashMap<String, Object> paramsQuery = new HashMap<>();
        paramsQuery.put("idelaborazione", idelaborazione);

        String query = " SELECT  " + selectFields + " FROM  ";
        int indexRole = 0;
        for (Iterator iterator = ruoliVariabileNome.keySet().iterator(); iterator.hasNext();) {
            String codRole = (String) iterator.next();
            indexRole++;
            String paramCodRole = "codRole" + indexRole;
            paramsQuery.put(paramCodRole, codRole);

            ArrayList<String> variableList = ruoliVariabileNome.get(codRole);
            query += " ( SELECT " + String.join(",", variableList) + " FROM  ";
            int indexVariableName = 0;
            for (Iterator iterator2 = variableList.iterator(); iterator2.hasNext();) {
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
            	   query += " subqvn"+i+".r=subqvn"+(i+1)+".r ";
            	   if (i<variableList.size()-1)     query += " and ";
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

        for (Iterator iterator = risList.iterator(); iterator.hasNext();) {
            Object[] ris = (Object[]) iterator.next();
            int indexValues = 0;
            for (Iterator iterator2 = variabileNomeList.iterator(); iterator2.hasNext();) {
                String name = (String) iterator2.next();
                ArrayList<String> valueList = worksetOut.get(name);
                valueList.add(ris[indexValues].toString());
                indexValues++;
                worksetOut.put(name, valueList);
            }

        }
*/
        return worksetOut;
    }

    public Map<?, ?> crossTableSQL(Long idelaborazione, Map ruoliVariabileNome) throws Exception {
        return relaisGenericDao.crossTable(idelaborazione, (LinkedHashMap<String, ArrayList<String>>) ruoliVariabileNome);
    }

}
