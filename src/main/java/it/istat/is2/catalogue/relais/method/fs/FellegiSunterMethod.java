package it.istat.is2.catalogue.relais.method.fs;

import it.istat.is2.catalogue.relais.constants.TablesName;
import it.istat.is2.catalogue.relais.log.TraceLog;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/* Launches R code for model estimation via EM */
public class FellegiSunterMethod {
	private Connection connection;
	private final String paramR="param.R";
	private final String FSFailRroot="FSFail";
        private final String FSAllRroot="FSAllert";
        private final String RMessage="RMessage";
	private String method;
	private int varNum;
	private final String RPathname = "mu_gen_embedded.R";
	
	public FellegiSunterMethod(Connection con) throws Exception {
		this.connection = con;
		try{
			Statement stm =(Statement)connection.createStatement();
			ResultSet rs;
			rs = stm.executeQuery("SELECT METHOD FROM "+TablesName.nameSetting()+";");
			rs.next();
			this.method = rs.getString(1);
			rs = stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameMatchingVeriables()+";");
			rs.next();
			this.varNum = rs.getInt(1);

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
	
      /* estimation of match/unmatch probability:         
         * - writes a parameter file with indication about contingency table
         * - execution of R code mu_gen_embedded.R
         * - R execution creates the match/unmatch (MU) table
         */ 
	public void FellegiSunter() throws Exception {

		    FileWriter writer = null;
                    TraceLog log = new TraceLog(connection);
                    String FSFailR=FSFailRroot+".Rout";
                    String FSAllR=FSAllRroot+".Rout";
                    
		    	//Writing the parameters for the R file in a file with extension .R
		    	try 
				  {
					writer = new FileWriter(new File(this.paramR));
					writer.write("nvar="+this.varNum+System.getProperty("line.separator"));
					writer.write("contingencyTableName= '"+TablesName.nameContingency()+"'"+System.getProperty("line.separator"));
					writer.write("muTableName = '"+TablesName.nameMU()+"'"+System.getProperty("line.separator"));
                                        writer.write("varmuTableName = '"+TablesName.nameMUVariable()+"'"+System.getProperty("line.separator"));
					writer.write("percorso_fail=\""+FSFailR+"\""+System.getProperty("line.separator"));
                                        writer.write("percorso_allert=\""+FSAllR+"\""+System.getProperty("line.separator"));
					if(new File(FSFailR).exists())
						new File(FSFailR).delete();
				  }catch (Exception ex) {
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
				  //launching mu_gen_embedded.R
				  try {
                                        Statement stmDrop = (Statement)connection.createStatement();
					stmDrop.executeUpdate("DROP TABLE IF EXISTS "+TablesName.nameMU()+";");
                                        stmDrop.executeUpdate("DROP TABLE IF EXISTS "+TablesName.nameMUVariable()+";");
					 	
					Runtime rt=Runtime.getRuntime();
		            log.AddMessage("Computing Fellegi-Sunter method...");          
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
                            FileWriter errwriter = new FileWriter(new File(this.RMessage+".Rout"));
                            
                           String line;
                            while ((line = br.readLine()) != null) {
                                log.AddMessage(line);
                            }
                            while ((line = brerr.readLine()) != null) {
                                errwriter.write(line);
                                errwriter.write(System.getProperty("line.separator"));
                                log.AddMessage(line, false);
                            }
                            errwriter.close();
                            
                            myProc.waitFor();
		            if(myProc.exitValue()!= 0){
		            	log.AddMessage("R execution failed","E");
                                log.AddMessage("See file "+this.RMessage+".Rout for more details");
		            	Exception fail = new Exception("EM Estimation task failed");
                                throw fail;
		            	}
		            else {
                                    if(new File(FSFailR).exists())
                                    {
                                      Exception fmodel = new Exception("Estimation of parameters failed for this model");
                                      System.out.println("ERROR: "+fmodel.getMessage());
                                      throw fmodel;
                                    }
                                    else	
                                    {	
                                     log.AddMessage("Writing MU table on db...",false);
                                     log.AddMessage("EM Estimation succeeded",false);	
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
		

}
