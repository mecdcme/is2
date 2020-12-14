package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;
import java.util.Arrays;

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
@Override
    public String getSimilarityExplained(final StringBuilder string1, final StringBuilder string2) {
        return null;
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return (str1Length * str2Length) * ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final StringBuilder string1b, final StringBuilder string2b) {

    
    	final char[] string1 = new char[string1b.length()];
    	string1b.getChars(0, string1b.length(), string1, 0);
    	final char[] string2 = new char[string2b.length()];
    	string2b.getChars(0, string2b.length(), string2, 0);
    	
        final int halflen = ((Math.min(string1.length, string2.length)) / 2) + ((Math.min(string1.length, string2.length)) % 2);

        final char[] common1 = getCommonCharacters(string1, string2, halflen);
        final char[] common2 = getCommonCharacters(string2, string1, halflen);

        if (common1.length == 0 || common2.length == 0) {
            return 0.0f;
        }

        if (common1.length != common2.length) {
            return 0.0f;
        }

        int transpositions = 0;
        for (int i = 0; i < common1.length; i++) {
            if (common1[i] != common2[i])
                transpositions++;
        }
        transpositions /= 2.0f;

        return (common1.length / ((float) string1.length) +
                common2.length / ((float) string2.length) +
                (common1.length - transpositions) / ((float) common1.length)) / 3.0f;
    }

    public float getUnNormalisedSimilarity(final StringBuilder string1, final StringBuilder string2) {
        return getSimilarity(string1, string2);
    }

    private static char[] getCommonCharacters(final char[] string1, final char[] string2, final int distanceSep) {
        final StringBuilder returnCommons = new StringBuilder();
        final char[] copy =  Arrays.copyOf(string2, string2.length);
        
        for (int i = 0; i < string1.length; i++) {
            final char ch = string1[i];
            boolean foundIt = false;
            for (int j = Math.max(0, i - distanceSep); !foundIt && j <= Math.min(i + distanceSep, string2.length - 1); j++) {
                if (copy[j] == ch) {
                    foundIt = true;
                    returnCommons.append(ch);
                    copy[j]= (char) 0;
                }
            }
        }
        char[] stringRet = new char[returnCommons.length()];
        returnCommons.getChars(0, returnCommons.length(), stringRet, 0);
        return stringRet;
    }
}
