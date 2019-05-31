package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserWhitespace;

import java.util.ArrayList;

public final class EuclideanDistance extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 7.4457142857142857142857142857146e-5f;

    private final InterfaceTokeniser tokeniser;

    public EuclideanDistance() {
        tokeniser = new TokeniserWhitespace();
    }

    public EuclideanDistance(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "EuclideanDistance";
    }

    public String getLongDescriptionString() {
        return "Implements the Euclidean Distancey algorithm providing a similarity measure between two stringsusing the vector space of combined terms as the dimensions";
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
        float totalPossible = (float) Math.sqrt((str1Tokens.size()*str1Tokens.size()) + (str2Tokens.size()*str2Tokens.size()));
        final float totalDistance = getUnNormalisedSimilarity(string1, string2);
        return (totalPossible - totalDistance) / totalPossible;
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        final Set<String> allTokens = new HashSet<String>();
        allTokens.addAll(str1Tokens);
        allTokens.addAll(str2Tokens);

        float totalDistance = 0.0f;
        for (final String token : allTokens) {
            int countInString1 = 0;
            int countInString2 = 0;
            for (final String sToken : str1Tokens) {
                if (sToken.equals(token)) {
                    countInString1++;
                }
            }
            for (final String sToken : str2Tokens) {
                if (sToken.equals(token)) {
                    countInString2++;
                }
            }

            totalDistance += ((countInString1 - countInString2) * (countInString1 - countInString2));
        }

        totalDistance = (float) Math.sqrt(totalDistance);
        return totalDistance;
    }

    public float getEuclidDistance(final String string1, final String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        final Set<String> allTokens = new HashSet<String>();
        allTokens.addAll(str1Tokens);
        allTokens.addAll(str2Tokens);

        float totalDistance = 0.0f;
        for (final String token : allTokens) {
            int countInString1 = 0;
            int countInString2 = 0;
            for (final String sToken : str1Tokens) {
                if (sToken.equals(token)) {
                    countInString1++;
                }
            }
            for (final String sToken : str2Tokens) {
                if (sToken.equals(token)) {
                    countInString2++;
                }
            }

            totalDistance += ((countInString1 - countInString2) * (countInString1 - countInString2));
        }

        return (float) Math.sqrt(totalDistance);
    }
}




