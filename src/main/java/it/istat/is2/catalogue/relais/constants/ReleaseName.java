package it.istat.is2.catalogue.relais.constants;

public class ReleaseName {
    
    public ReleaseName() {
        
    }

    /*returns the release number 
     resolve outofmemoryerror in export big resultset*/
    public static String release() {
        /* dbconnection using db.param file */
        return("3.0.4");
    } 
    
}
