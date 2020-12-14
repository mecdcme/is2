package it.istat.is2.catalogue.relais.metrics.added;

import it.istat.is2.catalogue.relais.metrics.dataStructure.MetricMatchingVariable;
import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;

import java.io.Serializable;

public final class  WindowEquality extends AbstractStringMetric implements Serializable{

    private int window;
    
    private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1e-4f;

    public WindowEquality(MetricMatchingVariable mmv) {
        this.window = mmv.getWindowSize(); 
     }

    public String getShortDescriptionString() {
        return "Numeric near window comparison";
    }

    public String getLongDescriptionString() {
        return "Compare two numbers x and y; these are considered equals (return 1) if their distance is in the fixed window";
    }

    
    @Override
   public float getSimilarity(StringBuilder string1, StringBuilder string2) {
       
        if((string1==null)||(string1.length()==0))
        {
            
            return 0;
        }
        else if ((string2== null)||(string2.length()==0))
            
        {
            
            return 0;
        }
        try{
        Float x = Float.valueOf(string1.toString());
        Float y = Float.valueOf(string2.toString());
       
        if(Float.compare(x,y)==0){
            return(1);
        }
        else if((Math.abs(x-y))<=window){
            return(1);
        }
        else {
            return 0;
        }
        } catch (Exception e) {
            return 0;
        }
    }

    @Override
    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;
    }

    @Override
    public float getSimilarityTimingEstimated(StringBuilder string1, StringBuilder string2) {
        return ESTIMATEDTIMINGCONST;
    }

    

    @Override
    public float getUnNormalisedSimilarity(StringBuilder string1, StringBuilder string2) {
        Float x = Float.valueOf(string1.toString());
        Float y = Float.valueOf(string2.toString());
        if(Float.compare(x,y)==0)
            return(1);
        else if((Math.abs(x-y))<=window)
           return(1);
        else 
            return 0;
    }
    
}
