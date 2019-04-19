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
package it.istat.rservice.workflow.engine;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
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

import it.istat.rservice.app.util.Utility;

/**
 * @author framato
 *
 */
@Service
public class EngineR implements EngineService {

    public static final String SELEMIX_RESULTSET = "sel_out";
    public static final String SELEMIX_WORKSET = "workset";
    public static final String SELEMIX_RUOLI_VAR = "role_var";
    public static final String SELEMIX_RUOLI_VAR_OUTPUT = "role_var_out";
    public static final String SELEMIX_RUOLI_INPUT = "role_in";
    public static final String SELEMIX_RUOLI_OUTPUT = "ruol_out";
    public static final String SELEMIX_PARAMETRI = "params";
    public static final String SELEMIX_MODELLO = "model";
    public static final String SELEMIX_RUOLO_SKIP_N = "N";
    public static final String SELEMIX_RESULT_RUOLI = "roles";
    public static final String SELEMIX_RESULT_OUTPUT = "out";
    public static final String SELEMIX_RESULT_PARAM = "mod";
    public static final String SELEMIX_RESULT_REPORT = "report"; //aggiunto componente dei parametri di uscita

    @Value("${serverR.host}")
    private String serverRHost;
    @Value("${serverR.port}")
    private Integer serverRPort;

    @Value("${path.R}")
    private String pathR;
    @Value("${file.script.R}")
    private String fileScriptR;

    
    private RConnection connection;
 
    private String istruzione;
 

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
    public void createConnection() throws RserveException {
        //Create a connection to Rserve instance running on default port 6311
        createConnection(serverRHost, serverRPort);
    }

    private void createConnection(String server, int port) throws RserveException {
        //Create a connection to Rserve instance running on default port 6311
        if (port == 0) {
            port = 6311;
        }

        if (server == null) {
            connection = new RConnection();
        } else {
            connection = new RConnection(server, port);
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
    @Override
    public void bindInputColumns(HashMap<String, ArrayList<String>> workset, String varR) throws REngineException {

        List<String> keys = new ArrayList<String>(workset.keySet());
        String listaCampi = "";

        int size = keys.size();
        String chiave0 = keys.get(0);
        listaCampi += "'" + chiave0 + "',";
        String key = "";
        //arrX = workset.get(chiave0).toArray(arrX);
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
        //String exec = "colnames(" + varR + ") = c(" + listaCampi + ")";
        Logger.getRootLogger().debug("Bind input columns names " + exec);
        if ((size == 1)) {
            connection.eval(varR + " <- data.frame(" + varR + ")");
        }
        connection.eval(exec);
    }
    @Override
    public void eseguiStringaIstruzione(String fname, HashMap<String, ArrayList<String>> ruoliVariabileNome) throws RserveException {
        // mlest <- ml.est (workset, y=Y,";
        // Aggiunto il workset nella lista degli argomenti della funzione (by paolinux)
        istruzione = SELEMIX_RESULTSET + "  <- " + fname + "( " + SELEMIX_WORKSET + ",";

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

    //Assegna il ruolo selemix alle variabili del workset
    @Override
    public void setRuoli(HashMap<String, ArrayList<String>> ruoliVariabileNome) throws RserveException {
        //  {X=[X1], Y=[Y1]}
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
    @Override
    public void bindOutputColumns(HashMap<String, ArrayList<String>> workset, String varR) throws RserveException, REXPMismatchException {
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
    @Override
    public void getRuoli(HashMap<String, ArrayList<String>> ruoliOutputStep, String varR) throws RserveException, REXPMismatchException {
        RList lista = connection.eval(varR + "$roles").asList();
        String name = "";
        for (int i = 0; i < lista.size(); i++) {
            String ts[] = lista.at(i).asStrings();
            name = lista.names.get(i).toString();
            ruoliOutputStep.put(name, new ArrayList<String>(Arrays.asList(ts)));
        }
        Logger.getRootLogger().debug("Campi dei ruoli IMPOSTATI (speriamo)");
    }
   @Override
    public void getGenericoOutput(HashMap<String, ArrayList<String>> GenericHashMap, String varR, String tipoOutput) throws RserveException, REXPMismatchException {
        Logger.getRootLogger().debug("Eseguo Get " + tipoOutput);
        try {
            RList lista = connection.eval(varR + "$" + tipoOutput).asList();
            if (lista != null) {
                GenericHashMap.clear();
                getGenericoOutput(GenericHashMap, lista);
                Logger.getRootLogger().debug("Impostati campi di " + tipoOutput + "= " + GenericHashMap.values().toString());
            }
        } catch (Exception e) {
            Logger.getRootLogger().info("No such list:" + tipoOutput);
            Logger.getRootLogger().debug(connection.eval("print(str(" + varR + "$" + tipoOutput + "))").toString());
            return;
        }
    }
    
    public void getGenericoOutput(HashMap<String, ArrayList<String>> GenericHashMap, RList lista) throws RserveException, REXPMismatchException {
        String name = "";
        if (lista != null) {
            Logger.getRootLogger().info("Campi:> " + lista.names.toString() + " Size(" + lista.size() + ")");
            for (int i = 0; i < lista.size(); i++) {
                if (lista.at(i).isList()) {
                    getGenericoOutput(GenericHashMap, lista.at(i).asList());
                } else {
                    String ts[] = lista.at(i).asStrings();
                    name = lista.names.get(i).toString();
                    GenericHashMap.put(name, new ArrayList<String>(Arrays.asList(ts)));
                    Logger.getRootLogger().info(name + " (" + ts.length + "/" + GenericHashMap.get(name).size() + "): " + GenericHashMap.get(name).toString());
                }
            }
        }
    }
   @Override
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
}
