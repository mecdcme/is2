package it.istat.is2.catalogue.relais.metrics;

import java.io.Serializable;

import it.istat.is2.catalogue.relais.metrics.utility.AbstractStringMetric;

public final class Soundex extends AbstractStringMetric implements Serializable {

	private static final long serialVersionUID = 1L;

    private final float ESTIMATEDTIMINGCONST = 0.00052f;

    private final AbstractStringMetric internalStringMetric;

    private final static int SOUNDEXLENGTH = 6;

    public Soundex() {
        internalStringMetric = new JaroWinkler();
    }

    public Soundex(final AbstractStringMetric internalComparisonMetric) {
        internalStringMetric = internalComparisonMetric;
    }

    public String getShortDescriptionString() {
        return "Soundex";
    }

    public String getLongDescriptionString() {
        return "Implements the Soundex algorithm providing a similarity measure between two soundex codes";
    }

    public String getSimilarityExplained(StringBuilder string1, StringBuilder string2) {
        return null;  
    }

    public float getSimilarityTimingEstimated(final StringBuilder string1, final StringBuilder string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        final String testString = "abcdefghijklmnopq";
        final StringBuilder strA = new StringBuilder(testString.substring(0,SOUNDEXLENGTH));
        final StringBuilder strB = new StringBuilder(testString.substring(0,SOUNDEXLENGTH));
        return ((str1Length + str2Length) * ESTIMATEDTIMINGCONST) + internalStringMetric.getSimilarityTimingEstimated(strA,strB);
    }

    public float getSimilarity(final StringBuilder string1, final StringBuilder string2) {
        final StringBuilder soundex1 = calcSoundEx(string1, SOUNDEXLENGTH);
        final StringBuilder soundex2 = calcSoundEx(string2, SOUNDEXLENGTH);
        return internalStringMetric.getSimilarity(soundex1, soundex2);
    }

    public float getUnNormalisedSimilarity(StringBuilder string1, StringBuilder string2) {
        return internalStringMetric.getUnNormalisedSimilarity(string1, string2);
    }

    private static StringBuilder calcSoundEx(StringBuilder wordString, int soundExLen) {
        String tmpStr;
        String wordStr;
        char curChar;
        char lastChar;
        final int wsLen;
        final char firstLetter;
        StringBuilder wordtoSB;

        if (soundExLen > 10) {
            soundExLen = 10;
        }
        if (soundExLen < 4) {
            soundExLen = 4;
        }

        if (wordString.length() == 0) {
        	wordtoSB = new StringBuilder("");
            return (wordtoSB);
        }

     

        wordStr = wordString.toString().toUpperCase();
        wordStr = wordStr.replaceAll("[^A-Z]", " "); 
        wordStr = wordStr.replaceAll("\\s+", "");   

        if (wordStr.length() == 0) {
        	wordtoSB = new StringBuilder("");
            return (wordtoSB);
        }

        firstLetter = wordStr.charAt(0);

        if(wordStr.length() > (SOUNDEXLENGTH*4)+1) {
            wordStr = "-" + wordStr.substring(1,SOUNDEXLENGTH*4);
        } else {
            wordStr = "-" + wordStr.substring(1);
        }
        wordStr = wordStr.replaceAll("[AEIOUWH]", "0");
        wordStr = wordStr.replaceAll("[BPFV]", "1");
        wordStr = wordStr.replaceAll("[CSKGJQXZ]", "2");
        wordStr = wordStr.replaceAll("[DT]", "3");
        wordStr = wordStr.replaceAll("[L]", "4");
        wordStr = wordStr.replaceAll("[MN]", "5");
        wordStr = wordStr.replaceAll("[R]", "6");

        wsLen = wordStr.length();
        lastChar = '-';
        tmpStr = "-";     
        for (int i = 1; i < wsLen; i++) {
            curChar = wordStr.charAt(i);
            if (curChar != lastChar) {
                tmpStr += curChar;
                lastChar = curChar;
            }
        }
        wordStr = tmpStr;
        wordStr = wordStr.substring(1);          
        wordStr = wordStr.replaceAll("0", "");  
        wordStr += "000000000000000000";            
        wordStr = firstLetter + wordStr;      
        wordStr = wordStr.substring(0, soundExLen); 
        wordtoSB = new StringBuilder(wordStr);
        return (wordtoSB);
    }
}
