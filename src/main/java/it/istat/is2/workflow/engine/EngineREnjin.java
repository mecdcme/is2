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
package it.istat.is2.workflow.engine;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.StringTokenizer;

import javax.script.ScriptException;

import org.apache.log4j.Logger;
import org.renjin.script.RenjinScriptEngine;
import org.renjin.script.RenjinScriptEngineFactory;
import org.renjin.sexp.ListVector;
import org.renjin.sexp.StringVector;
import org.renjin.sexp.Vector;

import org.springframework.stereotype.Service;


import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.StepInstanceSignature;
import it.istat.is2.workflow.domain.StepRuntime;
import it.istat.is2.workflow.domain.TypeIO;
import it.istat.is2.workflow.domain.Workset;

@Service
public class EngineREnjin extends EngineR implements EngineService {

    RenjinScriptEngine engine;


    final StringWriter logWriter = new StringWriter();
    private final Map<String, Object> worksetOut;
    private final Map<String, Object> rolesOut;

    public EngineREnjin(String pathR, String fileScriptR) {
        super();
        this.pathR = pathR;
        this.fileScriptR = fileScriptR;
        command = "";
        this.worksetOut = new LinkedHashMap<>();
        this.rolesOut = new LinkedHashMap<>();
    }

    public EngineREnjin() {
        super();
        command = "";
        this.worksetOut = new LinkedHashMap<>();
        this.rolesOut = new LinkedHashMap<>();
    }

    @Override
    public void init(DataProcessing dataProcessing, StepInstance stepInstance) throws Exception {
        // Create a connection to Rserve instance running on default port 6311
        this.dataProcessing = dataProcessing;
        this.stepInstance = stepInstance;
        this.fileScriptR = stepInstance.getAppService().getSource();

        logService.save("Engine REnjin Init for " + stepInstance.getMethod());

        prepareEnv();
        createConnection();
        bindInputColumnsMap(worksetVariables, WORKSET_IN);
        bindInputColumnsParams(parametersMap, PARAMETERS_IN);
        bindInputColumns(rulesetMap, RULESET);
        setRoles(variablesRolesMap);

    }

    private void createConnection() throws ScriptException {
        // Create a script engine manager:
        RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();
        // Create a Renjin engine:
        engine = factory.getScriptEngine();
        // set log
        logWriter.getBuffer().delete(0, logWriter.getBuffer().length());
        engine.getContext().setWriter(logWriter);
        engine.eval("setwd('" + pathR + "')");
        // engine.eval("source('libraries.R')");
        engine.eval("source('" + fileScriptR + "')");

        Logger.getRootLogger().debug("Script Loaded");
    }

    public void closeConnection() {
        // Do nothing
    }

    public void bindInputColumns(Map<String, List<String>> workset, String varR) throws ScriptException {

        if (!workset.isEmpty()) {
            List<String> keys = new ArrayList<>(workset.keySet());
            StringBuilder listaCampi = new StringBuilder();
            int size = keys.size();
            String key;

            for (int i = 0; i < size; i++) {
                key = keys.get(i);

                String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                listaCampi.append(key + ",");
                engine.put(key, arrX); // Create a string vector
                try {
                    if (Utility.isNumericR(arrX)) {
                        engine.eval(key + " <- as.numeric(" + key + ")");
                    }
                } catch (Exception e) {
                    Logger.getRootLogger().error(e.getMessage());
                }

            }

            engine.eval(varR + " <- data.frame(" + listaCampi.substring(0, listaCampi.length() - 1) + ")"); // Create a
            // data
            // frame
        }
    }

