package it.istat.is2.catalogue.relais.metrics.utility;

import java.io.Serializable;

public class SmithWatermanGotohWindowedAffine extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 4.5e-5f;

    private final int windowSize;

    private AbstractSubstitutionCost dCostFunc;

    private AbstractAffineGapCost gGapFunc;

    public SmithWatermanGotohWindowedAffine() {
        gGapFunc = new AffineGap5_1();
        dCostFunc = new SubCost5_3_Minus3();
        windowSize = 100;
    }

    public SmithWatermanGotohWindowedAffine(final AbstractAffineGapCost gapCostFunc) {
        gGapFunc = gapCostFunc;
        dCostFunc = new SubCost5_3_Minus3();
        windowSize = 100;
    }

    public SmithWatermanGotohWindowedAffine(final AbstractAffineGapCost gapCostFunc, final AbstractSubstitutionCost costFunc) {
        gGapFunc = gapCostFunc;
        dCostFunc = costFunc;
        windowSize = 100;
    }

    public SmithWatermanGotohWindowedAffine(final AbstractSubstitutionCost costFunc) {
        gGapFunc = new AffineGap5_1();
        dCostFunc = costFunc;
        windowSize = 100;
    }

    public SmithWatermanGotohWindowedAffine(final int affineGapWindowSize) {
        gGapFunc = new AffineGap5_1();
        dCostFunc = new SubCost5_3_Minus3();
        windowSize = affineGapWindowSize;
    }

    public SmithWatermanGotohWindowedAffine(final AbstractAffineGapCost gapCostFunc, final int affineGapWindowSize) {
        gGapFunc = gapCostFunc;
        dCostFunc = new SubCost5_3_Minus3();
        windowSize = affineGapWindowSize;
    }

    public SmithWatermanGotohWindowedAffine(final AbstractAffineGapCost gapCostFunc, final AbstractSubstitutionCost costFunc, final int affineGapWindowSize) {
        gGapFunc = gapCostFunc;
        dCostFunc = costFunc;
        windowSize = affineGapWindowSize;
    }

    public SmithWatermanGotohWindowedAffine(final AbstractSubstitutionCost costFunc, final int affineGapWindowSize) {
        gGapFunc = new AffineGap5_1();
        dCostFunc = costFunc;
        windowSize = affineGapWindowSize;
    }

    public final AbstractAffineGapCost getgGapFunc() {
        return gGapFunc;
    }

    public final void setgGapFunc(final AbstractAffineGapCost gGapFunc) {
        this.gGapFunc = gGapFunc;
    }

    public final AbstractSubstitutionCost getdCostFunc() {
        return dCostFunc;
    }

    public final void setdCostFunc(final AbstractSubstitutionCost dCostFunc) {
        this.dCostFunc = dCostFunc;
    }

    public String getShortDescriptionString() {
        return "SmithWatermanGotohWindowedAffine";
    }

    public String getLongDescriptionString() {
        return "Implements the Smith-Waterman-Gotoh algorithm with a windowed affine gap providing a similarity measure between two string";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return ((str1Length * str2Length * windowSize) + (str1Length * str2Length * windowSize)) * ESTIMATEDTIMINGCONST;
    }

    public final float getSimilarity(final String string1, final String string2) {
        final float smithWatermanGotoh = getUnNormalisedSimilarity(string1, string2);

        float maxValue = Math.min(string1.length(), string2.length());
        if (dCostFunc.getMaxCost() > -gGapFunc.getMaxCost()) {
            maxValue *= dCostFunc.getMaxCost();
        } else {
            maxValue *= -gGapFunc.getMaxCost();
        }

        if (maxValue == 0) {
            return 1.0f; 
        } else {
            return (smithWatermanGotoh / maxValue);
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
                d[0][0] = Math.max(0,
                        cost);
            } else {
                float maxGapCost = 0.0f;
                int windowStart = i-windowSize;
                if (windowStart < 1) {
                    windowStart = 1;
                }
                for (int k = windowStart; k < i; k++) {
                    maxGapCost = Math.max(maxGapCost, d[i - k][0] - gGapFunc.getCost(s, i - k, i));
                }
                d[i][0] = MathFuncs.max3(0,
                        maxGapCost,
                        cost);
            }
            if (d[i][0] > maxSoFar) {
                maxSoFar = d[i][0];
            }
        }
        for (j = 0; j < m; j++) {
            cost = dCostFunc.getCost(s, 0, t, j);

            if (j == 0) {
                d[0][0] = Math.max(0,
                        cost);
            } else {
                float maxGapCost = 0.0f;
                int windowStart = j-windowSize;
                if (windowStart < 1) {
                    windowStart = 1;
                }
                for (int k = windowStart; k < j; k++) {
                    maxGapCost = Math.max(maxGapCost, d[0][j - k] - gGapFunc.getCost(t, j - k, j));
                }
                d[0][j] = MathFuncs.max3(0,
                        maxGapCost,
                        cost);
            }
            if (d[0][j] > maxSoFar) {
                maxSoFar = d[0][j];
            }
        }

        for (i = 1; i < n; i++) {
            for (j = 1; j < m; j++) {
                cost = dCostFunc.getCost(s, i, t, j);

                float maxGapCost1 = 0.0f;
                float maxGapCost2 = 0.0f;
                int windowStart = i-windowSize;
                if (windowStart < 1) {
                    windowStart = 1;
                }
                for (int k = windowStart; k < i; k++) {
                    maxGapCost1 = Math.max(maxGapCost1, d[i - k][j] - gGapFunc.getCost(s, i - k, i));
                }
                windowStart = j-windowSize;
                if (windowStart < 1) {
                    windowStart = 1;
                }
                for (int k = windowStart; k < j; k++) {
                    maxGapCost2 = Math.max(maxGapCost2, d[i][j - k] - gGapFunc.getCost(t, j - k, j));
                }
                d[i][j] = MathFuncs.max4(0,
                        maxGapCost1,
                        maxGapCost2,
                        d[i - 1][j - 1] + cost);
                if (d[i][j] > maxSoFar) {
                    maxSoFar = d[i][j];
                }
            }
        }

     return maxSoFar;
    }
}



