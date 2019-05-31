package it.istat.is2.catalogue.relais.project;


import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;
/* traces summary for most significant step of linkage project */ 
import java.util.ArrayList;

import it.istat.is2.catalogue.relais.constants.TablesName;
public class Summary {
    private Connection connection;

    /* Create class and summary table */
    public Summary(Connection con){		
       this.connection = con;

       try{
           Statement stmCreate = (Statement)connection.createStatement();
	   stmCreate.executeUpdate("CREATE TABLE IF NOT EXISTS "+TablesName.nameSummary()+" (level integer, summary varchar(100), value DOUBLE, description varchar(100))");
	   stmCreate.close();
			
	}catch(Exception e){
	   e.printStackTrace();
	}
    }
    
    /* Create summary by type */
    public ArrayList<SummaryData> Create(String Type,VariablesSetting vs) {
        
        String summary;
        int value;
        ArrayList<SummaryData> sdl = new ArrayList<SummaryData>();
        
        try{
           if (Type.equalsIgnoreCase("Dataset")) {
               Statement stm = (Statement)connection.createStatement();
               ResultSet rs=stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameDsa());
               
               value=0;
               if (rs.next())
               {
                  value = rs.getInt(1);
               }
               if (vs.ReadProjectType().equalsIgnoreCase("Linkage")) {
                   summary = "Record in Dataset A";
                   Insert(10,summary,value,"");
                   
                   sdl.add(new SummaryData(summary,value,""));
                   rs=stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameDsb());
                   value=0;
                   if (rs.next())
                   {
                      value = rs.getInt(1);
                   }
                   summary = "Record in Dataset B";
                   Insert(11,summary,value,"");
                   
                   sdl.add(new SummaryData(summary,value,""));
                   
                   return sdl;
               } else {
                   stm.close();
                   summary = "Record in Dataset";
                   Insert(10,summary,value,"");
                   
                   sdl.add(new SummaryData(summary,value,""));
                   return sdl;
               }
           }
           else if (Type.equalsIgnoreCase("Searchspace")) {
               Statement stm = (Statement)connection.createStatement();
               ResultSet rs;
                   String sstable=TablesName.nameSearchSpaceTemp();
                   rs = stm.executeQuery("SELECT COUNT(*) FROM "+sstable);
               
                   value=0;
                   if (rs.next())
                   {
                      value = rs.getInt(1);
                   } 
                    summary = "Pairs in search space";
                    Insert(19,summary,value,"");
                    sdl.add(new SummaryData(summary,value,""));
               
               if(vs.ReadMethod().equals("CrossProduct")){
                    Insert(20,"Method",0,"Cartesian Product");
               }
               else if (vs.ReadMethod().equals("Blocking")) {
                   rs=stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameBlockModality());
                   value=0;
                   if (rs.next())
                   {
                      value = rs.getInt(1);
                   }
                   Insert(20,"Method",0,"Blocking");
                   summary = "Number of blocks";
                   Insert(21,summary,value,"");
                   sdl.add(new SummaryData(summary,value,""));
                } 
               else if (vs.ReadMethod().equals("Nested Blocking")) {
                   rs=stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameBlockModality());
                   value=0;
                   if (rs.next())
                   {
                      value = rs.getInt(1);
                   }
                   Insert(20,"Method",0,"Nested Blocking");
                   summary = "Number of blocks";
                   Insert(21,summary,value,"");
                   sdl.add(new SummaryData(summary,value,""));
                   summary = "Window Size";
                   value = vs.ReadWindowSize();
                   Insert(22,summary,value,"");
                  // sdl.add(new SummaryData(summary,value,""));
                } 
               else if (vs.ReadMethod().equals("SNM")) {
                   Insert(20,"Method",0,"Sorted Neighborhood");
                   summary = "Window Size";
                   value = vs.ReadWindowSize();
                   Insert(21,summary,value,"");
                   sdl.add(new SummaryData(summary,value,""));
                } else {
                   Insert(20,"Method",0,vs.ReadMethod());
                }  
               
                stm.close();
                return sdl;

           }
           else if (Type.equalsIgnoreCase("match")) {
               Statement stm = (Statement)connection.createStatement();

               ResultSet rs=stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameMatch());
               
               value=0;
               if (rs.next())
               {
                  value = rs.getInt(1);
               }
               summary = "Number of match pairs";
               Insert(40,summary,value,"");
               sdl.add(new SummaryData(summary,value,""));
               
               stm.close();
               return sdl;
           }
           else if (Type.equalsIgnoreCase("possiblematch")) {
               Statement stm = (Statement)connection.createStatement();

               ResultSet rs=stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.namePossibleMatch());
               
               value=0;
               if (rs.next())
               {
                  value = rs.getInt(1);
               }
               summary = "Number of possible match";
               Insert(41,summary,value,"");
               sdl.add(new SummaryData(summary,value,""));
               
               stm.close();
               return sdl;
           }
           else if(Type.equalsIgnoreCase("unmatch")){
              Statement stm = (Statement)connection.createStatement();
              ResultSet rs=stm.executeQuery("SELECT COUNT(*) FROM "+TablesName.nameUnMatch());
              value=0;
              if (rs.next())
              {
                 value = rs.getInt(1);
              }
              summary = "Number of unmatch";
              Insert(42,summary,value,"");
              sdl.add(new SummaryData(summary,value,""));
               
               stm.close();
               return sdl;
               
           }
           else if(Type.equalsIgnoreCase("threshold1")){
              Statement stm = (Statement)connection.createStatement();
              ResultSet rs = stm.executeQuery("SELECT THRESHOLDU FROM "+TablesName.nameSetting());
              double val = 0.0;
              if(rs.next())
                  val = rs.getDouble(1);
              summary = "Threshold Unmatch";
              Insert(38, summary, val,"");
              sdl.add(new SummaryData(summary,val,""));
              stm.close();
              return sdl;
           }
          else if(Type.equalsIgnoreCase("threshold2")){
              Statement stm = (Statement)connection.createStatement();
              ResultSet rs = stm.executeQuery("SELECT THRESHOLDM FROM "+TablesName.nameSetting());
              double val = 0.0;
              if(rs.next())
                  val = rs.getDouble(1);
              summary = "Threshold Match";
              Insert(39, summary, val,"");
              sdl.add(new SummaryData(summary,val,""));
              stm.close();
              return sdl;
           }
           
           return null;
        }catch(Exception e){
	   e.printStackTrace();
           return null;
	}
    }
    
    /* inserts a summary in table */
    public void Insert(int level, String desc, double value, String descr){

        try{
                String sqlString = "DELETE FROM "+TablesName.nameSummary()+" WHERE level>="+level;
                        
                Statement stmInsert = (Statement)connection.createStatement();
                stmInsert.executeUpdate(sqlString);
                
                sqlString = "INSERT INTO "+TablesName.nameSummary()+" (level,summary,value,description) VALUE ("+level+",'"+desc+"',"+value+",'"+descr+"')";
		stmInsert.executeUpdate(sqlString);
                stmInsert.close();
                        
	}catch(Exception e){
		e.printStackTrace();              
	}
    }

    public  SummaryData Read(String descr){
        String desc = null;
        if(descr.equals("DSASum"))
            desc = "Record in Dataset A";
        else if (descr.equals("DSBSum"))
            desc = "Record in Dataset B";
        else if(descr.equals("SSRMethod"))
            desc = "Method";
        else if(descr.equals("PairsInSpace"))
            desc = "Pairs in search space";
        else if(descr.equals("NumberBlock"))
            desc = "Number of blocks";
        else if (descr.equals("SNM"))
            desc = "Window Size";
        else if(descr.equals("NestedBlocking"))
            desc ="Window Size";
        else if(descr.equals("match")){
            //System.out.println("match");
            desc ="Number of match pairs";
        }
        else if(descr.equals("possiblematch")){
            //System.out.println("possiblematch");
            desc = "Number of possible match";
        }
        else if(descr.equals("unmatch")){
            //System.out.println("unmatch");
            desc="Number of unmatch";
        }
        else if(descr.equals("threshold1"))
            desc="Threshold Unmatch";
        else if(descr.equals("threshold2"))
            desc="Threshold Match";
        else if(descr.equals("ReductionMethod"))
            desc="Reduction 1:1 Method";
        else if(descr.equals("DescisionalModel"))
            desc="Decisional Model";
        SummaryData sdRead = new SummaryData("NO",0,"");
        String sqlQueryStr ="SELECT summary, value, description FROM "+TablesName.nameSummary()+" WHERE level IN (SELECT MAX(level) FROM "+TablesName.nameSummary()+" WHERE summary = \'"+desc+"\');";
        try{
            Statement stmRead =(Statement)connection.createStatement();
            ResultSet rsRead = stmRead.executeQuery(sqlQueryStr);
            if (rsRead.next()) {
                sdRead.setSummary(rsRead.getString(1));
                sdRead.setValue(rsRead.getDouble(2));
                sdRead.setDescription(rsRead.getString(3));
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return sdRead;
    }
    
    public boolean unmatchDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Number of unmatch\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }
    
     public boolean matchDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Number of match pairs\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }
    
      public boolean possiblematchDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Number of possible match\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }
    
     public boolean thresholdMatchDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Threshold Match\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }   
           
    public boolean thresholdUnmatchDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Threshold Unmatch\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }   
     
    public boolean reductionDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Reduction 1:1 Method\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }   
    
    public boolean decisionalModelDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Decisional Model\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }  
    
    public boolean dsaDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Record in Dataset A\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }  
    
    public boolean dsbDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Record in Dataset B\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }  
    
    public boolean SSRDone(){
       String sqlQueryStr = "SELECT summary FROM "+TablesName.nameSummary()+" WHERE summary = \'Method\';";
       String res = null; 
       try{
            Statement stm =(Statement)connection.createStatement();
            ResultSet rs = stm.executeQuery(sqlQueryStr);
            while(rs.next())
                res = rs.getString(1);
         }catch(Exception e){
            e.printStackTrace();
        } 
       if(res==null)
          return false;
      else
          return true;
    }  
    
    public  ArrayList<SummaryData> Read(){
        ArrayList<SummaryData> sdlRead = new ArrayList<SummaryData>();
        SummaryData sd;
        String sqlQueryStr2 ="SELECT summary, value, description FROM "+TablesName.nameSummary()+";";
        try{
            Statement stmRead =(Statement)connection.createStatement();
            ResultSet rsRead = stmRead.executeQuery(sqlQueryStr2);
            while(rsRead.next()){
                sd = new SummaryData();
                sd.setSummary(rsRead.getString(1));
                sd.setValue(rsRead.getDouble(2));
                sd.setDescription(rsRead.getString(3));
                sdlRead.add(sd);
            }   
        }catch(Exception e){
            e.printStackTrace();
        }
        return sdlRead;
    }
   
    public Connection getConnetion(){
       return this.connection;
    }
    
}