    public void bindInputColumnsMap(Map<String, Map<String, List<String>>> worksetIn, String varR) throws ScriptException {

        if (!worksetIn.isEmpty()) {
            engine.eval(varR + " <- list()");

            worksetIn.forEach((keyW, workset) -> {


                try {
                    engine.eval(keyW + " <- list() ");


                    List<String> keys = new ArrayList<>(workset.keySet());
                    StringBuilder listaCampi = new StringBuilder();
                    int size = keys.size();
                    String key;

                    for (int i = 0; i < size; i++) {
                        key = keys.get(i);

                        String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                        listaCampi.append(key + ",");
                        engine.put(key, arrX); // Create a string vector
                        try {
                            if (Utility.isNumericR(arrX)) {
                                engine.eval(key + " <- as.numeric(" + key + ")");

                            }
                        } catch (Exception e) {
                            Logger.getRootLogger().error(e.getMessage());
                        }

                    }
                    engine.eval(keyW + " <- data.frame(" + listaCampi.substring(0, listaCampi.length() - 1) + ", stringsAsFactors = FALSE)");


                    engine.eval(varR + "[['" + keyW + "']] <- " + keyW);
                } catch (ScriptException e1) {
                    // TODO Auto-generated catch block
                    throw new RuntimeException(e1);
                }

            });                                                                                                // data
            //	engine.eval(varR + " <- data.frame(" + listaCampi.substring(0, listaCampi.length() - 1) + ")");
            // frame
        }
    }

    public void bindInputColumnsParams(Map<String, List<String>> workset, String varR)
            throws ScriptException {

        if (!workset.isEmpty()) {
            List<String> keys = new ArrayList<>(workset.keySet());
            StringBuilder listaCampi = new StringBuilder();
            int size = keys.size();
            String key;
            for (int i = 0; i < size; i++) {
                key = keys.get(i);
                String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                listaCampi.append(key + ",");
                engine.put(key, arrX);
            }

            engine.eval(varR + " <- list(" + listaCampi.substring(0, listaCampi.length() - 1) + ")");

        }
    }

    @Override
    public void doAction() throws ScriptException {

        String fname = stepInstance.getMethod();
        // Aggiunto il workset e params nella lista degli argomenti della funzione (by
        // paolinux)
        command = RESULTSET + "  <- " + fname + "( " + WORKSET_IN + "," + ROLES_IN + ",";
        if (!parametersMap.isEmpty()) {
            command += PARAMETERS_IN + ",";
        }
        if (!rulesetMap.isEmpty()) {
            command += RULESET + ",";
        }

        command = command.substring(0, command.length() - 1);
        command += ")";
        Logger.getRootLogger().debug("Eseguo " + command);

        engine.eval(command);
    }

    // Assegna il ruolo selemix alle variabili del workset
    public void setRoles(LinkedHashMap<String, ArrayList<String>> ruoliVariabileNome) throws ScriptException {
        String rolesList = "";
        Logger.getRootLogger().debug("Eseguo SetRuoli>");
        for (Map.Entry<String, ArrayList<String>> entry : ruoliVariabileNome.entrySet()) {
            String roleCode = entry.getKey();
            ArrayList<String> nomeVariabiliList = entry.getValue();
            rolesList += "'" + roleCode + "' = " + Utility.combineList2String4R(nomeVariabiliList) + ",";
        }
        rolesList = rolesList.substring(0, rolesList.length() - 1);

        engine.eval(ROLES_IN + " <-list(" + rolesList + ")");
    }

    public void getGenericOutput(Map<String, Object> genericHashMap, String varR, String tipoOutput)
            throws ScriptException {
        Logger.getRootLogger().debug("Eseguo Get " + tipoOutput);
        try {
            ListVector listR = (ListVector) engine.eval(varR + "$" + tipoOutput);
            // StringVector names = (StringVector) engine.eval("names(" + varR + "$" +
            // tipoOutput + ")");
            if (listR != null && listR.length() > 0) {
                // getRecursiveOutput(genericHashMap, listR, names);
                getRecursiveOutput(genericHashMap, listR);
                Logger.getRootLogger()
                        .debug("Impostati campi di " + tipoOutput + "= " + genericHashMap.values().toString());
            }
        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
        }
    }

