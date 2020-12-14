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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Value;
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
public class EngineRServe extends EngineR implements EngineService {

    @Value("${serverR.host}")
    private String serverRHost;
    @Value("${serverR.port}")
    private Integer serverRPort;
    private RConnection connection;

    private final LinkedHashMap<String, ArrayList<String>> worksetOut = new LinkedHashMap<>();
    private final Map<String, ArrayList<String>> rolesOut = new LinkedHashMap<>();

    public EngineRServe(String serverRHost, int serverRPort, String pathR, String fileScriptR) {
        super();
        this.serverRHost = serverRHost;
        this.serverRPort = serverRPort;
        this.pathR = pathR;
        this.fileScriptR = fileScriptR;
        connection = null;
        command = "";
    }

    public EngineRServe() {
        super();
        connection = null;
        command = "";
    }

    @Override
    public void init(DataProcessing dataProcessing, StepInstance stepInstance) throws Exception {
        // Create a connection to Rserve instance running on default port 6311
        this.dataProcessing = dataProcessing;
        this.stepInstance = stepInstance;
        this.fileScriptR = stepInstance.getAppService().getSource();

        prepareEnv();
        createConnection();
        bindInputColumnsMap(worksetVariables, WORKSET_IN);
        bindInputColumnsParams(parametersMap, PARAMETERS_IN);
        bindInputColumns(rulesetMap, RULESET);
        setRoles(variablesRolesMap);

    }

    private void createConnection() throws RserveException {
        // Create a connection to Rserve instance running on default port 6311
        if (serverRPort == 0) {
        	serverRPort = 6311;
        }

        if ( serverRHost == null||serverRHost.isEmpty()) {
            connection = new RConnection();
        } else {
            connection = new RConnection(serverRHost, serverRPort);
        }
        connection.eval("setwd('" + pathR + "')");
        connection.eval("source('" + fileScriptR + "')");
        Logger.getRootLogger().debug("Script Loaded");
    }

    public void closeConnection() {
        if (connection != null) {
        	connection.close();
        }
    }

    public void bindInputColumns(Map<String, List<String>> workset, String varR) throws REngineException {

        if (!workset.isEmpty()) {
            List<String> keys = new ArrayList<>(workset.keySet());
            StringBuilder listaCampi = new StringBuilder();
            int size = keys.size();
            String key = "";

            for (int i = 0; i < size; i++) {
                key = keys.get(i);

                String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                listaCampi.append(key).append(",");
                connection.assign(key, arrX); // Create a string vector
                try {
                    if (Utility.isNumericR(arrX)) {
                        connection.eval(key + " <- as.numeric(" + key + ")");
                    }
                } catch (Exception e) {
                    Logger.getRootLogger().error(e.getMessage());
                }

            }
            connection.eval(varR + " <- data.frame(" + listaCampi.substring(0, listaCampi.length() - 1) + ")"); // Create 
            // a
            // data
            // frame
        }
    }

    public void bindInputColumnsMap(Map<String, Map<String, List<String>>> worksetIn, String varR)
            throws REngineException {

        if (!worksetIn.isEmpty()) {
            connection.eval(varR + " <- list()");

            worksetIn.forEach((keyW, workset) -> {
            try {
              	bindInputColumns(workset, keyW);
               	connection.eval(varR + "<- c("+ varR +","+ keyW +")");
	            } catch (REngineException e1) {
	                throw new RuntimeException(e1);
	            }
            
            }); 
            connection.eval(varR+"<-do.call(cbind.data.frame,"+varR+")");
            //connection.eval("print(\"BICol result is:\")");
            //connection.eval("print(str("+varR+"))");
         }
    }

