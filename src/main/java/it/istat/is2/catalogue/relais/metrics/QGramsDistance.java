package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;
import java.util.*;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserQGram3Extended;

public final class QGramsDistance extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1.34e-4f;

    private final InterfaceTokeniser tokeniser;

    public QGramsDistance() {
        tokeniser = new TokeniserQGram3Extended();
    }

    public QGramsDistance(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "QGramsDistance";
    }

    public String getLongDescriptionString() {
        return "Implements the Q Grams Distance algorithm providing a similarity measure between two strings using the qGram approach check matching qGrams/possible matching qGrams";
    }

    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return (str1Length * str2Length) * ESTIMATEDTIMINGCONST;
    }

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        final int maxQGramsMatching = str1Tokens.size() + str2Tokens.size();

        if (maxQGramsMatching == 0) {
            return 0.0f;
        } else {
            return (maxQGramsMatching - getUnNormalisedSimilarity(string1, string2)) / (float) maxQGramsMatching;
        }
    }

    public float getUnNormalisedSimilarity(StringBuilder string1, StringBuilder string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        final Set<String> allTokens = new HashSet<String>();
        allTokens.addAll(str1Tokens);
        allTokens.addAll(str2Tokens);

        final Iterator<String> allTokensIt = allTokens.iterator();
        int difference = 0;
        while (allTokensIt.hasNext()) {
            final String token = allTokensIt.next();
            int matchingQGrams1 = 0;
            for (String str1Token : str1Tokens) {
                if (str1Token.equals(token)) {
                    matchingQGrams1++;
                }
            }
            int matchingQGrams2 = 0;
            for (String str2Token : str2Tokens) {
                if (str2Token.equals(token)) {
                    matchingQGrams2++;
                }
            }
            if (matchingQGrams1 > matchingQGrams2) {
                difference += (matchingQGrams1 - matchingQGrams2);
            } else {
                difference += (matchingQGrams2 - matchingQGrams1);
            }
        }

        return difference;
    }
}


