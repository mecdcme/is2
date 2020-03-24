package it.istat.is2.catalogue.relais.metrics.added;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;

public final class NumericEuclideanDistance extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1e-4f;

    
    public NumericEuclideanDistance() {
    }

    public String getShortDescriptionString() {
        return "Simple numeric Euclidean distance";
    }

    public String getLongDescriptionString() {
        return "Apply the simple Euclidean distance between two numbers";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        return ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final String string1, final String string2) {
        int num1=0;
        int num2=0;
        double euclideanD = 0.0;
        try {
            num1 = Integer.parseInt(string1);
            num2 = Integer.parseInt(string2);
            
            euclideanD = Math.sqrt((double)(num1-num2)*(double)(num1-num2));
           
            return (float) euclideanD;
        } catch (Exception e) {
            return 0;
        }
    }

    public float getUnNormalisedSimilarity(final String string1, final String string2) {
        int num1=0, num2=0;
        double euclideanD = 0.0;
        try {
            num1 = Integer.parseInt(string1);
            num2 = Integer.parseInt(string2);
            
            euclideanD = Math.sqrt((num1-num2)^2);
            
            
            return (float) euclideanD;
        } catch (Exception e) {
            return 0;
        }
    }

}
