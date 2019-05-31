package it.istat.is2.catalogue.relais.metrics.utility;

import java.io.Serializable;
import java.util.ArrayList;

import it.istat.is2.catalogue.relais.metrics.SmithWatermanGotoh;


public class MongeElkan extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 0.0344f;

    final InterfaceTokeniser tokeniser;

    private final AbstractStringMetric internalStringMetric;

    public String getSimilarityExplained(String string1, String string2) {
        return null;  
    }

    public MongeElkan() {
        tokeniser = new TokeniserWhitespace();
        internalStringMetric = new SmithWatermanGotoh();
    }

    public MongeElkan(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
        internalStringMetric = new SmithWatermanGotoh();
    }

    public MongeElkan(final InterfaceTokeniser tokeniserToUse, final AbstractStringMetric metricToUse) {
        tokeniser = tokeniserToUse;
        internalStringMetric = metricToUse;
    }

    public MongeElkan(final AbstractStringMetric metricToUse) {
        tokeniser = new TokeniserWhitespace();
        internalStringMetric = metricToUse;
    }

    public String getShortDescriptionString() {
        return "MongeElkan";
    }

    public String getLongDescriptionString() {
        return "Implements the Monge Elkan algorithm providing an matching style similarity measure between two strings";
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Tokens = tokeniser.tokenizeToArrayList(string1).size();
        final float str2Tokens = tokeniser.tokenizeToArrayList(string2).size();
        return (((str1Tokens + str2Tokens) * str1Tokens) + ((str1Tokens + str2Tokens) * str2Tokens)) * ESTIMATEDTIMINGCONST;
    }

    public final float getSimilarity(final String string1, final String string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);

        float sumMatches = 0.0f;
        float maxFound;
        for (Object str1Token : str1Tokens) {
            maxFound = 0.0f;
            for (Object str2Token : str2Tokens) {
                final float found = internalStringMetric.getSimilarity((String) str1Token, (String) str2Token);
                if (found > maxFound) {
                    maxFound = found;
                }
            }
            sumMatches += maxFound;
        }
        return sumMatches / (float) str1Tokens.size();
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        return getSimilarity(string1, string2);
    }
}

