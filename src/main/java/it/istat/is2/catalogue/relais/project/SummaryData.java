package it.istat.is2.catalogue.relais.project;


public class SummaryData {
    String summary;
    double value;
    String description;
    
    public SummaryData(String summary,double value,String description) {
        this.summary = summary;
        this.value = value;
        this.description = description;
    }
    public SummaryData(){
        
    }
    
    public String getSummary() {
        return this.summary;
    }

    public double getValue() {
        return this.value;
    }
    
    public String getDescription(){
        return this.description;
    }
    
    public void setSummary(String sum){
        this.summary =sum;
    }
    
    public void setValue(double val){
        this.value = val;
    }
    
    public void setDescription(String descr){
        this.description = descr;
    }
}
