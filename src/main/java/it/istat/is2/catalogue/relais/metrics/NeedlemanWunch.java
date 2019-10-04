package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.AbstractSubstitutionCost;
import it.istat.is2.catalogue.relais.metrics.utility.MathFuncs;
import it.istat.is2.catalogue.relais.metrics.utility.SubCost01;

public final class NeedlemanWunch extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1.842e-4f;

    private AbstractSubstitutionCost dCostFunc;

    private float gapCost;

    public NeedlemanWunch() {
        gapCost = 2.0f;
        dCostFunc = new SubCost01();
    }

    public NeedlemanWunch(final float costG) {
        gapCost = costG;
        dCostFunc = new SubCost01();
    }

    public NeedlemanWunch(final float costG, final AbstractSubstitutionCost costFunc) {
        gapCost = costG;
        dCostFunc = costFunc;
    }

    public NeedlemanWunch(final AbstractSubstitutionCost costFunc) {
        gapCost = 2.0f;
        dCostFunc = costFunc;
    }

    public float getGapCost() {
        return gapCost;
    }

    public void setGapCost(final float gapCost) {
        this.gapCost = gapCost;
    }

    public AbstractSubstitutionCost getdCostFunc() {
        return dCostFunc;
    }

    public void setdCostFunc(final AbstractSubstitutionCost dCostFunc) {
        this.dCostFunc = dCostFunc;
    }

    public String getShortDescriptionString() {
        return "NeedlemanWunch";
    }

    public String getLongDescriptionString() {
        return "Implements the Needleman-Wunch algorithm providing an edit distance based similarity measure between two strings";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return (str1Length * str2Length) * ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final String string1, final String string2) {
        float needlemanWunch = getUnNormalisedSimilarity(string1, string2);

        float maxValue = Math.max(string1.length(), string2.length());
        float minValue = maxValue;
        if (dCostFunc.getMaxCost() > gapCost) {
            maxValue *= dCostFunc.getMaxCost();
        } else {
            maxValue *= gapCost;
        }
        if (dCostFunc.getMinCost() < gapCost) {
            minValue *= dCostFunc.getMinCost();
        } else {
            minValue *= gapCost;
        }
        if (minValue < 0.0f) {
            maxValue -= minValue;
            needlemanWunch -= minValue;
        }

        if (maxValue == 0) {
            return 1.0f; 
        } else {
            return 1.0f - (needlemanWunch / maxValue);
        }

    }

    public float getUnNormalisedSimilarity(final String s, final String t) {
        final float[][] d; 
        final int n; 
        final int m; 
        int i; 
        int j; 
        float cost; 

        n = s.length();
        m = t.length();
        if (n == 0) {
            return m;
        }
        if (m == 0) {
            return n;
        }

       
        d = new float[n + 1][m + 1];

        for (i = 0; i <= n; i++) {
            d[i][0] = i;
        }
        for (j = 0; j <= m; j++) {
            d[0][j] = j;
        }

        for (i = 1; i <= n; i++) {
            for (j = 1; j <= m; j++) {
                cost = dCostFunc.getCost(s, i - 1, t, j - 1);

                d[i][j] = MathFuncs.min3(d[i - 1][j] + gapCost, d[i][j - 1] + gapCost, d[i - 1][j - 1] + cost);
            }
        }

        return d[n][m];
    }
}
