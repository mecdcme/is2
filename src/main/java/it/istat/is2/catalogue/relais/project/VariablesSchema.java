/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package it.istat.is2.catalogue.relais.project;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.swing.DefaultComboBoxModel;

import it.istat.is2.catalogue.relais.constants.TablesName;

/**
 *
 * @author luvalent
 */
public class VariablesSchema {

    private Connection conn;
    
    public VariablesSchema(Connection connection) {

        conn = connection;
    }
    
    public void addField(String set,String newField) throws Exception {
        String dataTable;
        String colTable;
        String colTable2;
        String sql;
        Statement stm;
        
        if (set.equalsIgnoreCase("A")) {
            dataTable = TablesName.nameDsa();
            colTable = TablesName.nameColDsa();
            colTable2 = TablesName.nameColDsb();
        } else {
            dataTable = TablesName.nameDsb();
            colTable = TablesName.nameColDsb();
            colTable2 = TablesName.nameColDsa();
        }

        stm =(Statement)conn.createStatement();
        sql = "ALTER TABLE "+dataTable+" ADD "+newField.toUpperCase()+" VARCHAR(250)";
        stm.executeUpdate(sql);
        
        sql = "INSERT INTO "+colTable+" (ATTRIBUTE,ORIG) VALUES ('"+newField.toUpperCase()+"','N')";
        stm.executeUpdate(sql);

        sql = "SELECT * FROM "+colTable2+" WHERE ATTRIBUTE='"+newField.toUpperCase()+"'";
        ResultSet rsReconciliation = stm.executeQuery(sql);
        
        if (rsReconciliation.next()) {
            rsReconciliation.close();
            sql = "SELECT * FROM "+TablesName.nameReconciledSchema()+" WHERE COMMON_ATTRIBUTE='"+newField.toUpperCase()+"'";
            rsReconciliation = stm.executeQuery(sql);
            
            if (!rsReconciliation.next()) {
                sql = "INSERT INTO "+TablesName.nameReconciledSchema()+" (ATTRIBUTE_DSA, ATTRIBUTE_DSB, COMMON_ATTRIBUTE) "+
                      "VALUES ('"+newField.toUpperCase()+"','"+newField.toUpperCase()+"','"+newField.toUpperCase()+"')";
                stm.executeUpdate(sql);
            }
        }
        rsReconciliation.close();
        
    }
    
    public static DefaultComboBoxModel VariablesList(Connection conn1,String table) {
        return(VariablesList(conn1,table,true));
    }
    public static DefaultComboBoxModel VariablesList(Connection conn1,String table,boolean reconciled) {
        DefaultComboBoxModel cbmodel = new DefaultComboBoxModel();
        String colname="attribute_dsa";
        if (table.toUpperCase().equals(TablesName.nameColDsb())) colname="attribute_dsb";
        String condition=" WHERE attribute NOT IN (SELECT "+colname+" FROM "+TablesName.nameReconciledSchema()+")";
        
        try {
                String stringCount="SELECT ATTRIBUTE FROM "+table.toUpperCase();
                if (!reconciled) stringCount=stringCount+condition;
                Statement stmSchema =(Statement)conn1.createStatement();
                ResultSet rsSchema = stmSchema.executeQuery(stringCount);

                while (rsSchema.next())
                    cbmodel.addElement(rsSchema.getString(1));

                stmSchema.close();
        } catch (Exception e){
            System.out.println("Error in reading attribute");
        } finally {
            return cbmodel;
        }
    }
}
