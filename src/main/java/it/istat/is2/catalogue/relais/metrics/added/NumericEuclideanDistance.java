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

    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        return ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2) {
        int num1=0;
        int num2=0;
        double euclideanD = 0.0;
        try {
            num1 = Integer.parseInt(string1.toString());
            num2 = Integer.parseInt(string2.toString());
            
            euclideanD = Math.sqrt((double)(num1-num2)*(double)(num1-num2));
           
            return (float) euclideanD;
        } catch (Exception e) {
            return 0;
        }
    }

    public float getUnNormalisedSimilarity(final StringBuilder string1, final StringBuilder string2) {
        int num1=0, num2=0;
        double euclideanD = 0.0;
        try {
            num1 = Integer.parseInt(string1.toString());
            num2 = Integer.parseInt(string2.toString());
            
            euclideanD = Math.sqrt((num1-num2)^2);
            
            
            return (float) euclideanD;
        } catch (Exception e) {
            return 0;
        }
    }

}
