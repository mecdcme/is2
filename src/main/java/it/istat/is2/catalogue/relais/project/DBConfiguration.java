package it.istat.is2.catalogue.relais.project;

import java.io.BufferedReader;
import java.io.FileReader;

public class DBConfiguration {
	private static String DB_CONNECTION ="jdbc:mysql://localhost/relais";
	private static String DB_CONNECTION_MYSQL ="jdbc:mysql://localhost/mysql";
	private static DBConfiguration instance = null;
	
	public DBConfiguration() {
	
	}
	
	 public static DBConfiguration getInstance(){
	        if(instance==null) 
	            instance = new DBConfiguration();
	        return instance;         
	    }
	
        /* returns a connection to mysql database */
	public static java.sql.Connection getConnection(){
         try {
             try {
                  BufferedReader in = new BufferedReader(new FileReader("db.param"));
                  String readuser = in.readLine();
                  if (readuser != null && !readuser.equals("") && !readuser.equals("user="))
                    {
                        String readpass = in.readLine();
                          if (readpass != null && !readpass.equals("") && !readpass.equals("password="))
                        {
                            DB_CONNECTION ="jdbc:mysql://localhost/relais?"+readuser+"&"+readpass+"&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
                            DB_CONNECTION_MYSQL ="jdbc:mysql://localhost/mysql?"+readuser+"&"+readpass+"&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
                            System.out.println(" INFO: database connection parameters read from file");
                        }
                    }
                  in.close();
                  } catch (Exception ex) {
                     
                  }
	
                java.sql.Connection conn_mysql = java.sql.DriverManager.getConnection(DB_CONNECTION_MYSQL);
		java.sql.Statement stm = (java.sql.Statement)conn_mysql.createStatement();
                java.sql.ResultSet rs = stm.executeQuery("select SCHEMA_NAME from information_schema.SCHEMATA where SCHEMA_NAME = 'relais';");
                if(rs.next() == false)
                    stm.executeUpdate("create database relais;");
                rs.close();
                stm.close();
                conn_mysql.close();
                java.sql.Connection conn = java.sql.DriverManager.getConnection(DB_CONNECTION);
		return conn;  
            }catch(Exception e){
            throw new RuntimeException("Problems in connecting to the DB:"+ e.getMessage());
    } 


}
}