    public void bindInputColumnsMapOLD(Map<String, Map<String, List<String>>> worksetIn, String varR)
            throws REngineException {

        if (!worksetIn.isEmpty()) {
            connection.eval(varR + " <- list()");

            worksetIn.forEach((keyW, workset) -> {

                try {
                    connection.eval(keyW + " <- list() ");


                    List<String> keys = new ArrayList<>(workset.keySet());
                    StringBuilder listaCampi = new StringBuilder();
                    int size = keys.size();
                    String key;

                    for (int i = 0; i < size; i++) {
                        key = keys.get(i);

                        String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                        listaCampi.append(key + ",");
                        connection.assign(key, arrX); // Create a string vector
                        try {
                            if (Utility.isNumericR(arrX)) {
                                connection.eval(key + " <- as.numeric(" + key + ")");
                                connection.eval("append(" + keyW + "," + key + ")");
                            }
                        } catch (Exception e) {
                            Logger.getRootLogger().error(e.getMessage());
                        }

                    }
                    // engine.eval(keyW + " <- as.numeric(" + key + ")");
                    connection.eval("append(" + varR + "," + keyW+ ")");
                } catch (REngineException e1) {
                    // TODO Auto-generated catch block
                    throw new RuntimeException(e1);
                }
            }); // data
            // engine.eval(varR + " <- data.frame(" + listaCampi.substring(0,
            // listaCampi.length() - 1) + ")");
            // frame
        }
    }
    
    
    public void bindInputColumnsParams(Map<String, List<String>> workset, String varR) throws REngineException {

        if (!workset.isEmpty()) {
            List<String> keys = new ArrayList<>(workset.keySet());
            String listaCampi = "";
            int size = keys.size();
            String key;

            for (int i = 0; i < size; i++) {
                key = keys.get(i);
                String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                listaCampi += key + ",";
                connection.assign(key, arrX);
            }

            listaCampi = listaCampi.substring(0, listaCampi.length() - 1);
            //bisogna ritornare i campi da json altrimenti esplode qui
            //connection.eval(varR + " <- list(" + listaCampi + ")");
            connection.eval(varR + " <- list(" + listaCampi + ")");
        }
    }

    // new parameter setter
    public void bindInputParams(LinkedHashMap<String, ArrayList<String>> workset, String varR) throws REngineException {

        if (!workset.isEmpty()) {
            List<String> keys = new ArrayList<>(workset.keySet());
            String listaCampi = "";
            int size = keys.size();
            String key;

            for (int i = 0; i < size; i++) {
                key = keys.get(i);
                String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                listaCampi += key + ",";
                connection.assign(key, arrX);
            }

            listaCampi = listaCampi.substring(0, listaCampi.length() - 1);

            // connection.eval(varR + " <- list(" + listaCampi + ")");
            connection.eval("set_param(" + varR + "," + listaCampi + ")");
        }
    }

    @Override
    public void doAction() throws RserveException {

        String fname = stepInstance.getMethod();
        // mlest <- ml.est (workset, y=Y,";
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
        
        connection.eval(command);
    }

    //@Override
    public void doActionNew() throws RserveException {

        String fname = stepInstance.getMethod();
        // mlest <- ml.est (workset, y=Y,";
        // Aggiunto il workset e params nella lista degli argomenti della funzione (by
        // paolinux)
        command = OUT + "  <- is2.exec( " + WORKSET + "," + ROLES + ",";
        if (!parametersMap.isEmpty()) {
            command += PARAMETERS + ",";
        }
        command += fname + ",";
        if (!rulesetMap.isEmpty()) {
            command += RULESET + ",";
        }

        command = command.substring(0, command.length() - 1);
        command += ")";
        Logger.getRootLogger().debug("Eseguo " + command);

        connection.eval(command);
    }

    // Assegna il ruolo selemix alle variabili del workset
    public void setRoles(Map<String, ArrayList<String>> ruoliVariabileNome) throws RserveException {
        StringBuilder rolesList = new StringBuilder();
        Logger.getRootLogger().debug("Eseguo SetRuoli>");
        for (Map.Entry<String, ArrayList<String>> entry : ruoliVariabileNome.entrySet()) {
            String roleCode = entry.getKey();
            ArrayList<String> nomeVariabiliList = entry.getValue();
            rolesList.append("'" + roleCode + "' = ").append(Utility.combineList2String4R(nomeVariabiliList))
                    .append(",");
        }
        connection.eval(ROLES_IN + " <-list(" + rolesList.substring(0, rolesList.length() - 1) + ")");
    }

