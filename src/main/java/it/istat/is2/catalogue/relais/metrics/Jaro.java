package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.*;

public final class Jaro extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;
    private final float ESTIMATEDTIMINGCONST = 4.12e-5f;

    public Jaro() {
    }

    public String getShortDescriptionString() {
        return "Jaro";
    }

    public String getLongDescriptionString() {
        return "Implements the Jaro algorithm providing a similarity measure between two strings allowing character transpositions to a degree";
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

        final int halflen = ((Math.min(string1.length(), string2.length())) / 2) + ((Math.min(string1.length(), string2.length())) % 2);

        final StringBuffer common1 = getCommonCharacters(string1, string2, halflen);
        final StringBuffer common2 = getCommonCharacters(string2, string1, halflen);

        if (common1.length() == 0 || common2.length() == 0) {
            return 0.0f;
        }

        if (common1.length() != common2.length()) {
            return 0.0f;
        }

        int transpositions = 0;
        for (int i = 0; i < common1.length(); i++) {
            if (common1.charAt(i) != common2.charAt(i))
                transpositions++;
        }
        transpositions /= 2.0f;

        return (common1.length() / ((float) string1.length()) +
                common2.length() / ((float) string2.length()) +
                (common1.length() - transpositions) / ((float) common1.length())) / 3.0f;
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        return getSimilarity(string1, string2);
    }

    private static StringBuffer getCommonCharacters(final String string1, final String string2, final int distanceSep) {
        final StringBuffer returnCommons = new StringBuffer();
        final StringBuffer copy = new StringBuffer(string2);
        for (int i = 0; i < string1.length(); i++) {
            final char ch = string1.charAt(i);
            boolean foundIt = false;
            for (int j = Math.max(0, i - distanceSep); !foundIt && j <= Math.min(i + distanceSep, string2.length() - 1); j++) {
                if (copy.charAt(j) == ch) {
                    foundIt = true;
                    returnCommons.append(ch);
                    copy.setCharAt(j, (char)0);
                }
            }
        }
        return returnCommons;
    }
}
