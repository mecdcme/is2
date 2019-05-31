package it.istat.is2.catalogue.relais.project;


import java.sql.Connection;
import java.sql.Statement;

import it.istat.is2.catalogue.relais.constants.TablesName;

import java.sql.ResultSet;
/* traces transactions (significant operations) performed by users */ 
public class CurrentStatus {
    private Connection connection;
    
    String lastOperDesc;
    String lastOperStatus;
    String lastOperData;

    public CurrentStatus(Connection con){		
	this.connection = con;
        this.lastOperDesc="";
        this.lastOperStatus="";
        this.lastOperData="";
    }
    
    /* creates a table of transactions */
    public void CreateStatus(){
        try{
			Statement stmCreate = (Statement)connection.createStatement();
			stmCreate.executeUpdate("CREATE TABLE "+TablesName.nameCurrentStatus()+" ("+
                                                "ID_OPER INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, "+
                                                "COD_OPER char(5), DESC_OPER varchar(150), "+
                                                "DATA_OPER datetime, STATUS varchar(30), PRIMARY KEY (ID_OPER)) ENGINE MYISAM;");
			stmCreate.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
    }
    
    /* inserts a  transaction in table */
    public int Insert(String codOper, String descOper){
        int nRet=0;
        try{
                        String sqlString = "INSERT into "+TablesName.nameCurrentStatus()+
                                           " (COD_OPER,DESC_OPER,DATA_OPER,STATUS) " +
                                           " values ('"+codOper+"','"+descOper+"',now(),'In progress')";
                        
                        Statement stmInsert = (Statement)connection.createStatement();
			stmInsert.executeUpdate(sqlString);
			stmInsert.close();
                        
                        Statement stm= (Statement)connection.createStatement();	
                        ResultSet rs = stm.executeQuery("select max(ID_OPER) from "+TablesName.nameCurrentStatus());
                        if (rs.next())
                        {
                            nRet=rs.getInt(1);
                        }
			
                        
		}catch(Exception e){
			e.printStackTrace();
                        
		}finally{
                    return (nRet);
                }
    }
    
    /* modifies the status of a transaction */
    public void UpdateStatus(int idOper,String statusOper) {
		try{
			Statement stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameCurrentStatus()+" SET STATUS = '"+statusOper+"' WHERE ID_OPER="+idOper);
			stm.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
    }
    
    /* modifies the status of transaction */
    public void UpdateStatus(String codOper,String statusOper) {
		try{
			Statement stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameCurrentStatus()+" SET STATUS = '"+statusOper+"' WHERE COD_OPER='"+codOper+"' AND STATUS = 'In progress'");
			stm.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
    }
    
    /* assigns the status interrupt to transactions not terminated */
    public void CloseInProgress() {
		try{
			Statement stm = (Statement)connection.createStatement();
			stm.executeUpdate("UPDATE "+TablesName.nameCurrentStatus()+" SET STATUS = 'Interrupted' WHERE STATUS = 'In progress'");
			stm.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
    }

    /* reads the table and returns if  one transaction exists*/
    public boolean Read(){
        try{
		Statement stm= (Statement)connection.createStatement();	
		ResultSet rs = stm.executeQuery("SELECT COD_OPER, DESC_OPER, STATUS, date_format(DATA_OPER,'%Y/%m/%d %H:%i:%s')"+
                                            "  from "+TablesName.nameCurrentStatus()+" order by ID_OPER;");
		while (rs.next())
		{
                        this.lastOperDesc = rs.getString(2);
                        this.lastOperStatus = rs.getString(3);
                        this.lastOperData = rs.getString(4);
		}
                rs.close();
                stm.close();
                
                if (this.lastOperData.equals("")) return false;
                return true;
	} catch(Exception ex){
            System.out.println(ex.toString());
	    return false;
	}
    }
    
    /* returns last transaction */
    public String getLastTransaction(){
        return (this.lastOperDesc+" at "+this.lastOperData+": "+this.lastOperStatus);
    }
    
    /* returns if transaction is succesfully terminated */
    public boolean isTerminated(String codOper){
        boolean ret=false;
        try{
		Statement stm= (Statement)connection.createStatement();	
		ResultSet rs = stm.executeQuery("select STATUS from "+TablesName.nameCurrentStatus()+
                                                " where COD_OPER='"+codOper+"' and STATUS like 'Succ%'");
		if (rs.next())
		{
                        ret=true;
		}
                rs.close();
                stm.close();
                
                return ret;

	} catch(Exception ex){
            System.out.println(ex.toString());
	    return false;
	}
    }
    
    /* returns if a transaction in progress exists*/
    public boolean isInProgress(){
        boolean ret=false;
        try{
		Statement stm= (Statement)connection.createStatement();	
		ResultSet rs = stm.executeQuery("select STATUS from "+TablesName.nameCurrentStatus()+
                                                " where STATUS like 'In progress'");
		if (rs.next())
		{
                        ret=true;
		}
                rs.close();
                stm.close();
                
                return ret;

	} catch(Exception ex){
            System.out.println(ex.toString());
	    return false;
	}
    }
        
    
    
    /* returns if a  table of transactions exists*/
    public boolean Exists(){
        try{
		Statement stm= (Statement)connection.createStatement();	
		ResultSet rs = stm.executeQuery("Select TABLE_NAME from information_schema.TABLES where upper(TABLE_NAME)='"+TablesName.nameCurrentStatus()+"' and TABLE_SCHEMA = 'relais'");
		if (rs.next())
		{
                        return true;
		}
                return false;
	} catch(Exception ex){
            System.out.println(ex.toString());
	    return false;
	}
    }
}
