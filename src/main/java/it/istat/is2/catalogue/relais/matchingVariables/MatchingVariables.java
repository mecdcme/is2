package it.istat.is2.catalogue.relais.matchingVariables;




import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import it.istat.is2.catalogue.relais.constants.TablesName;
import it.istat.is2.catalogue.relais.metrics.dataStructure.MetricMatchingVariable;
import it.istat.is2.catalogue.relais.metrics.dataStructure.MetricMatchingVariableVector;
/* Populates a db table with matching variables*/ 
public class MatchingVariables {
	Connection connection;
	MetricMatchingVariableVector mmvvlocal;
	
	public MatchingVariables(Connection conn){
		this.connection = conn;
                this.mmvvlocal = new MetricMatchingVariableVector();
	}
	
	public MatchingVariables(Connection con, MetricMatchingVariableVector mmvv){
			this.connection = con;
			this.mmvvlocal = new MetricMatchingVariableVector();
			MetricMatchingVariable mmv = new MetricMatchingVariable();
			for(int i=0; i<mmvv.size(); i++){
			    mmv = new MetricMatchingVariable();
			    mmv.setMatchingVariable(mmvv.get(i).getMatchingVariable());
			    mmv.setComparisonFunction(mmvv.get(i).getComparisonFunction());
			    mmv.setMetricThreshold(mmvv.get(i).getMetricThreshold());
				this.mmvvlocal.add(mmv);
			}
		}
		
        /* creates table of matching variables and inserts chosen variables */
	public void CreateMatchingVariablesTable(){
		Statement stmDrop, stmCreate, stmInsert = null;
		String insertString;
		try{
			try{
			stmDrop = (Statement)connection.createStatement();
			stmDrop.executeUpdate("DROP TABLE "+TablesName.nameMatchingVeriables()+";");
			stmDrop.close();
			}catch(SQLException e){
				;
			}
			stmCreate =(Statement)connection.createStatement();
			stmCreate.executeUpdate("CREATE TABLE "+ TablesName.nameMatchingVeriables()+"(VARIABLE_NAME VARCHAR(150), METRIC VARCHAR(150), THRESHOLD DOUBLE, WINDOWSIZE INTEGER);");
			stmCreate.close();
			
			int numMV = mmvvlocal.size();
			
			stmInsert=(Statement)connection.createStatement();
			for(int i=0; i< numMV; i++){
				insertString = "INSERT INTO "+TablesName.nameMatchingVeriables()+"(VARIABLE_NAME, METRIC, THRESHOLD, WINDOWSIZE ) VALUES ("+"\""+mmvvlocal.get(i).getMatchingVariable()+"\", \"\", 0.2, 1);";
				stmInsert.executeUpdate(insertString);
		     }
			stmInsert.close();
	        
	}catch (Exception e) {
			e.printStackTrace();		
	
	}

	 }
	
    /* creates table of matching variables and inserts chosen variables with metric and threshold */    
    public void CreateMatchingVariablesTableComplete(){
            Statement stmDrop, stmCreate, stmInsert = null;
            String insertString;
            try{
                    try{
                    stmDrop = (Statement)connection.createStatement();
                    stmDrop.executeUpdate("DROP TABLE "+TablesName.nameMatchingVeriables()+";");
                    stmDrop.close();
                    }catch(SQLException e){
                    }
                    stmCreate =(Statement)connection.createStatement();
                    stmCreate.executeUpdate("CREATE TABLE "+TablesName.nameMatchingVeriables()+"(VARIABLE_NAME VARCHAR(150), METRIC VARCHAR(150), THRESHOLD DOUBLE, WINDOWSIZE INTEGER);");
                    stmCreate.close();

                    int numMV = mmvvlocal.size();

                    stmInsert=(Statement)connection.createStatement();
                    for(int i=0; i< numMV; i++){
                            insertString = "INSERT INTO "+TablesName.nameMatchingVeriables()+"(VARIABLE_NAME, METRIC, THRESHOLD, WINDOWSIZE ) VALUES "+
                                           "('"+mmvvlocal.get(i).getMatchingVariable()+"','"+mmvvlocal.get(i).getComparisonFunction()+"', "+mmvvlocal.get(i).getMetricThreshold()+",'"+mmvvlocal.get(i).getWindowSize()+"');";
                            stmInsert.executeUpdate(insertString);
                    }
                    stmInsert.close();

             }catch (Exception e) {
                    e.printStackTrace();
             }

    }

