package it.istat.is2.catalogue.relais.method.fs;

import it.istat.is2.catalogue.relais.constants.TablesName;
import it.istat.is2.catalogue.relais.log.TraceLog;

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

/* Launches R code for model estimation via EM after a blocking step*/ 

public class FellegiSunterBlocking {
	private Connection connection;
	private final String paramR="param.R";
	private final String FSFailRroot="FSFail";
        private final String FSAllRroot="FSAllert";
        private final String RMessage="RMessage";
	private int numBlockModality;
	@SuppressWarnings("unused")
	private String method;
	private ArrayList<String> blockModality;
	private int varNum;
	private static final int BUFFER_SZ = 51200;  
	private final String RPathname = "mu_gen_embedded.R";
	private String blockingKey;
	
	public FellegiSunterBlocking(Connection con) throws Exception {
		this.connection = con;
		try{
		Statement stm3 =(Statement)connection.createStatement();
		ResultSet rs3 = stm3.executeQuery("SELECT METHOD FROM "+TablesName.nameSetting()+";");
		rs3.next();
		this.method = rs3.getString(1);
		stm3.close();
		Statement stm4 =(Statement)connection.createStatement();
		ResultSet rs4 = stm4.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameMatchingVeriables()+";");
		rs4.next();
		this.varNum = rs4.getInt(1);
		stm4.close();
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
                
                /* remove old Rout files */
                DeleteRoutFiles drout = new DeleteRoutFiles(FSFailRroot);
                drout.delete();
                drout.changeFilesName(FSAllRroot);
                drout.delete();
                drout.changeFilesName(RMessage);
                drout.delete();

		}catch(Exception e){
			e.printStackTrace();
                        throw e;
		}
	}
	
	/* estimation of match/unmatch probability
         * in case of search space reduced by blocking
         * - writes a parameter file with indication about contingency table
         * - execution of R code mu_gen_embedded.R
         * - R execution creates the match/unmatch (MU) table
         */ 
	public void FellegiSunter() throws Exception {
		    FileWriter writer = null;
                    TraceLog log = new TraceLog(connection);
                    boolean success=false;
                    String FSFailRR="";
                    String FSAllRR="";
                    FileWriter errwriter = new FileWriter(new File(this.RMessage+".Rout"));
		    for(int i=0; i<numBlockModality;i++){
		    	//Writing the parameters for the R file in a file with extension .R
                        FSFailRR = FSFailRroot+"_"+this.blockModality.get(i).toUpperCase()+".Rout";
                        FSAllRR = FSAllRroot+"_"+this.blockModality.get(i).toUpperCase()+".Rout";
		    	try 
				  {
					writer = new FileWriter(new File(this.paramR));
					writer.write("nvar="+this.varNum+"\n");
					writer.write("contingencyTableName= '"+TablesName.nameContingency()+"_"+this.blockingKey.replace(",","_").toUpperCase()+"_"+this.blockModality.get(i).toUpperCase()+"'\n");
					
					log.AddMessage("contingencyTableName= '"+TablesName.nameContingency()+"_"+this.blockingKey.replace(",","_").toUpperCase()+"_"+this.blockModality.get(i).toUpperCase()+"'",false);
					
					writer.write("muTableName = '"+TablesName.nameMU()+"_"+this.blockModality.get(i).toUpperCase()+"'\n");
					log.AddMessage("muTableName = '"+TablesName.nameMU()+"_"+this.blockModality.get(i).toUpperCase()+"'");
                                        
                                        writer.write("varmuTableName = '"+TablesName.nameMUVariable()+"_"+this.blockModality.get(i).toUpperCase()+"'\n");
					log.AddMessage("varmuTableName = '"+TablesName.nameMUVariable()+"_"+this.blockModality.get(i).toUpperCase()+"'",false);

					writer.write("percorso_fail=\""+FSFailRR+"\"\n");
                                        writer.write("percorso_allert=\""+FSAllRR+"\"\n");
					
                                        if(new File(FSFailRR).exists())
						new File(FSFailRR).delete();
                                        
				  }catch (IOException ex) {
					ex.printStackTrace();
                                        throw ex;
				  }
				  finally 
				  {
				   try 
				   { 
					writer.close(); 
				   }catch(Exception e){
					   System.out.println("Error!!");
				   } 
				  }
				  //launching mu_gen.R
				  try {
                                        Statement stmDrop = (Statement)connection.createStatement();
					stmDrop.executeUpdate("DROP TABLE IF EXISTS "+TablesName.nameMU()+"_"+this.blockModality.get(i).toUpperCase()+";");
                                        stmDrop.executeUpdate("DROP TABLE IF EXISTS "+TablesName.nameMUVariable()+"_"+this.blockModality.get(i).toUpperCase()+";");

                            Runtime rt=Runtime.getRuntime();
		            log.AddMessage("Computing Fellegi-Sunter method...",false);		            
		            String path=new File(RPathname).getAbsolutePath(); 
                            String str="Rscript "+path+" ";
                            String os = System.getProperty("os.name").toLowerCase();
                            if (os.indexOf("win") >= 0){
                                str="RSCRIPT \""+path+"\"";
                            }
		            String newStr = str.replace("\\","\\\\");
		            log.AddMessage("Invoking R...",false);
		            Process myProc=rt.exec(newStr);
		           InputStream is = myProc.getInputStream();
                           InputStream errs = myProc.getErrorStream();
                            InputStreamReader isr = new InputStreamReader(is);
                            BufferedReader br = new BufferedReader(isr);
                            InputStreamReader iserr = new InputStreamReader(errs);
                            BufferedReader brerr = new BufferedReader(iserr);
                            
                           String line;
                            while ((line = br.readLine()) != null) {
                                log.AddMessage(line);
                            }
                           while ((line = brerr.readLine()) != null) {
                                errwriter.write(line);
                                errwriter.write(System.getProperty("line.separator"));
                                log.AddMessage(line, false);
                            }
                            errwriter.flush();
                            
                            myProc.waitFor();
		            if(myProc.exitValue()!= 0){
		            	log.AddMessage("R execution failed","W");
                                log.AddMessage("See file "+this.RMessage+".Rout for more details");
		            	log.AddMessage("EM Estimation task failed","W",false);
		            	}
		            else {
		            	if(new File(FSFailRR).exists())
		            	{
		            	  log.AddMessage("Estimation of parameters failed for this model","W");
		            	}
		            	else	
		            	{	
		            	 log.AddMessage("Writing MU table on db...",false);
		    	         log.AddMessage("EM Estimation succeeded");
                                 success = true;
		            	}
		            	}  
		        } catch (IOException ex) {
		            ex.printStackTrace();
                            throw ex;
		        } catch (InterruptedException e) {
					e.printStackTrace();
                                        throw e;
				} 
		    }
                    errwriter.close();
                    
                    if (!success) {
                        Exception fail = new Exception("The EM estimation of any block is failed");
                        throw fail;
                        
                    }
	}
}
