package it.istat.is2.catalogue.relais.metrics.added;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;

public final class NumericComparison extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1e-4f;


    public NumericComparison() {
    }

    public String getShortDescriptionString() {
        return "Simple numeric comparison";
    }

    public String getLongDescriptionString() {
        return "Convert string in float and compare normalizing by maximum value";
    }

    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        return ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2) {
        float fstring1=0, fstring2=0, max=0, NumComp=0;
        try {
            fstring1 = Float.valueOf(string1.toString());
            fstring2 = Float.valueOf(string2.toString());
            if ((fstring1*fstring2)<0)
                return 0;
            
            if (Math.abs(fstring2)>Math.abs(fstring1))
                max = Math.abs(fstring2);
            else
                max = Math.abs(fstring1);
            
            NumComp = (1-Math.abs(fstring2-fstring1)/max);
            
            return NumComp;
        } catch (Exception e) {
            return 0;
        }
    }

    public float getUnNormalisedSimilarity(final StringBuilder string1, final StringBuilder string2) {
        float fstring1=0, fstring2=0, NumComp=0;
        try {
            fstring1 = Float.valueOf(string1.toString());
            fstring2 = Float.valueOf(string2.toString());
            NumComp = Math.abs(fstring2-fstring1);
            
            return NumComp;
        } catch (Exception e) {
            return 0;
        }
    }
    
}
