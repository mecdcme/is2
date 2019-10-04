package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;
import java.util.ArrayList;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserWhitespace;

public final class MatchingCoefficient extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 2.0e-4f;

    private final InterfaceTokeniser tokeniser;

    public MatchingCoefficient() {
        tokeniser = new TokeniserWhitespace();
    }

    public MatchingCoefficient(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "MatchingCoefficient";
    }

    public String getLongDescriptionString() {
        return "Implements the Matching Coefficient algorithm providing a similarity measure between two strings";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Tokens = tokeniser.tokenizeToArrayList(string1).size();
        final float str2Tokens = tokeniser.tokenizeToArrayList(string2).size();
        return (str2Tokens * str1Tokens) * ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final String string1, final String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        final int totalPossible = Math.max(str1Tokens.size(), str2Tokens.size());
        return getUnNormalisedSimilarity(string1, string2) / (float) totalPossible;
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        int totalFound = 0;
        for (Object str1Token : str1Tokens) {
            final String sToken = (String) str1Token;
            boolean found = false;
            for (Object str2Token : str2Tokens) {
                final String tToken = (String) str2Token;
                if (sToken.equals(tToken)) {
                    found = true;
                }
            }
            if (found) {
                totalFound++;
            }
        }
        return (float)totalFound;
    }
}