    // adding new role setting by paolinux
    public void setRole(Map<String, ArrayList<String>> ruoliVariabileNome) throws RserveException {
        // StringBuilder rolesList = new StringBuilder();
        Logger.getRootLogger().debug("Eseguo SetRuoli>");
        for (Map.Entry<String, ArrayList<String>> entry : ruoliVariabileNome.entrySet()) {
            String roleCode = entry.getKey();
            ArrayList<String> nomeVariabiliList = entry.getValue();
            // rolesList.append("'" + roleCode + "' =
            // ").append(Utility.combineList2String4R(nomeVariabiliList)).append(",");
            connection.eval("set_role(" + roleCode + "," + Utility.combineList2String4R(nomeVariabiliList) + ")");
        }
        // connection.eval(ROLES_IN + " <-list(" + rolesList.substring(0,
        // rolesList.length() - 1) + ")");

    }

    public void getGenericOutput(Map<String, ArrayList<String>> genericHashMap, String varR, String tipoOutput)
            throws RserveException, REXPMismatchException {
        try {
            RList lista = connection.eval(varR + "$" + tipoOutput).asList();
            if (lista != null && !lista.isEmpty()) {
                getRecursiveOutput(genericHashMap, lista);
                Logger.getRootLogger()
                        .debug("Impostati campi di " + tipoOutput + "= " + genericHashMap.values().toString());
            }
        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
            Logger.getRootLogger().debug(connection.eval("print(str(" + varR + "$" + tipoOutput + "))").toString());
        }
    }

    public void getGenericParamterOutput(Map<String, String> genericHashMap, String varR, String tipoOutput)
            throws RserveException, REXPMismatchException {

        try {
            RList lista = connection.eval(varR + "$" + tipoOutput).asList();
            if (lista != null && !lista.isEmpty()) {

                for (int i = 0; i < lista.size(); i++) {
                    String name = lista.names.get(i).toString();
                    String value = lista.at(i).asString();
                    genericHashMap.put(name, value);
                }

                Logger.getRootLogger()
                        .debug("Impostati campi di " + tipoOutput + "= " + genericHashMap.values().toString());
            }
        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
            Logger.getRootLogger().debug(connection.eval("print(str(" + varR + "$" + tipoOutput + "))").toString());
        }
    }

    public void getRolesGroup(Map<String, String> genericHashMap, String varR, String tipoOutput)
            throws RserveException, REXPMismatchException {

        try {
            RList lista = connection.eval(varR + "$" + tipoOutput).asList();
            for (int j = 0; j < lista.size(); j++) {
                String ts[] = lista.at(j).asStrings();
                String name = lista.names.get(j).toString();
                for (int i = 0; i < ts.length; i++) {
                    genericHashMap.put(ts[i], name);
                }
            }
        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
            Logger.getRootLogger().debug(connection.eval("print(str(" + varR + "$" + tipoOutput + "))").toString());
        }
    }

    public void writeLogScriptR() throws RserveException, REXPMismatchException {
        Logger.getRootLogger().debug("Eseguo getLogScriptR ");
        String rlog[] = connection.eval(RESULTSET + "$log").asStrings();
        for (int i = 0; i < rlog.length; i++) {
            logService.save(rlog[i], IS2Const.OUTPUT_R);
        }
        logService.save("Script completed!");
    }

    public void getRecursiveOutput(Map<String, ArrayList<String>> genericHashMap, RList lista)
            throws RserveException, REXPMismatchException {
        String name;
        if (lista != null) {
            Logger.getRootLogger().info("Campi:> " + lista.names.toString() + " Size(" + lista.size() + ")");
            for (int i = 0; i < lista.size(); i++) {
                if (lista.at(i).isList()) {
                    getRecursiveOutput(genericHashMap, lista.at(i).asList());
                } else {
                    String ts[] = lista.at(i).asStrings();
                    name = lista.names.get(i).toString();
                    genericHashMap.put(name, new ArrayList<String>(Arrays.asList(ts)));
                    Logger.getRootLogger().info(name + " (" + ts.length + "/" + genericHashMap.get(name).size() + "): "
                            + genericHashMap.get(name).toString());
                }
            }
        }
    }

