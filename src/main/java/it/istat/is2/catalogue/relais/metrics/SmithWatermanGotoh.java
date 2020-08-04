package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractAffineGapCost;
import it.istat.is2.catalogue.relais.metrics.utility.AbstractSubstitutionCost;
import it.istat.is2.catalogue.relais.metrics.utility.AffineGap5_1;
import it.istat.is2.catalogue.relais.metrics.utility.SmithWatermanGotohWindowedAffine;
import it.istat.is2.catalogue.relais.metrics.utility.SubCost5_3_Minus3;

public final class SmithWatermanGotoh extends SmithWatermanGotohWindowedAffine implements Serializable {

    private static final long serialVersionUID = 1L;
    private final float ESTIMATEDTIMINGCONST = 2.2e-5f;

    public SmithWatermanGotoh() {
        super(new AffineGap5_1(), new SubCost5_3_Minus3(), Integer.MAX_VALUE);
    }

    public SmithWatermanGotoh(final AbstractAffineGapCost gapCostFunc) {
        super(gapCostFunc, new SubCost5_3_Minus3(), Integer.MAX_VALUE);
    }

    public SmithWatermanGotoh(final AbstractAffineGapCost gapCostFunc, final AbstractSubstitutionCost costFunc) {
        super(gapCostFunc, costFunc, Integer.MAX_VALUE);
    }

    public SmithWatermanGotoh(final AbstractSubstitutionCost costFunc) {
        super(new AffineGap5_1(), costFunc, Integer.MAX_VALUE);
    }

    public String getShortDescriptionString() {
        return "SmithWatermanGotoh";
    }

    public String getLongDescriptionString() {
        return "Implements the Smith-Waterman-Gotoh algorithm providing a similarity measure between two string";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return ((str1Length * str2Length * str1Length) + (str1Length * str2Length * str2Length)) * ESTIMATEDTIMINGCONST;
    }
}