    /* returns number of matching variables */
	public int getNumMatchingVariables(){
	     Statement stm;
	     ResultSet rs;
	     int num = 0;
	     try{
	    	 stm = (Statement)connection.createStatement();
	    	 rs = stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameMatchingVeriables()+";");
	    	 rs.next();
	    	 num = rs.getInt(1);
	    	 stm.close();
	     }catch(Exception e){
	    	 e.printStackTrace();
	     }
	     return num;
	}
	
        /* modifies metrics and thresholds for chosen matching variables */
	public void UpdateMatchingVariableTable(MetricMatchingVariableVector mv){
		for(int i=0; i<mv.size(); i++){
			MetricMatchingVariable mmv = new MetricMatchingVariable();
			mmv.setMatchingVariable(mv.get(i).getMatchingVariable());
			mmv.setComparisonFunction(mv.get(i).getComparisonFunction());
			mmv.setMetricThreshold(mv.get(i).getMetricThreshold());
                        mmv.setWindowSize(mv.get(i).getWindowSize());
			mmvvlocal.add(mmv);
		}
		   Statement stm;
		   String updateString = null;
		   try{
		   for(int i=0; i<mmvvlocal.size(); i++){
			   updateString = "UPDATE "+TablesName.nameMatchingVeriables()+" SET METRIC = \""+mmvvlocal.get(i).getComparisonFunction()+"\"";
			   updateString = updateString + " , THRESHOLD = "+mmvvlocal.get(i).getMetricThreshold();
			   updateString = updateString + " , WINDOWSIZE = "+mmvvlocal.get(i).getWindowSize();
			   updateString = updateString + " WHERE VARIABLE_NAME = \""+ mmvvlocal.get(i).getMatchingVariable()+"\";";
			   
			   stm = (Statement)connection.createStatement();
			   stm.executeUpdate(updateString);
			   stm.close();
		   }
		   }catch (Exception e) {
				e.printStackTrace();
		   }
		   
		   }
	
        /* returns all data from chosen matching variables  */
	public MetricMatchingVariableVector getMetricMatchingVariableVector(){
		Statement stmMV;
		ResultSet rsMV;
		MetricMatchingVariable mmv;
		MetricMatchingVariableVector mmvvlocal2;
		mmvvlocal2 = new MetricMatchingVariableVector();
                try{
		     	
                    stmMV = (Statement)connection.createStatement();
			rsMV = stmMV.executeQuery("SELECT * FROM "+TablesName.nameMatchingVeriables()+";");
			int index=0;
			while(rsMV.next()){
                                mmv = new MetricMatchingVariable();
			        mmv.setMatchingVariable(rsMV.getString(1));
				mmv.setComparisonFunction(rsMV.getString(2));
				mmv.setMetricThreshold(rsMV.getDouble(3));
                                mmv.setWindowSize(rsMV.getInt(4));
				mmvvlocal2.add(index,mmv);
                        	index++;
			}
			stmMV.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return mmvvlocal2;
			
	}

       /* generates the list of column names for the contingency table and the MU table */
       public String[] getContingencyColumns(){
		Statement stmMV;
		ResultSet rsMV;
                int nVar=getNumMatchingVariables();
                int countVar;
                String[] columnsName = new String[nVar];
                String[] varName = new String[nVar];
		String suffix;
                
		try{
			stmMV = (Statement)connection.createStatement();
			rsMV = stmMV.executeQuery("SELECT VARIABLE_NAME FROM "+TablesName.nameMatchingVeriables()+";");
			int index=0;
			while(rsMV.next()){
				varName[index]=rsMV.getString(1);
                                suffix="";
                                countVar=1;
                                for (int index2=0; index2<index; index2++)
                                    if (varName[index2].equalsIgnoreCase(varName[index]))
                                            countVar++;
                                /* same variables can appear more time like matching variables with different distance */
                                if (countVar>1) 
                                    suffix="_"+countVar;
				columnsName[index]=varName[index]+suffix;
				index++;
			}
			stmMV.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return columnsName;
			
	}

	}	

