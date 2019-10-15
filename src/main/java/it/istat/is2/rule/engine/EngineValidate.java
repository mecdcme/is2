/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.rule.engine;

import it.istat.is2.app.service.LogService;
import static it.istat.is2.app.util.IS2Const.OUTPUT_R;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class EngineValidate {

    public static final String INPUT = "input";
    public static final String INPUT_NAMES = "input_names";
    public static final String INPUT_NAMES_PREFIX = "R_";
    public static final String OUTPUT = "output";
    public static final String VALIDATE_FOLDER = "validate";
    public static final String VALIDATE_SRC = "validate.R";
    public static final String FUNCTION_DETECT_INFEASIBLE = "is2_detect_infeasible";
    
    @Value("${serverR.host}")
    private String serverRHost;
    @Value("${serverR.port}")
    private Integer serverRPort;
    @Value("${path.script.R}")
    private String pathR;
    private RConnection connection;
    private RList out;
    private String[] result;
    private String[] rlog;

    @Autowired
    private LogService logService;

    public void connect() throws Exception {

        logService.save("Connecting to R server...");

        // Create a connection to Rserve instance running on default port 6311
        if (serverRPort == null || serverRPort == 0) {
            serverRPort = 6311;
        }

        if (serverRHost == null || serverRHost.equals("") || serverRHost.trim().equals("localhost")) {
            connection = new RConnection();
        } else {
            connection = new RConnection(serverRHost, serverRPort);
        }

        logService.save("Successfully connected!");

        connection.eval("setwd('" + pathR + "')");
        connection.eval("source('" + VALIDATE_FOLDER + "/" + VALIDATE_SRC + "')");
        logService.save("Validate R script loaded");
    }

    public String[] detectInfeasibleRules(String[]input, String[]inputNames) throws Exception {

        connection.assign(INPUT, input);
        connection.assign(INPUT_NAMES, inputNames);
        connection.eval(INPUT + " <- data.frame(rule=" + INPUT + ")");
        out = connection.eval(FUNCTION_DETECT_INFEASIBLE + "(" + INPUT + ", " + INPUT_NAMES + ")").asList();

        result = out.at("rules").asStrings();
        rlog = out.at("log").asStrings();
        
        for(int i = 0; i < rlog.length; i++){
             logService.save(rlog[i], OUTPUT_R);
        }
        
        logService.save("Script completed!");
        
        return result;
    }

    public void destroy() {
        if (connection != null || !connection.isConnected()) {
            connection.close();
        }
        logService.save("Connection to R server closed!");
    }

}
