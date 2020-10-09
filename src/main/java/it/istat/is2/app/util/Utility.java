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
package it.istat.is2.app.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.apache.log4j.Logger;
import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.renjin.sexp.Vector;

import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.BusinessProcess;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.workflow.domain.StepRuntime;

public class Utility {
    @SuppressWarnings("rawtypes")
    public static String printJsonToHtml(String jsonString) {
        StringBuffer ret = new StringBuffer();
        JSONParser jSONParser;
        Object jsonObject;
        try {
            jSONParser = new JSONParser(jsonString);
            jsonObject = jSONParser.parse();
            if (jsonObject instanceof JSONObject)
                ret.append(parseJson((JSONObject) jsonObject, ""));
            else if (jsonObject instanceof List)
                ret.append(parseList((List) jsonObject, ""));
            else
                ret.append(jsonString);
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            ret.append(jsonString);
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            ret.append(jsonString);
        }

        return ret.toString();
    }

    @SuppressWarnings("unchecked")
    public static String parseList(List<?> list, String ret) throws JSONException {

        for (Object object : list) {
            if (object instanceof List)
                ret = parseList((List<?>) object, ret);
            else if (object instanceof Map)
                ret = parseMap((Map<String, ?>) object, ret);
            else
                ret += object.toString();
        }

        return ret;
    }

    public static String parseMap(Map<String, ?> jsonObject, String ret) throws JSONException {

        Iterator<String> iterator = jsonObject.keySet().iterator();
        int len = jsonObject.keySet().size();
        int index = 0;
        while (iterator.hasNext()) {
            String obj = iterator.next();
            if (jsonObject instanceof List) {
                ret += "<ul>";
                ret += obj;
                ret = parseList((List<?>) jsonObject.get(obj), ret);
                ret += "</ul>";
            } else {
                if (index == 0)
                    ret += "<li>";
                ret += "<i>";
                ret += obj;
                ret += "</i>:&nbsp;";
                ret += jsonObject.get(obj);
                ret += "&nbsp;&nbsp;";
                if (index == len - 1)
                    ret += "</li>";
            }
            index++;
        }
        return ret;
    }

    public static String getArray(Object object2, String ret) throws JSONException {

        JSONArray jsonArr = (JSONArray) object2;

        for (int k = 0; k < jsonArr.length(); k++) {

            if (jsonArr.get(k) instanceof JSONObject) {
                ret = parseJson((JSONObject) jsonArr.get(k), ret);
            } else {
                ret += jsonArr.get(k);

            }

        }

        return ret;
    }

    public static String parseJson(JSONObject jsonObject, String ret) throws JSONException {

        Iterator<String> iterator = jsonObject.keys();
        int len = jsonObject.length();
        int index = 0;
        while (iterator.hasNext()) {
            String obj = iterator.next();
            if (jsonObject.get(obj) instanceof JSONArray) {
                ret += "<ul>";
                ret += obj;
                ret = getArray(jsonObject.get(obj), ret);
                ret += "</ul>";
            } else {
                if (index == 0)
                    ret += "<li>";
                ret += "<i>";
                ret += obj;
                ret += "</i>:&nbsp;";
                ret += jsonObject.get(obj);
                ret += "&nbsp;&nbsp;";
                if (index == len - 1)
                    ret += "</li>";
            }
            index++;
        }
        return ret;
    }

