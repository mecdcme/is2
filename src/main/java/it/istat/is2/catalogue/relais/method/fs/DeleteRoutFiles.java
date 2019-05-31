/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package it.istat.is2.catalogue.relais.method.fs;

import java.io.File;

/**
 * delete file .Rout in Relais root
 */
public class DeleteRoutFiles {
    
    File[] files;
    String rootname;
    
    public DeleteRoutFiles(String rootname) throws Exception {
        File list = new File(".");
        this.files = list.listFiles();
        this.rootname=rootname;
    }
    
    public void changeFilesName(String rootname) throws Exception {
        this.rootname=rootname;
    }
    
    public void delete() throws Exception {
        for (File f : files)
        /*f.delete();*/
        if (f.getName().endsWith(".Rout") && f.getName().startsWith(this.rootname)) {
            f.delete();
        }
        
    }

}
