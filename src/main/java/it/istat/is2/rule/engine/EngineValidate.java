/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.rule.engine;

import it.istat.is2.app.service.LogService;
import it.istat.is2.workflow.domain.SxRule;
import java.util.List;
import org.apache.log4j.Logger;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class EngineValidate {

    public static final String INPUT = "input";
    public static final String OUTPUT = "output";
    public static final String SRC_VALIDATE = "validate.R";
    @Value("${serverR.host}")
    private String serverRHost;
    @Value("${serverR.port}")
    private Integer serverRPort;
    @Value("${path.script.R}")
    private String pathR;
    private RConnection connection;
    private String[] input;
    
    @Autowired
    private LogService logService;

    public void init() throws Exception {

        logService.save("Connecting to R server...");
        
        // Create a connection to Rserve instance running on default port 6311
        if (serverRPort == null || serverRPort == 0) {
            serverRPort = 6311;
        }

        if (serverRHost == null || serverRHost.equals("") || serverRHost.equals("localhost")) {
            connection = new RConnection();
        } else {
            connection = new RConnection(serverRHost, serverRPort);
        }
        
        logService.save("Successfully connected!");
        
        connection.eval("setwd('" + pathR + "')");
        connection.eval("source('" + SRC_VALIDATE + "')");
        logService.save("Validate R script loaded");
    }

    public void validateRules(List<SxRule> rules) throws Exception {

        init();
        
        input = new String[rules.size()];
        for(int i = 0; i < rules.size(); i++){
            input[i] = rules.get(i).getRule().toUpperCase();
        } 
        connection.assign(INPUT, input);
        connection.eval(INPUT + " <- data.frame(rule=" + INPUT + ")");
        connection.eval("print(" + INPUT + ")");
        String[] out = connection.eval("validate(" + INPUT + ")").asStrings();
        
        logService.save("Script output " + out[0]);
        
        destroy();
    }

    public void destroy() {
        if (connection != null || !connection.isConnected()) {
            connection.close();
        }
        logService.save("Connection to R server closed!");
    }

}
