package it.istat.is2.catalogue.relais.metrics;

import java.util.HashSet;
import java.util.Set;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserWhitespace;

import java.util.ArrayList;
import java.io.Serializable;

public final class DiceSimilarity extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 0.00000034457142857142857142857142857146f;

    private final InterfaceTokeniser tokeniser;

    public DiceSimilarity() {
        tokeniser = new TokeniserWhitespace();
    }

    public DiceSimilarity(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "DiceSimilarity";
    }

    public String getLongDescriptionString() {
        return "Implements the DiceSimilarity algorithm providing a similarity measure between two strings using the vector space of present terms";
    }

    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return (str1Length + str2Length) * ((str1Length + str2Length) * ESTIMATEDTIMINGCONST);
    }

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2) {
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

        return (2.0f * commonTerms) / (termsInString1 + termsInString2);
    }

    public float getUnNormalisedSimilarity(StringBuilder string1, StringBuilder string2) {
        return getSimilarity(string1, string2);
    }
}


