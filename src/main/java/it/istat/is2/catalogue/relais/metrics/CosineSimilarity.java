package it.istat.is2.catalogue.relais.metrics;

import java.util.HashSet;
import java.util.Set;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserWhitespace;

import java.util.ArrayList;
import java.io.Serializable;

public final class CosineSimilarity extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 0.00000038337142857142857142857142857142f;

    private final InterfaceTokeniser tokeniser;

    public CosineSimilarity() {
        tokeniser = new TokeniserWhitespace();
    }

    public CosineSimilarity(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "CosineSimilarity";
    }

    public String getLongDescriptionString() {
        return "Implements the Cosine Similarity algorithm providing a similarity measure between two strings from the angular divergence within term based vector space";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null; 
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return (str1Length + str2Length) * ((str1Length + str2Length) * ESTIMATEDTIMINGCONST);
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

        return (float) (commonTerms) / (float) (Math.pow((float) termsInString1, 0.5f) * Math.pow((float) termsInString2, 0.5f));
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        return getSimilarity(string1, string2);
    }
}