    public void getGenericParamterOutput(Map<String, String> genericHashMap, String varR, String tipoOutput)
            throws ScriptException {
        Logger.getRootLogger().debug("Eseguo Get " + tipoOutput);
        try {
            ListVector listR = (ListVector) engine.eval(varR + "$" + tipoOutput);
            StringVector names = (StringVector) engine.eval("names(" + varR + "$" + tipoOutput + ")");
            String name;
            String value;
            if (listR != null && listR.length() > 0) {
                for (int i = 0; i < listR.length(); i++) {
                    name = names.getElementAsString(i);
                    value = listR.getElementAsString(i);
                    genericHashMap.put(name, value);
                }

                Logger.getRootLogger()
                        .debug("Impostati campi di " + tipoOutput + "= " + genericHashMap.values().toString());
            }
        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
        }
    }

    public void getRolesGroup(LinkedHashMap<String, String> genericHashMap, String varR, String tipoOutput)
            throws ScriptException {
        Logger.getRootLogger().debug("Eseguo Get " + tipoOutput);
        try {
            ListVector listR = (ListVector) engine.eval(varR + "$" + tipoOutput);
            StringVector names = (StringVector) engine.eval("names(" + varR + "$" + tipoOutput + ")");
            String name;
            for (int i = 0; i < listR.length(); i++) {
                name = names.getElementAsString(i);
                StringVector vectorR = (StringVector) listR.getElementAsSEXP(i);
                for (int j = 0; j < vectorR.length(); j++) {
                    genericHashMap.put(vectorR.getElementAsString(j), name);
                }
            }
        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
        }
    }

    public void writeLogScriptR() throws ScriptException {
        Logger.getRootLogger().debug("Eseguo getLogScriptR ");

        String output = logWriter.toString();
        StringTokenizer multiTokenizer = new StringTokenizer(output, "\n");

        while (multiTokenizer.hasMoreTokens()) {

            logService.save(multiTokenizer.nextToken(), IS2Const.OUTPUT_R);
        }

        logService.save("Script completed!");
    }

    public void getRecursiveOutput(Map<String, Object> genericHashMap, ListVector listR) throws ScriptException {
        String name = "";
        if (listR != null) {
            // Logger.getRootLogger().info("Campi:> " + names.asString() + " Size(" +
            // listR.length() + ")");
            for (int i = 0; i < listR.length(); i++) {
                if (listR.get(i) instanceof ListVector) {
                    // getRecursiveOutput(genericHashMap, (ListVector) listR.get(i), (StringVector)
                    name = listR.getName(i);
                    Map<String, Object> mapOutput = new LinkedHashMap<>();

                    getRecursiveOutput(mapOutput, (ListVector) listR.get(i));
                    genericHashMap.put(name, mapOutput);
                } else {
                    Vector values = (Vector) listR.get(i);
                    name = listR.getName(i);
                    genericHashMap.put(name, Utility.toArrayListofString(values));
                    Logger.getRootLogger()
                            .info(name + " (" + values.length() + "): " + genericHashMap.get(name).toString());
                }
            }
        }
    }

    public void bindInputParams(HashMap<String, ArrayList<String>> parametriMap) throws ScriptException {
        for (Map.Entry<String, ArrayList<String>> entry : parametriMap.entrySet()) {
            String nomep = entry.getKey();
            ArrayList<String> valore = entry.getValue();
            // X <- c('X1','X2');
            String comando = nomep + " <- " + Utility.combineList2String4R(valore);
            Logger.getRootLogger().info("Comando: " + comando);
            engine.eval(comando);
        }
    }

