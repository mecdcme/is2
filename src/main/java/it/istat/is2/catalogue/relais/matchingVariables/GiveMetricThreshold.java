package it.istat.is2.catalogue.relais.matchingVariables;

import it.istat.is2.catalogue.relais.constants.TablesName;
import it.istat.is2.catalogue.relais.metrics.dataStructure.MetricMatchingVariableVector;

import java.sql.Connection;
import java.sql.Statement;

/*updates db with choices about metrics and thresholds for matcvhing varaibles*/
public class GiveMetricThreshold {
	private Connection connection;
	private MetricMatchingVariableVector mmvv;
	
	public GiveMetricThreshold(Connection con, MetricMatchingVariableVector mmvv){
		this.connection = con;
		this.mmvv = mmvv;
	}

        /* modifies in table the metric and the threshold for a chosen matching variable */
	public void UpdateMatchingVariableTable(){
	   Statement stm;
	   String updateString = null;
	   try{
	   for(int i=0; i<mmvv.size(); i++){
		   updateString = "UPDATE "+TablesName.nameMatchingVeriables()+" SET METRIC = \""+mmvv.get(i).getComparisonFunction()+"\"";
		   updateString = updateString + " , THRESHOLD = "+mmvv.get(i).getMetricThreshold()+" , WINDOWSIZE = "+mmvv.get(i).getWindowSize();
		   updateString = updateString + " WHERE VARIABLE_NAME = \""+ mmvv.get(i).getMatchingVariable()+"\";";
		   
		   stm = (Statement)connection.createStatement();
		   stm.executeUpdate(updateString);
		   
	   }
	   }catch (Exception e) {
			e.printStackTrace();
	   }
	   
	   }
}
