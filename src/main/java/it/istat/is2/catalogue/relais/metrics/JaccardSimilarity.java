package it.istat.is2.catalogue.relais.metrics;

import java.util.HashSet;
import java.util.Set;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserWhitespace;

import java.util.ArrayList;
import java.io.Serializable;

public final class JaccardSimilarity extends AbstractStringMetric implements Serializable {

    private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1.4e-4f;

    private final InterfaceTokeniser tokeniser;

    public JaccardSimilarity() {
        tokeniser = new TokeniserWhitespace();
    }

    public JaccardSimilarity(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "JaccardSimilarity";
    }

    public String getLongDescriptionString() {
        return "Implements the Jaccard Similarity algorithm providing a similarity measure between two strings";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Tokens = tokeniser.tokenizeToArrayList(string1).size();
        final float str2Tokens = tokeniser.tokenizeToArrayList(string2).size();
        return (str1Tokens * str2Tokens) * ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final String string1, final String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        final Set<String> allTokens = new HashSet<String>();
        allTokens.addAll(str1Tokens);
        final int termsInString1 = allTokens.size();
        final Set<String> secondStringTokens = new HashSet<String>();
        secondStringTokens.addAll(str2Tokens);
        final int termsInString2 = secondStringTokens.size();

        allTokens.addAll(secondStringTokens);
        final int commonTerms = (termsInString1 + termsInString2) - allTokens.size();

        return (float) (commonTerms) / (float) (allTokens.size());
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        return getSimilarity(string1, string2);
    }
}