    @SuppressWarnings("unchecked")
    public void prepareEnv() {

        // Get all roles
        rolesMap = ruoloDao.findByServiceAsCodMap(stepInstance.getAppService().getBusinessService());

        // Recupero dei ruoli di INPUT e OUTUPT e dalle istanze
        // {S=[S], X=[X], Y=[Y], Z=[Z]}
        HashMap<String, ArrayList<String>> ruoliInputStep = new HashMap<>();
        // {P=[P], M=[M], O=[O]}
        rolesGroupOut = new LinkedHashMap<>();

        for (Iterator<?> iterator = stepInstance.getStepInstanceSignatures().iterator(); iterator.hasNext(); ) {
            StepInstanceSignature stepInstanceSignature = (StepInstanceSignature) iterator.next();
            if (stepInstanceSignature.getTypeIO().getId().intValue() == IS2Const.TYPE_IO_INPUT) {
                ArrayList<String> listv = ruoliInputStep.get(stepInstanceSignature.getAppRole().getCode());
                if (listv == null) {
                    listv = new ArrayList<>();
                }
                listv.add(stepInstanceSignature.getAppRole().getCode());
                ruoliInputStep.put(stepInstanceSignature.getAppRole().getCode(), listv);
            } else if (stepInstanceSignature.getTypeIO().getId().intValue() == IS2Const.TYPE_IO_OUTPUT) {
                ArrayList<String> listv = (ArrayList<String>) rolesOut
                        .get(stepInstanceSignature.getAppRole().getCode());
                if (listv == null) {
                    listv = new ArrayList<>();
                }
                listv.add(stepInstanceSignature.getAppRole().getCode());
                rolesOut.put(stepInstanceSignature.getAppRole().getCode(), listv);
            }
        }

        // Get input workset
        List<StepRuntime> dataList = stepRuntimeDao.findByDataProcessing(dataProcessing);
        // mappa delle colonne workset <nome campo, oggetto stepv>
        dataMap = Utility.getMapNameWorkSetStep(dataList);
        // mappa delle colonne workset <nome campo, oggetto stepv>
        Map<String, ArrayList<StepRuntime>> dataRuoliStepVarMap = Utility.getMapCodiceRuoloStepVariabili(dataList);
        // List<AppRole> ruoliAll = ruoloDao.findAll();
        // Utility.getMapRuoliByCod(ruoliAll)

        // mappa delle colonne workset <nome,lista valori>
        worksetVariables = Utility.getMapWorkSetValuesInRoles(dataMap, new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE),
                ruoliInputStep.keySet());

        // Parameters
        parametersMap = Utility.getMapWorkSetValues(dataMap, new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
        rulesetMap = Utility.getMapWorkSetValues(dataMap, new DataTypeCls(IS2Const.DATA_TYPE_RULESET));

        // associo il codice ruolo alla variabile
        // codiceRuolo, lista nome variabili {X=[X1], Y=[Y1]}
        variablesRolesMap = new LinkedHashMap<>();
        LinkedHashMap<String, String> rolesVariablesMap = new LinkedHashMap<>();
        parameterOut = new LinkedHashMap<>();

        for (Map.Entry<String, ArrayList<StepRuntime>> entry : dataRuoliStepVarMap.entrySet()) {
            String codR = entry.getKey();
            ArrayList<StepRuntime> listSVariable = entry.getValue();
            for (Iterator<StepRuntime> iterator = listSVariable.iterator(); iterator.hasNext(); ) {
                StepRuntime stepRuntime = iterator.next();

                rolesVariablesMap.put(stepRuntime.getWorkset().getName(), codR);

                ArrayList<String> listv = variablesRolesMap.get(codR);
                if (listv == null) {
                    listv = new ArrayList<>();
                }
                listv.add(stepRuntime.getWorkset().getName());
                variablesRolesMap.put(codR, listv);
            }
        }

    }

    @Override
    public void processOutput() throws Exception {
        getGenericOutput(worksetOut, RESULTSET, WORKSET_OUT);
        getGenericOutput(rolesOut, RESULTSET, ROLES_OUT);
        getGenericParamterOutput(parameterOut, RESULTSET, PARAMETERS_OUT);
        getGenericParamterOutput(parameterOut, RESULTSET, REPORT_OUT);

        getRolesGroup(rolesGroupOut, RESULTSET, ROLES_GROUP_OUT);
        writeLogScriptR();
        saveOutputDB();

    }

