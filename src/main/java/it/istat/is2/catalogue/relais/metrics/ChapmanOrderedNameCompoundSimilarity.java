package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;
import java.util.ArrayList;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserWhitespace;

public final class ChapmanOrderedNameCompoundSimilarity extends AbstractStringMetric implements Serializable {

    private static final long serialVersionUID = 1L;
    private final float ESTIMATEDTIMINGCONST = 0.026571428571428571428571428571429f;

    final InterfaceTokeniser tokeniser;

    private final AbstractStringMetric internalStringMetric1 = new Soundex();

    private final AbstractStringMetric internalStringMetric2 = new SmithWaterman();

    public ChapmanOrderedNameCompoundSimilarity() {
        tokeniser = new TokeniserWhitespace();
    }

    public ChapmanOrderedNameCompoundSimilarity(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "ChapmanOrderedNameCompoundSimilarity";
    }


    public String getLongDescriptionString() {
        return "Implements the Chapman Ordered Name Compound Similarity algorithm whereby terms are matched and tested against the standard soundex algorithm - this is intended to provide a better rating for lists of proper names.";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Tokens = tokeniser.tokenizeToArrayList(string1).size();
        final float str2Tokens = tokeniser.tokenizeToArrayList(string2).size();
        return (tokeniser.tokenizeToArrayList(string1).size() + tokeniser.tokenizeToArrayList(string2).size()) * ((str1Tokens + str2Tokens) * ESTIMATEDTIMINGCONST);
    }

    public final float getSimilarity(final String string1, final String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);
        int str1TokenNum = str1Tokens.size();
        int str2TokenNum = str2Tokens.size();
        int minTokens = Math.min(str1TokenNum, str2TokenNum);

        float SKEW_AMMOUNT = 1.0f;

        float sumMatches = 0.0f;
        for (int i = 1; i <= minTokens; i++) {
            float strWeightingAdjustment = ((1.0f / minTokens) + (((((minTokens - i) + 0.5f) - (minTokens / 2.0f)) / minTokens) * SKEW_AMMOUNT * (1.0f / minTokens)));
            final String sToken = (String) str1Tokens.get(str1TokenNum - i);
            final String tToken = (String) str2Tokens.get(str2TokenNum - i);

            final float found1 = internalStringMetric1.getSimilarity(sToken, tToken);
            final float found2 = internalStringMetric2.getSimilarity(sToken, tToken);
            sumMatches += ((0.5f * (found1 + found2)) * strWeightingAdjustment);
        }
        return sumMatches;
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        return getSimilarity(string1, string2);
    }

}



