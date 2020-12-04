package it.istat.is2.catalogue.relais.metrics.added;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;
import it.istat.is2.catalogue.relais.metrics.utility.InterfaceTokeniser;
import it.istat.is2.catalogue.relais.metrics.utility.TokeniserQGram3Extended;

import java.io.Serializable;
import java.util.*;

public final class Likeness extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private static final float ESTIMATEDTIMINGCONST = 1.34e-4f;

    private final InterfaceTokeniser tokeniser;
    public HashMap<String,Integer> voc=null;
    int vocitot, toktot;

    public Likeness() {
        tokeniser = new TokeniserQGram3Extended();
        voc = new HashMap<String,Integer>();
        vocitot=0;
        toktot=0;
    }

    public Likeness(final InterfaceTokeniser tokeniserToUse) {
        tokeniser = tokeniserToUse;
        voc = new HashMap<String,Integer>();
        vocitot=0;
        toktot=0;
    }

    public String getShortDescriptionString() {
        return "Likeness";
    }

    public String getLongDescriptionString() {
        return "Estimates the number common 3-grams scorder in base of frequency";
    }

    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        return (str1Length * str2Length) * ESTIMATEDTIMINGCONST;
    }
    
        @Override
    public void prepareMap(List<String> stringList) {
        
        StringBuilder stringIn;
        int count;
        
        for (String stringApp : stringList) {
        	stringIn = new StringBuilder(stringApp);
        	final ArrayList<String> strTokens = tokeniser.tokenizeToArrayList(stringIn);
        	for (String tok : strTokens) {
        		
                if (voc.containsKey(tok)) {
                   count= (Integer) voc.get(tok);
                   count++;
                   voc.put(tok, count);
                }
                else {
                    voc.put(tok, 1);
                    vocitot++;
                }
                toktot++;
            }
        
        }
    }

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2) {
        
        return (getUnNormalisedSimilarity(string1, string2));

    }

    public float getUnNormalisedSimilarity(StringBuilder string1, StringBuilder string2) {
        final ArrayList<String> str1Tokens = tokeniser.tokenizeToArrayList(string1);
        final ArrayList<String> str2Tokens = tokeniser.tokenizeToArrayList(string2);
        final Iterator<String> minTokensIt;
        final ArrayList<String> maxTokens;
        double difference = 0;
        double similar = 0;
        
        if (str1Tokens.size()==str2Tokens.size()) {
            minTokensIt = str1Tokens.iterator();
            maxTokens = str2Tokens; 
        } 
        else if (str1Tokens.size()<str2Tokens.size()) {
            minTokensIt = str1Tokens.iterator();
            maxTokens = str2Tokens;
            difference = ((double)vocitot/toktot);
        } else {
            minTokensIt = str2Tokens.iterator();
            maxTokens = str1Tokens;
            difference = ((double)vocitot/toktot);
        }
        
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
                difference += ((double)vocitot/toktot);
            }
            else {
                similar += ((double) 1/(Integer) voc.get(token));
            }

        }

        float retval = 0f;
        if ((similar+difference)>0f) 
           retval = ((float) similar/(float)(similar+difference));
        
        return (retval);
    }

}


