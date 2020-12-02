package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.AbstractSubstitutionCost;
import it.istat.is2.catalogue.relais.metrics.utility.MathFuncs;
import it.istat.is2.catalogue.relais.metrics.utility.SubCost01;

public final class Levenshtein extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1.8e-4f;

    private final AbstractSubstitutionCost dCostFunc = new SubCost01();

    public Levenshtein() {
    }

    public String getShortDescriptionString() {
        return "Levenshtein";
    }

    public String getLongDescriptionString() {
        return "Implements the basic Levenshtein algorithm providing a similarity measure between two strings";
    }

    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return (str1Length * str2Length) * ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2) {
        final float levensteinDistance = getUnNormalisedSimilarity(string1, string2);
        float maxLen = string1.length();
        if (maxLen < string2.length()) {
            maxLen = string2.length();
        }

        if (maxLen == 0) {
            return 1.0f; 
        } else {
            return 1.0f - (levensteinDistance / maxLen);
        }

    }

    public float getUnNormalisedSimilarity(final StringBuilder s, final StringBuilder t) {
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

                d[i][j] = MathFuncs.min3(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1] + cost);
            }
        }

        return d[n][m];
    }
}
