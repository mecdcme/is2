/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.rule.service;

import it.istat.is2.workflow.domain.SxRule;
import java.io.IOException;
import java.util.List;
import org.apache.log4j.Logger;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class EngineValidate {

    public static final String INPUT = "input";
    public static final String OUTPUT = "output";
    public static final String SRC_VALIDATE = "validate.R";
    
    @Value("${path.script.R}")
    private String pathR;

    private RConnection connection;
    private String[] input;

    public void init() throws Exception {

        connection = new RConnection();

        if (connection == null || !connection.isConnected()) {
            throw new IOException("Failed to establish RServe connection");
        }

        connection.eval("setwd('" + pathR + "')");
        connection.eval("source('" + SRC_VALIDATE + "')");
        Logger.getRootLogger().info("Script Loaded");
    }

    public void loadRules(List<SxRule> rules) throws Exception {

//        String[] input = new String[rules.size()];
//        for(int i = 0; i < rules.size(); i++){
//            input[i] = rules.get(i).getRule().toUpperCase();
//        }
        String[] input = new String[4];
        input[0] = "x>0";
        input[1] = "y>0";
        input[2] = "x<0";
        input[3] = "y<0";

        connection.assign(INPUT, input);

        connection.eval(INPUT + " <- data.frame(rule=" + INPUT + ")");
        connection.eval("print(" + INPUT + ")");
        String[] out = connection.eval("validate(" + INPUT + ")").asStrings();
        System.out.println(out[0]);
    }

    public void processOutput() throws Exception {
        //TO DO
    }

    public void destroy() {
        if (connection != null || !connection.isConnected()) {
            connection.close();
        }
    }

}
