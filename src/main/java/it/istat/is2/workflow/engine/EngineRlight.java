/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.workflow.engine;

import it.istat.is2.workflow.domain.Elaborazione;
import it.istat.is2.workflow.domain.SxStepInstance;
import java.io.IOException;
import org.apache.log4j.Logger;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class EngineRlight implements EngineService {

    @Value("${serverR.host}")
    private String serverRHost;
    @Value("${serverR.port}")
    private Integer serverRPort;

    private RConnection connection;

    @Override
    public void init(Elaborazione elaborazione, SxStepInstance stepInstance) throws Exception {
        //TO DO
    }

    @Override
    public void init() throws Exception {
        createConnection(serverRHost, serverRPort);
    }

    @Override
    public void doAction() throws Exception {
        //TO DO
    }

    @Override
    public void processOutput() throws Exception {
        //TO DO
    }

    @Override
    public void destroy() {
        closeConnection();
    }

    private void createConnection(String server, int port) throws RserveException, IOException {
        // Create a connection to Rserve instance running on default port 6311
        if (port == 0) {
            port = 6311;
        }

        if (server == null) {
            connection = new RConnection();
        } else {
            connection = new RConnection(server, port);
        }

        if (connection == null || !connection.isConnected()) {
            throw new IOException("Failed to establish RServe connection");
        }

        Logger.getRootLogger().error("Script Loaded");
    }

    public void closeConnection() {
        if (connection != null || !connection.isConnected()) {
            connection.close();
        }
    }

}
