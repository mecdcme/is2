package it.istat.is2.catalogue.relais.constants;

public class TablesName {
    
    public TablesName() {
        
    }

    /*returns the name of the dataset A */
    public static String nameDsa() {
        return("DATASET_A");
    } 
    
    /*returns the name of the dataset B */
    public static String nameDsb() {
        return("DATASET_B");
    }
    
    /*returns the name of the table containing the variables of dataset A */
    public static String nameColDsa() {
        return("DATASET_A_COLUMNS");
    } 
    
    /*returns the name of the table containing the variables of dataset B */
    public static String nameColDsb() {
        return("DATASET_B_COLUMNS");
    }
    
    /*returns the name of the temporary table containing the search space*/
    public static String nameSearchSpaceTemp() {
        return("SEARCHSPACE_TEMP");
    }
    
    /*returns the name of the table containing the search space*/
    public static String nameSearchSpaceFinal() {
        return("SEARCHSPACE");
    }
    
    /*returns the name of the table containig the different block modality*/
    public static String nameBlockModality() {
        return("BLOCK_MODALITY");
    }
    
    /*returns the name of the table containing the log informations*/
    public static String nameLog() {
        return("LOG_TABLE");
    }
    
    /*returns the name of the table containing the contingency table*/ 
    public static String nameContingency() {
        return("CONTINGENCY_TABLE");
    }
    
    /*returns the name of the table containing the result of the 
     * probabilist model (MU table)*/
    public static String nameMU() {
        return("MU_TABLE");
    }
    
    /*returns the name of the table containing the result of the 
     * estimation for each variable */
    public static String nameMUVariable() {
        //return("RELAIS_MARGINALS");
        return("MARGINAL");
    }
        
    /*returns the name of the table containing the 
     * result of the deterministic rule based method */ 
    public static String nameMURule() {
        return("DETERMINISTIC_TRUE_TABLE");
    }
    
    /*returns the name of the table containing the
     * couple of record that have been matched*/
    public static String nameMatch() {
        return("MATCH_TABLE");
    }
    
    /*returns the name of the table containing the
     * couple of record that have been classified as 
     * possible matches*/
    public static String namePossibleMatch() {
        return("POSSIBLE_MATCH_TABLE");
    }
    
    /*returns the name of the table containig the 
     * couple of record that have been classified as
     * unmatches*/
    public static String nameUnMatch() {
        return("UNMATCH_TABLE");
    }
    
    /*returns the name of the table containing the
     * record of the dataset A that have not been 
     * matched with no record of the dataset B*/ 
    public static String nameResidualDsa() {
        return("RESIDUAL_DATASET_A");
    }
    
    /*returns the name of the table containing the
     * record of the dataset B that have not been 
     * matched with no record of the dataset A*/ 
    public static String nameResidualDsb() {
        return("RESIDUAL_DATASET_B");
    }
    
    /*returns the name of the table containing the
     * results of the one to one reduction phase*/
    public static String nameOtoO() {
        //return("RELAIS_ONETOONE");
        return("REDUCED");
    }
    
    /*returns the name of the ??? containing the input 
     * of the one to one reduction phase*/
    public static String nameInputOtoO() {
        return("INPUT_REDUCTION");
    }
    
    /*returns the name of the table containing the 
     * contingency table calculated on the record output 
     of the ono to reduction phase*/
    public static String nameContingencyReduced() {
        return("REDUCED_CONTINGENCY_TABLE");
    }
    
    /*returns the name of the table containing the
     * name of the matching variables chosen*/
    public static String nameMatchingVeriables() {
        return("MATCHING_VARIABLES");
    }
    
    /*returns the name of the table containing the name
     * of the variables choosen as matching variables*/
    public static String nameReconciledSchema() {
        return("RECONCILED_SCHEMA");
    }
    
    /*returns the name of the table containing the metadata*/ 
    public static String nameMetaData() {
        return("METADATA");
    }
    
    /*returns the name of the table containing the 
     * value setted for the variables: outputfolderpath,
     * model, method, blockvar, rule, thresholdU, thresholdM, 
     * char_separator*/
    public static String nameSetting() {
        return("SETTINGS");
    }
   
    /*returns the name of the table containing the 
     status of phases of linkage */
    public static String nameCurrentStatus() {
        return("CURRENT_STATUS");
    } 
    
    /*returns the name of the table containing the weights for
     deterministic reduction to 1:1 */
    public static String nameReductionWeight(){
        return("REDUCTION_WEIGHT");
    }
   
    /*returns the name of the table containing the 
     * frequency distributions of the variable modalities */
    public static String nameFrequencyDistributions(){
        return("FREQUENCY_DISTRIBUTIONS");
    }
    
    /*returns the name of the table containing 
     * the accuracy dictionary*/
     public static String nameAccuracyDictionary(){
        return("ACCURACY_DICTIONARY");
    }
    
    /*returns the name of the table containing
     * the consistency dictionary*/ 
    public static String nameConsistencyDictionary(){
        return("CONSISTENCY_DICTIONARY");
    }
    
    /*returns the name of the table containing
     * the metadata related to the blocking variables*/
    public static String nameBlockingMetaData(){
        return("BLOCKING_METADATA");
    }
    
    /*returns the name of the table containing
     *the metadata related to the matching variables*/
    public static String nameMatchingMetaData(){
        return("MATCHING_METADATA");
    }
    
    /*returns the name of the table containing
     *the metadata related to the matching variables*/
    public static String nameSummary(){
        return("SUMMARY");
    }
    
    /*returns a list of all the table names*/
    public static String listTables() {
        String sep="','";
        String allList;
        allList="'"+nameDsa()+sep+nameDsb()+sep+nameBlockModality()+sep+nameLog()+sep+nameContingency()+
                sep+nameMU()+sep+nameMURule()+sep+nameMatch()+sep+namePossibleMatch()+sep+nameUnMatch()+
                sep+nameResidualDsa()+sep+nameResidualDsb()+sep+nameOtoO()+sep+nameContingencyReduced()+
                sep+nameMatchingVeriables()+sep+nameReconciledSchema()+sep+nameBlockingMetaData()+sep+
                nameMatchingMetaData()+sep+nameReductionWeight()+sep+nameSetting()+sep+nameSummary()+sep+
                nameMUVariable()+"'";
        return(allList);
    }
}
