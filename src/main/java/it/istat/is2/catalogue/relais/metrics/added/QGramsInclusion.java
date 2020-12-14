package it.istat.is2.catalogue.relais.metrics.added;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserQGram3Extended;

import java.io.Serializable;
import java.util.*;

public final class QGramsInclusion extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 1.34e-4f;

    private final InterfaceTokeniser tokeniser;

    public QGramsInclusion() {
        tokeniser = new TokeniserQGram3Extended();
    }

    public QGramsInclusion(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
    }

    public String getShortDescriptionString() {
        return "QGramsInclusion";
    }

    public String getLongDescriptionString() {
        return "Estimates the number of Q-grams of the shortest string in the longest string";
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

        int maxQGramsMatching = str1Tokens.size();
        if (str2Tokens.size()<maxQGramsMatching) {
            maxQGramsMatching = str2Tokens.size();
        }

        if (maxQGramsMatching == 0) {
            return 0.0f;
        } else {
            return (maxQGramsMatching - getUnNormalisedSimilarity(string1, string2)) / (float) maxQGramsMatching;
        }
    }

    public float getUnNormalisedSimilarity(StringBuilder string1, StringBuilder string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);
        final Iterator<String> minTokensIt;
        final ArrayList<String> maxTokens;
        
        if (str1Tokens.size()<=str2Tokens.size()) {
            minTokensIt = str1Tokens.iterator();
            maxTokens = str2Tokens;
        } else {
            minTokensIt = str2Tokens.iterator();
            maxTokens = str1Tokens;
        }
        
        int difference = 0;
        int find=0;
        while (minTokensIt.hasNext()) {
            final String token = minTokensIt.next();
            find=0;
            for (String currToken : maxTokens) {
                if (currToken.equals(token)) {
                    find=1;
                    break;
                }
            }
            if (find == 0) {
                difference++;
            } 
        }

        return difference;
    }
}


