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

    public String getSimilarityExplained(String string1, String string2) {
        return null;
    }

    public float getSimilarityTimingEstimated(final String string1, final String string2) {
        final float str1Length = string1.length();
        final float str2Length = string2.length();
        final String testString = "abcdefghijklmnopq";
        return ((str1Length + str2Length) * ESTIMATEDTIMINGCONST) + internalStringMetric.getSimilarityTimingEstimated(testString.substring(0, SOUNDEXLENGTH), testString.substring(0, SOUNDEXLENGTH));
    }

    public float getSimilarity(final String string1, final String string2) {
        final String soundex1 = calcSoundEx(string1, SOUNDEXLENGTH);
        final String soundex2 = calcSoundEx(string2, SOUNDEXLENGTH);
        return internalStringMetric.getSimilarity(soundex1, soundex2);
    }

    public float getUnNormalisedSimilarity(String string1, String string2) {
        return internalStringMetric.getUnNormalisedSimilarity(string1, string2);
    }

    private static String calcSoundEx(String wordString, int soundExLen) {
        String tmpStr;
        String wordStr;
        char curChar;
        char lastChar;
        final int wsLen;
        final char firstLetter;

        if (soundExLen > 10) {
            soundExLen = 10;
        }
        if (soundExLen < 4) {
            soundExLen = 4;
        }

        if (wordString.length() == 0) {
            return ("");
        }

        wordString = wordString.toUpperCase();

        wordStr = wordString;
        wordStr = wordStr.replaceAll("[^A-Z]", " ");
        wordStr = wordStr.replaceAll("\\s+", "");

        if (wordStr.length() == 0) {
            return ("");
        }

        firstLetter = wordStr.charAt(0);

        if (wordStr.length() > (SOUNDEXLENGTH * 4) + 1) {
            wordStr = "-" + wordStr.substring(1, SOUNDEXLENGTH * 4);
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
        return (wordStr);
    }
}
