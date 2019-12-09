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
package it.istat.is2.workflow.engine;

import static it.istat.is2.app.util.IS2Const.OUTPUT_R;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import it.istat.is2.app.service.LogService;
import it.istat.is2.app.util.IS2Const;
import it.istat.is2.app.util.Utility;
import it.istat.is2.workflow.dao.AppRoleDao;
import it.istat.is2.workflow.dao.StepRuntimeDao;
import it.istat.is2.workflow.domain.AppRole;
import it.istat.is2.workflow.domain.DataProcessing;
import it.istat.is2.workflow.domain.DataTypeCls;
import it.istat.is2.workflow.domain.StepInstance;
import it.istat.is2.workflow.domain.StepInstanceSignature;
import it.istat.is2.workflow.domain.StepRuntime;
import it.istat.is2.workflow.domain.TypeIO;
import it.istat.is2.workflow.domain.Workset;

@Service
public class EngineR implements EngineService {

    @Autowired
    AppRoleDao ruoloDao;
    @Autowired
    StepRuntimeDao stepRuntimeDao;
    @Autowired
    LogService logService;

    @Value("${serverR.host}")
    private String serverRHost;
    @Value("${serverR.port}")
    private Integer serverRPort;

    @Value("${path.script.R}")
    private String pathR;

    private String fileScriptR;

    private RConnection connection;

    private String istruzione;

    private DataProcessing dataProcessing;
    private StepInstance stepInstance;
    private LinkedHashMap<String, ArrayList<StepRuntime>> dataMap;
    private Map<String, AppRole> ruoliAllMap;
    private LinkedHashMap<String, ArrayList<String>> worksetVariables;
    private LinkedHashMap<String, ArrayList<String>> parameterMap;
    private LinkedHashMap<String, ArrayList<String>> ruleset;

    private HashMap<String, ArrayList<String>> ruoliVariabileNome;

    private LinkedHashMap<String, ArrayList<String>> rolesOut;
    private LinkedHashMap<String, String> ruoliGruppoOutputStep;
    private LinkedHashMap<String, ArrayList<String>> worksetOut;
    private LinkedHashMap<String, ArrayList<String>> parameterOut;

    public EngineR(String serverRHost, int serverRPort, String pathR, String fileScriptR) {
        super();
        this.serverRHost = serverRHost;
        this.serverRPort = serverRPort;
        this.pathR = pathR;
        this.fileScriptR = fileScriptR;
        connection = null;
        istruzione = "";
    }

    public EngineR() {
        super();
        connection = null;
        istruzione = "";
    }

    @Override
    public void init(DataProcessing dataProcessing, StepInstance stepInstance) throws Exception {
        // Create a connection to Rserve instance running on default port 6311
        this.dataProcessing = dataProcessing;
        this.stepInstance = stepInstance;
        this.fileScriptR = stepInstance.getAppService().getSource();

        prepareEnv();
        createConnection(serverRHost, serverRPort);
        bindInputColumns(worksetVariables, WORKSET);
        bindInputColumns(parameterMap, PARAMETERS);
        bindInputColumns(ruleset, RULESET);
        setRuoli(ruoliVariabileNome);

    }