    private void saveOutputDB() {
        // salva output su DB
        for (Map.Entry<String, ?> entry : worksetOut.entrySet()) {
            String nameOut = entry.getKey();

            if (null != entry.getValue()) {

                try {
                    @SuppressWarnings("unchecked")
                    Map<String, ArrayList<String>> outContent = (Map<String, ArrayList<String>>) entry.getValue();

                    for (Map.Entry<String, ArrayList<String>> entryWS : outContent.entrySet()) {
                        String nomeW = entryWS.getKey();
                        ArrayList<String> value = entryWS.getValue();
                        StepRuntime stepVariable;
                        // String ruolo = ruoliOutputStepInversa.get(nomeW);
                        String ruolo = nameOut;
                        String ruoloGruppo = rolesGroupOut.get(ruolo);
                        if (ruolo == null) {
                            ruolo = ROLE_DEFAULT;
                        }
                        if (ruoloGruppo == null) {
                            ruoloGruppo = ROLE_DEFAULT;
                        }
                        AppRole sxRuolo = rolesMap.get(ruolo);
                        AppRole sxRuoloGruppo = rolesMap.get(ruoloGruppo);

                        stepVariable = Utility.retrieveStepRuntime(dataMap, nomeW, sxRuolo);

                        if (stepVariable != null) { // update

                            stepVariable.getWorkset().setContents(value);
                            stepVariable.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
                        } else {
                            stepVariable = new StepRuntime();
                            stepVariable.setDataProcessing(dataProcessing);
                            stepVariable.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));

                            stepVariable.setAppRole(sxRuolo);
                            stepVariable.setDataType(sxRuolo.getDataType());
                            stepVariable.setRoleGroup(sxRuoloGruppo);
                            stepVariable.setOrderCode(sxRuolo.getOrder());
                            Workset workset = new Workset();
                            workset.setName(nomeW.replaceAll("\\.", "_"));
                            workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
                            ArrayList<StepRuntime> l = new ArrayList<>();
                            l.add(stepVariable);
                            workset.setStepRuntimes(l);
                            workset.setContents(value);
                            workset.setContentSize(workset.getContents().size());
                            stepVariable.setWorkset(workset);
                        }

                        stepRuntimeDao.save(stepVariable);
                    }
                } catch (Exception e) {
                    Logger.getRootLogger().debug(nameOut + " " + e.getMessage());
                }
            }
        }

        // save output Parameter DB
        if (parameterOut.size() > 0) {
            HashMap<String, String> ruoliOutputStepInversa = new HashMap<>();
            for (Entry<String, Object> entry : rolesOut.entrySet()) {
                String nomeR = entry.getKey();
                @SuppressWarnings("unchecked")
                ArrayList<String> value = (ArrayList<String>) entry.getValue();
                value.forEach(nomevar -> ruoliOutputStepInversa.put(nomevar, nomeR));
            }

            for (Map.Entry<String, String> entry : parameterOut.entrySet()) {
                String nomeW = entry.getKey();
                String value = entry.getValue();
                StepRuntime stepRuntime;
                String ruolo = ruoliOutputStepInversa.get(nomeW);
                String ruoloGruppo = rolesGroupOut.get(ruolo);
                if (ruolo == null) {
                    ruolo = ROLE_DEFAULT;
                }
                if (ruoloGruppo == null) {
                    ruoloGruppo = ROLE_DEFAULT;
                }
                AppRole sxRuolo = rolesMap.get(ruolo);
                AppRole sxRuoloGruppo = rolesMap.get(ruoloGruppo);

                stepRuntime = Utility.retrieveStepRuntime(dataMap, nomeW, sxRuolo);

                if (stepRuntime != null) { // update
                    stepRuntime.getWorkset().setParamValue(value);
                    stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
                } else {
                    stepRuntime = new StepRuntime();
                    stepRuntime.setDataProcessing(dataProcessing);
                    stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
                    stepRuntime.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
                    stepRuntime.setAppRole(sxRuolo);
                    stepRuntime.setRoleGroup(sxRuoloGruppo);
                    stepRuntime.setOrderCode(sxRuolo.getOrder());
                    Workset workset = new Workset();
                    workset.setName(nomeW.replaceAll("\\.", "_"));

                    ArrayList<StepRuntime> l = new ArrayList<>();
                    l.add(stepRuntime);
                    workset.setStepRuntimes(l);
                    workset.setParamValue(value);
                    workset.setContentSize(1);
                    workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
                    stepRuntime.setWorkset(workset);
                }
                stepRuntimeDao.save(stepRuntime);
            }
        }
    }

    @Override
    public void destroy() {
        closeConnection();

    }

    @Override
    public void init() throws Exception {
        // Do nothing
    }
}