package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.MathFuncs;

public final class JaroWinkler extends AbstractStringMetric implements Serializable {

    private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 4.342e-5f;

    private final AbstractStringMetric internalStringMetric;

    private static final int MINPREFIXTESTLENGTH = 6;

    private static final float PREFIXADUSTMENTSCALE = 0.1f;

    public JaroWinkler() {
        internalStringMetric = new Jaro();
    }

    public String getShortDescriptionString() {
        return "JaroWinkler";
    }

    public String getLongDescriptionString() {
        return "Implements the Jaro-Winkler algorithm providing a similarity measure between two strings allowing character transpositions to a degree adjusting the weighting for common prefixes";
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
        final float dist = internalStringMetric.getSimilarity(string1, string2);

        final int prefixLength = getPrefixLength(string1, string2);
        return dist + ((float) prefixLength * PREFIXADUSTMENTSCALE * (1.0f - dist));
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        return getSimilarity(string1, string2);
    }

    private static int getPrefixLength(final String string1, final String string2) {
        final int n = MathFuncs.min3(MINPREFIXTESTLENGTH, string1.length(), string2.length());
        for (int i = 0; i < n; i++) {
            if (string1.charAt(i) != string2.charAt(i)) {
                return i;
            }
        }
        return n;
    }
}

