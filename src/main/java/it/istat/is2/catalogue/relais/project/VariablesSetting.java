package it.istat.is2.catalogue.relais.project;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import it.istat.is2.catalogue.relais.constants.TablesName;

public class VariablesSetting {
    private Connection connection;
	
	public VariablesSetting(Connection con){		
		this.connection = con;
	}
	
        /* creates a table of settings and inserts default values for variables */
	public void InitialSettingVariables(){
		Statement stmDrop, stmCreate, stmInsert;
		
		try{
			stmDrop = (Statement)connection.createStatement();
			stmDrop.executeUpdate("DROP TABLE "+TablesName.nameSetting());
			stmDrop.close();
		}catch(SQLException e){
			;
		}
		try{
			stmCreate = (Statement)connection.createStatement();
			stmCreate.executeUpdate("CREATE TABLE "+TablesName.nameSetting()+" (PROJECT_TYPE varchar(20), METHOD varchar(50), BLOCKVAR varchar(150), MODEL varchar(50), RULE varchar(900), THRESHOLDU double, THRESHOLDM double, OUTPUTFOLDERPATH varchar(150), CHAR_SEPARATOR varchar(50), WINDOWSIZE integer);");
			stmCreate.close();
			
			stmInsert = (Statement)connection.createStatement();
			stmInsert.executeUpdate("INSERT INTO "+TablesName.nameSetting()+" VALUES (null, null, null, null, null, null, null, null, ';',null);");
			stmInsert.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
        /* modifies variable output folder in the table of settings */
	public void UpdateOutputFolder(String outputFolderPath){
		Statement stm;
		String appo = outputFolderPath.replace("\\","\\\\");
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET OUTPUTFOLDERPATH = "+appo+";");
			stm.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
        /* modifies variable method in the table of settings */
	public void UpdateMethod(String method){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET METHOD = \""+method+"\";");
			stm.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
      /* modifies variable blocking in the table of settings */
	public void UpdateBlockVar(String blockvar){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET BLOCKVAR = \""+blockvar+"\";");
			stm.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
        /* modifies variable match threshold in the table of settings */
	public void UpdateThresholdM(double valThreshold){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET THRESHOLDM = "+valThreshold+";");
			stm.close();
                }catch(Exception e){
			e.printStackTrace();
		}
	}
	
       /* modifies variable unmatch threshold in the table of settings */
	public void UpdateThresholdU(double valThreshold){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET THRESHOLDU = "+valThreshold+";");
			stm.close();
                }catch(Exception e){
			e.printStackTrace();
		}
	}
        
       /* modifies variable model in the table of settings */
        public void UpdateModel(String model){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET MODEL = '"+model+"';");
			stm.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
        
     /* modifies variable rule in the table of settings */
        public void UpdateRule(String rule){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET RULE = '"+rule+"';");
			stm.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
     /* modifies variable windowSize in the table of settings */
        public void UpdateWindowSize(int wsize){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET WINDOWSIZE = "+wsize+";");
			stm.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
        
     /* modifies variable separator in the table of settings */
        public void UpdateSeparator(String separator){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET CHAR_SEPARATOR = '"+separator+"';");
			stm.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

        /* modifies variable project_type in the table of settings */
        public void UpdateProjectType(String type){
		Statement stm;
		try{
			stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameSetting()+" SET PROJECT_TYPE = '"+type+"';");
			stm.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
        /* returns value of variable blocking var in the table of settings */
        public String ReadBlockVar() {
            String output = "";
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT BLOCKVAR FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getString(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
        
           /* returns value of variable windowSize in the table of settings */
        public int ReadWindowSize() {
            int output = 0;
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT WINDOWSIZE FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getInt(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
        
       /* returns value of variable method in the table of settings */
        public String ReadMethod() {
            String output = "";
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT METHOD FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getString(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
        
        /* returns value of variable output folder in the table of settings */
        public String ReadOutputFolder() {
            String output = "";
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT OUTPUTFOLDERPATH FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getString(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
        
         /* returns value of variable model in the table of settings */
        public String ReadModel() {
            String output = "";
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT MODEL FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getString(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
        
         /* returns value of variable separator in the table of settings */
        public String ReadSeparator() {
            String output = ";";
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT CHAR_SEPARATOR FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getString(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
        
         /* returns value of variable separator in the table of settings */
        public String ReadProjectType() {
            String output = ";";
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT IFNULL(PROJECT_TYPE,'Linkage') FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getString(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
        
         /* returns value of variable unmatch-treshold in the table of settings */
        public double ReadThresholdU() {
            double output = -1;
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT IFNULL(THRESHOLDU,-1) FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getDouble(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
        
                 /* returns value of variable match-treshold in the table of settings */
        public double ReadThresholdM() {
            double output = -1;
            try{
			Statement stm = (Statement)connection.createStatement();
			ResultSet rset = stm.executeQuery("SELECT IFNULL(THRESHOLDM,-1) FROM "+TablesName.nameSetting());
                        if (rset.next()) output = rset.getDouble(1);
			stm.close();
                        
		}catch(Exception e){
			e.printStackTrace();
		}finally{
                    return (output);
                }
        }
}
