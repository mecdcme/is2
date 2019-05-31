package it.istat.is2.catalogue.relais.matchingVariables;

import it.istat.is2.catalogue.relais.constants.TablesName;
import it.istat.is2.catalogue.relais.log.TraceLog;
import it.istat.is2.catalogue.relais.method.fs.*;
import it.istat.is2.catalogue.relais.project.VariablesSetting;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/* Remove the existing estimations */ 

public class RemoveMU {
	private Connection connection;
	private int numBlockModality;
	private String method;
	private ArrayList<String> blockModality;
	private String blockingKey;
	
	public RemoveMU(Connection con) throws Exception {
		this.connection = con;
		try{
		VariablesSetting vs = new VariablesSetting(connection);
		this.method = vs.ReadMethod();
                if (method.endsWith("Blocking")) {
                    Statement stm5 =(Statement)connection.createStatement();
                    ResultSet rs5 = stm5.executeQuery("SELECT BLOCKVAR FROM "+TablesName.nameSetting()+";");
                    rs5.next();
                    this.blockingKey = rs5.getString(1);
                    stm5.close();
		
                    this.blockModality = new ArrayList<String>();
                    Statement stm6 =(Statement)connection.createStatement();
                    ResultSet rs6 = stm6.executeQuery("SELECT * FROM "+TablesName.nameBlockModality()+";");
                    while(rs6.next())
			this.blockModality.add(rs6.getString(1));
                    stm6.close();
                    this.numBlockModality =this.blockModality.size();
                } else {
                    this.numBlockModality = 0;
                    this.blockModality = new ArrayList<String>();
                    this.blockingKey = "";
                }

		}catch(Exception e){
			e.printStackTrace();
                        throw e;
		}
	}
	
	/* 
         * remove the existing mu-table
         */ 
	public void Remove() {
            String muTableBlock;
            TraceLog log = new TraceLog(connection);
                    
            try{	
		Statement stmDrop = (Statement)connection.createStatement();
                

                log.AddMessage("DROP "+TablesName.nameMU(), false);
		stmDrop.executeUpdate("DROP table IF EXISTS "+TablesName.nameMU());
		

                for(int i=0; i<numBlockModality;i++) {
                     muTableBlock = TablesName.nameMU()+"_"+this.blockingKey.replace(",","_").toUpperCase()+"_"+this.blockModality.get(i).toUpperCase();
                     log.AddMessage("DROP "+muTableBlock, false);
		     stmDrop.executeUpdate("DROP table IF EXISTS "+muTableBlock);
                }
                
                stmDrop.close();
	    }catch(Exception e){
                try {
                    log.AddMessage(e.getMessage(), false);
                } catch(Exception ex) {}
	    }			
	}
}
