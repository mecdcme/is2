package it.istat.is2.catalogue.relais.log;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import it.istat.is2.catalogue.relais.constants.TablesName;

public class TraceLog {
    boolean tableCreated;
    Connection conn;
    
    public TraceLog(Connection conn1) {
        tableCreated = false;
        conn = conn1;
    }
    
    /* inserts debug messages in the log table and prints them on the output 
     panel if viewToUser is true */
    public void AddMessage(String message, String type, boolean viewToUser) throws Exception {
        try {
            if (!tableCreated)
                this.CreateTable();
            
            if (message.length()>150) message = message.substring(0, 149);
            String messinsert = message.replace("'", "''").replace("\\", "\\\\");
            
            Statement stmInsert = conn.createStatement();
            stmInsert.executeUpdate("INSERT INTO "+TablesName.nameLog()+" (TYPE_MESSAGE,MESSAGE,TIME_MESSAGE) VALUES ('"+type+"','"+messinsert+"',now());");
            stmInsert.close();
            
            if (viewToUser)
            {
                System.out.println(message);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw(e);
        }
    }

    /* sends debug messages using generic method */
    public void AddMessage(String message, String type) throws Exception {
        this.AddMessage(message, type, true);
    }
    
    /* sends debug messages using generic method */
    public void AddMessage(String message, boolean viewToUser) throws Exception {
        this.AddMessage(message, "L", viewToUser);
    }
    
    /* sends debug messages using generic method */
    public void AddMessage(String message) throws Exception {
        this.AddMessage(message, "L");
    }
    
    /* creates the table for debug messages */
    private void CreateTable() throws Exception {

            Statement stmQuery = conn.createStatement();
            ResultSet rsLog = stmQuery.executeQuery("SELECT * FROM information_schema.TABLES WHERE TABLE_NAME='"+TablesName.nameLog()+"' AND TABLE_SCHEMA='relais'");
            if (!rsLog.next()) {
            Statement stmCreate = conn.createStatement();
            stmCreate.executeUpdate("CREATE TABLE "+TablesName.nameLog()+" (IDLOG INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, TYPE_MESSAGE CHAR(1), MESSAGE VARCHAR(150), TIME_MESSAGE VARCHAR(20), PRIMARY KEY (IDLOG)) ENGINE = MYISAM ");
            stmCreate.close();
            }
            tableCreated = true;
    }
}