    public static String getLocalDate() {
        Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Europe/Rome"), Locale.ITALY);
        Date today = calendar.getTime();
        String dataOutput = null;
        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd-MMMM-yyyy HH:mm:ss");
            dataOutput = simpleDateFormat.format(today);
        } catch (Exception e) {
            Logger.getRootLogger().debug(e);
        }
        return dataOutput;
    }

    public static String buildQueryFilter(Long idelaborazione, HashMap<String, String> paramsFilter) {

        String paramQuery = " ";

        if (paramsFilter != null) {
            for (String key : paramsFilter.keySet()) {
                String value = paramsFilter.get(key);
                paramQuery += " and t.r in( select f.r from SX_WORKSET si, SX_STEP_VARIABLE ssv,json_table(si.valori, '$.valori[*]'  columns "
                        + "(  idx FOR ORDINALITY,r integer path '$.r', v varchar2 path '$.v') ) f "
                        + " where  ssv.elaborazione=" + idelaborazione + " and ssv.var=si.id  and si.nome='" + key
                        + "' and f.v='" + value + "') ";
            }
        }
        return paramQuery;
    }

    public static HashMap<String, String> recuperaParametri(HashMap<String, String> params,
                                                            Map<String, String[]> parameterMap) {
        // HashMap per l'invio in procedura
        HashMap<String, String> paramsToUse = new HashMap<String, String>();
        String param = "";

        for (String key : params.keySet()) {

            if (parameterMap.get("param_" + key) != null) {
                param = parameterMap.get("param_" + key)[0];
                paramsToUse.put(key, param);
            }
        }
        return paramsToUse;
    }

    // Ritorna un HashMap che mappa in modo dinamico i tipi dell'header provenienti
    // dal form con gli indici dell'header che abbiamo dal file
    public static HashMap<Integer, List<Integer>> mappaHeaderValues(Map<String, String[]> parameterMap,
                                                                    ArrayList<String> valoriHeader, int size) {
        // Mappa in modo dinamico i tipi dell'header provenienti dal form con gli indici
        // dell'header che abbiamo dal file
        HashMap<Integer, List<Integer>> headerValues = new HashMap<Integer, List<Integer>>();
        List<List<Integer>> colonne = new ArrayList<List<Integer>>();

        for (int i = 0; i < size; i++) {
            List<Integer> list = new ArrayList<>();
            colonne.add(list);
        }
        // Ogni valore iesimo per noi è una colonna dell'intestazione
        for (int i = 0; i < valoriHeader.size(); i++) {

            String value = parameterMap.get("sel_" + i)[0];
            int intValue = Integer.parseInt(value);
            // Controlla i tipi e riempie l'hashmap con la relativa etichetta (ad es. chiave
            // "variabile core" -> lista variabili core)
            // TODO: I tipi vanno presi da un file di configurazione dei metadati,
            // attualmente sono in calce lato javascript e lato java: Skip:0, Id:1, Y:2,
            // X:3, Pred:4
            switch (intValue) {
                case 0:
                    colonne.get(0).add(i);
                    break;
                case 1:
                    colonne.get(1).add(i);
                    break;
                case 2:
                    colonne.get(2).add(i);
                    break;
                case 3:
                    colonne.get(3).add(i);
                    break;
                case 4:
                    colonne.get(4).add(i);
                    break;
            }

        }
        // Vado a riempire l'hashmap con gli array di interi in modo posizionale
        // rispetto all'header
        // Le chiavi saranno sempre quelle del file di configurazione dei tipi, per ora:
        // Skip:0, Id:1, Y:2, X:3, Pred:4
        for (int i = 0; i < size; i++) {
            headerValues.put(i, colonne.get(i));
        }
        return headerValues;
    }

    public static void stampaValoriHeader(HashMap<Integer, List<Integer>> headerValues, int size) {
        for (int i = 0; i < size; i++) {
            switch (i) {
                case 0:
                    Logger.getRootLogger().info("Colonne skippate: " + headerValues.get(0));
                    break;
                case 1:
                    Logger.getRootLogger().info("Colonne Id: " + headerValues.get(1));
                    break;
                case 2:
                    Logger.getRootLogger().info("Colonne Y: " + headerValues.get(2));
                    break;
                case 3:
                    Logger.getRootLogger().info("Colonne X: " + headerValues.get(3));
                    break;
                case 4:
                    Logger.getRootLogger().info("Colonne Pred: " + headerValues.get(4));
                    break;
            }
        }
    }

    public static HashMap<String, String> createParamsMap() {
        // TODO: da integrare con la gestione parametri da file e sintesi
        HashMap<String, String> params = new HashMap<String, String>();
        params.put("model", "LN");
        params.put("lambda", "3");
        params.put("w", "0.0479");
        params.put("lambda.fix", "TRUE");
        params.put("w.fix", "TRUE");
        params.put("eps", "1e-7");
        params.put("max.iter", "500");
        params.put("t.outl", "0.5");
        params.put("graph", "TRUE");
        params.put("beta", "-0.152 1.215");
        params.put("sigma", "1.25");
        params.put("n.outlier", "0");
        params.put("is.conv", "");
        params.put("n.iter", "0");
        params.put("sing", "");
        params.put("bic.aic", "");
        params.put("wgt", "");
        params.put("tot", "");
        params.put("t.sel", "");
        return params;
    }

    public static HashMap<Integer, List<String>> creaListaTipi() {
        // HashMap tipi: TODO: da integrare con la gestione parametri da file e sintesi
        HashMap<Integer, List<String>> tipoDato = new HashMap<Integer, List<String>>();
        ArrayList<String> skip = new ArrayList<String>();
        skip.add(0, "Z");
        skip.add(1, "skip");

        List<String> identificativo = new ArrayList<String>();
        identificativo.add(0, "Id");
        identificativo.add(1, "identificativo");

        List<String> target = new ArrayList<String>();
        target.add(0, "Y");
        target.add(1, "target");

        List<String> covariata = new ArrayList<String>();
        covariata.add(0, "X");
        covariata.add(1, "covariata");

        List<String> predizione = new ArrayList<String>();
        predizione.add(0, "P");
        predizione.add(1, "predizione");

        List<String> outlier = new ArrayList<String>();
        outlier.add(0, "O");
        outlier.add(1, "outlier");

        List<String> peso = new ArrayList<String>();
        peso.add(0, "W");
        peso.add(1, "peso");

        List<String> errore = new ArrayList<String>();
        errore.add(0, "E");
        errore.add(1, "errore");

        List<String> ranking = new ArrayList<String>();
        ranking.add(0, "R");
        ranking.add(1, "ranking");

        List<String> output = new ArrayList<String>();
        output.add(0, "Out");
        output.add(1, "output");

        List<String> strato = new ArrayList<String>();
        strato.add(0, "S");
        strato.add(1, "strato");

        tipoDato.put(0, skip);
        tipoDato.put(1, identificativo);
        tipoDato.put(2, target);
        tipoDato.put(3, covariata);
        tipoDato.put(4, predizione);
        tipoDato.put(5, outlier);
        tipoDato.put(6, peso);
        tipoDato.put(7, errore);
        tipoDato.put(8, ranking);
        tipoDato.put(9, output);
        tipoDato.put(10, strato);
        return tipoDato;
    }

    public static Map<String, List<String>> getMapWorkSetValues(
            Map<String, ArrayList<StepRuntime>> dataMap, DataTypeCls dataType) {

        Map<String, List<String>> ret = new LinkedHashMap<>();
        for (Map.Entry<String, ArrayList<StepRuntime>> entry : dataMap.entrySet()) {
            String nomeW = entry.getKey();
            ArrayList<StepRuntime> stepRuntimes = entry.getValue();
            for (Iterator<StepRuntime> iterator = stepRuntimes.iterator(); iterator.hasNext(); ) {
                StepRuntime stepRuntime = iterator.next();

                if (stepRuntime.getWorkset().getDataType().getId().equals(dataType.getId())) {
                    if (dataType.getId().equals(IS2Const.DATA_TYPE_PARAMETER)) {
                        ArrayList<String> paramList = new ArrayList<>();
                        paramList.add(stepRuntime.getWorkset().getParamValue());
                        ret.put(nomeW, paramList);
                    } else
                        ret.put(nomeW, (ArrayList<String>) stepRuntime.getWorkset().getContents());
                }
            }
        }
        return ret;
    }


    public static Map<String, ArrayList<StepRuntime>> getMapCodiceRuoloStepVariabili(List<StepRuntime> dataList) {

        LinkedHashMap<String, ArrayList<StepRuntime>> ret = new LinkedHashMap<>();
        for (StepRuntime stepV : dataList) {
            String codR = stepV.getAppRole().getCode();
            ArrayList<StepRuntime> lista = ret.get(codR);
            if (lista == null) {
                lista = new ArrayList<StepRuntime>();
            }
            lista.add(stepV);
            ret.put(codR, lista);
        }
        return ret;
    }

    public static LinkedHashMap<String, ArrayList<StepRuntime>> getMapNameWorkSetStep(List<StepRuntime> dataList) {

        LinkedHashMap<String, ArrayList<StepRuntime>> ret = new LinkedHashMap<>();
        for (StepRuntime stepRuntime : dataList) {

            ArrayList<StepRuntime> stepList = ret.get(stepRuntime.getWorkset().getName());
            if (stepList == null)
                stepList = new ArrayList<>();
            stepList.add(stepRuntime);
            ret.put(stepRuntime.getWorkset().getName(), stepList);
        }
        return ret;
    }

    public static Map<String, AppRole> getMapRuoliByCod(List<AppRole> ruoliAll) {

        HashMap<String, AppRole> ret = new HashMap<>();
        for (AppRole appRoles : ruoliAll) {

            ret.put(appRoles.getCode(), appRoles);
        }
        return ret;
    }

    public static String combineList2String4R(List<String> lista) {
        String c = "";
        if (lista != null && !lista.isEmpty()) {
            c = "c(";
            for (String s : lista) {
                c += "'" + s + "',";
            }
            c = c.substring(0, c.length() - 1) + ")";
        }
        Logger.getRootLogger().debug("c4R: <" + c + ">");
        return c;
    }

    public static Map<Long, AppRole> getMapRuoliById(List<AppRole> ruoliAll) {
        HashMap<Long, AppRole> ret = new HashMap<>();
        for (AppRole appRoles : ruoliAll) {
            ret.put(appRoles.getId(), appRoles);
        }
        return ret;
    }

    public static BusinessProcess getBusinessProcess(List<BusinessProcess> listaBp, Long idprocesso) {

        for (BusinessProcess bP : listaBp) {
            if (bP.getId().equals(idprocesso)) {
                return bP;
            }
        }
        return null;

    }

    public static void writeObjectToCSV(PrintWriter writer, Map<String, List<String>> dataMap) throws IOException {
        ArrayList<String> header = new ArrayList<String>();
        CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.EXCEL);
        try {
            String wi = "";
            for (Iterator<String> iterator = dataMap.keySet().iterator(); iterator.hasNext(); ) {
                wi = iterator.next();
                header.add(wi);
            }

            csvPrinter.printRecord(header);

            int size = dataMap.get(wi).size();

            for (int i = 0; i < size; i++) {
                List<String> data = new ArrayList<>();
                for (Iterator<String> iterator = dataMap.keySet().iterator(); iterator.hasNext(); ) {
                    wi = iterator.next();
                    data.add(dataMap.get(wi).get(i));

                }

                csvPrinter.printRecord(data);
            }
            csvPrinter.flush();
            csvPrinter.close();
        } catch (Exception e) {
            csvPrinter.flush();
            csvPrinter.close();

        }
    }

    public static String string(ArrayList<String> values) throws JSONException {
        String value = "";
        JSONArray allDataArray = new JSONArray();
        for (int index = 0; index < values.size(); index++) {
            allDataArray.put(values.get(index) != null ? values.get(index) : "");
        }
        value = allDataArray.toString();
        return value;
    }

    public static ArrayList<String> convertToArrayListStringFieldOfObjects(List<?> values, Class<?> classObject,
                                                                           String fieldName)
            throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException {
        ArrayList<String> ret = new ArrayList<String>();
        Field field;

        field = classObject.getDeclaredField(fieldName);
        for (Object object : values) {
            field.setAccessible(true);
            Object value = field.get(object);
            ret.add(value.toString());
        }

        return ret;
    }

    /**
     * @param dataMap
     * @param dataType
     * @param keySet
     * @return
     */
    public static Map<String, Map<String, List<String>>> getMapWorkSetValuesInRoles(
            Map<String, ArrayList<StepRuntime>> dataMap, DataTypeCls dataType, Set<String> roles) {
        // TODO Auto-generated method stub
        Map<String, Map<String, List<String>>> ret = new LinkedHashMap<>();

        for (Map.Entry<String, ArrayList<StepRuntime>> entry : dataMap.entrySet()) {
            String nomeW = entry.getKey();
            ArrayList<StepRuntime> stepRuntimes = entry.getValue();
            for (Iterator<StepRuntime> iterator = stepRuntimes.iterator(); iterator.hasNext(); ) {
                StepRuntime stepRuntime = iterator.next();

                String codeRole = stepRuntime.getAppRole().getCode();
                String codeGroupRole = stepRuntime.getRoleGroup().getCode();
                Long idTipoVar = stepRuntime.getWorkset().getDataType().getId();

                if (roles.contains(codeRole) && idTipoVar.equals(dataType.getId())) {
                    ret.computeIfAbsent(codeGroupRole, k -> new LinkedHashMap<>()).put(nomeW, stepRuntime.getWorkset().getContents());
                }
            }
        }
        return ret;
    }

    /**
     * @param dataMap
     * @param nomeW
     * @param sxRuolo
     * @return
     */
    public static StepRuntime retrieveStepRuntime(Map<String, ArrayList<StepRuntime>> dataMap, String nomeW,
                                                  AppRole appRole) {
        StepRuntime ret = null;
        ArrayList<StepRuntime> stepRuntimes = dataMap.get(nomeW);
        if (stepRuntimes != null) {
            for (Iterator<StepRuntime> iterator = stepRuntimes.iterator(); iterator.hasNext(); ) {
                StepRuntime stepRuntime = iterator.next();
                if (stepRuntime.getAppRole().getCode().equals(appRole.getCode()))
                    ret = stepRuntime;

            }

        }

        return ret;
    }

    public static Map<String, String> getMapWorkSetValuesParams(Map<String, ArrayList<StepRuntime>> dataMap,
                                                                DataTypeCls dataType) {
        // TODO Auto-generated method stub
        HashMap<String, String> ret = new HashMap<>();
        for (Map.Entry<String, ArrayList<StepRuntime>> entry : dataMap.entrySet()) {
            String nomeW = entry.getKey();
            ArrayList<StepRuntime> stepRuntimes = entry.getValue();
            for (Iterator<StepRuntime> iterator = stepRuntimes.iterator(); iterator.hasNext(); ) {
                StepRuntime stepRuntime = iterator.next();

                if (stepRuntime.getWorkset().getDataType().getId().equals(dataType.getId())) {
                    if (dataType.getId().equals(IS2Const.DATA_TYPE_PARAMETER)) {

                        ret.put(nomeW, stepRuntime.getWorkset().getParamValue());
                    }

                }
            }
        }
        return ret;

    }

    public static ArrayList<String> toArrayListofString(Vector values) {
        // TODO Auto-generated method stub
        ArrayList<String> ret = new ArrayList<String>();
        for (int i = 0; i < values.length(); i++) {
            Object elem = values.getElementAsObject(i);
            ret.add(String.valueOf(elem));
        }
        return ret;
    }

    public static boolean isNumericR(String[] arrX) {
        for (String elem : arrX) {
            if (elem.isEmpty() || "NA".equalsIgnoreCase(elem)) {
                continue;
            }
            try {
                Double.parseDouble(elem);
            } catch (NumberFormatException | NullPointerException nfe) {
                return false;
            }
        }
        return true;
    }

  

    public static boolean isNullOrEmpty(final Collection<?> c) {
        return c == null || c.isEmpty();
    }

    public static boolean isNullOrEmpty(final Map<?, ?> m) {
        return m == null || m.isEmpty();
    }

}