    private void createConnection(String server, int port) throws RserveException {
        // Create a connection to Rserve instance running on default port 6311
        if (port == 0) {
            port = 6311;
        }

        if (server == null) {
            connection = new RConnection();
        } else {
            connection = new RConnection();
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

    public void bindInputColumns(LinkedHashMap<String, ArrayList<String>> workset, String varR)
            throws REngineException {

        if (!workset.isEmpty()) {
            List<String> keys = new ArrayList(workset.keySet());
            String listaCampi = "";
            String listaCampiLabel = "";
            int size = keys.size();
            String key = "";

            for (int i = 0; i < size; i++) {
                key = keys.get(i);

                String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                listaCampi += key + ",";
                listaCampiLabel += "'" + key + "',";
                connection.assign(key, arrX); //Create a string vector
                try {
                    if (isNumeric(arrX)) {
                        connection.eval(key + " <- as.numeric(" + key + ")");
                    }
                } catch (Exception e) {
                    Logger.getRootLogger().error(e.getMessage());
                }

            }
            listaCampi = listaCampi.substring(0, listaCampi.length() - 1);
            listaCampiLabel = listaCampiLabel.substring(0, listaCampiLabel.length() - 1);

            connection.eval(varR + " <- data.frame(" + listaCampi + ")"); //Create a data frame 

            // Assign the correct name to each vector in the data frame
            String namecols = ((size > 1) ? "col" : "") + "names(" + varR + ") = c(" + listaCampiLabel + ")";

            Logger.getRootLogger().debug("Bind input columns names " + namecols);
            connection.eval(namecols);

        }
    }

    public void bindInputColumnsParams(LinkedHashMap<String, ArrayList<String>> workset, String varR)
            throws REngineException {

        if (!workset.isEmpty()) {
            List<String> keys = new ArrayList<String>(workset.keySet());
            String listaCampi = "";
            String listaCampiLabel = "";
            int size = keys.size();
            String key = "";

            for (int i = 0; i < size; i++) {
                key = keys.get(i);

                String[] arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                listaCampi += key + ",";
                listaCampiLabel += "'" + key + "',";
                connection.assign(key, arrX);

            }
            listaCampi = listaCampi.substring(0, listaCampi.length() - 1);
            listaCampiLabel = listaCampiLabel.substring(0, listaCampiLabel.length() - 1);
            connection.eval(varR + " <- c(" + listaCampi + ")");

            // assegnazione nome dei campi alle colonne
            String namecols = ((size > 1) ? "col" : "") + "names(" + varR + ") = c(" + listaCampiLabel + ")";
            // String exec = "colnames(" + varR + ") = c(" + listaCampi + ")";
            Logger.getRootLogger().debug("Bind input columns names " + namecols);
            //connection.eval(namecols);

        }
    }

    private boolean isNumeric(String[] arrX) {
        for (String elem : arrX) {
            if (elem.isEmpty() || R_NA_VALUE.equalsIgnoreCase(elem)) {
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

    public void bindInputColumns_old(LinkedHashMap<String, ArrayList<String>> workset, String varR)
            throws REngineException {

        if (!workset.isEmpty()) {
            List<String> keys = new ArrayList<String>(workset.keySet());
            String listaCampi = "";

            int size = keys.size();
            String chiave0 = keys.get(0);
            listaCampi += "'" + chiave0 + "',";
            String key = "";
            // arrX = workset.get(chiave0).toArray(arrX);
            String[] arrX = workset.get(chiave0).toArray(new String[workset.get(chiave0).size()]);

            connection.assign(varR, arrX);

            for (int i = 1; i < size; i++) {
                key = keys.get(i);
                arrX = workset.get(key).toArray(new String[workset.get(key).size()]);
                listaCampi += "'" + key + "',";
                connection.assign("tmp", arrX);
                String evalstringa = varR + " <- cbind(" + varR + ",tmp)";
                System.out.println(evalstringa);
                connection.eval(evalstringa);
            }

            listaCampi = listaCampi.substring(0, listaCampi.length() - 1);
            // assegnazione nome dei campi alle colonne
            String exec = ((size > 1) ? "col" : "") + "names(" + varR + ") = c(" + listaCampi + ")";
            // String exec = "colnames(" + varR + ") = c(" + listaCampi + ")";
            Logger.getRootLogger().debug("Bind input columns names " + exec);
            if ((size == 1)) {
                connection.eval(varR + " <- data.frame(" + varR + ")");
            }
            connection.eval(exec);
        }
    }

    @Override
    public void doAction() throws RserveException {

        String fname = stepInstance.getMethod();
        // mlest <- ml.est (workset, y=Y,";
        // Aggiunto il workset  e params nella lista degli argomenti della funzione (by paolinux)
        istruzione = RESULTSET + "  <- " + fname + "( " + WORKSET + ",";
        if (!parameterMap.isEmpty()) {
            istruzione += PARAMETERS + ",";
        }
        if (!ruleset.isEmpty()) {
            istruzione += RULESET + ", ";
        }

        for (Map.Entry<String, ArrayList<String>> entry : ruoliVariabileNome.entrySet()) {
            String codiceRuolo = entry.getKey();
            // X <- as.numeric(workset[,c('X1','X2') ];
            istruzione += codiceRuolo.toLowerCase() + "=" + codiceRuolo.toUpperCase() + ",";
        }

        istruzione = istruzione.substring(0, istruzione.length() - 1);
        istruzione += ")";
        Logger.getRootLogger().debug("Eseguo " + istruzione);
        System.out.println("Eseguo " + istruzione);
        connection.eval(istruzione);
    }

    // Assegna il ruolo selemix alle variabili del workset
    public void setRuoli(HashMap<String, ArrayList<String>> ruoliVariabileNome) throws RserveException {
        // {X=[X1], Y=[Y1]}
        Logger.getRootLogger().debug("Eseguo SetRuoli>");
        for (Map.Entry<String, ArrayList<String>> entry : ruoliVariabileNome.entrySet()) {
            String codiceRuolo = entry.getKey();
            ArrayList<String> nomeVariabiliList = entry.getValue();
            // X <- as.numeric(workset[,c('X1','X2') ];
            // String comando = codiceRuolo+ " <- as.numeric("+selemixRuoliVar+"[,"
            // +Utility.combineList2String4R(nomeVariabiliList) + "])";
            // X <- c('X1','X2');
            String comando = codiceRuolo + " <- " + Utility.combineList2String4R(nomeVariabiliList);
            connection.eval(comando);
        }
    }

    public void bindOutputColumns(HashMap<String, ArrayList<String>> workset, String varR)
            throws RserveException, REXPMismatchException {
        // scrittura matrice di output
        RList lista = connection.eval(varR + "$out").asList();
        // RList lista = connection.eval(varR).asList();
        Logger.getRootLogger().debug("Campi OUT " + workset.keySet().toString());
        Logger.getRootLogger().debug("Numero di campi del workset " + lista.size());
        String name = "";
        for (int i = 0; i < lista.size(); i++) {
            String ts[] = lista.at(i).asStrings();
            name = lista.names.get(i).toString();
            workset.put(name, new ArrayList<String>(Arrays.asList(ts)));
        }
    }

    public void getRuoli(HashMap<String, ArrayList<String>> ruoliOutputStep, String varR)
            throws RserveException, REXPMismatchException {
        RList lista = connection.eval(varR + "$roles").asList();
        String name = "";
        for (int i = 0; i < lista.size(); i++) {
            String ts[] = lista.at(i).asStrings();
            name = lista.names.get(i).toString();
            ruoliOutputStep.put(name, new ArrayList<String>(Arrays.asList(ts)));
        }
        Logger.getRootLogger().debug("Campi dei ruoli IMPOSTATI (speriamo)");
    }

    public void getGenericOutput(LinkedHashMap<String, ArrayList<String>> genericHashMap, String varR,
            String tipoOutput) throws RserveException, REXPMismatchException {
        Logger.getRootLogger().debug("Eseguo Get " + tipoOutput);
        try {
            RList lista = connection.eval(varR + "$" + tipoOutput).asList();
            if (lista != null) {
                genericHashMap.clear();
                getGenericoOutput(genericHashMap, lista);
                Logger.getRootLogger().debug("Impostati campi di " + tipoOutput + "= " + genericHashMap.values().toString());
            }
        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
            Logger.getRootLogger().debug(connection.eval("print(str(" + varR + "$" + tipoOutput + "))").toString());
        }
    }

    public void getRolesGroup(LinkedHashMap<String, String> genericHashMap, String varR, String tipoOutput)
            throws RserveException, REXPMismatchException {
        Logger.getRootLogger().debug("Eseguo Get " + tipoOutput);
        try {
            RList lista = connection.eval(varR + "$" + tipoOutput).asList();
            String ts[] = lista.at(0).asStrings();
            String name = lista.names.get(0).toString();
            for (int i = 0; i < ts.length; i++) {
                genericHashMap.put(ts[i], name);
            }

        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
            Logger.getRootLogger().debug(connection.eval("print(str(" + varR + "$" + tipoOutput + "))").toString());
        }
    }

    public void writeLogScriptR() throws RserveException, REXPMismatchException {
        Logger.getRootLogger().debug("Eseguo getLogScriptR ");
        String rlog[];
        rlog = connection.eval("sel_out" + "$log").asStrings();
        for (int i = 0; i < rlog.length; i++) {
            logService.save(rlog[i], OUTPUT_R);
        }
        logService.save("Script completed!");
    }

    public void getGenericoOutput(LinkedHashMap<String, ArrayList<String>> genericHashMap, RList lista)
            throws RserveException, REXPMismatchException {
        String name = "";
        if (lista != null) {
            Logger.getRootLogger().info("Campi:> " + lista.names.toString() + " Size(" + lista.size() + ")");
            for (int i = 0; i < lista.size(); i++) {
                if (lista.at(i).isList()) {
                    getGenericoOutput(genericHashMap, lista.at(i).asList());
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

    public void bindInputParams(HashMap<String, ArrayList<String>> parametriMap) throws RserveException {
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
        //Get all roles 
        ruoliAllMap = ruoloDao.findByServiceAsCodMap(stepInstance.getAppService().getBusinessService());

        // Recupero dei ruoli di INPUT e OUTUPT e dalle istanze
        // {S=[S], X=[X], Y=[Y], Z=[Z]}
        HashMap<String, ArrayList<String>> ruoliInputStep = new HashMap<>();
        // {P=[P], M=[M], O=[O]}
        rolesOut = new LinkedHashMap();
        ruoliGruppoOutputStep = new LinkedHashMap<>();

        for (Iterator<?> iterator = stepInstance.getStepInstanceSignatures().iterator(); iterator.hasNext();) {
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
        worksetVariables = Utility.getMapWorkSetValuesInRoles(dataMap, new DataTypeCls(IS2Const.DATA_TYPE_VARIABLE), ruoliInputStep.keySet());

        // Parameters
        parameterMap = Utility.getMapWorkSetValues(dataMap, new DataTypeCls(IS2Const.DATA_TYPE_PARAMETER));
        ruleset = Utility.getMapWorkSetValues(dataMap, new DataTypeCls(IS2Const.DATA_TYPE_RULESET));
        worksetOut = new LinkedHashMap<>();

        // associo il codice ruolo alla variabile
        // codiceRuolo, lista nome variabili {X=[X1], Y=[Y1]}
        ruoliVariabileNome = new HashMap<>();
        parameterOut = new LinkedHashMap<>();

        for (Map.Entry<String, ArrayList<StepRuntime>> entry : dataRuoliStepVarMap.entrySet()) {
            String codR = entry.getKey();
            ArrayList<StepRuntime> listSVariable = entry.getValue();
            for (Iterator<StepRuntime> iterator = listSVariable.iterator(); iterator.hasNext();) {
                StepRuntime stepRuntime = (StepRuntime) iterator.next();
                ArrayList<String> listv = ruoliVariabileNome.get(codR);
                if (listv == null) {
                    listv = new ArrayList<>();
                }
                listv.add(stepRuntime.getWorkset().getName());
                ruoliVariabileNome.put(codR, listv);
            }
        }

    }

    @Override
    public void processOutput() throws Exception {
        getGenericOutput(worksetOut, RESULTSET, RESULT_OUTPUT);
        getGenericOutput(rolesOut, RESULTSET, RESULT_ROLES);
        getGenericOutput(parameterOut, RESULTSET, RESULT_PARAM);
        getGenericOutput(parameterOut, RESULTSET, RESULT_REPORT);
        getRolesGroup(ruoliGruppoOutputStep, RESULTSET, RESULT_ROLES_GROUPS);
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
            String ruoloGruppo = ruoliGruppoOutputStep.get(ruolo);
            if (ruolo == null) {
                ruolo = RUOLO_SKIP_N;
            }
            if (ruoloGruppo == null) {
                ruoloGruppo = RUOLO_SKIP_N;
            }
            AppRole sxRuolo = ruoliAllMap.get(ruolo);
            AppRole sxRuoloGruppo = ruoliAllMap.get(ruoloGruppo);

            stepRuntime = Utility.retrieveStepRuntime(dataMap, nomeW, sxRuolo);

            if (stepRuntime != null) { // update

                stepRuntime.getWorkset().setContents(value);
                stepRuntime.setTypeIO(new TypeIO(IS2Const.TYPE_IO_OUTPUT));
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

        // save output Parameter  DB
        for (Map.Entry<String, ArrayList<String>> entry : parameterOut.entrySet()) {
            String nomeW = entry.getKey();
            ArrayList<String> value = entry.getValue();
            StepRuntime stepRuntime;
            String ruolo = ruoliOutputStepInversa.get(nomeW);
            String ruoloGruppo = ruoliGruppoOutputStep.get(ruolo);
            if (ruolo == null) {
                ruolo = RUOLO_SKIP_N;
            }
            if (ruoloGruppo == null) {
                ruoloGruppo = RUOLO_SKIP_N;
            }
            AppRole sxRuolo = ruoliAllMap.get(ruolo);
            AppRole sxRuoloGruppo = ruoliAllMap.get(ruoloGruppo);

            stepRuntime = Utility.retrieveStepRuntime(dataMap, nomeW, sxRuolo);

            if (stepRuntime != null) { // update

                stepRuntime.getWorkset().setContents(value);
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

    }

    @Override
    public void destroy() {
        closeConnection();

    }

    @Override
    public void init() throws Exception {
        //Do nothing
    }
}
