/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package it.istat.is2.catalogue.relais.project;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import it.istat.is2.catalogue.relais.constants.TablesName;

/**
 *
 * @author luvalent
 */
public class ReconciledSchema {

    Connection connection;
    String[] common = {};
    String[] seta = {};
    String[] setb = {};
    /* returns the list of common attributes */
    public ReconciledSchema(Connection conn) {

      this.connection= conn;
      readFromTable();
    }
      
    private void readFromTable() {
      try {
         String stringCount="Select count(*) from "+TablesName.nameReconciledSchema();
         Statement stmCount =(Statement)connection.createStatement();
         ResultSet rsCount = stmCount.executeQuery(stringCount);
         int ntot=0;
         if (rsCount.next())
             ntot = (int) rsCount.getDouble(1);

         if (ntot>0) {
             common = new String[ntot];
             seta = new String[ntot];
             setb = new String[ntot];
            
            String stringQuery="Select COMMON_ATTRIBUTE, ATTRIBUTE_DSA, ATTRIBUTE_DSB from "+TablesName.nameReconciledSchema();
            Statement stmSchema =(Statement)connection.createStatement();
            ResultSet rsSchema = stmSchema.executeQuery(stringQuery);

            int count=0;
            while (rsSchema.next()) {
                common[count] = rsSchema.getString(1);
                seta[count] = rsSchema.getString(2);
                setb[count] = rsSchema.getString(3);
                count++;
            }
            stmSchema.close();
        }
        else {
            common = new String[] {};
            seta = new String[] {};
            setb = new String[] {}; 
        }
      } catch (Exception e){
	System.out.println("Error in finding reconciled schema");
      }
    }
    
    /* returns the list of common attributes */
    public String[] getReconciledSchema() {
        return common;
    }
    
    /* returns the list of dsa attributes reconciled */
    public String[] getVariableReconciled(String set) {
        if (set.equalsIgnoreCase("A"))
            return seta;
        if (set.equalsIgnoreCase("B"))
            return setb;
        return null;
    }
    
    public void insertReconciliation(String dsaVar, String dsbVar, String commonName) {
        
        try {
           String stringQuery="INSERT INTO "+TablesName.nameReconciledSchema()+" (COMMON_ATTRIBUTE, ATTRIBUTE_DSA, ATTRIBUTE_DSB) "+
                              " VALUES ('"+commonName+"','"+dsaVar+"','"+dsbVar+"')";
           Statement stmSchema =(Statement)connection.createStatement();
           //System.out.println(stringQuery);
           stmSchema.executeUpdate(stringQuery);
           
           readFromTable();
        } catch (Exception e){
	    System.out.println("Error in insert reconciliation: "+e.getMessage());
        }
    }
    
    public void removeReconciliation(int index) {
        
        try {
           String stringQuery="DELETE FROM "+TablesName.nameReconciledSchema()+" WHERE COMMON_ATTRIBUTE='"+common[index]+"'";
           Statement stmSchema =(Statement)connection.createStatement();
           stmSchema.executeUpdate(stringQuery);
           
           readFromTable();
        } catch (Exception e){
	    System.out.println("Error in remove reconciliation: "+e.getMessage());
        }
    }
    
    public String getAttribute(String attribute,String set) {
        int index=0;
        while (index<common.length) {
            if (common[index].equalsIgnoreCase(attribute)) {
                if (set.equalsIgnoreCase("A"))
                    return seta[index];
                if (set.equalsIgnoreCase("B"))
                    return setb[index];
            }
            index++;
        }
        return "";
    }
    
    /* returns the list of common attributes (static method) */
    public static String[] getReconciledSchema(Connection conn) {
            String[] list = {""};
    try {
            String stringCount="Select count(*) from "+TablesName.nameReconciledSchema();
            Statement stmCount =(Statement)conn.createStatement();
            ResultSet rsCount = stmCount.executeQuery(stringCount);
            int ntot=0;
            if (rsCount.next())
                ntot = (int) rsCount.getDouble(1);

            if (ntot==0) return list;
            list = new String[ntot];
            
            String stringQuery="Select COMMON_ATTRIBUTE from "+TablesName.nameReconciledSchema();
            Statement stmSchema =(Statement)conn.createStatement();
            ResultSet rsSchema = stmSchema.executeQuery(stringQuery);

            int count=0;
            while (rsSchema.next()) {
                list[count] = rsSchema.getString(1);
                count++;
            }
            stmSchema.close();
    } catch (Exception e){
	System.out.println("Error in finding reconciled schema");
    } finally {
        return list;
    }
    }
}
