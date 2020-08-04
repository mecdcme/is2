package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.*;

public final class SmithWaterman extends AbstractStringMetric implements Serializable {

    private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1.61e-4f;

    private AbstractSubstitutionCost dCostFunc;

    private float gapCost;

    public SmithWaterman() {
        gapCost = 0.5f;
        dCostFunc = new SubCost1_Minus2();
    }

    public SmithWaterman(final float costG) {
        gapCost = costG;
        dCostFunc = new SubCost1_Minus2();
    }

    public SmithWaterman(final float costG, final AbstractSubstitutionCost costFunc) {
        gapCost = costG;
        dCostFunc = costFunc;
    }

    public SmithWaterman(final AbstractSubstitutionCost costFunc) {
        gapCost = 0.5f;
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
        return "SmithWaterman";
    }

    public String getLongDescriptionString() {
        return "Implements the Smith-Waterman algorithm providing a similarity measure between two string";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return ((str1Length * str2Length) + str1Length + str2Length) * ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final String string1, final String string2) {
        final float smithWaterman = getUnNormalisedSimilarity(string1, string2);

        float maxValue = Math.min(string1.length(), string2.length());
        if (dCostFunc.getMaxCost() > -gapCost) {
            maxValue *= dCostFunc.getMaxCost();
        } else {
            maxValue *= -gapCost;
        }

        if (maxValue == 0) {
            return 1.0f;
        } else {
            return (smithWaterman / maxValue);
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

        d = new float[n][m];

        float maxSoFar = 0.0f;
        for (i = 0; i < n; i++) {
            cost = dCostFunc.getCost(s, i, t, 0);

            if (i == 0) {
                d[0][0] = MathFuncs.max3(0,
                        -gapCost,
                        cost);
            } else {
                d[i][0] = MathFuncs.max3(0,
                        d[i - 1][0] - gapCost,
                        cost);
            }
            if (d[i][0] > maxSoFar) {
                maxSoFar = d[i][0];
            }
        }
        for (j = 0; j < m; j++) {
            cost = dCostFunc.getCost(s, 0, t, j);

            if (j == 0) {
                d[0][0] = MathFuncs.max3(0,
                        -gapCost,
                        cost);
            } else {
                d[0][j] = MathFuncs.max3(0,
                        d[0][j - 1] - gapCost,
                        cost);
            }
            if (d[0][j] > maxSoFar) {
                maxSoFar = d[0][j];
            }
        }

        for (i = 1; i < n; i++) {
            for (j = 1; j < m; j++) {
                cost = dCostFunc.getCost(s, i, t, j);

                d[i][j] = MathFuncs.max4(0,
                        d[i - 1][j] - gapCost,
                        d[i][j - 1] - gapCost,
                        d[i - 1][j - 1] + cost);
                if (d[i][j] > maxSoFar) {
                    maxSoFar = d[i][j];
                }
            }
        }

        return maxSoFar;
    }
}

