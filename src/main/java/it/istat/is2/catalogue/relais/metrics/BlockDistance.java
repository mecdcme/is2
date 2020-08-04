package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserWhitespace;

import java.util.ArrayList;

public final class BlockDistance extends AbstractStringMetric implements Serializable {

    private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 6.4457142857142857142857142857146e-5f;

    private final InterfaceTokeniser tokeniser;

    public BlockDistance() {
        tokeniser = new TokeniserWhitespace();
    }

    public BlockDistance(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "BlockDistance";
    }

    public String getLongDescriptionString() {
        return "Implements the Block distance algorithm whereby vector space block distance is used to determine a similarity";
    }

    public String getSimilarityExplained(String string1, String string2) {
        return null;
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Tokens = tokeniser.tokenizeToArrayList(string1).size();
        final float str2Tokens = tokeniser.tokenizeToArrayList(string2).size();
        return (((str1Tokens + str2Tokens) * str1Tokens) + ((str1Tokens + str2Tokens) * str2Tokens)) * ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final String string1, final String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        final float totalPossible = (float) (str1Tokens.size() + str2Tokens.size());

        final float totalDistance = getUnNormalisedSimilarity(string1, string2);
        return (totalPossible - totalDistance) / totalPossible;
    }

    public float getUnNormalisedSimilarity(final String string1, final String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        final Set<Object> allTokens = new HashSet<Object>();
        allTokens.addAll(str1Tokens);
        allTokens.addAll(str2Tokens);

        int totalDistance = 0;
        for (Object allToken : allTokens) {
            final String token = (String) allToken;
            int countInString1 = 0;
            int countInString2 = 0;
            for (Object str1Token : str1Tokens) {
                final String sToken = (String) str1Token;
                if (sToken.equals(token)) {
                    countInString1++;
                }
            }
            for (Object str2Token : str2Tokens) {
                final String sToken = (String) str2Token;
                if (sToken.equals(token)) {
                    countInString2++;
                }
            }
            if (countInString1 > countInString2) {
                totalDistance += (countInString1 - countInString2);
            } else {
                totalDistance += (countInString2 - countInString1);
            }
        }
        return totalDistance;
    }
}