    public void bindInputParams(Map<String, ArrayList<String>> parametriMap) throws RserveException {
        for (Map.Entry<String, ArrayList<String>> entry : parametriMap.entrySet()) {
            String nomep = entry.getKey();
            ArrayList<String> valore = entry.getValue();
            // X <- c('X1','X2');
            String comando = nomep + " <- " + Utility.combineList2String4R(valore);
            Logger.getRootLogger().info("Comando: " + comando);
            connection.eval(comando);
        }
    }

    public void prepareEnv() {
        // Get all roles
        LinkedHashMap<String, String> rolesVariablesMap;
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
                ArrayList<String> listv = rolesOut.get(stepInstanceSignature.getAppRole().getCode());
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
        rolesVariablesMap = new LinkedHashMap<>();
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
        // getGenericOutput(worksetOut, RESULTSET, REPORT_OUT);
        getRolesGroup(rolesGroupOut, RESULTSET, ROLES_GROUP_OUT);
        writeLogScriptR();
        saveOutputDB();

    }

    private void saveOutputDB() {
        HashMap<String, String> ruoliOutputStepInversa = new HashMap<>();
        for (Map.Entry<String, ArrayList<String>> entry : rolesOut.entrySet()) {
            String nomeR = entry.getKey();
            ArrayList<String> value = entry.getValue();
            value.forEach((nomevar) -> ruoliOutputStepInversa.put(nomevar, nomeR));
        }

        // salva output su DB
        for (Map.Entry<String, ArrayList<String>> entry : worksetOut.entrySet()) {
            String nomeW = entry.getKey();
            ArrayList<String> value = entry.getValue();
            StepRuntime stepRuntime;
            String ruolo = ruoliOutputStepInversa.get(nomeW);
            String ruoloGruppo = rolesGroupOut.get(ruolo);
            if (ruolo == null) {
                ruolo = ROLE_DEFAULT;
            }
            if (ruoloGruppo == null) {
                ruoloGruppo = ROLE_DEFAULT;
            }
            AppRole sxRuolo = rolesMap.get(ruolo) != null ? rolesMap.get(ruolo) : rolesMap.get(ROLE_DEFAULT);
            AppRole sxRuoloGruppo = rolesMap.get(ruoloGruppo) != null ? rolesMap.get(ruoloGruppo) : rolesMap.get(ROLE_DEFAULT);
            
            stepRuntime = Utility.retrieveStepRuntime(dataMap, nomeW, sxRuolo);

            if (stepRuntime != null) { // update
                stepRuntime.getWorkset().setContents(value);
                stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
                stepRuntime.setAppRole(sxRuolo);
                stepRuntime.setRoleGroup(sxRuoloGruppo);
            } else {
                stepRuntime = new StepRuntime();
                stepRuntime.setDataProcessing(dataProcessing);
                stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
                stepRuntime.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
                stepRuntime.setAppRole(sxRuolo);
                stepRuntime.setRoleGroup(sxRuoloGruppo);
                stepRuntime.setOrderCode(sxRuolo.getOrder());
                Workset workset = new Workset();
                workset.setName(nomeW.replaceAll("\\.", "_"));
                workset.setDataType(new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE));
                ArrayList<StepRuntime> l = new ArrayList<>();
                l.add(stepRuntime);
                workset.setStepRuntimes(l);
                workset.setContents(value);
                workset.setContentSize(workset.getContents().size());
                stepRuntime.setWorkset(workset);
            }

            stepRuntimeDao.save(stepRuntime);
        }

        // save output Parameter DB
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
            AppRole sxRuolo = rolesMap.get(ruolo) != null ? rolesMap.get(ruolo) : rolesMap.get(ROLE_DEFAULT);
            AppRole sxRuoloGruppo = rolesMap.get(ruoloGruppo) != null ? rolesMap.get(ruoloGruppo) : rolesMap.get(ROLE_DEFAULT);
            
            stepRuntime = Utility.retrieveStepRuntime(dataMap, nomeW, sxRuolo);

            if (stepRuntime != null) { // update

                stepRuntime.getWorkset().setParamValue(value);
                stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
                stepRuntime.setAppRole(sxRuolo);
                stepRuntime.setRoleGroup(sxRuoloGruppo);
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

    @Override
    public void destroy() {
        closeConnection();

    }

    @Override
    public void init() throws Exception {
        // Do nothing
    }
}
